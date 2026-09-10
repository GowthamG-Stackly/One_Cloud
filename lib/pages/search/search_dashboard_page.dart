import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class SearchDashboardPage extends StatelessWidget {
  const SearchDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Search',
      subtitle: 'Search and discover information across the OneCloud platform.',
      icon: Icons.search_outlined,
      kpis: [
        ModuleKpi(
          title: 'Searches Today',
          value: '12.4K',
          icon: Icons.search_outlined,
        ),
        ModuleKpi(
          title: 'Indexed Records',
          value: '2.8M',
          icon: Icons.storage_outlined,
        ),
        ModuleKpi(
          title: 'Saved Searches',
          value: '428',
          icon: Icons.bookmark_outline,
        ),
        ModuleKpi(
          title: 'Search Accuracy',
          value: '96%',
          icon: Icons.check_circle_outline,
        ),
      ],
      quickActions: [
        ModuleQuickAction(title: 'Global Search', icon: Icons.search_outlined),
        ModuleQuickAction(
          title: 'Index Management',
          icon: Icons.storage_outlined,
        ),
        ModuleQuickAction(
          title: 'Search Analytics',
          icon: Icons.analytics_outlined,
        ),
        ModuleQuickAction(
          title: 'Autocomplete',
          icon: Icons.auto_awesome_outlined,
        ),
        ModuleQuickAction(
          title: 'Relevance Ranking',
          icon: Icons.sort_outlined,
        ),
        ModuleQuickAction(
          title: 'Saved Searches',
          icon: Icons.bookmark_outline,
        ),
        ModuleQuickAction(
          title: 'Multi-Tenant Index',
          icon: Icons.account_tree_outlined,
        ),
        ModuleQuickAction(title: 'Synonyms', icon: Icons.translate_outlined),
      ],
    );
  }
}
