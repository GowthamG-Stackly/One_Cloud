import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../app_theme.dart';
import '../routes/routes.dart';
import '../providers/user_provider.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  void _navigate(BuildContext context, String route) {
    if (GoRouterState.of(context).uri.path == route) {
      return;
    }

    context.push(route);
  }

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final email = userProvider.email;

    return AppBar(
      backgroundColor: AppTheme.darkNavy,
      elevation: 0,
      toolbarHeight: 68,
      automaticallyImplyLeading: true,
      titleSpacing: 0,

      title: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Row(
          children: [
            // LOGO
            Container(
              height: 46,
              width: 145,
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

            if (MediaQuery.of(context).size.width >= 850) ...[
              // DASHBOARD
              TextButton(
                onPressed: () {
                  _navigate(context, AppRoutes.dashboard);
                },
                child: const Text(
                  'Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),

              // FEATURES
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Features',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),

              // CONTACT
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Contact',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),

              // ABOUT
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

              // PROFILE
              if (email.isNotEmpty)
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
                            : email,
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

              // LOGOUT
              IconButton(
                tooltip: 'Logout',
                onPressed: () {
                  Provider.of<UserProvider>(context, listen: false).logout();

                  context.go(AppRoutes.login);
                },
                icon: const Icon(Icons.logout, color: Colors.white, size: 21),
              ),
            ],

            // MOBILE MENU
            if (MediaQuery.of(context).size.width < 850)
              PopupMenuButton<String>(
                tooltip: 'Menu',
                icon: const Icon(Icons.more_vert, color: Colors.white),
                color: Colors.white,

                onSelected: (value) {
                  if (value == 'dashboard') {
                    _navigate(context, AppRoutes.dashboard);
                  }

                  if (value == 'about') {
                    _navigate(context, AppRoutes.about);
                  }

                  if (value == 'profile') {
                    _navigate(context, AppRoutes.profile);
                  }

                  if (value == 'logout') {
                    Provider.of<UserProvider>(context, listen: false).logout();

                    context.go(AppRoutes.login);
                  }
                },

                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'dashboard',
                    child: Row(
                      children: [
                        Icon(Icons.dashboard_outlined, size: 20),
                        SizedBox(width: 10),
                        Text('Dashboard'),
                      ],
                    ),
                  ),

                  const PopupMenuItem(
                    value: 'features',
                    child: Row(
                      children: [
                        Icon(Icons.widgets_outlined, size: 20),
                        SizedBox(width: 10),
                        Text('Features'),
                      ],
                    ),
                  ),

                  const PopupMenuItem(
                    value: 'contact',
                    child: Row(
                      children: [
                        Icon(Icons.contact_mail_outlined, size: 20),
                        SizedBox(width: 10),
                        Text('Contact'),
                      ],
                    ),
                  ),

                  const PopupMenuItem(
                    value: 'about',
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, size: 20),
                        SizedBox(width: 10),
                        Text('About'),
                      ],
                    ),
                  ),

                  if (email.isNotEmpty)
                    PopupMenuItem(
                      value: 'profile',
                      child: Row(
                        children: [
                          const Icon(Icons.account_circle_outlined, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            userProvider.name.isNotEmpty
                                ? userProvider.name
                                : 'Profile',
                          ),
                        ],
                      ),
                    ),

                  const PopupMenuDivider(),

                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 20),
                        SizedBox(width: 10),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _navigate(BuildContext context, String route) {
    if (GoRouterState.of(context).uri.path == route) {
      Navigator.pop(context);
      return;
    }

    Navigator.pop(context);
    context.push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter, // Starts at the top
                end: Alignment.bottomCenter,
                colors: [AppTheme.primaryBlue, AppTheme.darkNavy],
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/onecloud_logo.png',
                width: 250,
                height: 90,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 10),

          _drawerItem(context, Icons.dashboard, 'Dashboard', () {
            _navigate(context, AppRoutes.dashboard);
          }),

          _drawerItem(context, Icons.inventory_2, 'Products', () {}),

          _drawerItem(context, Icons.warehouse, 'Stock', () {}),

          _drawerItem(context, Icons.swap_horiz, 'Stock Movement', () {}),

          _drawerItem(context, Icons.analytics, 'Reports & Analytics', () {}),

          _drawerItem(context, Icons.warning_amber, 'Stock Alerts', () {}),

          const Spacer(),

          const Divider(),

          _drawerItem(context, Icons.logout, 'Logout', () {
            Provider.of<UserProvider>(context, listen: false).logout();

            context.go(AppRoutes.login);
          }),

          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryBlue),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: AppTheme.darkNavy,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'One Cloud Enterprise Platform',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 10),

          Text(
            '© 2026 All rights reserved',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.65),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
