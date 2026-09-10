import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class FinanceDashboardPage extends StatelessWidget {
  const FinanceDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Finance & Accounting',
      subtitle: 'Manage financial operations, accounting and reporting.',
      icon: Icons.account_balance_wallet_outlined,
      kpis: [
        ModuleKpi(
          title: 'Total Revenue',
          value: '\$248K',
          icon: Icons.trending_up_outlined,
        ),
        ModuleKpi(
          title: 'Receivables',
          value: '\$82K',
          icon: Icons.receipt_long_outlined,
        ),
        ModuleKpi(
          title: 'Payables',
          value: '\$46K',
          icon: Icons.payments_outlined,
        ),
        ModuleKpi(
          title: 'Pending Entries',
          value: '18',
          icon: Icons.pending_actions_outlined,
        ),
      ],
      quickActions: [
        ModuleQuickAction(
          title: 'General Ledger',
          icon: Icons.menu_book_outlined,
        ),
        ModuleQuickAction(
          title: 'Accounts Payable',
          icon: Icons.arrow_downward_outlined,
        ),
        ModuleQuickAction(
          title: 'Accounts Receivable',
          icon: Icons.arrow_upward_outlined,
        ),
        ModuleQuickAction(
          title: 'Tax Management',
          icon: Icons.account_balance_outlined,
        ),
        ModuleQuickAction(title: 'Budgeting', icon: Icons.pie_chart_outline),
        ModuleQuickAction(title: 'Costing', icon: Icons.calculate_outlined),
        ModuleQuickAction(
          title: 'Financial Reports',
          icon: Icons.bar_chart_outlined,
        ),
        ModuleQuickAction(
          title: 'Reconciliation',
          icon: Icons.sync_alt_outlined,
        ),
      ],
    );
  }
}
