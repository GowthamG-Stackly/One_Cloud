import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../app_theme.dart';
import '../widgets/app_layout.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const Color background = Color(0xFFF5F8FC);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: background,
      body: _DashboardBody(user: user),
    );
  }
}

// ================================================================
// DASHBOARD BODY
// ================================================================

class _DashboardBody extends StatelessWidget {
  final UserProvider user;

  const _DashboardBody({required this.user});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final bool isMobile = width < 700;
        final bool isTablet = width >= 700 && width < 1100;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 14 : 28,
                  vertical: isMobile ? 18 : 24,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1400),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPageHeader(context, isMobile: isMobile),

                        const SizedBox(height: 20),

                        _buildKpiCards(isMobile: isMobile, isTablet: isTablet),

                        const SizedBox(height: 20),

                        _buildOverview(isMobile: isMobile),

                        const SizedBox(height: 20),

                        _buildRecentActivity(context, isMobile: isMobile),

                        const SizedBox(height: 20),

                        _buildQuickActions(isMobile: isMobile),
                      ],
                    ),
                  ),
                ),
              ),

              // Full-width page footer
              const AppFooter(),
            ],
          ),
        );
      },
    );
  }

  // ================================================================
  // PAGE HEADER
  // ================================================================

  Widget _buildPageHeader(BuildContext context, {required bool isMobile}) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppTheme.darkNavy,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Overview of your inventory and stock operations',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 14),

          _todayBadge(),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.darkNavy,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                'Overview of your inventory and stock operations',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),

        _todayBadge(),
      ],
    );
  }

  // ================================================================
  // TODAY BADGE
  // ================================================================

  Widget _todayBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 16,
            color: AppTheme.primaryBlue,
          ),
          const SizedBox(width: 8),
          Text(
            'Today',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // KPI CARDS
  // ================================================================

  Widget _buildKpiCards({required bool isMobile, required bool isTablet}) {
    final cards = [
      const _KpiData(
        title: 'Total Products',
        value: '1,248',
        change: '+8.2%',
        subtitle: 'vs last month',
        icon: Icons.inventory_2_outlined,
      ),
      const _KpiData(
        title: 'Total Stock',
        value: '18,420',
        change: '+5.4%',
        subtitle: 'units available',
        icon: Icons.warehouse_outlined,
      ),
      const _KpiData(
        title: 'Low Stock',
        value: '24',
        change: 'Needs attention',
        subtitle: 'products',
        icon: Icons.warning_amber_outlined,
      ),
      const _KpiData(
        title: 'Out of Stock',
        value: '07',
        change: 'Critical',
        subtitle: 'products',
        icon: Icons.remove_shopping_cart_outlined,
      ),
    ];

    if (isMobile) {
      return Column(
        children: [
          for (int i = 0; i < cards.length; i++) ...[
            _buildKpiCard(cards[i], compact: true),
            if (i != cards.length - 1) const SizedBox(height: 10),
          ],
        ],
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 2 : 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isTablet ? 2.8 : 2.05,
      ),
      itemBuilder: (context, index) {
        return _buildKpiCard(cards[index]);
      },
    );
  }

  // ================================================================
  // KPI CARD
  // ================================================================

  Widget _buildKpiCard(_KpiData data, {bool compact = false}) {
    Color cardColor;
    Color iconBackground;
    Color iconColor;

    switch (data.title) {
      case 'Total Products':
        cardColor = const Color(0xFFF2F7FF);
        iconBackground = const Color(0xFFDCEAFF);
        iconColor = AppTheme.primaryBlue;
        break;

      case 'Total Stock':
        cardColor = const Color(0xFFF0F9FA);
        iconBackground = const Color(0xFFD9F0F2);
        iconColor = const Color(0xFF168A9B);
        break;

      case 'Low Stock':
        cardColor = const Color(0xFFFFF8ED);
        iconBackground = const Color(0xFFFFEBC7);
        iconColor = const Color(0xFFD88900);
        break;

      default:
        cardColor = const Color(0xFFFFF1F1);
        iconBackground = const Color(0xFFFFDCDC);
        iconColor = const Color(0xFFD94A4A);
    }

    final bool isWarning =
        data.title == 'Low Stock' || data.title == 'Out of Stock';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 15 : 18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          Container(
            width: compact ? 44 : 46,
            height: compact ? 44 : 46,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(data.icon, size: compact ? 21 : 22, color: iconColor),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: compact ? 11 : 12,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  data.value,
                  style: TextStyle(
                    fontSize: compact ? 21 : 22,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkNavy,
                  ),
                ),

                const SizedBox(height: 2),

                Wrap(
                  spacing: 5,
                  children: [
                    Text(
                      data.change,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isWarning ? iconColor : Colors.green.shade700,
                      ),
                    ),
                    Text(
                      data.subtitle,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // OVERVIEW
  // ================================================================

  Widget _buildOverview({required bool isMobile}) {
    if (isMobile) {
      return Column(
        children: [
          _buildInventoryHealth(),

          const SizedBox(height: 16),

          _buildStockMovement(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildInventoryHealth()),

        const SizedBox(width: 18),

        Expanded(child: _buildStockMovement()),
      ],
    );
  }

  // ================================================================
  // INVENTORY HEALTH
  // ================================================================

  Widget _buildInventoryHealth() {
    return _panel(
      title: 'Inventory Health',
      icon: Icons.inventory_2_outlined,
      backgroundColor: const Color(0xFFF8FBFF),
      borderColor: const Color(0xFFE1ECFA),
      trailing: Text(
        '1,248 products',
        style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
      ),
      child: Column(
        children: [
          _healthRow(
            label: 'Healthy Stock',
            value: '1,217',
            percentage: '97.5%',
            progress: 0.975,
            color: Colors.green.shade600,
            icon: Icons.check_circle_outline,
          ),

          const SizedBox(height: 18),

          _healthRow(
            label: 'Low Stock',
            value: '24',
            percentage: '1.9%',
            progress: 0.019,
            color: Colors.orange.shade600,
            icon: Icons.warning_amber_outlined,
          ),

          const SizedBox(height: 18),

          _healthRow(
            label: 'Out of Stock',
            value: '7',
            percentage: '0.6%',
            progress: 0.006,
            color: Colors.red.shade500,
            icon: Icons.error_outline,
          ),
        ],
      ),
    );
  }

  Widget _healthRow({
    required String label,
    required String value,
    required String percentage,
    required double progress,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),

            const SizedBox(width: 9),

            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF263143),
                ),
              ),
            ),

            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppTheme.darkNavy,
              ),
            ),

            const SizedBox(width: 8),

            SizedBox(
              width: 42,
              child: Text(
                percentage,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  // ================================================================
  // STOCK MOVEMENT
  // ================================================================

  Widget _buildStockMovement() {
    return _panel(
      title: 'Stock Movement',
      icon: Icons.swap_vert_rounded,
      backgroundColor: const Color(0xFFF7FCFD),
      borderColor: const Color(0xFFDDEFF1),
      trailing: Text(
        'This week',
        style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
      ),
      child: Column(
        children: [
          _movementRow(
            'Stock Received',
            '+2,450',
            Icons.arrow_downward_rounded,
            Colors.green.shade600,
          ),

          const Divider(height: 24),

          _movementRow(
            'Stock Dispatched',
            '-1,820',
            Icons.arrow_upward_rounded,
            AppTheme.primaryBlue,
          ),

          const Divider(height: 24),

          _movementRow(
            'Stock Adjusted',
            '+320',
            Icons.sync_alt_rounded,
            Colors.orange.shade600,
          ),

          const SizedBox(height: 16),

          _buildMiniChart(),
        ],
      ),
    );
  }

  Widget _movementRow(String title, String value, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: color),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF263143),
            ),
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppTheme.darkNavy,
          ),
        ),
      ],
    );
  }

  // ================================================================
  // MINI CHART
  // ================================================================

  Widget _buildMiniChart() {
    final values = [0.55, 0.72, 0.45, 0.85, 0.65, 0.92, 0.75];

    final labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return SizedBox(
      height: 90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(values.length, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: values[index],
                        child: Container(
                          width: 16,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withValues(alpha: 0.65),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    labels[index],
                    style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // ================================================================
  // RECENT ACTIVITY
  // ================================================================

  Widget _buildRecentActivity(BuildContext context, {required bool isMobile}) {
    return _panel(
      title: 'Recent Activity',
      icon: Icons.history_rounded,
      backgroundColor: Colors.white,
      borderColor: Colors.grey.shade200,
      trailing: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 30),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'View all',
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.primaryBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: isMobile ? _buildMobileActivity() : _buildDesktopActivity(),
    );
  }

  // ================================================================
  // DESKTOP ACTIVITY
  // ================================================================

  Widget _buildDesktopActivity() {
    return Column(
      children: [
        _activityHeader(),

        const Divider(height: 18),

        _activityRow(
          icon: Icons.add_box_outlined,
          action: 'Product Added',
          item: 'Wireless Keyboard',
          user: 'Admin',
          time: '10 min ago',
          status: 'Completed',
        ),

        const Divider(height: 1),

        _activityRow(
          icon: Icons.inventory_2_outlined,
          action: 'Stock Received',
          item: 'Laptop Pro 14"',
          user: 'Warehouse',
          time: '35 min ago',
          status: 'Completed',
        ),

        const Divider(height: 1),

        _activityRow(
          icon: Icons.local_shipping_outlined,
          action: 'Stock Dispatched',
          item: 'USB-C Cable',
          user: 'Dispatch',
          time: '1 hour ago',
          status: 'Completed',
        ),

        const Divider(height: 1),

        _activityRow(
          icon: Icons.warning_amber_outlined,
          action: 'Low Stock Alert',
          item: 'Wireless Mouse',
          user: 'System',
          time: '2 hours ago',
          status: 'Attention',
        ),
      ],
    );
  }

  Widget _activityHeader() {
    return const Row(
      children: [
        SizedBox(width: 42),

        Expanded(
          flex: 2,
          child: Text(
            'ACTIVITY',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8992A3),
            ),
          ),
        ),

        Expanded(
          child: Text(
            'USER',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8992A3),
            ),
          ),
        ),

        Expanded(
          child: Text(
            'TIME',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8992A3),
            ),
          ),
        ),

        SizedBox(
          width: 80,
          child: Text(
            'STATUS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8992A3),
            ),
          ),
        ),
      ],
    );
  }

  // ================================================================
  // DESKTOP ACTIVITY ROW
  // ================================================================

  Widget _activityRow({
    required IconData icon,
    required String action,
    required String item,
    required String user,
    required String time,
    required String status,
  }) {
    final bool attention = status == 'Attention';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppTheme.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 17, color: AppTheme.primaryBlue),
          ),

          const SizedBox(width: 8),

          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF263143),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  item,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),

          Expanded(
            child: Text(
              user,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ),

          Expanded(
            child: Text(
              time,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ),

          SizedBox(
            width: 80,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _statusBadge(status, attention: attention),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // MOBILE ACTIVITY
  // ================================================================

  Widget _buildMobileActivity() {
    return Column(
      children: [
        _mobileActivityItem(
          icon: Icons.add_box_outlined,
          title: 'Product Added',
          item: 'Wireless Keyboard',
          user: 'Admin',
          time: '10 min ago',
          status: 'Completed',
        ),

        const Divider(height: 1),

        _mobileActivityItem(
          icon: Icons.inventory_2_outlined,
          title: 'Stock Received',
          item: 'Laptop Pro 14"',
          user: 'Warehouse',
          time: '35 min ago',
          status: 'Completed',
        ),

        const Divider(height: 1),

        _mobileActivityItem(
          icon: Icons.local_shipping_outlined,
          title: 'Stock Dispatched',
          item: 'USB-C Cable',
          user: 'Dispatch',
          time: '1 hour ago',
          status: 'Completed',
        ),

        const Divider(height: 1),

        _mobileActivityItem(
          icon: Icons.warning_amber_outlined,
          title: 'Low Stock Alert',
          item: 'Wireless Mouse',
          user: 'System',
          time: '2 hours ago',
          status: 'Attention',
        ),
      ],
    );
  }

  // ================================================================
  // MOBILE ACTIVITY ITEM
  // ================================================================

  Widget _mobileActivityItem({
    required IconData icon,
    required String title,
    required String item,
    required String user,
    required String time,
    required String status,
  }) {
    final bool attention = status == 'Attention';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppTheme.lightBlue,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 18, color: AppTheme.primaryBlue),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkNavy,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 3),

                Text(
                  item,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),

                const SizedBox(height: 7),

                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 13,
                      color: Colors.grey.shade500,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      user,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(width: 10),

                    _statusBadge(status, attention: attention),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // STATUS BADGE
  // ================================================================

  Widget _statusBadge(String status, {required bool attention}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: attention ? const Color(0xFFFFF4E5) : const Color(0xFFEAF8EF),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: attention ? Colors.orange.shade700 : Colors.green.shade700,
        ),
      ),
    );
  }

  // ================================================================
  // QUICK ACTIONS
  // ================================================================

  Widget _buildQuickActions({required bool isMobile}) {
    return _panel(
      title: 'Quick Actions',
      icon: Icons.flash_on_outlined,
      backgroundColor: const Color(0xFFF8FBFF),
      borderColor: const Color(0xFFE1ECFA),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _quickAction('Add Product', Icons.add_box_outlined),
          _quickAction('Receive Stock', Icons.add_circle_outline),
          _quickAction('Dispatch Stock', Icons.local_shipping_outlined),
          _quickAction('View Reports', Icons.analytics_outlined),
        ],
      ),
    );
  }

  Widget _quickAction(String title, IconData icon) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.primaryBlue.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 17, color: AppTheme.primaryBlue),

            const SizedBox(width: 7),

            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkNavy,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // COMMON PANEL
  // ================================================================

  Widget _panel({
    required String title,
    required IconData icon,
    required Widget child,
    required Color backgroundColor,
    required Color borderColor,
    Widget? trailing,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppTheme.lightBlue,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(icon, size: 16, color: AppTheme.primaryBlue),
              ),

              const SizedBox(width: 9),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkNavy,
                  ),
                ),
              ),

              if (trailing != null) trailing,
            ],
          ),

          const SizedBox(height: 17),

          child,
        ],
      ),
    );
  }
}

// ================================================================
// KPI MODEL
// ================================================================

class _KpiData {
  final String title;
  final String value;
  final String change;
  final String subtitle;
  final IconData icon;

  const _KpiData({
    required this.title,
    required this.value,
    required this.change,
    required this.subtitle,
    required this.icon,
  });
}
