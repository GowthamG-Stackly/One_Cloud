import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app_theme.dart';
import '../providers/user_provider.dart';
import '../providers/registration_provider.dart';
import '../routes/routes.dart';

class AppLayout extends ConsumerStatefulWidget {
  final Widget child;

  const AppLayout({super.key, required this.child});

  @override
  ConsumerState<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends ConsumerState<AppLayout> {
  static const double desktopBreakpoint = 850;
  static const double expandedSidebarWidth = 255;
  static const double collapsedSidebarWidth = 80;

  bool sidebarExpanded = true;
  bool mobileSidebarOpen = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final width = MediaQuery.of(context).size.width;

      setState(() {
        sidebarExpanded = width >= desktopBreakpoint;
      });
    });
  }

  void _toggleSidebar() {
    setState(() {
      sidebarExpanded = !sidebarExpanded;
    });
  }

  void _openMobileSidebar() {
    setState(() {
      mobileSidebarOpen = true;
    });
  }

  void _closeMobileSidebar() {
    setState(() {
      mobileSidebarOpen = false;
    });
  }

  void _navigate(String route) {
    final currentRoute = GoRouterState.of(context).uri.path;

    if (currentRoute == route) {
      if (mobileSidebarOpen) {
        _closeMobileSidebar();
      }
      return;
    }

    context.go(route);

    if (mobileSidebarOpen) {
      _closeMobileSidebar();
    }
  }

  void _logout() {
    ref.read(userProvider.notifier).logout();
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < desktopBreakpoint;

    final registration = ref.watch(registrationProvider);

    final adminName = '${registration.firstName} ${registration.lastName}'
        .trim();

    final displayName = adminName.isNotEmpty ? adminName : 'Admin User';

    return Scaffold(
      backgroundColor: AppTheme.paperDim,
      body: Stack(
        children: [
          Row(
            children: [
              if (!isMobile)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  width: sidebarExpanded
                      ? expandedSidebarWidth
                      : collapsedSidebarWidth,
                  child: AppSidebar(
                    collapsed: !sidebarExpanded,
                    adminName: displayName,
                    onNavigate: _navigate,
                  ),
                ),

              Expanded(
                child: Column(
                  children: [
                    AppHeader(
                      isMobile: isMobile,
                      sidebarExpanded: sidebarExpanded,
                      adminName: displayName,
                      onMenuPressed: isMobile
                          ? _openMobileSidebar
                          : _toggleSidebar,
                      onNavigate: _navigate,
                      onLogout: _logout,
                    ),

                    Expanded(
                      child: Container(
                        color: AppTheme.paperDim,
                        child: widget.child,
                      ),
                    ),

                    const AppFooter(),
                  ],
                ),
              ),
            ],
          ),

          if (isMobile && mobileSidebarOpen)
            Positioned.fill(
              child: Row(
                children: [
                  SizedBox(
                    width: 280,
                    child: AppSidebar(
                      collapsed: false,
                      mobile: true,
                      adminName: displayName,
                      onNavigate: _navigate,
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: _closeMobileSidebar,
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.45),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ============================================================================
// APP HEADER
// ============================================================================

class AppHeader extends StatelessWidget {
  final bool isMobile;
  final bool sidebarExpanded;
  final String adminName;
  final VoidCallback onMenuPressed;
  final Function(String route) onNavigate;
  final VoidCallback onLogout;

  const AppHeader({
    super.key,
    required this.isMobile,
    required this.sidebarExpanded,
    required this.adminName,
    required this.onMenuPressed,
    required this.onNavigate,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    // ============================================================
    // MOBILE HEADER
    // ============================================================
    if (isMobile) {
      return SafeArea(
        bottom: false,
        child: Container(
          height: 116,
          decoration: BoxDecoration(
            color: AppTheme.paper,
            border: Border(bottom: BorderSide(color: AppTheme.border)),
          ),
          child: Column(
            children: [
              // ------------------------------------------------------
              // TOP ROW
              // Menu + Stackly logo + Notification + Profile
              // ------------------------------------------------------
              SizedBox(
                height: 58,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      _HeaderIconButton(
                        icon: Icons.menu_rounded,
                        tooltip: 'Open navigation',
                        onPressed: onMenuPressed,
                      ),

                      const SizedBox(width: 10),

                      // STACKLY LOGO
                      Container(
                        width: 128,
                        height: 44,
                        alignment: Alignment.centerLeft,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF28537A),
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            'assets/images/stackly_logo.png',
                            width: 128,
                            height: 44,
                            fit: BoxFit.contain,
                            alignment: Alignment.centerLeft,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),

                      const Spacer(),

                      // NOTIFICATION
                      _HeaderIconButton(
                        icon: Icons.notifications_none_rounded,
                        tooltip: 'Notifications',
                        showNotificationDot: true,
                        onPressed: () {
                          onNavigate(AppRoutes.notification);
                        },
                      ),

                      const SizedBox(width: 8),

                      // PROFILE
                      _ProfileMenu(
                        adminName: adminName,
                        onDashboard: () {
                          onNavigate(AppRoutes.dashboard);
                        },
                        onProfile: () {
                          onNavigate(AppRoutes.profile);
                        },
                        onLogout: onLogout,
                      ),
                    ],
                  ),
                ),
              ),

              // ------------------------------------------------------
              // SECOND ROW
              // Full-width search bar
              // ------------------------------------------------------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 4, 14, 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: _SearchBar(
                      onTap: () {
                        onNavigate(AppRoutes.search);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ============================================================
    // DESKTOP / TABLET HEADER
    // ============================================================
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border(bottom: BorderSide(color: AppTheme.border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // MENU
          _HeaderIconButton(
            icon: sidebarExpanded
                ? Icons.menu_open_rounded
                : Icons.menu_rounded,
            tooltip: sidebarExpanded
                ? 'Collapse navigation'
                : 'Expand navigation',
            onPressed: onMenuPressed,
          ),

          const SizedBox(width: 16),

          // SEARCH
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: _SearchBar(
                  onTap: () {
                    onNavigate(AppRoutes.search);
                  },
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // NOTIFICATION
          _HeaderIconButton(
            icon: Icons.notifications_none_rounded,
            tooltip: 'Notifications',
            showNotificationDot: true,
            onPressed: () {
              onNavigate(AppRoutes.notification);
            },
          ),

          const SizedBox(width: 8),

          // SETTINGS
          _HeaderIconButton(
            icon: Icons.settings_outlined,
            tooltip: 'Settings',
            onPressed: () {
              onNavigate(AppRoutes.globalSettings);
            },
          ),

          const SizedBox(width: 12),

          // PROFILE
          _ProfileMenu(
            adminName: adminName,
            onDashboard: () {
              onNavigate(AppRoutes.dashboard);
            },
            onProfile: () {
              onNavigate(AppRoutes.profile);
            },
            onLogout: onLogout,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SEARCH BAR
// ============================================================================

class _SearchBar extends StatelessWidget {
  final VoidCallback onTap;

  const _SearchBar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 850;
    final radius = isMobile ? 20.0 : 10.0;

    return Material(
      color: AppTheme.paperDim,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: AppTheme.border),
          ),
          child: Row(
            children: [
              Icon(Icons.search_rounded, size: 18, color: AppTheme.textMuted),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  'Search tenants, users, settings, audit logs...',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                ),
              ),

              if (MediaQuery.of(context).size.width > 700)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.paper,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Text(
                    '⌘K',
                    style: TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// HEADER ICON BUTTON
// ============================================================================

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool showNotificationDot;

  const _HeaderIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.showNotificationDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: AppTheme.paper,
            borderRadius: BorderRadius.circular(9),
            child: InkWell(
              borderRadius: BorderRadius.circular(9),
              onTap: onPressed,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Icon(icon, size: 19, color: AppTheme.textMuted),
              ),
            ),
          ),

          if (showNotificationDot)
            Positioned(
              right: 7,
              top: 5,
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: AppTheme.danger,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ============================================================================
// PROFILE MENU
// ============================================================================

class _ProfileMenu extends ConsumerWidget {
  final String adminName;
  final VoidCallback onDashboard;
  final VoidCallback onProfile;
  final VoidCallback onLogout;

  const _ProfileMenu({
    required this.adminName,
    required this.onDashboard,
    required this.onProfile,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = context.findAncestorStateOfType<_AppLayoutState>();

    return PopupMenuButton<String>(
      offset: const Offset(0, 52),
      elevation: 8,
      color: AppTheme.paper,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppTheme.border),
      ),
      onSelected: (value) {
        if (value == 'dashboard') {
          onDashboard();
        }

        if (value == 'profile') {
          onProfile();
        }

        if (value == 'logout') {
          onLogout();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'dashboard',
          child: Row(
            children: [
              Icon(
                Icons.dashboard_outlined,
                size: 19,
                color: AppTheme.textMuted,
              ),
              const SizedBox(width: 12),
              const Text('Dashboard'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: [
              Icon(
                Icons.person_outline_rounded,
                size: 19,
                color: AppTheme.textMuted,
              ),
              const SizedBox(width: 12),
              const Text('Profile'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout_rounded, size: 19, color: AppTheme.danger),
              const SizedBox(width: 12),
              Text('Log out', style: TextStyle(color: AppTheme.danger)),
            ],
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          final isMobile = MediaQuery.of(context).size.width < 850;

          return Container(
            height: 42,
            width: isMobile ? 42 : null,
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 1 : 7),
            decoration: BoxDecoration(
              shape: isMobile ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isMobile ? null : BorderRadius.circular(22),
              border: isMobile ? null : Border.all(color: AppTheme.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.ink3,
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),

                if (!isMobile && MediaQuery.of(context).size.width > 650) ...[
                  const SizedBox(width: 9),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        adminName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.text,
                        ),
                      ),
                      Text(
                        'Super Admin',
                        style: TextStyle(
                          fontSize: 9,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 8),

                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 17,
                    color: AppTheme.textMuted,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// APP SIDEBAR
// ============================================================================

class AppSidebar extends StatefulWidget {
  final bool collapsed;
  final bool mobile;
  final String adminName;
  final Function(String route) onNavigate;

  const AppSidebar({
    super.key,
    required this.collapsed,
    required this.onNavigate,
    required this.adminName,
    this.mobile = false,
  });

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  final Set<String> expandedSections = {};

  void _toggleSection(String title) {
    setState(() {
      if (expandedSections.contains(title)) {
        expandedSections.remove(title);
      } else {
        expandedSections.add(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;

    return Material(
      color: AppTheme.ink,
      child: SafeArea(
        child: Column(
          children: [
            // ==============================================================
            // BRAND
            // ==============================================================

            _SidebarBrand(collapsed: widget.collapsed),

            const SizedBox(height: 8),

            // ==============================================================
            // NAVIGATION
            // ==============================================================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel('ENTERPRISE', widget.collapsed),

                    _SidebarSection(
                      title: 'Platform Administration',
                      icon: Icons.admin_panel_settings_outlined,
                      route: AppRoutes.admin,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains(
                        'Platform Administration',
                      ),
                      onToggle: () {
                        _toggleSection('Platform Administration');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'Admin Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.admin,
                        ),
                        _NavItem(
                          'Global Settings',
                          Icons.settings_outlined,
                          AppRoutes.globalSettings,
                        ),
                        _NavItem(
                          'Platform Configuration',
                          Icons.tune_outlined,
                          AppRoutes.platformConfig,
                        ),
                        _NavItem(
                          'License Management',
                          Icons.badge_outlined,
                          AppRoutes.licenseManagement,
                        ),
                        _NavItem(
                          'Feature Management',
                          Icons.extension_outlined,
                          AppRoutes.featureManagement,
                        ),
                        _NavItem(
                          'Resource Management',
                          Icons.dns_outlined,
                          AppRoutes.resourceManagement,
                        ),
                        _NavItem(
                          'System Health',
                          Icons.monitor_heart_outlined,
                          AppRoutes.systemHealth,
                        ),
                        _NavItem(
                          'Tenant Templates',
                          Icons.view_quilt_outlined,
                          AppRoutes.tenantTemplates,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'HRMS',
                      icon: Icons.people_alt_outlined,
                      route: AppRoutes.hrms,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains('HRMS'),
                      onToggle: () {
                        _toggleSection('HRMS');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'HRMS Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.hrms,
                        ),
                        _NavItem(
                          'Employee Management',
                          Icons.badge_outlined,
                          AppRoutes.hrmsEmployees,
                        ),
                        _NavItem(
                          'Attendance',
                          Icons.access_time_outlined,
                          AppRoutes.hrmsAttendance,
                        ),
                        _NavItem(
                          'Leave',
                          Icons.event_available_outlined,
                          AppRoutes.hrmsLeave,
                        ),
                        _NavItem(
                          'Payroll',
                          Icons.payments_outlined,
                          AppRoutes.hrmsPayroll,
                        ),
                        _NavItem(
                          'Recruitment',
                          Icons.person_add_alt_1_outlined,
                          AppRoutes.hrmsRecruitment,
                        ),
                        _NavItem(
                          'Performance',
                          Icons.insights_outlined,
                          AppRoutes.hrmsPerformance,
                        ),
                        _NavItem(
                          'Learning',
                          Icons.school_outlined,
                          AppRoutes.hrmsLearning,
                        ),
                        _NavItem(
                          'ESS / MSS',
                          Icons.account_circle_outlined,
                          AppRoutes.hrmsEssMss,
                        ),
                        _NavItem(
                          'HRMS Assets',
                          Icons.inventory_2_outlined,
                          AppRoutes.hrmsAssets,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'CRM',
                      icon: Icons.groups_outlined,
                      route: AppRoutes.crm,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains('CRM'),
                      onToggle: () {
                        _toggleSection('CRM');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'CRM Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.crm,
                        ),
                        _NavItem(
                          'Leads',
                          Icons.person_search_outlined,
                          AppRoutes.crmLeads,
                        ),
                        _NavItem(
                          'Opportunities',
                          Icons.trending_up_outlined,
                          AppRoutes.crmOpportunities,
                        ),
                        _NavItem(
                          'Accounts',
                          Icons.business_outlined,
                          AppRoutes.crmAccounts,
                        ),
                        _NavItem(
                          'Contacts',
                          Icons.contacts_outlined,
                          AppRoutes.crmContacts,
                        ),
                        _NavItem(
                          'Activities',
                          Icons.task_alt_outlined,
                          AppRoutes.crmActivities,
                        ),
                        _NavItem(
                          'Sales Pipeline',
                          Icons.account_tree_outlined,
                          AppRoutes.crmPipeline,
                        ),
                        _NavItem(
                          'Quotations',
                          Icons.request_quote_outlined,
                          AppRoutes.crmQuotations,
                        ),
                        _NavItem(
                          'Campaigns',
                          Icons.campaign_outlined,
                          AppRoutes.crmCampaigns,
                        ),
                        _NavItem(
                          'Customer Support',
                          Icons.support_agent_outlined,
                          AppRoutes.crmCustomerSupport,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'ERP',
                      icon: Icons.inventory_2_outlined,
                      route: AppRoutes.erp,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains('ERP'),
                      onToggle: () {
                        _toggleSection('ERP');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'ERP Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.erp,
                        ),
                        _NavItem(
                          'Inventory',
                          Icons.inventory_2_outlined,
                          AppRoutes.inventory,
                        ),
                        _NavItem(
                          'Warehouses',
                          Icons.warehouse_outlined,
                          AppRoutes.warehouses,
                        ),
                        _NavItem(
                          'Stock Movements',
                          Icons.swap_vert_circle_outlined,
                          AppRoutes.stockMovements,
                        ),
                        _NavItem(
                          'Procurement',
                          Icons.shopping_cart_outlined,
                          AppRoutes.procurement,
                        ),
                        _NavItem(
                          'Vendors',
                          Icons.storefront_outlined,
                          AppRoutes.vendors,
                        ),
                        _NavItem(
                          'Sales Orders',
                          Icons.receipt_long_outlined,
                          AppRoutes.salesOrders,
                        ),
                        _NavItem(
                          'Dispatch',
                          Icons.local_shipping_outlined,
                          AppRoutes.dispatch,
                        ),
                        _NavItem(
                          'Production',
                          Icons.precision_manufacturing_outlined,
                          AppRoutes.production,
                        ),
                        _NavItem(
                          'Asset Management',
                          Icons.business_center_outlined,
                          AppRoutes.assetManagement,
                        ),
                        _NavItem(
                          'Maintenance',
                          Icons.build_outlined,
                          AppRoutes.maintenance,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'Finance & Accounting',
                      icon: Icons.account_balance_outlined,
                      route: AppRoutes.finance,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains(
                        'Finance & Accounting',
                      ),
                      onToggle: () {
                        _toggleSection('Finance & Accounting');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'Finance Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.finance,
                        ),
                        _NavItem(
                          'General Ledger',
                          Icons.menu_book_outlined,
                          AppRoutes.financeGeneralLedger,
                        ),
                        _NavItem(
                          'Accounts Payable',
                          Icons.arrow_upward_outlined,
                          AppRoutes.financeAccountsPayable,
                        ),
                        _NavItem(
                          'Accounts Receivable',
                          Icons.arrow_downward_outlined,
                          AppRoutes.financeAccountsReceivable,
                        ),
                        _NavItem(
                          'Asset Management',
                          Icons.account_balance_wallet_outlined,
                          AppRoutes.financeAssetManagement,
                        ),
                        _NavItem(
                          'Budgeting',
                          Icons.pie_chart_outline,
                          AppRoutes.financeBudgeting,
                        ),
                        _NavItem(
                          'Costing',
                          Icons.calculate_outlined,
                          AppRoutes.financeCosting,
                        ),
                        _NavItem(
                          'Financial Reports',
                          Icons.bar_chart_outlined,
                          AppRoutes.financeFinancialReports,
                        ),
                        _NavItem(
                          'Reconciliation',
                          Icons.compare_arrows_outlined,
                          AppRoutes.financeReconciliation,
                        ),
                        _NavItem(
                          'Multi Currency',
                          Icons.currency_exchange_outlined,
                          AppRoutes.financeMultiCurrency,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'Workflow & Automation',
                      icon: Icons.account_tree_outlined,
                      route: AppRoutes.workflow,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains(
                        'Workflow & Automation',
                      ),
                      onToggle: () {
                        _toggleSection('Workflow & Automation');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'Workflow Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.workflow,
                        ),
                        _NavItem(
                          'Workflow Builder',
                          Icons.account_tree_outlined,
                          AppRoutes.workflowBuilder,
                        ),
                        _NavItem(
                          'Approvals',
                          Icons.approval_outlined,
                          AppRoutes.workflowApprovals,
                        ),
                        _NavItem(
                          'Business Rules',
                          Icons.rule_outlined,
                          AppRoutes.workflowBusinessRules,
                        ),
                        _NavItem(
                          'Process Automation',
                          Icons.auto_awesome_outlined,
                          AppRoutes.workflowProcessAutomation,
                        ),
                        _NavItem(
                          'Task Management',
                          Icons.task_alt_outlined,
                          AppRoutes.workflowTasks,
                        ),
                        _NavItem(
                          'Triggers',
                          Icons.flash_on_outlined,
                          AppRoutes.workflowTriggers,
                        ),
                        _NavItem(
                          'SLAs & Escalations',
                          Icons.timer_outlined,
                          AppRoutes.workflowSlas,
                        ),
                        _NavItem(
                          'Process Monitoring',
                          Icons.monitor_outlined,
                          AppRoutes.workflowMonitoring,
                        ),
                        _NavItem(
                          'Workflow Templates',
                          Icons.dashboard_customize_outlined,
                          AppRoutes.workflowTemplates,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'Document Management',
                      icon: Icons.folder_outlined,
                      route: AppRoutes.documents,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains(
                        'Document Management',
                      ),
                      onToggle: () {
                        _toggleSection('Document Management');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'Document Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.documents,
                        ),
                        _NavItem(
                          'Repository',
                          Icons.folder_open_outlined,
                          AppRoutes.documentRepository,
                        ),
                        _NavItem(
                          'Versioning',
                          Icons.history_outlined,
                          AppRoutes.documentVersioning,
                        ),
                        _NavItem(
                          'Upload / Download',
                          Icons.cloud_upload_outlined,
                          AppRoutes.documentUploadDownload,
                        ),
                        _NavItem(
                          'Access Control',
                          Icons.lock_outline,
                          AppRoutes.documentAccessControl,
                        ),
                        _NavItem(
                          'Templates',
                          Icons.description_outlined,
                          AppRoutes.documentTemplates,
                        ),
                        _NavItem(
                          'Tagging & Search',
                          Icons.label_outline,
                          AppRoutes.documentTaggingSearch,
                        ),
                        _NavItem(
                          'Retention Policies',
                          Icons.archive_outlined,
                          AppRoutes.documentRetentionPolicies,
                        ),
                        _NavItem(
                          'Audit Trails',
                          Icons.fact_check_outlined,
                          AppRoutes.documentAuditTrails,
                        ),
                        _NavItem(
                          'OCR Integration',
                          Icons.document_scanner_outlined,
                          AppRoutes.documentOcrIntegration,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'Subscription',
                      icon: Icons.card_membership_outlined,
                      route: AppRoutes.subscription,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains('Subscription'),
                      onToggle: () {
                        _toggleSection('Subscription');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'Subscription Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.subscription,
                        ),
                        _NavItem(
                          'Plans & Features',
                          Icons.layers_outlined,
                          AppRoutes.subscriptionPlansFeatures,
                        ),
                        _NavItem(
                          'Tenant Subscriptions',
                          Icons.business_outlined,
                          AppRoutes.tenantSubscriptions,
                        ),
                        _NavItem(
                          'Usage & Quotas',
                          Icons.data_usage_outlined,
                          AppRoutes.subscriptionUsageQuotas,
                        ),
                        _NavItem(
                          'Payment Tracking',
                          Icons.payment_outlined,
                          AppRoutes.subscriptionPaymentTracking,
                        ),
                        _NavItem(
                          'License Allocation',
                          Icons.assignment_outlined,
                          AppRoutes.subscriptionLicenseAllocation,
                        ),
                        _NavItem(
                          'Renewals',
                          Icons.autorenew_outlined,
                          AppRoutes.subscriptionRenewals,
                        ),
                        _NavItem(
                          'Trial Management',
                          Icons.hourglass_empty_outlined,
                          AppRoutes.subscriptionTrialManagement,
                        ),
                        _NavItem(
                          'Billing Integration',
                          Icons.receipt_outlined,
                          AppRoutes.subscriptionBillingIntegration,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'Revenue',
                      icon: Icons.show_chart_outlined,
                      route: AppRoutes.revenue,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains('Revenue'),
                      onToggle: () {
                        _toggleSection('Revenue');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'Revenue Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.revenue,
                        ),
                        _NavItem(
                          'Revenue Tracking',
                          Icons.track_changes_outlined,
                          AppRoutes.revenueTracking,
                        ),
                        _NavItem(
                          'Usage Analytics',
                          Icons.analytics_outlined,
                          AppRoutes.revenueUsageAnalytics,
                        ),
                        _NavItem(
                          'Forecasting',
                          Icons.insights_outlined,
                          AppRoutes.revenueForecasting,
                        ),
                        _NavItem(
                          'Revenue Recognition',
                          Icons.fact_check_outlined,
                          AppRoutes.revenueRecognition,
                        ),
                        _NavItem(
                          'Commission Management',
                          Icons.percent_outlined,
                          AppRoutes.revenueCommissionManagement,
                        ),
                        _NavItem(
                          'Financial Analytics',
                          Icons.bar_chart_outlined,
                          AppRoutes.revenueFinancialAnalytics,
                        ),
                        _NavItem(
                          'Invoicing',
                          Icons.receipt_long_outlined,
                          AppRoutes.revenueInvoicing,
                        ),
                        _NavItem(
                          'Integration',
                          Icons.integration_instructions_outlined,
                          AppRoutes.revenueIntegration,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'Reporting & BI',
                      icon: Icons.analytics_outlined,
                      route: AppRoutes.reporting,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains('Reporting & BI'),
                      onToggle: () {
                        _toggleSection('Reporting & BI');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'Reporting Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.reporting,
                        ),
                        _NavItem(
                          'Standard Reports',
                          Icons.description_outlined,
                          AppRoutes.reportingStandardReports,
                        ),
                        _NavItem(
                          'Ad Hoc Reports',
                          Icons.edit_document,
                          AppRoutes.reportingAdHocReports,
                        ),
                        _NavItem(
                          'Data Exploration',
                          Icons.explore_outlined,
                          AppRoutes.reportingDataExploration,
                        ),
                        _NavItem(
                          'Data Export',
                          Icons.download_outlined,
                          AppRoutes.reportingDataExport,
                        ),
                        _NavItem(
                          'Scheduled Reports',
                          Icons.schedule_outlined,
                          AppRoutes.reportingScheduledReports,
                        ),
                        _NavItem(
                          'Data Visualization',
                          Icons.bar_chart_outlined,
                          AppRoutes.reportingDataVisualization,
                        ),
                        _NavItem(
                          'Self-Service Analytics',
                          Icons.auto_graph_outlined,
                          AppRoutes.reportingSelfServiceAnalytics,
                        ),
                        _NavItem(
                          'BI Management',
                          Icons.manage_search_outlined,
                          AppRoutes.reportingBiManagement,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'Enterprise AI',
                      icon: Icons.auto_awesome_outlined,
                      route: AppRoutes.ai,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains('Enterprise AI'),
                      accentColor: AppTheme.amberAI,
                      onToggle: () {
                        _toggleSection('Enterprise AI');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'AI Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.ai,
                        ),
                        _NavItem(
                          'AI Models',
                          Icons.psychology_outlined,
                          AppRoutes.enterpriseAiModels,
                        ),
                        _NavItem(
                          'Chat / Copilot',
                          Icons.chat_bubble_outline,
                          AppRoutes.enterpriseAiChatCopilot,
                        ),
                        _NavItem(
                          'Document AI / OCR',
                          Icons.document_scanner_outlined,
                          AppRoutes.enterpriseAiDocumentAiOcr,
                        ),
                        _NavItem(
                          'Predictive Analytics',
                          Icons.query_stats_outlined,
                          AppRoutes.enterpriseAiPredictiveAnalytics,
                        ),
                        _NavItem(
                          'Recommendations',
                          Icons.lightbulb_outline,
                          AppRoutes.enterpriseAiRecommendations,
                        ),
                        _NavItem(
                          'AI Workflows',
                          Icons.account_tree_outlined,
                          AppRoutes.enterpriseAiWorkflows,
                        ),
                        _NavItem(
                          'Model Management',
                          Icons.model_training_outlined,
                          AppRoutes.enterpriseAiModelManagement,
                        ),
                        _NavItem(
                          'Prompt Engineering',
                          Icons.code_outlined,
                          AppRoutes.enterpriseAiPromptEngineering,
                        ),
                        _NavItem(
                          'Usage Logs',
                          Icons.history_outlined,
                          AppRoutes.enterpriseAiUsageLogs,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'Notifications',
                      icon: Icons.notifications_none_outlined,
                      route: AppRoutes.notification,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      accentColor: AppTheme.tealData,
                      expanded: expandedSections.contains('Notifications'),
                      onToggle: () {
                        _toggleSection('Notifications');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'Notification Center',
                          Icons.notifications_none_outlined,
                          AppRoutes.notification,
                        ),
                        _NavItem(
                          'In-App',
                          Icons.web_asset_outlined,
                          AppRoutes.notificationInApp,
                        ),
                        _NavItem(
                          'Email',
                          Icons.email_outlined,
                          AppRoutes.notificationEmail,
                        ),
                        _NavItem(
                          'SMS',
                          Icons.sms_outlined,
                          AppRoutes.notificationSms,
                        ),
                        _NavItem(
                          'Push',
                          Icons.phone_android_outlined,
                          AppRoutes.notificationPush,
                        ),
                        _NavItem(
                          'Templates',
                          Icons.description_outlined,
                          AppRoutes.notificationTemplates,
                        ),
                        _NavItem(
                          'Preferences',
                          Icons.tune_outlined,
                          AppRoutes.notificationPreferences,
                        ),
                        _NavItem(
                          'Schedules',
                          Icons.schedule_outlined,
                          AppRoutes.notificationSchedules,
                        ),
                        _NavItem(
                          'Delivery Tracking',
                          Icons.delivery_dining_outlined,
                          AppRoutes.notificationDeliveryTracking,
                        ),
                        _NavItem(
                          'Multi Channel',
                          Icons.hub_outlined,
                          AppRoutes.notificationMultiChannel,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'Calendar',
                      icon: Icons.calendar_month_outlined,
                      route: AppRoutes.calendar,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains('Calendar'),
                      onToggle: () {
                        _toggleSection('Calendar');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'Calendar Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.calendar,
                        ),
                        _NavItem(
                          'User Calendars',
                          Icons.person_outline,
                          AppRoutes.calendarUserCalendars,
                        ),
                        _NavItem(
                          'Team Calendars',
                          Icons.groups_outlined,
                          AppRoutes.calendarTeamCalendars,
                        ),
                        _NavItem(
                          'Meeting Scheduler',
                          Icons.event_outlined,
                          AppRoutes.calendarMeetingScheduler,
                        ),
                        _NavItem(
                          'Recurring Booking',
                          Icons.repeat_outlined,
                          AppRoutes.calendarRecurringBooking,
                        ),
                        _NavItem(
                          'Reminders',
                          Icons.alarm_outlined,
                          AppRoutes.calendarReminders,
                        ),
                        _NavItem(
                          'Integrations',
                          Icons.integration_instructions_outlined,
                          AppRoutes.calendarIntegrations,
                        ),
                        _NavItem(
                          'Availability',
                          Icons.access_time_outlined,
                          AppRoutes.calendarAvailability,
                        ),
                        _NavItem(
                          'Event Notifications',
                          Icons.notifications_outlined,
                          AppRoutes.calendarEventNotifications,
                        ),
                        _NavItem(
                          'Shared Calendars',
                          Icons.calendar_view_month_outlined,
                          AppRoutes.calendarSharedCalendars,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'Integration',
                      icon: Icons.integration_instructions_outlined,
                      route: AppRoutes.integration,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains('Integration'),
                      onToggle: () {
                        _toggleSection('Integration');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'Integration Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.integration,
                        ),
                        _NavItem(
                          'API Management',
                          Icons.api_outlined,
                          AppRoutes.integrationApiManagement,
                        ),
                        _NavItem(
                          'Third Party Integrations',
                          Icons.extension_outlined,
                          AppRoutes.integrationThirdPartyIntegrations,
                        ),
                        _NavItem(
                          'Webhooks',
                          Icons.webhook_outlined,
                          AppRoutes.integrationWebhooks,
                        ),
                        _NavItem(
                          'Event Streaming',
                          Icons.stream_outlined,
                          AppRoutes.integrationEventStreaming,
                        ),
                        _NavItem(
                          'Data Transformation',
                          Icons.transform_outlined,
                          AppRoutes.integrationDataTransformation,
                        ),
                        _NavItem(
                          'ETL / Data Sync',
                          Icons.sync_alt_outlined,
                          AppRoutes.integrationEtlDataSync,
                        ),
                        _NavItem(
                          'Connectors',
                          Icons.cable_outlined,
                          AppRoutes.integrationConnectors,
                        ),
                        _NavItem(
                          'Integration Logs',
                          Icons.receipt_long_outlined,
                          AppRoutes.integrationLogs,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'Search',
                      icon: Icons.search_outlined,
                      route: AppRoutes.search,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains('Search'),
                      onToggle: () {
                        _toggleSection('Search');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'Global Search',
                          Icons.search_outlined,
                          AppRoutes.searchGlobalSearch,
                        ),
                        _NavItem(
                          'Index Management',
                          Icons.storage_outlined,
                          AppRoutes.searchIndexManagement,
                        ),
                        _NavItem(
                          'Search Analytics',
                          Icons.analytics_outlined,
                          AppRoutes.searchAnalytics,
                        ),
                        _NavItem(
                          'Autocomplete',
                          Icons.auto_awesome_outlined,
                          AppRoutes.searchAutocomplete,
                        ),
                        _NavItem(
                          'Relevance Ranking',
                          Icons.sort_outlined,
                          AppRoutes.searchRelevanceRanking,
                        ),
                        _NavItem(
                          'Saved Searches',
                          Icons.bookmark_outline,
                          AppRoutes.searchSavedSearches,
                        ),
                        _NavItem(
                          'Multi Tenant Index',
                          Icons.account_tree_outlined,
                          AppRoutes.searchMultiTenantIndex,
                        ),
                        _NavItem(
                          'Synonyms',
                          Icons.link_outlined,
                          AppRoutes.searchSynonyms,
                        ),
                        _NavItem(
                          'Suggestion Engine',
                          Icons.lightbulb_outline,
                          AppRoutes.searchSuggestionEngine,
                        ),
                      ],
                    ),

                    _SidebarSection(
                      title: 'Security & Compliance',
                      icon: Icons.security_outlined,
                      route: AppRoutes.security,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      expanded: expandedSections.contains(
                        'Security & Compliance',
                      ),
                      onToggle: () {
                        _toggleSection('Security & Compliance');
                      },
                      onNavigate: widget.onNavigate,
                      children: [
                        _NavItem(
                          'Security Dashboard',
                          Icons.dashboard_outlined,
                          AppRoutes.security,
                        ),
                        _NavItem(
                          'Audit Logs',
                          Icons.history_outlined,
                          AppRoutes.securityAuditLogs,
                        ),
                        _NavItem(
                          'Activity Tracking',
                          Icons.track_changes_outlined,
                          AppRoutes.securityActivityTracking,
                        ),
                        _NavItem(
                          'Compliance Reports',
                          Icons.fact_check_outlined,
                          AppRoutes.securityComplianceReports,
                        ),
                        _NavItem(
                          'Data Retention',
                          Icons.delete_sweep_outlined,
                          AppRoutes.securityDataRetention,
                        ),
                        _NavItem(
                          'Policy Management',
                          Icons.policy_outlined,
                          AppRoutes.securityPolicyManagement,
                        ),
                        _NavItem(
                          'Threat Detection',
                          Icons.gpp_maybe_outlined,
                          AppRoutes.securityThreatDetection,
                        ),
                        _NavItem(
                          'Vulnerability Management',
                          Icons.bug_report_outlined,
                          AppRoutes.securityVulnerabilityManagement,
                        ),
                        _NavItem(
                          'Encryption Keys',
                          Icons.key_outlined,
                          AppRoutes.securityEncryptionKeyManagement,
                        ),
                        _NavItem(
                          'Security Alerts',
                          Icons.warning_amber_outlined,
                          AppRoutes.securityAlerts,
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    _sectionLabel('GENERAL', widget.collapsed),

                    _SidebarItem(
                      title: 'Profile',
                      icon: Icons.person_outline_rounded,
                      route: AppRoutes.profile,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      onTap: widget.onNavigate,
                    ),

                    _SidebarItem(
                      title: 'About',
                      icon: Icons.info_outline_rounded,
                      route: AppRoutes.about,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      onTap: widget.onNavigate,
                    ),

                    _SidebarItem(
                      title: 'Features',
                      icon: Icons.widgets_outlined,
                      route: AppRoutes.features,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      onTap: widget.onNavigate,
                    ),

                    _SidebarItem(
                      title: 'Contact',
                      icon: Icons.mail_outline_rounded,
                      route: AppRoutes.contact,
                      currentRoute: currentRoute,
                      collapsed: widget.collapsed,
                      onTap: widget.onNavigate,
                    ),
                  ],
                ),
              ),
            ),

            // ==============================================================
            // SIDEBAR BOTTOM
            // ==============================================================
            if (!widget.collapsed)
              _SidebarBottom(
                adminName: widget.adminName,
                onProfile: () {
                  widget.onNavigate(AppRoutes.profile);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String title, bool collapsed) {
    if (collapsed) {
      return const SizedBox(height: 8);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 7),
      child: Text(
        title,
        style: TextStyle(
          color: AppTheme.textMuted.withValues(alpha: 0.75),
          fontSize: 9,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ============================================================================
// SIDEBAR BRAND
// ============================================================================

class _SidebarBrand extends StatelessWidget {
  final bool collapsed;

  const _SidebarBrand({required this.collapsed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(horizontal: collapsed ? 16 : 18),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: Center(
        child: SizedBox(
          width: collapsed ? 52 : 150,
          height: 42,
          child: Image.asset(
            'assets/images/stackly_logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      // child: Row(
      //   children: [
      //     Container(
      //       width: 38,
      //       height: 38,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10),
      //         gradient: LinearGradient(
      //           colors: [AppTheme.amberAI, AppTheme.tealData],
      //         ),
      //       ),
      //       child: const Center(
      //         child: Text(
      //           '1E',
      //           style: TextStyle(
      //             color: AppTheme.ink,
      //             fontSize: 14,
      //             fontWeight: FontWeight.w800,
      //           ),
      //         ),
      //       ),
      //     ),

      //     if (!collapsed) ...[
      //       const SizedBox(width: 12),

      //       const Expanded(
      //         child: Text(
      //           'One Enterprise',
      //           maxLines: 1,
      //           overflow: TextOverflow.ellipsis,
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 16,
      //             fontWeight: FontWeight.w600,
      //             letterSpacing: -0.2,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ],
      // ),
    );
  }
}

// ============================================================================
// SIDEBAR SECTION
// ============================================================================

class _SidebarSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final String currentRoute;
  final bool collapsed;
  final bool expanded;
  final Color? accentColor;
  final VoidCallback onToggle;
  final Function(String route) onNavigate;
  final List<_NavItem> children;

  const _SidebarSection({
    required this.title,
    required this.icon,
    required this.route,
    required this.currentRoute,
    required this.collapsed,
    required this.expanded,
    required this.onToggle,
    required this.onNavigate,
    required this.children,
    this.accentColor,
  });

  bool get sectionActive {
    return currentRoute == route || currentRoute.startsWith('$route/');
  }

  @override
  Widget build(BuildContext context) {
    if (collapsed) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: _SidebarItem(
          title: title,
          icon: icon,
          route: route,
          currentRoute: currentRoute,
          collapsed: true,
          accentColor: accentColor,
          onTap: onNavigate,
        ),
      );
    }

    return Column(
      children: [
        Material(
          color: sectionActive
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onToggle,
            hoverColor: Colors.white.withValues(alpha: 0.05),
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 19,
                    color: sectionActive
                        ? (accentColor ?? AppTheme.tealData)
                        : Colors.white.withValues(alpha: 0.62),
                  ),

                  const SizedBox(width: 11),

                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: sectionActive
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.78),
                        fontSize: 12,
                        fontWeight: sectionActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),

                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 17,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                ],
              ),
            ),
          ),
        ),

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 180),
          crossFadeState: expanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Padding(
            padding: const EdgeInsets.only(left: 7, right: 2, bottom: 5),
            child: Column(
              children: children.map((item) {
                return _SidebarChildItem(
                  item: item,
                  currentRoute: currentRoute,
                  onNavigate: onNavigate,
                );
              }).toList(),
            ),
          ),
          secondChild: const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ============================================================================
// SIDEBAR CHILD ITEM
// ============================================================================

class _SidebarChildItem extends StatelessWidget {
  final _NavItem item;
  final String currentRoute;
  final Function(String route) onNavigate;

  const _SidebarChildItem({
    required this.item,
    required this.currentRoute,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final selected = currentRoute == item.route;

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: selected
            ? Colors.white.withValues(alpha: 0.09)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(7),
        child: InkWell(
          borderRadius: BorderRadius.circular(7),
          hoverColor: Colors.white.withValues(alpha: 0.05),
          onTap: () {
            onNavigate(item.route);
          },
          child: Container(
            height: 37,
            padding: const EdgeInsets.only(left: 12, right: 7),
            child: Row(
              children: [
                Container(
                  width: 3,
                  height: selected ? 19 : 13,
                  decoration: BoxDecoration(
                    color: selected
                        ? AppTheme.tealData
                        : Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),

                const SizedBox(width: 9),

                Icon(
                  item.icon,
                  size: 16,
                  color: selected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.48),
                ),

                const SizedBox(width: 9),

                Expanded(
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.65),
                      fontSize: 11,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),

                if (selected)
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 15,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// NORMAL SIDEBAR ITEM
// ============================================================================

class _SidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final String currentRoute;
  final bool collapsed;
  final Color? accentColor;
  final Function(String route) onTap;

  const _SidebarItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.currentRoute,
    required this.collapsed,
    required this.onTap,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final selected = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Tooltip(
        message: collapsed ? title : '',
        preferBelow: false,
        child: Material(
          color: selected
              ? Colors.white.withValues(alpha: 0.10)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            hoverColor: Colors.white.withValues(alpha: 0.05),
            onTap: () {
              onTap(route);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 42,
              padding: EdgeInsets.symmetric(horizontal: collapsed ? 17 : 11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: selected
                    ? Border.all(
                        color: (accentColor ?? AppTheme.tealData).withValues(
                          alpha: 0.55,
                        ),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  if (selected && !collapsed)
                    Container(
                      width: 3,
                      height: 23,
                      margin: const EdgeInsets.only(right: 9),
                      decoration: BoxDecoration(
                        color: accentColor ?? AppTheme.tealData,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),

                  Icon(
                    icon,
                    size: 19,
                    color: selected
                        ? (accentColor ?? Colors.white)
                        : Colors.white.withValues(alpha: 0.60),
                  ),

                  if (!collapsed) ...[
                    const SizedBox(width: 11),

                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.75),
                          fontSize: 12,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// SIDEBAR BOTTOM
// ============================================================================

class _SidebarBottom extends StatelessWidget {
  final String adminName;
  final VoidCallback onProfile;

  const _SidebarBottom({required this.adminName, required this.onProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.07)),
        ),
      ),
      child: Column(
        children: [
          // Language
          Row(
            children: [
              Icon(
                Icons.language_outlined,
                size: 17,
                color: Colors.white.withValues(alpha: 0.55),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Language',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.62),
                    fontSize: 11,
                  ),
                ),
              ),
              Text(
                'English',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.62),
                  fontSize: 10,
                ),
              ),
              const SizedBox(width: 3),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 15,
                color: Colors.white.withValues(alpha: 0.45),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // User
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            child: InkWell(
              borderRadius: BorderRadius.circular(9),
              onTap: onProfile,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.ink3,
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),

                    const SizedBox(width: 9),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            adminName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Super Admin',
                            style: TextStyle(
                              color: AppTheme.textMuted,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// NAVIGATION ITEM MODEL
// ============================================================================

class _NavItem {
  final String title;
  final IconData icon;
  final String route;

  const _NavItem(this.title, this.icon, this.route);
}

// ============================================================================
// APP FOOTER
// ============================================================================

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border(top: BorderSide(color: AppTheme.border)),
      ),
      child: Row(
        children: [
          Text(
            'One Enterprise Cloud Platform',
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(width: 10),

          Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: AppTheme.tealData,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 10),

          Text(
            '© 2026',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 10),
          ),

          const Spacer(),

          if (MediaQuery.of(context).size.width > 600) ...[
            Icon(Icons.shield_outlined, size: 13, color: AppTheme.textMuted),

            const SizedBox(width: 5),

            Text(
              'Enterprise Security',
              style: TextStyle(color: AppTheme.textMuted, fontSize: 10),
            ),

            const SizedBox(width: 18),

            Icon(Icons.cloud_done_outlined, size: 13, color: AppTheme.tealData),

            const SizedBox(width: 5),

            Text(
              'Platform Operational',
              style: TextStyle(color: AppTheme.textMuted, fontSize: 10),
            ),
          ],
        ],
      ),
    );
  }
}
