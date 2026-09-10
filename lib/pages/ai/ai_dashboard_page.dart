import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class AiDashboardPage extends StatelessWidget {
  const AiDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Enterprise AI',
      subtitle: 'Access AI-powered enterprise intelligence and automation.',
      icon: Icons.auto_awesome_outlined,
      kpis: [
        ModuleKpi(
          title: 'AI Models',
          value: '18',
          icon: Icons.psychology_outlined,
        ),
        ModuleKpi(
          title: 'AI Requests',
          value: '24.8K',
          icon: Icons.bolt_outlined,
        ),
        ModuleKpi(
          title: 'AI Workflows',
          value: '34',
          icon: Icons.account_tree_outlined,
        ),
        ModuleKpi(
          title: 'Usage Today',
          value: '4.2K',
          icon: Icons.insights_outlined,
        ),
      ],
      quickActions: [
        ModuleQuickAction(title: 'AI Models', icon: Icons.psychology_outlined),
        ModuleQuickAction(title: 'Chat / Copilot', icon: Icons.chat_outlined),
        ModuleQuickAction(
          title: 'Document AI / OCR',
          icon: Icons.document_scanner_outlined,
        ),
        ModuleQuickAction(
          title: 'Predictive Analytics',
          icon: Icons.auto_graph_outlined,
        ),
        ModuleQuickAction(
          title: 'Recommendations',
          icon: Icons.recommend_outlined,
        ),
        ModuleQuickAction(
          title: 'AI Workflows',
          icon: Icons.account_tree_outlined,
        ),
        ModuleQuickAction(
          title: 'Model Management',
          icon: Icons.model_training_outlined,
        ),
        ModuleQuickAction(
          title: 'AI Usage Logs',
          icon: Icons.receipt_long_outlined,
        ),
      ],
    );
  }
}
