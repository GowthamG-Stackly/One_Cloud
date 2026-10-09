import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../app_theme.dart';

import '../../routes/routes.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;

        final horizontalPadding = width < 600 ? 16.0 : 28.0;

        return SingleChildScrollView(
          primary: false,

          physics: const ClampingScrollPhysics(),

          padding: EdgeInsets.fromLTRB(
            horizontalPadding,

            18,

            horizontalPadding,

            28,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              const _AdminHeader(),

              const SizedBox(height: 20),

              const _PlatformOverview(),

              const SizedBox(height: 24),

              const _SectionTitle(title: 'MODULE QUICK ACTIONS'),

              const SizedBox(height: 12),

              const _ModuleQuickActions(),

              const SizedBox(height: 24),

              const _SectionTitle(title: 'ORGANIZATION'),

              const SizedBox(height: 12),

              const _OrganizationSection(),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================

// HEADER

// ============================================================================

class _AdminHeader extends StatelessWidget {
  const _AdminHeader();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = constraints.maxWidth < 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Platform Administration',

              maxLines: 1,

              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                fontSize: 11,

                fontWeight: FontWeight.w600,

                color: Color(0xFF65778A),
              ),
            ),

            const SizedBox(height: 5),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                const Expanded(
                  child: Text(
                    'Platform Administration',

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      fontSize: 27,

                      fontWeight: FontWeight.w800,

                      color: Color(0xFF182736),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                if (mobile)
                  IconButton(
                    onPressed: () {},

                    padding: EdgeInsets.zero,

                    constraints: const BoxConstraints(
                      minWidth: 40,

                      minHeight: 40,
                    ),

                    icon: const Icon(
                      Icons.refresh_rounded,

                      size: 24,

                      color: Color(0xFF536170),
                    ),
                  )
                else
                  OutlinedButton.icon(
                    onPressed: () {},

                    icon: const Icon(Icons.refresh_rounded, size: 16),

                    label: const Text(
                      'Refresh',

                      style: TextStyle(
                        fontSize: 11,

                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF182736),

                      side: const BorderSide(color: Color(0xFFDCE2E8)),

                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,

                        vertical: 10,
                      ),

                      minimumSize: const Size(0, 40),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================

// SECTION TITLE

// ============================================================================

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,

      maxLines: 1,

      overflow: TextOverflow.ellipsis,

      style: const TextStyle(
        fontSize: 13,

        letterSpacing: 0.7,

        fontWeight: FontWeight.w700,

        color: Color(0xFF65778A),
      ),
    );
  }
}

// ============================================================================

// KPI DATA

// ============================================================================

class _KpiData {
  final String title;

  final String value;

  final String subtitle;

  final IconData icon;

  final Color iconColor;

  final Color iconBackground;

  const _KpiData({
    required this.title,

    required this.value,

    required this.subtitle,

    required this.icon,

    required this.iconColor,

    required this.iconBackground,
  });
}

// ============================================================================

// PLATFORM OVERVIEW

// ============================================================================

class _PlatformOverview extends StatelessWidget {
  const _PlatformOverview();

  static const items = [
    _KpiData(
      title: 'ORGANIZATIONS',

      value: '1,842',

      subtitle: '↑ 4.2% this month',

      icon: Icons.apartment_outlined,

      iconColor: Color(0xFF159B68),

      iconBackground: Color(0xFFE8F7F0),
    ),

    _KpiData(
      title: 'TOTAL USERS',

      value: '96,412',

      subtitle: '↑ 1.8% this month',

      icon: Icons.people_outline_rounded,

      iconColor: Color(0xFF326CF4),

      iconBackground: Color(0xFFEAF0FF),
    ),

    _KpiData(
      title: 'LICENSES ACTIVE',

      value: '2,140',

      subtitle: '27 expiring < 30 days',

      icon: Icons.description_outlined,

      iconColor: Color(0xFFE14A4A),

      iconBackground: Color(0xFFFFEAEA),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < 700) {
          return Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                _KpiCard(data: items[i]),

                const SizedBox(height: 14),
              ],

              const _UptimeCard(),
            ],
          );
        }

        const gap = 14.0;

        final cardWidth = (width - (gap * 3)) / 4;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              width: cardWidth,

              child: _KpiCard(data: items[0]),
            ),

            const SizedBox(width: gap),

            SizedBox(
              width: cardWidth,

              child: _KpiCard(data: items[1]),
            ),

            const SizedBox(width: gap),

            SizedBox(
              width: cardWidth,

              child: _KpiCard(data: items[2]),
            ),

            const SizedBox(width: gap),

            SizedBox(width: cardWidth, child: const _UptimeCard()),
          ],
        );
      },
    );
  }
}

