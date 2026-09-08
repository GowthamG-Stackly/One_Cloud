import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/routes.dart';
import '../providers/user_provider.dart';
import '../app_theme.dart';
import '../widgets/app_layout.dart';

// import '../routes.dart'

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const Color background = Color(0xFFF5FAFD);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: background,
      appBar: const AppHeader(),
      drawer: const AppDrawer(),
      body: _body(context, user),
    );
  }

  //  BODY

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
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Center(
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
                          gradient: LinearGradient(
                            colors: [AppTheme.darkNavy, AppTheme.primaryBlue],
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
                                      color: Colors.white.withValues(
                                        alpha: 0.85,
                                      ),
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
                          _card(
                            'Total Stock',
                            '1,250',
                            Icons.warehouse_outlined,
                          ),
                          _card(
                            'Low Stock',
                            '18',
                            Icons.warning_amber_outlined,
                          ),
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
                            _action(
                              'Remove Stock',
                              Icons.remove_circle_outline,
                            ),
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
              const SizedBox(height: 25),

              const AppFooter(),
            ],
          ),
        );
      },
    );
  }

  // SUMMARY CARD

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
              color: AppTheme.lightBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primaryBlue, size: 24),
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

  //  SECTION

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
              Icon(icon, color: AppTheme.primaryBlue, size: 22),
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

  //  STOCK ROW

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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
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
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryBlue),
          ),
        ),
      ],
    );
  }

  //  ACTION

  Widget _action(String title, IconData icon) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: AppTheme.lightBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppTheme.primaryBlue, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: AppTheme.darkNavy,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  ACTIVITY

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
            color: AppTheme.lightBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.primaryBlue, size: 20),
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

  //  LOGOUT

  void _logout(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).logout();

    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }
}
