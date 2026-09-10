import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class WorkflowDashboardPage extends StatelessWidget {
  const WorkflowDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Workflow & Automation',
      subtitle: 'Design workflows, approvals and automated business processes.',
      icon: Icons.account_tree_outlined,
      kpis: [
        ModuleKpi(
          title: 'Active Workflows',
          value: '32',
          icon: Icons.account_tree_outlined,
        ),
        ModuleKpi(
          title: 'Pending Approvals',
          value: '18',
          icon: Icons.pending_actions_outlined,
        ),
        ModuleKpi(
          title: 'Running Tasks',
          value: '64',
          icon: Icons.play_circle_outline,
        ),
        ModuleKpi(
          title: 'Completed',
          value: '1,248',
          icon: Icons.check_circle_outline,
        ),
      ],
      quickActions: [
        ModuleQuickAction(
          title: 'Workflow Builder',
          icon: Icons.account_tree_outlined,
        ),
        ModuleQuickAction(title: 'Approvals', icon: Icons.approval_outlined),
        ModuleQuickAction(title: 'Business Rules', icon: Icons.rule_outlined),
        ModuleQuickAction(
          title: 'Process Automation',
          icon: Icons.auto_fix_high_outlined,
        ),
        ModuleQuickAction(
          title: 'Task Management',
          icon: Icons.task_alt_outlined,
        ),
        ModuleQuickAction(title: 'Triggers', icon: Icons.flash_on_outlined),
        ModuleQuickAction(
          title: 'SLAs & Escalations',
          icon: Icons.timer_outlined,
        ),
        ModuleQuickAction(
          title: 'Workflow Templates',
          icon: Icons.description_outlined,
        ),
      ],
    );
  }
}