// ============================================================================

// KPI CARD

// ============================================================================

class _KpiCard extends StatelessWidget {
  final _KpiData data;

  const _KpiCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      height: 136,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: AppTheme.paper,

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: AppTheme.border),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.title,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 9,

                    letterSpacing: 1,

                    fontWeight: FontWeight.w600,

                    color: Color(0xFF718093),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Container(
                width: 32,

                height: 32,

                decoration: BoxDecoration(
                  color: data.iconBackground,

                  borderRadius: BorderRadius.circular(8),
                ),

                child: Icon(data.icon, size: 17, color: data.iconColor),
              ),
            ],
          ),

          const Spacer(),

          Text(
            data.value,

            maxLines: 1,

            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
              fontSize: 25,

              fontWeight: FontWeight.w800,

              color: Color(0xFF182736),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            data.subtitle,

            maxLines: 1,

            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              fontSize: 10,

              fontWeight: FontWeight.w600,

              color: data.subtitle.contains('expiring')
                  ? const Color(0xFF68788B)
                  : const Color(0xFF178451),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================

// UPTIME CARD

// ============================================================================

class _UptimeCard extends StatelessWidget {
  const _UptimeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      height: 136,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF303FEA), Color(0xFF11174C)],
        ),

        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'PLATFORM UPTIME',

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize: 9,

                    letterSpacing: 1,

                    color: Color(0xFFDCE3FF),
                  ),
                ),
              ),

              Container(
                width: 32,

                height: 32,

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(8),
                ),

                child: const Icon(
                  Icons.monitor_heart_outlined,

                  size: 18,

                  color: Color(0xFF1D2A67),
                ),
              ),
            ],
          ),

          const Spacer(),

          const Text(
            '99.98%',

            maxLines: 1,

            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              fontSize: 25,

              fontWeight: FontWeight.w800,

              color: Colors.white,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Healthy — all regions',

            maxLines: 1,

            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              fontSize: 10,

              fontWeight: FontWeight.w600,

              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================

// ADMIN ACTION

// ============================================================================

class _AdminAction {
  final String title;

  final String description;

  final IconData icon;

  final String route;

  const _AdminAction({
    required this.title,

    required this.description,

    required this.icon,

    required this.route,
  });
}

// ============================================================================

// MODULE QUICK ACTIONS

// ============================================================================

class _ModuleQuickActions extends StatelessWidget {
  const _ModuleQuickActions();

  static const actions = [
    _AdminAction(
      title: 'Super Admin Dashboard',

      description: 'Manage and monitor the entire OneCloud platform.',

      icon: Icons.admin_panel_settings_outlined,

      route: AppRoutes.superAdminDashboard,
    ),

    _AdminAction(
      title: 'Global Dashboard',

      description:
          'View overall platform metrics, activity, and system health.',

      icon: Icons.dashboard_outlined,

      route: AppRoutes.globalDashboard,
    ),

    _AdminAction(
      title: 'Platform Configuration',

      description:
          'Configure core platform identity, regional defaults, and security.',

      icon: Icons.tune_outlined,

      route: AppRoutes.platformConfig,
    ),

    _AdminAction(
      title: 'Global Settings',

      description:
          'Manage platform-wide settings, security, and notifications.',

      icon: Icons.settings_outlined,

      route: AppRoutes.globalSettings,
    ),

    _AdminAction(
      title: 'Platform Branding',

      description:
          'Manage platform logos, colors, themes, and visual identity.',

      icon: Icons.branding_watermark_outlined,

      route: AppRoutes.platformBranding,
    ),

    _AdminAction(
      title: 'Feature Management',

      description:
          'Control platform features, availability, configuration, and access.',

      icon: Icons.extension_outlined,

      route: AppRoutes.featureManagement,
    ),

    _AdminAction(
      title: 'License Management',

      description:
          'Manage licenses, plans, subscriptions, and platform entitlements.',

      icon: Icons.description_outlined,

      route: AppRoutes.licenseManagement,
    ),

    _AdminAction(
      title: 'Platform Health Overview',

      description:
          'Monitor infrastructure, services, performance, and system health.',

      icon: Icons.monitor_heart_outlined,

      route: AppRoutes.systemHealth,
    ),

    _AdminAction(
      title: 'Tenant Templates',

      description:
          'Create and manage reusable templates for tenant configuration.',

      icon: Icons.view_quilt_outlined,

      route: AppRoutes.tenantTemplates,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Responsive columns:
        // Mobile  -> 1 card per row
        // Tablet  -> 2 cards per row
        // Desktop -> 3 cards per row
        final int columns;

        if (width < 600) {
          columns = 1;
        } else if (width < 950) {
          columns = 2;
        } else {
          columns = 3;
        }

        const spacing = 14.0;

        final cardWidth = columns == 1
            ? width
            : (width - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,

          runSpacing: spacing,

          children: [
            for (final action in actions)
              SizedBox(
                width: cardWidth,

                child: _ActionCard(action: action),
              ),
          ],
        );
      },
    );
  }
}

