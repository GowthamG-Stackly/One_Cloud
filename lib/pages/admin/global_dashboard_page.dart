import 'package:flutter/material.dart';

import '../../app_theme.dart';

class GlobalDashboardPage extends StatefulWidget {
  const GlobalDashboardPage({super.key});

  @override
  State<GlobalDashboardPage> createState() => _GlobalDashboardPageState();
}

class _GlobalDashboardPageState extends State<GlobalDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool mobile = constraints.maxWidth < 700;

              return SingleChildScrollView(
                padding: EdgeInsets.all(
                  mobile ? AppTheme.space12 : AppTheme.space24,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    _buildPageHeader(mobile),

                    SizedBox(height: mobile ? 14 : 22),

                    _buildKpis(mobile),

                    const SizedBox(height: 24),

                    _buildTitle(
                      'Quick Navigation',

                      'Access frequently used platform functions.',
                    ),

                    const SizedBox(height: 12),

                    _buildQuickNavigation(mobile),

                    const SizedBox(height: 24),

                    _buildTitle(
                      'Platform Health',

                      'Current infrastructure and service status.',
                    ),

                    const SizedBox(height: 12),

                    _buildHealth(mobile),

                    const SizedBox(height: 24),

                    _buildActivity(mobile),

                    const SizedBox(height: 24),

                    if (mobile)
                      SizedBox(
                        width: double.infinity,
                        child: _buildExportButton(),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PAGE HEADER
  // ============================================================

  Widget _buildPageHeader(bool mobile) {
    if (mobile) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Platform Administration / Global Dashboard',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
                ),
                const SizedBox(height: 6),
                Text(
                  'Global Dashboard',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppTheme.text,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            tooltip: 'Refresh',
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh, size: 21),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Platform Administration / Global Dashboard',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
              ),
              const SizedBox(height: 6),
              Text(
                'Global Dashboard',
                style: TextStyle(
                  color: AppTheme.text,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Track performance, engagement and growth across all your social plaftorms in our place.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: () => setState(() {}),
          icon: const Icon(Icons.refresh, size: 17),
          label: const Text('Refresh'),
        ),
        const SizedBox(width: 8),
        _buildExportButton(),
      ],
    );
  }

  Widget _buildExportButton() {
    return ElevatedButton.icon(
      onPressed: _showExportDialog,
      icon: const Icon(Icons.file_download_outlined, size: 18),
      label: const Text('Export Report'),
    );
  }

  // ============================================================

  // SECTION TITLE

  // ============================================================

  Widget _buildTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,

          style: TextStyle(
            color: AppTheme.text,

            fontSize: 18,

            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          subtitle,

          maxLines: 2,

          overflow: TextOverflow.ellipsis,

          style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
        ),
      ],
    );
  }

  // ============================================================

  // KPI CARDS

  // ============================================================

  Widget _buildKpis(bool mobile) {
    final items = [
      const _Kpi(
        title: 'Total Tenants',

        value: '132',

        change: '+8%',

        icon: Icons.business_outlined,
      ),

      const _Kpi(
        title: 'Total Users',

        value: '48,920',

        change: '+13%',

        icon: Icons.people_outline,
      ),

      const _Kpi(
        title: 'Active Subscriptions',

        value: '1,233',

        change: '+10%',

        icon: Icons.card_membership_outlined,
      ),

      const _Kpi(
        title: 'Active Sessions',

        value: '789',

        change: '+6%',

        icon: Icons.devices_outlined,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      itemCount: items.length,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: mobile ? 2 : 4,

        crossAxisSpacing: 10,

        mainAxisSpacing: 10,

        childAspectRatio: mobile ? 1.25 : 1.9,
      ),

      itemBuilder: (context, index) {
        return _kpiCard(items[index]);
      },
    );
  }

  Widget _kpiCard(_Kpi item) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: AppTheme.paper,

        border: Border.all(color: AppTheme.border),

        borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                width: 32,

                height: 32,

                decoration: BoxDecoration(
                  color: AppTheme.tealData.withOpacity(0.12),

                  borderRadius: BorderRadius.circular(8),
                ),

                child: Icon(item.icon, color: AppTheme.ink, size: 18),
              ),

              const Spacer(),

              Text(
                item.change,

                style: TextStyle(
                  color: AppTheme.success,

                  fontSize: 10,

                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            item.value,

            maxLines: 1,

            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              color: AppTheme.ink,

              fontSize: 20,

              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            item.title,

            maxLines: 1,

            overflow: TextOverflow.ellipsis,

            style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  // ============================================================

  // QUICK NAVIGATION

  // ============================================================

  Widget _buildQuickNavigation(bool mobile) {
    final items = [
      const _Quick(
        title: 'Manage Tenants',

        subtitle: 'Manage accounts & roles',

        icon: Icons.business_center_outlined,
      ),

      const _Quick(
        title: 'Platform Settings',

        subtitle: 'Global configuration',

        icon: Icons.settings_outlined,
      ),

      const _Quick(
        title: 'Generate Report',

        subtitle: 'Renewals & seat usage',

        icon: Icons.bar_chart_outlined,
      ),

      const _Quick(
        title: 'System Monitoring',

        subtitle: 'Track admin actions',

        icon: Icons.monitor_heart_outlined,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      itemCount: items.length,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: mobile ? 2 : 4,

        crossAxisSpacing: 10,

        mainAxisSpacing: 10,

        childAspectRatio: mobile ? 1.35 : 2.2,
      ),

      itemBuilder: (context, index) {
        return _quickCard(items[index]);
      },
    );
  }

  Widget _quickCard(_Quick item) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppTheme.radiusDefault),

      onTap: () {},

      child: Container(
        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: AppTheme.paper,

          border: Border.all(color: AppTheme.border),

          borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
        ),

        child: Row(
          children: [
            Container(
              width: 34,

              height: 34,

              decoration: BoxDecoration(
                color: AppTheme.amberAI.withOpacity(0.12),

                borderRadius: BorderRadius.circular(8),
              ),

              child: Icon(item.icon, color: AppTheme.ink, size: 18),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    item.title,

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      color: AppTheme.text,

                      fontSize: 11,

                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    item.subtitle,

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(color: AppTheme.textMuted, fontSize: 9),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 2),

            Icon(Icons.chevron_right, size: 16, color: AppTheme.textMuted),
          ],
        ),
      ),
    );
  }

  // ============================================================

  // HEALTH

  // ============================================================

  Widget _buildHealth(bool mobile) {
    if (mobile) {
      return Column(
        children: [
          _platformHealth(),

          const SizedBox(height: 12),

          _systemHealth(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Expanded(child: _platformHealth()),

        const SizedBox(width: 12),

        Expanded(child: _systemHealth()),
      ],
    );
  }

  Widget _platformHealth() {
    return _card(
      title: 'Platform Health',

      icon: Icons.health_and_safety_outlined,

      child: Column(
        children: [
          _progress('CPU Usage', 0.67, '67%', AppTheme.warning),

          const SizedBox(height: 15),

          _progress('Memory Usage', 0.54, '54%', AppTheme.success),

          const SizedBox(height: 15),

          _progress('Disk I/O', 0.32, '32%', AppTheme.success),

          const SizedBox(height: 15),

          _progress('Network Bandwidth', 0.78, '78%', AppTheme.warning),
        ],
      ),
    );
  }

  Widget _progress(String title, double value, String percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(color: AppTheme.text, fontSize: 12),
              ),
            ),

            Text(
              percentage,

              style: TextStyle(
                color: AppTheme.text,

                fontSize: 11,

                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        LinearProgressIndicator(
          value: value,

          minHeight: 6,

          backgroundColor: AppTheme.paperDim,

          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Widget _systemHealth() {
    final values = [0.8, 0.65, 0.9, 0.75, 0.85, 0.7, 0.95, 0.8];

    return _card(
      title: 'System Health',

      icon: Icons.monitor_heart_outlined,

      child: Column(
        children: [
          SizedBox(
            height: 130,

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: values.map((value) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),

                    child: Container(
                      height: 110 * value,

                      decoration: BoxDecoration(
                        color: value < 0.7
                            ? AppTheme.warning
                            : AppTheme.tealData,

                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 14),

          Wrap(
            spacing: 14,

            runSpacing: 8,

            children: [
              _legend('Operational', AppTheme.success),

              _legend('Degraded', AppTheme.warning),

              _legend('Down', AppTheme.danger),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legend(String title, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,

      children: [
        Container(
          width: 8,

          height: 8,

          decoration: BoxDecoration(
            color: color,

            borderRadius: BorderRadius.circular(2),
          ),
        ),

        const SizedBox(width: 5),

        Text(title, style: TextStyle(color: AppTheme.textMuted, fontSize: 10)),
      ],
    );
  }

  // ============================================================

  // ACTIVITY

  // ============================================================

  Widget _buildActivity(bool mobile) {
    if (mobile) {
      return Column(
        children: [_securityCard(), const SizedBox(height: 12), _recentCard()],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Expanded(child: _securityCard()),

        const SizedBox(width: 12),

        Expanded(child: _recentCard()),
      ],
    );
  }

  Widget _securityCard() {
    return _card(
      title: 'Security Alerts',

      icon: Icons.security_outlined,

      child: Column(
        children: [
          _activityRow(
            Icons.warning_amber_outlined,

            'High CPU Usage',

            'Production server exceeded 65%.',

            '10 min ago',

            AppTheme.warning,
          ),

          Divider(color: AppTheme.border),

          _activityRow(
            Icons.storage_outlined,

            'Storage Threshold',

            'Database storage reached 80%.',

            '32 min ago',

            AppTheme.warning,
          ),

          Divider(color: AppTheme.border),

          _activityRow(
            Icons.person_add_outlined,

            'New Tenant Registration',

            'A new tenant account was created.',

            '1 hour ago',

            AppTheme.info,
          ),
        ],
      ),
    );
  }

  Widget _recentCard() {
    return _card(
      title: 'Recent Activities',

      icon: Icons.history_outlined,

      child: Column(
        children: [
          _activityRow(
            Icons.settings_outlined,

            'Platform settings updated',

            'Admin',

            '12 min ago',

            AppTheme.tealData,
          ),

          Divider(color: AppTheme.border),

          _activityRow(
            Icons.person_add_outlined,

            'New administrator created',

            'Super Admin',

            '45 min ago',

            AppTheme.tealData,
          ),

          Divider(color: AppTheme.border),

          _activityRow(
            Icons.download_outlined,

            'Global report exported',

            'Admin',

            '2 hours ago',

            AppTheme.tealData,
          ),
        ],
      ),
    );
  }

  Widget _activityRow(
    IconData icon,

    String title,

    String subtitle,

    String time,

    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          width: 34,

          height: 34,

          decoration: BoxDecoration(
            color: color.withOpacity(0.12),

            borderRadius: BorderRadius.circular(8),
          ),

          child: Icon(icon, color: color, size: 18),
        ),

        const SizedBox(width: 9),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                title,

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(
                  color: AppTheme.text,

                  fontSize: 12,

                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(color: AppTheme.textMuted, fontSize: 10),
              ),

              const SizedBox(height: 2),

              Text(
                time,

                maxLines: 1,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(color: AppTheme.textMuted, fontSize: 9),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================

  // COMMON CARD

  // ============================================================

  Widget _card({
    required String title,

    required IconData icon,

    required Widget child,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppTheme.paper,

        border: Border.all(color: AppTheme.border),

        borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                width: 34,

                height: 34,

                decoration: BoxDecoration(
                  color: AppTheme.ink.withOpacity(0.08),

                  borderRadius: BorderRadius.circular(8),
                ),

                child: Icon(icon, color: AppTheme.ink, size: 18),
              ),

              const SizedBox(width: 9),

              Expanded(
                child: Text(
                  title,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    color: AppTheme.text,

                    fontSize: 15,

                    fontWeight: FontWeight.w600,
                  ),
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

  // ============================================================

  // EXPORT DIALOG

  // ============================================================

  void _showExportDialog() {
    showDialog<void>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text('Export Report'),

          content: const Text('Choose your preferred report format.'),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text('Report exported successfully.'),
                  ),
                );
              },

              child: const Text('Export'),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================

// KPI MODEL

// ============================================================

class _Kpi {
  final String title;

  final String value;

  final String change;

  final IconData icon;

  const _Kpi({
    required this.title,

    required this.value,

    required this.change,

    required this.icon,
  });
}

// ============================================================

// QUICK NAV MODEL

// ============================================================

class _Quick {
  final String title;

  final String subtitle;

  final IconData icon;

  const _Quick({
    required this.title,

    required this.subtitle,

    required this.icon,
  });
}
