import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class SubscriptionDashboardPage extends StatelessWidget {
  const SubscriptionDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Subscription',
      subtitle: 'Manage plans, subscriptions, licenses and usage.',
      icon: Icons.card_membership_outlined,
      kpis: [
        ModuleKpi(
          title: 'Active Subscriptions',
          value: '184',
          icon: Icons.card_membership_outlined,
        ),
        ModuleKpi(
          title: 'Active Plans',
          value: '12',
          icon: Icons.layers_outlined,
        ),
        ModuleKpi(
          title: 'Trials',
          value: '26',
          icon: Icons.hourglass_empty_outlined,
        ),
        ModuleKpi(
          title: 'Renewals Due',
          value: '14',
          icon: Icons.autorenew_outlined,
        ),
      ],
      quickActions: [
        ModuleQuickAction(
          title: 'Plans & Features',
          icon: Icons.layers_outlined,
        ),
        ModuleQuickAction(
          title: 'Tenant Subscriptions',
          icon: Icons.business_outlined,
        ),
        ModuleQuickAction(
          title: 'Usage & Quotas',
          icon: Icons.data_usage_outlined,
        ),
        ModuleQuickAction(
          title: 'Payment Tracking',
          icon: Icons.payments_outlined,
        ),
        ModuleQuickAction(
          title: 'License Allocation',
          icon: Icons.key_outlined,
        ),
        ModuleQuickAction(title: 'License Keys', icon: Icons.vpn_key_outlined),
        ModuleQuickAction(title: 'Renewals', icon: Icons.autorenew_outlined),
        ModuleQuickAction(
          title: 'Trial Management',
          icon: Icons.hourglass_empty_outlined,
        ),
      ],
    );
  }
}