// ============================================================================

// ACTION CARD

// ============================================================================

class _ActionCard extends StatelessWidget {
  final _AdminAction action;

  const _ActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(12),

        onTap: () => context.push(action.route),

        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).width >= 950 ? 125 : 104,
          ),
          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: AppTheme.paper,

            borderRadius: BorderRadius.circular(12),

            border: Border.all(color: AppTheme.border),
          ),

          child: Row(
            children: [
              Container(
                width: 40,

                height: 40,

                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),

                  borderRadius: BorderRadius.circular(10),
                ),

                child: Icon(
                  action.icon,

                  size: 20,

                  color: const Color(0xFF2939E8),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      action.title,

                      maxLines: 2,

                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        color: AppTheme.text,

                        fontSize: 13,

                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      action.description,

                      maxLines: 2,

                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        color: AppTheme.textMuted,

                        fontSize: 10,

                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 4),

              const Icon(
                Icons.north_east_rounded,

                size: 15,

                color: Color(0xFF738092),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================

// ORGANIZATION

// ============================================================================

class _OrganizationSection extends StatelessWidget {
  const _OrganizationSection();

  static const actions = [
    _AdminAction(
      title: 'Company Setup',

      description:
          'Configure company details, organization information, and defaults.',

      icon: Icons.business_outlined,

      route: '/company-setup',
    ),

    _AdminAction(
      title: 'User Management',

      description: 'Manage users, roles, permissions, and access across the organization.',

      icon: Icons.people_outline_rounded,

      route: '/user-management',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              _OrganizationCard(action: actions[0]),

              const SizedBox(height: 14),

              _OrganizationCard(action: actions[1]),
            ],
          );
        }

        const gap = 14.0;

        final cardWidth = (constraints.maxWidth - gap) / 2;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              width: cardWidth,

              child: _OrganizationCard(action: actions[0]),
            ),

            const SizedBox(width: gap),

            SizedBox(
              width: cardWidth,

              child: _OrganizationCard(action: actions[1]),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================

// ORGANIZATION CARD

// ============================================================================

class _OrganizationCard extends StatelessWidget {
  final _AdminAction action;

  const _OrganizationCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(12),

        onTap: () => context.push(action.route),

        child: Container(
          width: double.infinity,

          constraints: const BoxConstraints(minHeight: 110),

          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: AppTheme.paper,

            borderRadius: BorderRadius.circular(12),

            border: Border.all(color: AppTheme.border),
          ),

          child: Row(
            children: [
              Container(
                width: 40,

                height: 40,

                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),

                  borderRadius: BorderRadius.circular(9),
                ),

                child: Icon(
                  action.icon,

                  size: 20,

                  color: const Color(0xFF2939E8),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  action.title,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 13,

                    fontWeight: FontWeight.w800,

                    color: Color(0xFF182736),
                  ),
                ),
              ),

              const SizedBox(width: 6),

              const Icon(
                Icons.north_east_rounded,

                size: 15,

                color: Color(0xFF738092),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
