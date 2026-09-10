import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class DocumentDashboardPage extends StatelessWidget {
  const DocumentDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Document Management',
      subtitle: 'Manage enterprise documents, files and document workflows.',
      icon: Icons.folder_open_outlined,
      kpis: [
        ModuleKpi(
          title: 'Total Documents',
          value: '18,642',
          icon: Icons.description_outlined,
        ),
        ModuleKpi(
          title: 'Recent Uploads',
          value: '284',
          icon: Icons.upload_file_outlined,
        ),
        ModuleKpi(
          title: 'Shared Documents',
          value: '1,426',
          icon: Icons.share_outlined,
        ),
        ModuleKpi(
          title: 'Pending Review',
          value: '36',
          icon: Icons.pending_actions_outlined,
        ),
      ],
      quickActions: [
        ModuleQuickAction(
          title: 'Document Repository',
          icon: Icons.folder_outlined,
        ),
        ModuleQuickAction(title: 'Versioning', icon: Icons.history_outlined),
        ModuleQuickAction(
          title: 'Upload / Download',
          icon: Icons.cloud_upload_outlined,
        ),
        ModuleQuickAction(title: 'Access Control', icon: Icons.lock_outline),
        ModuleQuickAction(
          title: 'Document Templates',
          icon: Icons.description_outlined,
        ),
        ModuleQuickAction(
          title: 'Tagging & Search',
          icon: Icons.local_offer_outlined,
        ),
        ModuleQuickAction(
          title: 'Retention Policies',
          icon: Icons.policy_outlined,
        ),
        ModuleQuickAction(
          title: 'OCR Integration',
          icon: Icons.document_scanner_outlined,
        ),
      ],
    );
  }
}
