import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../routes/routes.dart';
import '../providers/user_provider.dart';

// ================================================================
// APP HEADER
// ================================================================

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool sidebarOpen;
  final VoidCallback onMenuPressed;

  const AppHeader({
    super.key,
    required this.sidebarOpen,
    required this.onMenuPressed,
  });

  void _navigate(BuildContext context, String route) {
    if (GoRouterState.of(context).uri.path == route) {
      return;
    }

    context.push(route);
  }

  void _logout(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).logout();

    context.go(AppRoutes.login);
  }

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 850;

    return AppBar(
      backgroundColor: AppTheme.darkNavy,
      elevation: 0,
      toolbarHeight: 68,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          // --------------------------------------------------------
          // SIDEBAR TOGGLE
          // --------------------------------------------------------

          Padding(
            padding: const EdgeInsets.only(left: 8, right: 6),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: onMenuPressed,
                borderRadius: BorderRadius.circular(8),
                hoverColor: Colors.white.withValues(alpha: 0.08),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(
                      sidebarOpen
                          ? Icons.menu_open_rounded
                          : Icons.menu_rounded,
                      color: Colors.white.withValues(alpha: 0.90),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 4),

          // --------------------------------------------------------
          // LOGO
          // --------------------------------------------------------
          Container(
            height: 44,
            width: isMobile ? 125 : 140,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/images/onecloud_logo.png',
              fit: BoxFit.contain,
            ),
          ),

          const Spacer(),

          // --------------------------------------------------------
          // DESKTOP MENU
          // --------------------------------------------------------
          if (!isMobile) ...[
            TextButton(
              onPressed: () {
                _navigate(context, AppRoutes.dashboard);
              },
              child: const Text(
                'Dashboard',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            TextButton(
              onPressed: () {
                _navigate(context, AppRoutes.features);
              },
              child: const Text(
                'Features',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            TextButton(
              onPressed: () {
                _navigate(context, AppRoutes.contact);
              },
              child: const Text(
                'Contact',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            TextButton(
              onPressed: () {
                _navigate(context, AppRoutes.about);
              },
              child: const Text(
                'About',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            const SizedBox(width: 8),

            // ------------------------------------------------------
            // PROFILE
            // ------------------------------------------------------
            if (userProvider.email.isNotEmpty)
              TextButton(
                onPressed: () {
                  _navigate(context, AppRoutes.profile);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      userProvider.name.isNotEmpty
                          ? userProvider.name
                          : userProvider.email,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(width: 6),

            // ------------------------------------------------------
            // LOGOUT
            // ------------------------------------------------------
            IconButton(
              tooltip: 'Logout',
              onPressed: () {
                _logout(context);
              },
              icon: const Icon(Icons.logout, color: Colors.white, size: 21),
            ),

            const SizedBox(width: 6),
          ],

          // --------------------------------------------------------
          // MOBILE MENU
          // --------------------------------------------------------
          if (isMobile)
            IconButton(
              tooltip: 'Profile',
              icon: const Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                context.push(AppRoutes.profile);
              },
            ),
          if (isMobile)
            PopupMenuButton<String>(
              tooltip: 'Menu',
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 28,
              ),
              color: Colors.white,
              elevation: 8,
              offset: const Offset(0, 48),
              onSelected: (value) {
                switch (value) {
                  case 'dashboard':
                    _navigate(context, AppRoutes.dashboard);
                    break;

                  case 'features':
                    _navigate(context, AppRoutes.features);
                    break;

                  case 'contact':
                    _navigate(context, AppRoutes.contact);
                    break;

                  case 'about':
                    _navigate(context, AppRoutes.about);
                    break;

                  case 'profile':
                    _navigate(context, AppRoutes.profile);
                    break;

                  case 'logout':
                    _logout(context);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'dashboard',
                  child: Row(
                    children: [
                      Icon(Icons.dashboard_outlined, size: 20),
                      SizedBox(width: 12),
                      Text('Dashboard'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'features',
                  child: Row(
                    children: [
                      Icon(Icons.apps_outlined, size: 20),
                      SizedBox(width: 12),
                      Text('Features'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'contact',
                  child: Row(
                    children: [
                      Icon(Icons.contact_support_outlined, size: 20),
                      SizedBox(width: 12),
                      Text('Contact'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'about',
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 20),
                      SizedBox(width: 12),
                      Text('About'),
                    ],
                  ),
                ),
                // if (userProvider.email.isNotEmpty)
                //   PopupMenuItem<String>(
                //     value: 'profile',
                //     child: Row(
                //       children: [
                //         const Icon(Icons.account_circle_outlined, size: 20),
                //         const SizedBox(width: 12),
                //         Text(
                //           userProvider.name.isNotEmpty
                //               ? userProvider.name
                //               : 'Profile',
                //         ),
                //       ],
                //     ),
                //   ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 20),
                      SizedBox(width: 12),
                      Text('Logout'),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ================================================================
// APP SIDEBAR
// ================================================================

class AppSidebar extends StatefulWidget {
  const AppSidebar({super.key});

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  bool mainExpanded = true;
  bool operationsExpanded = true;

  void _navigate(BuildContext context, String route) {
    final currentRoute = GoRouterState.of(context).uri.path;

    if (currentRoute == route) {
      return;
    }

    context.push(route);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    final currentRoute = GoRouterState.of(context).uri.path;

    return Container(
      width: 255,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.darkNavy,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 14,
            offset: const Offset(3, 0),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ------------------------------------------------------
            // BRAND
            // ------------------------------------------------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'assets/images/onecloud_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'OneCloud',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Enterprise Platform',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.55),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ------------------------------------------------------
            // NAVIGATION
            // ------------------------------------------------------
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 18, 12, 12),
                children: [
                  _sectionHeader(
                    title: 'MAIN',
                    expanded: mainExpanded,
                    onTap: () {
                      setState(() {
                        mainExpanded = !mainExpanded;
                      });
                    },
                  ),

                  const SizedBox(height: 6),

                  if (mainExpanded) ...[
                    _sidebarItem(
                      context,
                      currentRoute,
                      Icons.dashboard_outlined,
                      'Dashboard',
                      AppRoutes.dashboard,
                    ),
                    _sidebarItem(
                      context,
                      currentRoute,
                      Icons.inventory_2_outlined,
                      'Inventory',
                      AppRoutes.inventory,
                    ),
                    _sidebarItem(
                      context,
                      currentRoute,
                      Icons.warehouse_outlined,
                      'Warehouses',
                      AppRoutes.warehouses,
                    ),
                    _sidebarItem(
                      context,
                      currentRoute,
                      Icons.swap_horiz,
                      'Stock Movements',
                      AppRoutes.stockMovements,
                    ),
                  ],

                  const SizedBox(height: 20),

                  _sectionHeader(
                    title: 'OPERATIONS',
                    expanded: operationsExpanded,
                    onTap: () {
                      setState(() {
                        operationsExpanded = !operationsExpanded;
                      });
                    },
                  ),

                  const SizedBox(height: 6),

                  if (operationsExpanded) ...[
                    _sidebarItem(
                      context,
                      currentRoute,
                      Icons.shopping_cart_outlined,
                      'Procurement',
                      AppRoutes.procurement,
                    ),
                    _sidebarItem(
                      context,
                      currentRoute,
                      Icons.people_outline,
                      'Vendors',
                      AppRoutes.vendors,
                    ),
                    _sidebarItem(
                      context,
                      currentRoute,
                      Icons.receipt_long_outlined,
                      'Sales Orders',
                      AppRoutes.salesOrders,
                    ),
                    _sidebarItem(
                      context,
                      currentRoute,
                      Icons.local_shipping_outlined,
                      'Dispatch',
                      AppRoutes.dispatch,
                    ),
                  ],
                ],
              ),
            ),

            // ------------------------------------------------------
            // USER AREA
            // ------------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                border: Border(
                  top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
                ),
              ),
              child: Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.go(AppRoutes.profile);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name.isEmpty
                                        ? 'Guest User'
                                        : user.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    user.email.isEmpty
                                        ? 'guest@onecloud.com'
                                        : user.email,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.55,
                                      ),
                                      fontSize: 10,
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

                  const SizedBox(height: 8),

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        user.logout();
                        context.go(AppRoutes.login);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white.withValues(alpha: 0.70),
                              size: 19,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.80),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white.withValues(alpha: 0.35),
                              size: 13,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // SECTION HEADER
  // ==============================================================

  Widget _sectionHeader({
    required String title,
    required bool expanded,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.48),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.3,
                ),
              ),
            ),
            AnimatedRotation(
              turns: expanded ? 0.0 : 0.5,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white.withValues(alpha: 0.65),
                size: 19,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // SIDEBAR ITEM
  // ==============================================================

  Widget _sidebarItem(
    BuildContext context,
    String currentRoute,
    IconData icon,
    String title,
    String route,
  ) {
    final selected = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: selected
            ? Colors.white.withValues(alpha: 0.13)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(9),
        child: InkWell(
          borderRadius: BorderRadius.circular(9),
          hoverColor: Colors.white.withValues(alpha: 0.07),
          onTap: () {
            _navigate(context, route);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: selected
                  ? Border.all(color: Colors.white.withValues(alpha: 0.08))
                  : null,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 4,
                  height: selected ? 25 : 0,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                const SizedBox(width: 12),

                Icon(
                  icon,
                  size: 20,
                  color: selected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.62),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.72),
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),

                AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: selected ? 1 : 0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white.withValues(alpha: 0.70),
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// APP FOOTER
// ================================================================

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: AppTheme.darkNavy,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'One Cloud Enterprise Platform',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 10),

          Text(
            '© 2026 All rights reserved',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.60),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// APP LAYOUT
// ================================================================

class AppLayout extends StatefulWidget {
  final Widget child;

  const AppLayout({super.key, required this.child});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  bool sidebarOpen = true;

  @override
  void initState() {
    super.initState();

    // Desktop / tablet = open
    // Mobile = closed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final width = MediaQuery.of(context).size.width;

      setState(() {
        sidebarOpen = width >= 850;
      });
    });
  }

  void _toggleSidebar() {
    setState(() {
      sidebarOpen = !sidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Row(
        children: [
          // ==========================================================
          // DESKTOP / TABLET SIDEBAR
          // ==========================================================

          if (!isMobile)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: sidebarOpen ? 255 : 0,
              child: ClipRect(
                child: sidebarOpen
                    ? const AppSidebar()
                    : const SizedBox.shrink(),
              ),
            ),

          // ==========================================================
          // MAIN AREA
          // ==========================================================
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.white,

              // ------------------------------------------------------
              // HEADER
              // ------------------------------------------------------
              appBar: AppHeader(
                sidebarOpen: sidebarOpen,
                onMenuPressed: _toggleSidebar,
              ),

              // ------------------------------------------------------
              // PAGE CONTENT
              // ------------------------------------------------------
              body: Stack(
                children: [
                  // Current page
                  widget.child,

                  // ==================================================
                  // MOBILE SIDEBAR
                  // ==================================================
                  if (isMobile && sidebarOpen)
                    Positioned.fill(
                      child: Row(
                        children: [
                          const AppSidebar(),

                          // Dark overlay
                          Expanded(
                            child: GestureDetector(
                              onTap: _toggleSidebar,
                              child: Container(
                                color: Colors.black.withOpacity(0.35),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              // ------------------------------------------------------
              // FOOTER
              // ------------------------------------------------------
              bottomNavigationBar: const AppFooter(),
            ),
          ),
        ],
      ),
    );
  }
}
