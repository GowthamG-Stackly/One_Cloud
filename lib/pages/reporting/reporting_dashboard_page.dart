import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class ReportingDashboardPage extends StatelessWidget {
  const ReportingDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Reporting & BI',
      subtitle: 'Explore enterprise data, analytics and business intelligence.',
      icon: Icons.analytics_outlined,
      kpis: [
        ModuleKpi(
          title: 'Reports',
          value: '248',
          icon: Icons.description_outlined,
        ),
        ModuleKpi(
          title: 'Dashboards',
          value: '42',
          icon: Icons.dashboard_outlined,
        ),
        ModuleKpi(
          title: 'Scheduled Reports',
          value: '68',
          icon: Icons.schedule_outlined,
        ),
        ModuleKpi(
          title: 'Data Exports',
          value: '324',
          icon: Icons.download_outlined,
        ),
      ],
      quickActions: [
        ModuleQuickAction(
          title: 'Standard Reports',
          icon: Icons.description_outlined,
        ),
        ModuleQuickAction(
          title: 'Ad-hoc Reports',
          icon: Icons.edit_note_outlined,
        ),
        ModuleQuickAction(
          title: 'Data Exploration',
          icon: Icons.explore_outlined,
        ),
        ModuleQuickAction(
          title: 'BI Management',
          icon: Icons.analytics_outlined,
        ),
        ModuleQuickAction(title: 'Data Export', icon: Icons.download_outlined),
        ModuleQuickAction(
          title: 'Data Visualization',
          icon: Icons.bar_chart_outlined,
        ),
        ModuleQuickAction(
          title: 'Scheduled Reports',
          icon: Icons.schedule_outlined,
        ),
        ModuleQuickAction(
          title: 'Self-Service Analytics',
          icon: Icons.insights_outlined,
        ),
      ],
    );
  }
}
