import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class SecurityDashboardPage extends StatelessWidget {
  const SecurityDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Security & Compliance',
      subtitle: 'Manage enterprise security, auditing and compliance.',
      icon: Icons.security_outlined,
      kpis: [
        ModuleKpi(
          title: 'Security Score',
          value: '96%',
          icon: Icons.security_outlined,
        ),
        ModuleKpi(
          title: 'Audit Events',
          value: '8,426',
          icon: Icons.history_outlined,
        ),
        ModuleKpi(
          title: 'Security Alerts',
          value: '12',
          icon: Icons.warning_amber_outlined,
        ),
        ModuleKpi(title: 'Policies', value: '48', icon: Icons.policy_outlined),
      ],
      quickActions: [
        ModuleQuickAction(title: 'Audit Logs', icon: Icons.history_outlined),
        ModuleQuickAction(
          title: 'Activity Tracking',
          icon: Icons.track_changes_outlined,
        ),
        ModuleQuickAction(
          title: 'Compliance Reports',
          icon: Icons.fact_check_outlined,
        ),
        ModuleQuickAction(
          title: 'Data Retention',
          icon: Icons.delete_sweep_outlined,
        ),
        ModuleQuickAction(
          title: 'Policy Management',
          icon: Icons.policy_outlined,
        ),
        ModuleQuickAction(
          title: 'Threat Detection',
          icon: Icons.shield_outlined,
        ),
        ModuleQuickAction(
          title: 'Vulnerability Management',
          icon: Icons.bug_report_outlined,
        ),
        ModuleQuickAction(
          title: 'Security Alerts',
          icon: Icons.warning_amber_outlined,
        ),
        ModuleQuickAction(title: 'Encryption & Keys', icon: Icons.key_outlined),
      ],
    );
  }
}
