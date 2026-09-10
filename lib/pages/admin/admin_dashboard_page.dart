import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Platform Administration',
      subtitle: 'Manage and configure the OneCloud enterprise platform.',
      icon: Icons.admin_panel_settings_outlined,

      kpis: [
        ModuleKpi(
          title: 'Total Tenants',
          value: '24',
          icon: Icons.business_outlined,
        ),
        ModuleKpi(
          title: 'Active Users',
          value: '1,248',
          icon: Icons.people_outline,
        ),
        ModuleKpi(
          title: 'Active Features',
          value: '38',
          icon: Icons.extension_outlined,
        ),
        ModuleKpi(
          title: 'System Status',
          value: 'Healthy',
          icon: Icons.check_circle_outline,
        ),
      ],

      quickActions: [
        // ModuleQuickAction(
        //   title: 'Admin Dashboard',
        //   icon: Icons.dashboard_outlined,
        //   route: '/admin',
        // ),
        ModuleQuickAction(
          title: 'Global Settings',
          icon: Icons.settings_outlined,
          route: '/admin/global-settings',
        ),
        ModuleQuickAction(
          title: 'Platform Config',
          icon: Icons.tune_outlined,
          route: '/admin/platform-config',
        ),
        ModuleQuickAction(
          title: 'License Management',
          icon: Icons.card_membership_outlined,
          route: '/admin/license-management',
        ),
        ModuleQuickAction(
          title: 'Feature Management',
          icon: Icons.extension_outlined,
          route: '/admin/feature-management',
        ),
        ModuleQuickAction(
          title: 'Resource Management',
          icon: Icons.dns_outlined,
          route: '/admin/resource-management',
        ),
        ModuleQuickAction(
          title: 'System Health',
          icon: Icons.monitor_heart_outlined,
          route: '/admin/system-health',
        ),
        ModuleQuickAction(
          title: 'Tenant Templates',
          icon: Icons.business_outlined,
          route: '/admin/tenant-templates',
        ),
      ],
    );
  }
}
