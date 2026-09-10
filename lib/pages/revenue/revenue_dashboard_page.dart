import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class RevenueDashboardPage extends StatelessWidget {
  const RevenueDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Revenue',
      subtitle: 'Monitor revenue, forecasting and revenue operations.',
      icon: Icons.trending_up_outlined,
      kpis: [
        ModuleKpi(
          title: 'Current Revenue',
          value: '\$482K',
          icon: Icons.attach_money_outlined,
        ),
        ModuleKpi(
          title: 'Monthly Growth',
          value: '12.8%',
          icon: Icons.trending_up_outlined,
        ),
        ModuleKpi(
          title: 'Forecast',
          value: '\$560K',
          icon: Icons.insights_outlined,
        ),
        ModuleKpi(
          title: 'Invoices',
          value: '326',
          icon: Icons.receipt_long_outlined,
        ),
      ],
      quickActions: [
        ModuleQuickAction(
          title: 'Revenue Tracking',
          icon: Icons.trending_up_outlined,
        ),
        ModuleQuickAction(
          title: 'Usage Analytics',
          icon: Icons.analytics_outlined,
        ),
        ModuleQuickAction(title: 'Forecasting', icon: Icons.insights_outlined),
        ModuleQuickAction(
          title: 'Revenue Reports',
          icon: Icons.bar_chart_outlined,
        ),
        ModuleQuickAction(
          title: 'Revenue Recognition',
          icon: Icons.fact_check_outlined,
        ),
        ModuleQuickAction(
          title: 'Commission Management',
          icon: Icons.groups_outlined,
        ),
        ModuleQuickAction(
          title: 'Financial Analytics',
          icon: Icons.pie_chart_outline,
        ),
        ModuleQuickAction(
          title: 'Invoicing',
          icon: Icons.receipt_long_outlined,
        ),
      ],
    );
  }
}
