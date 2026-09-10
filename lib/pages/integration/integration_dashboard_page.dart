import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class IntegrationDashboardPage extends StatelessWidget {
  const IntegrationDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Integration',
      subtitle: 'Manage APIs, connectors and third-party integrations.',
      icon: Icons.integration_instructions_outlined,
      kpis: [
        ModuleKpi(
          title: 'Integrations',
          value: '42',
          icon: Icons.extension_outlined,
        ),
        ModuleKpi(title: 'Active APIs', value: '86', icon: Icons.api_outlined),
        ModuleKpi(
          title: 'Webhooks',
          value: '128',
          icon: Icons.webhook_outlined,
        ),
        ModuleKpi(title: 'Sync Jobs', value: '24', icon: Icons.sync_outlined),
      ],
      quickActions: [
        ModuleQuickAction(title: 'API Management', icon: Icons.api_outlined),
        ModuleQuickAction(
          title: 'Third-Party Integrations',
          icon: Icons.extension_outlined,
        ),
        ModuleQuickAction(title: 'Webhooks', icon: Icons.webhook_outlined),
        ModuleQuickAction(
          title: 'Event Streaming',
          icon: Icons.stream_outlined,
        ),
        ModuleQuickAction(
          title: 'Data Transformation',
          icon: Icons.transform_outlined,
        ),
        ModuleQuickAction(title: 'ETL / Data Sync', icon: Icons.sync_outlined),
        ModuleQuickAction(title: 'Connectors', icon: Icons.link_outlined),
        ModuleQuickAction(
          title: 'Integration Logs',
          icon: Icons.receipt_long_outlined,
        ),
      ],
    );
  }
}
