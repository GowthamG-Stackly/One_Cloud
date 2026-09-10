import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class NotificationDashboardPage extends StatelessWidget {
  const NotificationDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Notification',
      subtitle: 'Manage enterprise notifications and communication channels.',
      icon: Icons.notifications_none_outlined,
      kpis: [
        ModuleKpi(
          title: 'Notifications Sent',
          value: '18.4K',
          icon: Icons.send_outlined,
        ),
        ModuleKpi(
          title: 'Delivered',
          value: '17.9K',
          icon: Icons.done_all_outlined,
        ),
        ModuleKpi(title: 'Pending', value: '284', icon: Icons.pending_outlined),
        ModuleKpi(
          title: 'Templates',
          value: '46',
          icon: Icons.description_outlined,
        ),
      ],
      quickActions: [
        ModuleQuickAction(
          title: 'In-App Notifications',
          icon: Icons.notifications_outlined,
        ),
        ModuleQuickAction(
          title: 'Email Notifications',
          icon: Icons.email_outlined,
        ),
        ModuleQuickAction(title: 'SMS Notifications', icon: Icons.sms_outlined),
        ModuleQuickAction(
          title: 'Push Notifications',
          icon: Icons.phone_android_outlined,
        ),
        ModuleQuickAction(title: 'Templates', icon: Icons.description_outlined),
        ModuleQuickAction(title: 'Preferences', icon: Icons.settings_outlined),
        ModuleQuickAction(title: 'Schedules', icon: Icons.schedule_outlined),
        ModuleQuickAction(
          title: 'Delivery Tracking',
          icon: Icons.track_changes_outlined,
        ),
      ],
    );
  }
}
