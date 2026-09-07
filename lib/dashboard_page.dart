import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';
import 'user_provider.dart';
import 'welcome_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const Color green = Color(0xFF16A34A);
  static const Color darkGreen = Color(0xFF087443);
  static const Color background = Color(0xFFF4FAF6);
  static const Color lightGreen = Color(0xFFE8F7EC);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: background,
      appBar: _header(context, user),
      drawer: _drawer(context),
      body: _body(context, user),
    );
  }

  // ================= HEADER =================

  PreferredSizeWidget _header(BuildContext context, UserProvider user) {
    return AppBar(
      backgroundColor: darkGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 72,

      leading: MediaQuery.of(context).size.width < 800
          ? Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                );
              },
            )
          : null,

      title: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'GT',
                style: TextStyle(
                  color: darkGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GT-InStock',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (MediaQuery.of(context).size.width >= 600)
                Text(
                  'Global Tracking InStock',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 10,
                  ),
                ),
            ],
          ),
        ],
      ),

      actions: [
        if (MediaQuery.of(context).size.width >= 800) ...[
          TextButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomePage()),
              );
            },
            icon: Icon(Icons.home_outlined, color: Colors.white),
            label: Text('Home', style: TextStyle(color: Colors.white)),
          ),

          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              user.email.isEmpty ? 'User' : user.email,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),

          IconButton(
            onPressed: () => _logout(context),
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ],
    );
  }

  // ================= BODY =================

  Widget _body(BuildContext context, UserProvider user) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns;

        if (constraints.maxWidth >= 1100) {
          columns = 4;
        } else if (constraints.maxWidth >= 650) {
          columns = 2;
        } else {
          columns = 1;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [darkGreen, green],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.dashboard_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dashboard',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Monitor your inventory',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // SUMMARY CARDS
                  GridView.count(
                    crossAxisCount: columns,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: columns == 1 ? 3.5 : 1.7,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _card(
                        'Total Products',
                        '120',
                        Icons.inventory_2_outlined,
                      ),
                      _card('Total Stock', '1,250', Icons.warehouse_outlined),
                      _card('Low Stock', '18', Icons.warning_amber_outlined),
                      _card(
                        'Out of Stock',
                        '7',
                        Icons.remove_shopping_cart_outlined,
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // INVENTORY
                  _section(
                    title: 'Inventory Overview',
                    icon: Icons.bar_chart_outlined,
                    child: Column(
                      children: [
                        _stockRow('Available Stock', '1,225', 0.85),
                        const SizedBox(height: 18),
                        _stockRow('Low Stock', '18', 0.10),
                        const SizedBox(height: 18),
                        _stockRow('Out of Stock', '7', 0.05),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // QUICK ACTIONS
                  _section(
                    title: 'Quick Actions',
                    icon: Icons.flash_on_outlined,
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _action('Add Product', Icons.add_box_outlined),
                        _action('Add Stock', Icons.add_circle_outline),
                        _action('Remove Stock', Icons.remove_circle_outline),
                        _action('Reports', Icons.analytics_outlined),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // RECENT ACTIVITY
                  _section(
                    title: 'Recent Activity',
                    icon: Icons.history,
                    child: Column(
                      children: [
                        _activity(
                          Icons.add_box_outlined,
                          'New product added',
                          'Wireless Keyboard',
                          '10 min ago',
                        ),
                        const Divider(),
                        _activity(
                          Icons.inventory_outlined,
                          'Stock updated',
                          'Laptop +25 units',
                          '35 min ago',
                        ),
                        const Divider(),
                        _activity(
                          Icons.warning_amber_outlined,
                          'Low stock alert',
                          'USB-C Cable',
                          '1 hour ago',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ================= SUMMARY CARD =================

  Widget _card(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: green, size: 24),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= SECTION =================

  Widget _section({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: green, size: 22),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          child,
        ],
      ),
    );
  }

  // ================= STOCK ROW =================

  Widget _stockRow(String title, String value, double percentage) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, color: green),
            ),
          ],
        ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(green),
          ),
        ),
      ],
    );
  }

  // ================= ACTION =================

  Widget _action(String title, IconData icon) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: green, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(color: darkGreen, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // ================= ACTIVITY =================

  Widget _activity(
    IconData icon,
    String title,
    String description,
    String time,
  ) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: lightGreen,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: green, size: 20),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),

        Text(time, style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),
      ],
    );
  }

  // ================= DRAWER =================

  Widget _drawer(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    String username = 'User';

    if (user.email.isNotEmpty) {
      username = user.email.split('@').first;

      if (username.isNotEmpty) {
        username = username[0].toUpperCase() + username.substring(1);
      }
    }

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 22),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [darkGreen, green]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'GT',
                          style: TextStyle(
                            color: darkGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Text(
                      'GT-InStock',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // USER INFORMATION
                const SizedBox(height: 20),

                Text(
                  username,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  user.email.isEmpty ? 'No email available' : user.email,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.80),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          _drawerItem(context, Icons.home_outlined, 'Home', () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomePage()),
            );
          }),

          _drawerItem(context, Icons.dashboard_outlined, 'Dashboard', () {
            Navigator.pop(context);
          }, selected: true),

          _drawerItem(context, Icons.inventory_2_outlined, 'Products', () {}),

          _drawerItem(context, Icons.warehouse_outlined, 'Stock', () {}),

          _drawerItem(context, Icons.swap_vert, 'Stock Movement', () {}),

          _drawerItem(
            context,
            Icons.analytics_outlined,
            'Reports & Analytics',
            () {},
          ),

          _drawerItem(context, Icons.notifications_none, 'Stock Alerts', () {}),

          const Spacer(),

          _drawerItem(context, Icons.logout, 'Logout', () => _logout(context)),

          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool selected = false,
  }) {
    return ListTile(
      onTap: onTap,
      selected: selected,
      selectedTileColor: lightGreen,
      leading: Icon(icon, color: selected ? green : Colors.grey.shade700),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? darkGreen : Colors.black87,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // ================= LOGOUT =================

  void _logout(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).logout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }
}
