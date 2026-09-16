// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// import '../app_theme.dart';
// import '../routes/routes.dart';
// import '../providers/user_provider.dart';

// // ================================================================
// // APP HEADER
// // ================================================================

// class AppHeader extends StatelessWidget implements PreferredSizeWidget {
//   final bool sidebarOpen;
//   final VoidCallback onMenuPressed;

//   const AppHeader({
//     super.key,
//     required this.sidebarOpen,
//     required this.onMenuPressed,
//   });

//   void _navigate(BuildContext context, String route) {
//     if (GoRouterState.of(context).uri.path == route) {
//       return;
//     }

//     context.push(route);
//   }

//   void _logout(BuildContext context) {
//     Provider.of<UserProvider>(context, listen: false).logout();
//     context.go(AppRoutes.login);
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(68);

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);

//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobile = screenWidth < 850;

//     return AppBar(
//       backgroundColor: AppTheme.darkNavy,
//       elevation: 0,
//       toolbarHeight: 68,
//       automaticallyImplyLeading: false,
//       titleSpacing: 0,
//       title: Row(
//         children: [
//           // ==========================================================
//           // SIDEBAR TOGGLE
//           // ==========================================================

//           Padding(
//             padding: const EdgeInsets.only(left: 8, right: 6),
//             child: Material(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(8),
//               child: InkWell(
//                 onTap: onMenuPressed,
//                 borderRadius: BorderRadius.circular(8),
//                 hoverColor: Colors.white.withValues(alpha: 0.08),
//                 child: SizedBox(
//                   width: 40,
//                   height: 40,
//                   child: Center(
//                     child: Icon(
//                       sidebarOpen
//                           ? Icons.menu_open_rounded
//                           : Icons.menu_rounded,
//                       color: Colors.white.withValues(alpha: 0.90),
//                       size: 22,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(width: 4),

//           // ==========================================================
//           // LOGO
//           // ==========================================================
//           Container(
//             height: 44,
//             width: isMobile ? 125 : 140,
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Image.asset(
//               'assets/images/onecloud_logo.png',
//               fit: BoxFit.contain,
//             ),
//           ),

//           const Spacer(),

//           // ==========================================================
//           // DESKTOP MENU
//           // ==========================================================
//           if (!isMobile) ...[
//             TextButton(
//               onPressed: () {
//                 _navigate(context, AppRoutes.dashboard);
//               },
//               child: const Text(
//                 'Dashboard',
//                 style: TextStyle(color: Colors.white, fontSize: 14),
//               ),
//             ),

//             TextButton(
//               onPressed: () {
//                 _navigate(context, AppRoutes.features);
//               },
//               child: const Text(
//                 'Features',
//                 style: TextStyle(color: Colors.white, fontSize: 14),
//               ),
//             ),

//             TextButton(
//               onPressed: () {
//                 _navigate(context, AppRoutes.contact);
//               },
//               child: const Text(
//                 'Contact',
//                 style: TextStyle(color: Colors.white, fontSize: 14),
//               ),
//             ),

//             TextButton(
//               onPressed: () {
//                 _navigate(context, AppRoutes.about);
//               },
//               child: const Text(
//                 'About',
//                 style: TextStyle(color: Colors.white, fontSize: 14),
//               ),
//             ),

//             const SizedBox(width: 8),

//             // ========================================================
//             // PROFILE
//             // ========================================================
//             if (userProvider.email.isNotEmpty)
//               TextButton(
//                 onPressed: () {
//                   _navigate(context, AppRoutes.profile);
//                 },
//                 style: TextButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 6,
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.account_circle_outlined,
//                       color: Colors.white,
//                       size: 22,
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       userProvider.name.isNotEmpty
//                           ? userProvider.name
//                           : userProvider.email,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//             const SizedBox(width: 6),

//             // ========================================================
//             // LOGOUT
//             // ========================================================
//             IconButton(
//               tooltip: 'Logout',
//               onPressed: () {
//                 _logout(context);
//               },
//               icon: const Icon(Icons.logout, color: Colors.white, size: 21),
//             ),

//             const SizedBox(width: 6),
//           ],

//           // ==========================================================
//           // MOBILE MENU
//           // ==========================================================
//           if (isMobile)
//             IconButton(
//               tooltip: 'Profile',
//               icon: const Icon(
//                 Icons.account_circle_outlined,
//                 color: Colors.white,
//                 size: 25,
//               ),
//               onPressed: () {
//                 context.push(AppRoutes.profile);
//               },
//             ),

//           if (isMobile)
//             PopupMenuButton<String>(
//               tooltip: 'Menu',
//               icon: const Icon(
//                 Icons.keyboard_arrow_down,
//                 color: Colors.white,
//                 size: 28,
//               ),
//               color: Colors.white,
//               elevation: 8,
//               offset: const Offset(0, 48),
//               onSelected: (value) {
//                 switch (value) {
//                   case 'dashboard':
//                     _navigate(context, AppRoutes.dashboard);
//                     break;

//                   case 'features':
//                     _navigate(context, AppRoutes.features);
//                     break;

//                   case 'contact':
//                     _navigate(context, AppRoutes.contact);
//                     break;

//                   case 'about':
//                     _navigate(context, AppRoutes.about);
//                     break;

//                   case 'profile':
//                     _navigate(context, AppRoutes.profile);
//                     break;

//                   case 'logout':
//                     _logout(context);
//                     break;
//                 }
//               },
//               itemBuilder: (context) => [
//                 const PopupMenuItem<String>(
//                   value: 'dashboard',
//                   child: Row(
//                     children: [
//                       Icon(Icons.dashboard_outlined, size: 20),
//                       SizedBox(width: 12),
//                       Text('Dashboard'),
//                     ],
//                   ),
//                 ),
//                 const PopupMenuItem<String>(
//                   value: 'features',
//                   child: Row(
//                     children: [
//                       Icon(Icons.apps_outlined, size: 20),
//                       SizedBox(width: 12),
//                       Text('Features'),
//                     ],
//                   ),
//                 ),
//                 const PopupMenuItem<String>(
//                   value: 'contact',
//                   child: Row(
//                     children: [
//                       Icon(Icons.contact_support_outlined, size: 20),
//                       SizedBox(width: 12),
//                       Text('Contact'),
//                     ],
//                   ),
//                 ),
//                 const PopupMenuItem<String>(
//                   value: 'about',
//                   child: Row(
//                     children: [
//                       Icon(Icons.info_outline, size: 20),
//                       SizedBox(width: 12),
//                       Text('About'),
//                     ],
//                   ),
//                 ),
//                 const PopupMenuDivider(),
//                 const PopupMenuItem<String>(
//                   value: 'logout',
//                   child: Row(
//                     children: [
//                       Icon(Icons.logout, size: 20),
//                       SizedBox(width: 12),
//                       Text('Logout'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }

// // ================================================================
// // SIDEBAR MENU MODEL
// // ================================================================

// class SidebarChild {
//   final String title;
//   final IconData icon;
//   final String route;

//   const SidebarChild({
//     required this.title,
//     required this.icon,
//     required this.route,
//   });
// }

// class SidebarSection {
//   final String title;
//   final IconData icon;
//   final String route;
//   final List<SidebarChild> children;

//   const SidebarSection({
//     required this.title,
//     required this.icon,
//     required this.route,
//     this.children = const [],
//   });
// }

// // ================================================================
// // APP SIDEBAR
// // ================================================================

// class AppSidebar extends StatefulWidget {
//   final bool collapsed;

//   const AppSidebar({super.key, this.collapsed = false});

//   @override
//   State<AppSidebar> createState() => _AppSidebarState();
// }

// class _AppSidebarState extends State<AppSidebar> {
//   final Map<String, bool> _expandedSections = {};

//   // ==============================================================
//   // ONECLOUD SIDEBAR STRUCTURE
//   // ==============================================================

//   final List<SidebarSection> _sections = const [
//     // ------------------------------------------------------------
//     // PLATFORM ADMINISTRATION
//     // ------------------------------------------------------------

//     SidebarSection(
//       title: 'Platform Administration',
//       icon: Icons.admin_panel_settings_outlined,
//       route: AppRoutes.admin,
//       children: [
//         SidebarChild(
//           title: 'Admin Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.admin,
//         ),
//         SidebarChild(
//           title: 'Global Settings',
//           icon: Icons.settings_outlined,
//           route: AppRoutes.globalSettings,
//         ),
//         SidebarChild(
//           title: 'Platform Config',
//           icon: Icons.tune_outlined,
//           route: AppRoutes.platformConfig,
//         ),
//         SidebarChild(
//           title: 'License Management',
//           icon: Icons.key_outlined,
//           route: AppRoutes.licenseManagement,
//         ),
//         SidebarChild(
//           title: 'Feature Management',
//           icon: Icons.extension_outlined,
//           route: AppRoutes.featureManagement,
//         ),
//         SidebarChild(
//           title: 'Resource Management',
//           icon: Icons.storage_outlined,
//           route: AppRoutes.resourceManagement,
//         ),
//         SidebarChild(
//           title: 'System Health',
//           icon: Icons.monitor_heart_outlined,
//           route: AppRoutes.systemHealth,
//         ),
//         SidebarChild(
//           title: 'Tenant Templates',
//           icon: Icons.layers_outlined,
//           route: AppRoutes.tenantTemplates,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // HRMS
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'HRMS',
//       icon: Icons.people_alt_outlined,
//       route: AppRoutes.hrms,
//       children: [
//         SidebarChild(
//           title: 'HRMS Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.hrms,
//         ),
//         SidebarChild(
//           title: 'Employee Management',
//           icon: Icons.badge_outlined,
//           route: AppRoutes.hrmsEmployees,
//         ),
//         SidebarChild(
//           title: 'Attendance',
//           icon: Icons.access_time_outlined,
//           route: AppRoutes.hrmsAttendance,
//         ),
//         SidebarChild(
//           title: 'Leave',
//           icon: Icons.event_busy_outlined,
//           route: AppRoutes.hrmsLeave,
//         ),
//         SidebarChild(
//           title: 'Payroll',
//           icon: Icons.payments_outlined,
//           route: AppRoutes.hrmsPayroll,
//         ),
//         SidebarChild(
//           title: 'Recruitment',
//           icon: Icons.person_search_outlined,
//           route: AppRoutes.hrmsRecruitment,
//         ),
//         SidebarChild(
//           title: 'Performance',
//           icon: Icons.trending_up_outlined,
//           route: AppRoutes.hrmsPerformance,
//         ),
//         SidebarChild(
//           title: 'Learning',
//           icon: Icons.school_outlined,
//           route: AppRoutes.hrmsLearning,
//         ),
//         SidebarChild(
//           title: 'ESS / MSS',
//           icon: Icons.manage_accounts_outlined,
//           route: AppRoutes.hrmsEssMss,
//         ),
//         SidebarChild(
//           title: 'Asset Management',
//           icon: Icons.devices_outlined,
//           route: AppRoutes.hrmsAssets,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // CRM
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'CRM',
//       icon: Icons.handshake_outlined,
//       route: AppRoutes.crm,
//       children: [
//         SidebarChild(
//           title: 'Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.crm,
//         ),
//         SidebarChild(
//           title: 'Leads',
//           icon: Icons.person_search_outlined,
//           route: AppRoutes.crmLeads,
//         ),
//         SidebarChild(
//           title: 'Opportunities',
//           icon: Icons.trending_up_outlined,
//           route: AppRoutes.crmOpportunities,
//         ),
//         SidebarChild(
//           title: 'Accounts',
//           icon: Icons.business_outlined,
//           route: AppRoutes.crmAccounts,
//         ),
//         SidebarChild(
//           title: 'Contacts',
//           icon: Icons.contacts_outlined,
//           route: AppRoutes.crmContacts,
//         ),
//         SidebarChild(
//           title: 'Activities',
//           icon: Icons.task_alt_outlined,
//           route: AppRoutes.crmActivities,
//         ),
//         SidebarChild(
//           title: 'Pipeline',
//           icon: Icons.filter_alt_outlined,
//           route: AppRoutes.crmPipeline,
//         ),
//         SidebarChild(
//           title: 'Quotations',
//           icon: Icons.request_quote_outlined,
//           route: AppRoutes.crmQuotations,
//         ),
//         SidebarChild(
//           title: 'Campaigns',
//           icon: Icons.campaign_outlined,
//           route: AppRoutes.crmCampaigns,
//         ),
//         SidebarChild(
//           title: 'Customer Support',
//           icon: Icons.support_agent_outlined,
//           route: AppRoutes.crmCustomerSupport,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // ERP
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'ERP',
//       icon: Icons.inventory_2_outlined,
//       route: AppRoutes.erp,
//       children: [
//         SidebarChild(
//           title: 'ERP Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.erp,
//         ),

//         SidebarChild(
//           title: 'Inventory',
//           icon: Icons.inventory_2_outlined,
//           route: AppRoutes.inventory,
//         ),
//         SidebarChild(
//           title: 'Warehouses',
//           icon: Icons.warehouse_outlined,
//           route: AppRoutes.warehouses,
//         ),
//         SidebarChild(
//           title: 'Stock Movements',
//           icon: Icons.swap_horiz_outlined,
//           route: AppRoutes.stockMovements,
//         ),
//         SidebarChild(
//           title: 'Procurement',
//           icon: Icons.shopping_cart_outlined,
//           route: AppRoutes.procurement,
//         ),
//         SidebarChild(
//           title: 'Vendors',
//           icon: Icons.people_outline,
//           route: AppRoutes.vendors,
//         ),
//         SidebarChild(
//           title: 'Sales Orders',
//           icon: Icons.receipt_long_outlined,
//           route: AppRoutes.salesOrders,
//         ),
//         SidebarChild(
//           title: 'Dispatch',
//           icon: Icons.local_shipping_outlined,
//           route: AppRoutes.dispatch,
//         ),
//         SidebarChild(
//           title: 'Production',
//           icon: Icons.precision_manufacturing_outlined,
//           route: AppRoutes.production,
//         ),
//         SidebarChild(
//           title: 'Asset Management',
//           icon: Icons.business_center_outlined,
//           route: AppRoutes.assetManagement,
//         ),
//         SidebarChild(
//           title: 'Maintenance',
//           icon: Icons.build_outlined,
//           route: AppRoutes.maintenance,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // FINANCE & ACCOUNTING
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'Finance & Accounting',
//       icon: Icons.account_balance_wallet_outlined,
//       route: AppRoutes.finance,
//       children: [
//         SidebarChild(
//           title: 'Finance Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.finance,
//         ),

//         SidebarChild(
//           title: 'General Ledger',
//           icon: Icons.menu_book_outlined,
//           route: AppRoutes.financeGeneralLedger,
//         ),

//         SidebarChild(
//           title: 'Accounts Payable',
//           icon: Icons.arrow_circle_down_outlined,
//           route: AppRoutes.financeAccountsPayable,
//         ),

//         SidebarChild(
//           title: 'Accounts Receivable',
//           icon: Icons.arrow_circle_up_outlined,
//           route: AppRoutes.financeAccountsReceivable,
//         ),

//         SidebarChild(
//           title: 'Asset Management',
//           icon: Icons.business_center_outlined,
//           route: AppRoutes.financeAssetManagement,
//         ),

//         SidebarChild(
//           title: 'Budgeting',
//           icon: Icons.account_balance_outlined,
//           route: AppRoutes.financeBudgeting,
//         ),

//         SidebarChild(
//           title: 'Costing',
//           icon: Icons.calculate_outlined,
//           route: AppRoutes.financeCosting,
//         ),

//         SidebarChild(
//           title: 'Financial Reports',
//           icon: Icons.bar_chart_outlined,
//           route: AppRoutes.financeFinancialReports,
//         ),

//         SidebarChild(
//           title: 'Reconciliation',
//           icon: Icons.sync_alt_outlined,
//           route: AppRoutes.financeReconciliation,
//         ),

//         SidebarChild(
//           title: 'Multi-Currency',
//           icon: Icons.currency_exchange_outlined,
//           route: AppRoutes.financeMultiCurrency,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // WORKFLOW & AUTOMATION
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'Workflow & Automation',
//       icon: Icons.account_tree_outlined,
//       route: AppRoutes.workflow,
//       children: [
//         SidebarChild(
//           title: 'Workflow Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.workflow,
//         ),
//         SidebarChild(
//           title: 'Workflow Builder',
//           icon: Icons.account_tree_outlined,
//           route: AppRoutes.workflowBuilder,
//         ),
//         SidebarChild(
//           title: 'Approvals',
//           icon: Icons.approval_outlined,
//           route: AppRoutes.workflowApprovals,
//         ),
//         SidebarChild(
//           title: 'Business Rules',
//           icon: Icons.rule_outlined,
//           route: AppRoutes.workflowBusinessRules,
//         ),
//         SidebarChild(
//           title: 'Process Automation',
//           icon: Icons.auto_awesome_outlined,
//           route: AppRoutes.workflowProcessAutomation,
//         ),
//         SidebarChild(
//           title: 'Task Management',
//           icon: Icons.task_outlined,
//           route: AppRoutes.workflowTasks,
//         ),
//         SidebarChild(
//           title: 'Triggers',
//           icon: Icons.flash_on_outlined,
//           route: AppRoutes.workflowTriggers,
//         ),
//         SidebarChild(
//           title: 'SLAs & Escalations',
//           icon: Icons.timer_outlined,
//           route: AppRoutes.workflowSlas,
//         ),
//         SidebarChild(
//           title: 'Process Monitoring',
//           icon: Icons.monitor_outlined,
//           route: AppRoutes.workflowMonitoring,
//         ),
//         SidebarChild(
//           title: 'Workflow Templates',
//           icon: Icons.dashboard_customize_outlined,
//           route: AppRoutes.workflowTemplates,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // DOCUMENT MANAGEMENT
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'Document Management',
//       icon: Icons.folder_open_outlined,
//       route: AppRoutes.documents,
//       children: [
//         SidebarChild(
//           title: 'Document Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.documents,
//         ),
//         SidebarChild(
//           title: 'Document Repository',
//           icon: Icons.folder_outlined,
//           route: AppRoutes.documentRepository,
//         ),
//         SidebarChild(
//           title: 'Versioning',
//           icon: Icons.history_outlined,
//           route: AppRoutes.documentVersioning,
//         ),
//         SidebarChild(
//           title: 'File Upload / Download',
//           icon: Icons.file_upload_outlined,
//           route: AppRoutes.documentUploadDownload,
//         ),
//         SidebarChild(
//           title: 'Access Control',
//           icon: Icons.lock_outline,
//           route: AppRoutes.documentAccessControl,
//         ),
//         SidebarChild(
//           title: 'Document Templates',
//           icon: Icons.description_outlined,
//           route: AppRoutes.documentTemplates,
//         ),
//         SidebarChild(
//           title: 'Tagging & Search',
//           icon: Icons.local_offer_outlined,
//           route: AppRoutes.documentTaggingSearch,
//         ),
//         SidebarChild(
//           title: 'Retention Policies',
//           icon: Icons.policy_outlined,
//           route: AppRoutes.documentRetentionPolicies,
//         ),
//         SidebarChild(
//           title: 'Audit Trails',
//           icon: Icons.fact_check_outlined,
//           route: AppRoutes.documentAuditTrails,
//         ),
//         SidebarChild(
//           title: 'OCR Integration',
//           icon: Icons.document_scanner_outlined,
//           route: AppRoutes.documentOcrIntegration,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // SUBSCRIPTION
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'Subscription',
//       icon: Icons.card_membership_outlined,
//       route: AppRoutes.subscription,
//       children: [
//         SidebarChild(
//           title: 'Subscription Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.subscription,
//         ),
//         SidebarChild(
//           title: 'Plans & Features',
//           icon: Icons.view_list_outlined,
//           route: AppRoutes.subscriptionPlansFeatures,
//         ),
//         SidebarChild(
//           title: 'Tenant Subscriptions',
//           icon: Icons.apartment_outlined,
//           route: AppRoutes.tenantSubscriptions,
//         ),
//         SidebarChild(
//           title: 'Usage & Quotas',
//           icon: Icons.data_usage_outlined,
//           route: AppRoutes.subscriptionUsageQuotas,
//         ),
//         SidebarChild(
//           title: 'Payment Tracking',
//           icon: Icons.payment_outlined,
//           route: AppRoutes.subscriptionPaymentTracking,
//         ),
//         SidebarChild(
//           title: 'License Allocation',
//           icon: Icons.key_outlined,
//           route: AppRoutes.subscriptionLicenseAllocation,
//         ),
//         SidebarChild(
//           title: 'Renewals',
//           icon: Icons.autorenew_outlined,
//           route: AppRoutes.subscriptionRenewals,
//         ),
//         SidebarChild(
//           title: 'Trial Management',
//           icon: Icons.timer_outlined,
//           route: AppRoutes.subscriptionTrialManagement,
//         ),
//         SidebarChild(
//           title: 'Billing Integration',
//           icon: Icons.receipt_long_outlined,
//           route: AppRoutes.subscriptionBillingIntegration,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // REVENUE
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'Revenue',
//       icon: Icons.trending_up_outlined,
//       route: AppRoutes.revenue,
//       children: [
//         SidebarChild(
//           title: 'Revenue Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.revenue,
//         ),
//         SidebarChild(
//           title: 'Revenue Tracking',
//           icon: Icons.track_changes_outlined,
//           route: AppRoutes.revenueTracking,
//         ),
//         SidebarChild(
//           title: 'Usage Analytics',
//           icon: Icons.analytics_outlined,
//           route: AppRoutes.revenueUsageAnalytics,
//         ),
//         SidebarChild(
//           title: 'Forecasting',
//           icon: Icons.insights_outlined,
//           route: AppRoutes.revenueForecasting,
//         ),
//         SidebarChild(
//           title: 'Financial Analytics',
//           icon: Icons.bar_chart_outlined,
//           route: AppRoutes.revenueFinancialAnalytics,
//         ),
//         SidebarChild(
//           title: 'Revenue Recognition',
//           icon: Icons.verified_outlined,
//           route: AppRoutes.revenueRecognition,
//         ),
//         SidebarChild(
//           title: 'Commission Management',
//           icon: Icons.percent_outlined,
//           route: AppRoutes.revenueCommissionManagement,
//         ),
//         SidebarChild(
//           title: 'Invoicing',
//           icon: Icons.receipt_long_outlined,
//           route: AppRoutes.revenueInvoicing,
//         ),
//         SidebarChild(
//           title: 'Integration',
//           icon: Icons.integration_instructions_outlined,
//           route: AppRoutes.revenueIntegration,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // REPORTING & BI
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'Reporting & BI',
//       icon: Icons.analytics_outlined,
//       route: AppRoutes.reporting,
//       children: [
//         SidebarChild(
//           title: 'Reporting Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.reporting,
//         ),
//         SidebarChild(
//           title: 'Standard Reports',
//           icon: Icons.description_outlined,
//           route: AppRoutes.reportingStandardReports,
//         ),
//         SidebarChild(
//           title: 'Ad-hoc Reports',
//           icon: Icons.edit_note_outlined,
//           route: AppRoutes.reportingAdHocReports,
//         ),
//         SidebarChild(
//           title: 'Data Exploration',
//           icon: Icons.explore_outlined,
//           route: AppRoutes.reportingDataExploration,
//         ),
//         SidebarChild(
//           title: 'BI Management',
//           icon: Icons.dashboard_customize_outlined,
//           route: AppRoutes.reportingBiManagement,
//         ),
//         SidebarChild(
//           title: 'Data Export',
//           icon: Icons.file_download_outlined,
//           route: AppRoutes.reportingDataExport,
//         ),
//         SidebarChild(
//           title: 'Scheduled Reports',
//           icon: Icons.schedule_outlined,
//           route: AppRoutes.reportingScheduledReports,
//         ),
//         SidebarChild(
//           title: 'Data Visualization',
//           icon: Icons.bar_chart_outlined,
//           route: AppRoutes.reportingDataVisualization,
//         ),
//         SidebarChild(
//           title: 'Self-Service Analytics',
//           icon: Icons.auto_graph_outlined,
//           route: AppRoutes.reportingSelfServiceAnalytics,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // ENTERPRISE AI
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'Enterprise AI',
//       icon: Icons.auto_awesome_outlined,
//       route: AppRoutes.ai,
//       children: [
//         SidebarChild(
//           title: 'AI Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.ai,
//         ),
//         SidebarChild(
//           title: 'AI Models',
//           icon: Icons.psychology_outlined,
//           route: AppRoutes.enterpriseAiModels,
//         ),
//         SidebarChild(
//           title: 'Chat / Copilot',
//           icon: Icons.smart_toy_outlined,
//           route: AppRoutes.enterpriseAiChatCopilot,
//         ),
//         SidebarChild(
//           title: 'Document AI / OCR',
//           icon: Icons.document_scanner_outlined,
//           route: AppRoutes.enterpriseAiDocumentAiOcr,
//         ),
//         SidebarChild(
//           title: 'Predictive Analytics',
//           icon: Icons.insights_outlined,
//           route: AppRoutes.enterpriseAiPredictiveAnalytics,
//         ),
//         SidebarChild(
//           title: 'Recommendations',
//           icon: Icons.recommend_outlined,
//           route: AppRoutes.enterpriseAiRecommendations,
//         ),
//         SidebarChild(
//           title: 'AI Workflows',
//           icon: Icons.account_tree_outlined,
//           route: AppRoutes.enterpriseAiWorkflows,
//         ),
//         SidebarChild(
//           title: 'Model Management',
//           icon: Icons.model_training_outlined,
//           route: AppRoutes.enterpriseAiModelManagement,
//         ),
//         SidebarChild(
//           title: 'Prompt Engineering',
//           icon: Icons.code_outlined,
//           route: AppRoutes.enterpriseAiPromptEngineering,
//         ),
//         SidebarChild(
//           title: 'AI Usage Logs',
//           icon: Icons.history_outlined,
//           route: AppRoutes.enterpriseAiUsageLogs,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // NOTIFICATION
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'Notification',
//       icon: Icons.notifications_none_outlined,
//       route: AppRoutes.notification,
//       children: [
//         SidebarChild(
//           title: 'Notification Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.notification,
//         ),
//         SidebarChild(
//           title: 'In-App Notifications',
//           icon: Icons.notifications_outlined,
//           route: AppRoutes.notificationInApp,
//         ),
//         SidebarChild(
//           title: 'Email Notifications',
//           icon: Icons.email_outlined,
//           route: AppRoutes.notificationEmail,
//         ),
//         SidebarChild(
//           title: 'SMS Notifications',
//           icon: Icons.sms_outlined,
//           route: AppRoutes.notificationSms,
//         ),
//         SidebarChild(
//           title: 'Push Notifications',
//           icon: Icons.phone_android_outlined,
//           route: AppRoutes.notificationPush,
//         ),
//         SidebarChild(
//           title: 'Templates',
//           icon: Icons.article_outlined,
//           route: AppRoutes.notificationTemplates,
//         ),
//         SidebarChild(
//           title: 'Preferences',
//           icon: Icons.tune_outlined,
//           route: AppRoutes.notificationPreferences,
//         ),
//         SidebarChild(
//           title: 'Schedules',
//           icon: Icons.schedule_outlined,
//           route: AppRoutes.notificationSchedules,
//         ),
//         SidebarChild(
//           title: 'Delivery Tracking',
//           icon: Icons.local_shipping_outlined,
//           route: AppRoutes.notificationDeliveryTracking,
//         ),
//         SidebarChild(
//           title: 'Multi-Channel',
//           icon: Icons.hub_outlined,
//           route: AppRoutes.notificationMultiChannel,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // CALENDAR
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'Calendar',
//       icon: Icons.calendar_month_outlined,
//       route: AppRoutes.calendar,
//       children: [
//         SidebarChild(
//           title: 'Calendar Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.calendar,
//         ),
//         SidebarChild(
//           title: 'User Calendars',
//           icon: Icons.calendar_today_outlined,
//           route: AppRoutes.calendarUserCalendars,
//         ),
//         SidebarChild(
//           title: 'Team Calendars',
//           icon: Icons.groups_outlined,
//           route: AppRoutes.calendarTeamCalendars,
//         ),
//         SidebarChild(
//           title: 'Meeting Scheduler',
//           icon: Icons.event_available_outlined,
//           route: AppRoutes.calendarMeetingScheduler,
//         ),
//         SidebarChild(
//           title: 'Resource Booking',
//           icon: Icons.event_seat_outlined,
//           route: AppRoutes.calendarRecurringBooking,
//         ),
//         SidebarChild(
//           title: 'Reminders',
//           icon: Icons.alarm_outlined,
//           route: AppRoutes.calendarReminders,
//         ),
//         SidebarChild(
//           title: 'Integrations',
//           icon: Icons.sync_outlined,
//           route: AppRoutes.calendarIntegrations,
//         ),
//         SidebarChild(
//           title: 'Availability',
//           icon: Icons.av_timer_outlined,
//           route: AppRoutes.calendarAvailability,
//         ),
//         SidebarChild(
//           title: 'Event Notifications',
//           icon: Icons.notifications_active_outlined,
//           route: AppRoutes.calendarEventNotifications,
//         ),
//         SidebarChild(
//           title: 'Shared Calendars',
//           icon: Icons.share_outlined,
//           route: AppRoutes.calendarSharedCalendars,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // INTEGRATION
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'Integration',
//       icon: Icons.integration_instructions_outlined,
//       route: AppRoutes.integration,
//       children: [
//         SidebarChild(
//           title: 'Integration Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.integration,
//         ),
//         SidebarChild(
//           title: 'API Management',
//           icon: Icons.api_outlined,
//           route: AppRoutes.integrationApiManagement,
//         ),
//         SidebarChild(
//           title: 'Third-Party Integrations',
//           icon: Icons.extension_outlined,
//           route: AppRoutes.integrationThirdPartyIntegrations,
//         ),
//         SidebarChild(
//           title: 'Webhooks',
//           icon: Icons.webhook_outlined,
//           route: AppRoutes.integrationWebhooks,
//         ),
//         SidebarChild(
//           title: 'Event Streaming',
//           icon: Icons.stream_outlined,
//           route: AppRoutes.integrationEventStreaming,
//         ),
//         SidebarChild(
//           title: 'Data Transformation',
//           icon: Icons.transform_outlined,
//           route: AppRoutes.integrationDataTransformation,
//         ),
//         SidebarChild(
//           title: 'ETL / Data Sync',
//           icon: Icons.sync_alt_outlined,
//           route: AppRoutes.integrationEtlDataSync,
//         ),
//         SidebarChild(
//           title: 'Connectors',
//           icon: Icons.link_outlined,
//           route: AppRoutes.integrationConnectors,
//         ),
//         SidebarChild(
//           title: 'Integration Logs',
//           icon: Icons.receipt_long_outlined,
//           route: AppRoutes.integrationLogs,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // SEARCH
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'Search',
//       icon: Icons.search_outlined,
//       route: AppRoutes.search,
//       children: [
//         SidebarChild(
//           title: 'Search Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.search,
//         ),
//         SidebarChild(
//           title: 'Global Search',
//           icon: Icons.search_outlined,
//           route: AppRoutes.searchGlobalSearch,
//         ),
//         SidebarChild(
//           title: 'Index Management',
//           icon: Icons.storage_outlined,
//           route: AppRoutes.searchIndexManagement,
//         ),
//         SidebarChild(
//           title: 'Search Analytics',
//           icon: Icons.analytics_outlined,
//           route: AppRoutes.searchAnalytics,
//         ),
//         SidebarChild(
//           title: 'Autocomplete',
//           icon: Icons.auto_fix_high_outlined,
//           route: AppRoutes.searchAutocomplete,
//         ),
//         SidebarChild(
//           title: 'Relevance Ranking',
//           icon: Icons.format_list_numbered_outlined,
//           route: AppRoutes.searchRelevanceRanking,
//         ),
//         SidebarChild(
//           title: 'Saved Searches',
//           icon: Icons.bookmark_outline,
//           route: AppRoutes.searchSavedSearches,
//         ),
//         SidebarChild(
//           title: 'Multi-Tenant Index',
//           icon: Icons.layers_outlined,
//           route: AppRoutes.searchMultiTenantIndex,
//         ),
//         SidebarChild(
//           title: 'Synonyms',
//           icon: Icons.compare_arrows_outlined,
//           route: AppRoutes.searchSynonyms,
//         ),
//         SidebarChild(
//           title: 'Suggestion Engine',
//           icon: Icons.lightbulb_outline,
//           route: AppRoutes.searchSuggestionEngine,
//         ),
//       ],
//     ),

//     // ------------------------------------------------------------
//     // SECURITY & COMPLIANCE
//     // ------------------------------------------------------------
//     SidebarSection(
//       title: 'Security & Compliance',
//       icon: Icons.security_outlined,
//       route: AppRoutes.security,
//       children: [
//         SidebarChild(
//           title: 'Security Dashboard',
//           icon: Icons.dashboard_outlined,
//           route: AppRoutes.security,
//         ),
//         SidebarChild(
//           title: 'Audit Logs',
//           icon: Icons.fact_check_outlined,
//           route: AppRoutes.securityAuditLogs,
//         ),
//         SidebarChild(
//           title: 'Activity Tracking',
//           icon: Icons.track_changes_outlined,
//           route: AppRoutes.securityActivityTracking,
//         ),
//         SidebarChild(
//           title: 'Compliance Reports',
//           icon: Icons.assignment_turned_in_outlined,
//           route: AppRoutes.securityComplianceReports,
//         ),
//         SidebarChild(
//           title: 'Data Retention',
//           icon: Icons.delete_sweep_outlined,
//           route: AppRoutes.securityDataRetention,
//         ),
//         SidebarChild(
//           title: 'Policy Management',
//           icon: Icons.policy_outlined,
//           route: AppRoutes.securityPolicyManagement,
//         ),
//         SidebarChild(
//           title: 'Threat Detection',
//           icon: Icons.gpp_maybe_outlined,
//           route: AppRoutes.securityThreatDetection,
//         ),
//         SidebarChild(
//           title: 'Vulnerability Management',
//           icon: Icons.bug_report_outlined,
//           route: AppRoutes.securityVulnerabilityManagement,
//         ),
//         SidebarChild(
//           title: 'Encryption & Key Management',
//           icon: Icons.enhanced_encryption_outlined,
//           route: AppRoutes.securityEncryptionKeyManagement,
//         ),
//         SidebarChild(
//           title: 'Security Alerts',
//           icon: Icons.warning_amber_outlined,
//           route: AppRoutes.securityAlerts,
//         ),
//       ],
//     ),
//   ];

//   // ==============================================================
//   // INITIALIZE EXPANSION STATES
//   // ==============================================================

//   @override
//   void initState() {
//     super.initState();

//     for (final section in _sections) {
//       _expandedSections[section.title] = false;
//     }

//     // ERP open by default because it is our current working module.
//     // _expandedSections['ERP'] = true;
//   }

//   // ==============================================================
//   // NAVIGATION
//   // ==============================================================

//   void _navigate(BuildContext context, String route) {
//     final currentRoute = GoRouterState.of(context).uri.path;

//     if (currentRoute == route) {
//       return;
//     }

//     context.push(route);
//   }

//   // ==============================================================
//   // CHECK WHETHER SECTION IS ACTIVE
//   // ==============================================================

//   bool _isSectionActive(SidebarSection section, String currentRoute) {
//     if (currentRoute == section.route) {
//       return true;
//     }

//     for (final child in section.children) {
//       if (currentRoute == child.route) {
//         return true;
//       }
//     }

//     return false;
//   }

//   // ==============================================================
//   // TOGGLE SECTION
//   // ==============================================================

//   void _toggleSection(String title) {
//     setState(() {
//       _expandedSections[title] = !(_expandedSections[title] ?? false);
//     });
//   }

//   // ==============================================================
//   // BUILD
//   // ==============================================================

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context);

//     final currentRoute = GoRouterState.of(context).uri.path;

//     return Container(
//       width: widget.collapsed ? 72 : 275,
//       height: double.infinity,
//       decoration: BoxDecoration(
//         color: AppTheme.darkNavy,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.14),
//             blurRadius: 14,
//             offset: const Offset(3, 0),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Column(
//           children: [
//             // ========================================================
//             // BRAND
//             // ========================================================

//             if (!widget.collapsed)
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withValues(alpha: 0.04),
//                   border: Border(
//                     bottom: BorderSide(
//                       color: Colors.white.withValues(alpha: 0.08),
//                     ),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 44,
//                       height: 44,
//                       padding: const EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Image.asset(
//                         'assets/images/onecloud_logo.png',
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'OneCloud',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 3),
//                           Text(
//                             'Enterprise Platform',
//                             style: TextStyle(
//                               color: Colors.white.withValues(alpha: 0.55),
//                               fontSize: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             else
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withValues(alpha: 0.04),
//                   border: Border(
//                     bottom: BorderSide(
//                       color: Colors.white.withValues(alpha: 0.08),
//                     ),
//                   ),
//                 ),
//                 child: Center(
//                   child: Container(
//                     width: 42,
//                     height: 42,
//                     padding: const EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Image.asset(
//                       'assets/images/onecloud_logo.png',
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ),

//             // ========================================================
//             // NAVIGATION
//             // ========================================================
//             Expanded(
//               child: widget.collapsed
//                   ? ListView(
//                       padding: const EdgeInsets.fromLTRB(8, 18, 8, 12),
//                       children: [
//                         ..._sections.map(
//                           (section) => _buildCollapsedSection(
//                             context,
//                             section,
//                             currentRoute,
//                           ),
//                         ),
//                       ],
//                     )
//                   : ListView(
//                       padding: const EdgeInsets.fromLTRB(12, 18, 12, 12),
//                       children: [
//                         _sectionHeader(title: 'ENTERPRISE SERVICES'),
//                         const SizedBox(height: 6),
//                         ..._sections.map(
//                           (section) => _buildServiceSection(
//                             context,
//                             section,
//                             currentRoute,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                       ],
//                     ),
//             ),

//             // ========================================================
//             // USER AREA
//             // ========================================================
//             if (widget.collapsed)
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withValues(alpha: 0.04),
//                   border: Border(
//                     top: BorderSide(
//                       color: Colors.white.withValues(alpha: 0.08),
//                     ),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Tooltip(
//                       message: user.name.isEmpty ? 'Guest User' : user.name,
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(9),
//                           onTap: () {
//                             context.go(AppRoutes.profile);
//                           },
//                           child: Container(
//                             width: 46,
//                             height: 46,
//                             decoration: BoxDecoration(
//                               color: AppTheme.primaryBlue,
//                               borderRadius: BorderRadius.circular(9),
//                             ),
//                             child: const Icon(
//                               Icons.person_outline,
//                               color: Colors.white,
//                               size: 21,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Tooltip(
//                       message: 'Logout',
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(9),
//                           onTap: () {
//                             user.logout();
//                             context.go(AppRoutes.login);
//                           },
//                           child: SizedBox(
//                             width: 46,
//                             height: 42,
//                             child: Center(
//                               child: Icon(
//                                 Icons.logout,
//                                 color: Colors.white.withValues(alpha: 0.72),
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             else
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withValues(alpha: 0.04),
//                   border: Border(
//                     top: BorderSide(
//                       color: Colors.white.withValues(alpha: 0.08),
//                     ),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: () {
//                           context.go(AppRoutes.profile);
//                         },
//                         borderRadius: BorderRadius.circular(10),
//                         child: Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withValues(alpha: 0.06),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: 38,
//                                 height: 38,
//                                 decoration: BoxDecoration(
//                                   color: AppTheme.primaryBlue,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(
//                                   Icons.person_outline,
//                                   color: Colors.white,
//                                   size: 20,
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       user.name.isEmpty
//                                           ? 'Guest User'
//                                           : user.name,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 3),
//                                     Text(
//                                       user.email.isEmpty
//                                           ? 'guest@onecloud.com'
//                                           : user.email,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(
//                                         color: Colors.white.withValues(
//                                           alpha: 0.55,
//                                         ),
//                                         fontSize: 10,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(8),
//                         onTap: () {
//                           user.logout();
//                           context.go(AppRoutes.login);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 10,
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.logout,
//                                 color: Colors.white.withValues(alpha: 0.70),
//                                 size: 19,
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 'Logout',
//                                 style: TextStyle(
//                                   color: Colors.white.withValues(alpha: 0.80),
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               const Spacer(),
//                               Icon(
//                                 Icons.arrow_forward_ios,
//                                 color: Colors.white.withValues(alpha: 0.35),
//                                 size: 13,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ==============================================================
//   // COLLAPSED SERVICE SECTION
//   // ==============================================================

//   Widget _buildCollapsedSection(
//     BuildContext context,
//     SidebarSection section,
//     String currentRoute,
//   ) {
//     final active = _isSectionActive(section, currentRoute);

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Tooltip(
//         message: section.title,
//         preferBelow: false,
//         child: Material(
//           color: active
//               ? Colors.white.withValues(alpha: 0.12)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(9),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(9),
//             hoverColor: Colors.white.withValues(alpha: 0.08),
//             onTap: () {
//               // If the section has a dashboard route, open it.
//               // Otherwise open the first available child.
//               if (section.route.isNotEmpty) {
//                 _navigate(context, section.route);
//               } else if (section.children.isNotEmpty) {
//                 _navigate(context, section.children.first.route);
//               }
//             },
//             child: SizedBox(
//               width: 56,
//               height: 46,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   if (active)
//                     Positioned(
//                       left: 0,
//                       child: Container(
//                         width: 3,
//                         height: 24,
//                         decoration: BoxDecoration(
//                           color: AppTheme.primaryBlue,
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                       ),
//                     ),
//                   Icon(
//                     section.icon,
//                     size: 21,
//                     color: active
//                         ? Colors.white
//                         : Colors.white.withValues(alpha: 0.68),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ==============================================================
//   // SERVICE SECTION
//   // ==============================================================

//   Widget _buildServiceSection(
//     BuildContext context,
//     SidebarSection section,
//     String currentRoute,
//   ) {
//     final expanded = _expandedSections[section.title] ?? false;

//     final active = _isSectionActive(section, currentRoute);

//     return Column(
//       children: [
//         // ------------------------------------------------------------
//         // PARENT ITEM
//         // ------------------------------------------------------------

//         Padding(
//           padding: const EdgeInsets.only(bottom: 4),
//           child: Material(
//             color: active
//                 ? Colors.white.withValues(alpha: 0.10)
//                 : Colors.transparent,
//             borderRadius: BorderRadius.circular(9),
//             child: InkWell(
//               borderRadius: BorderRadius.circular(9),
//               hoverColor: Colors.white.withValues(alpha: 0.07),
//               onTap: () {
//                 _toggleSection(section.title);
//               },
//               child: Container(
//                 height: 46,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(9),
//                   border: active
//                       ? Border.all(color: Colors.white.withValues(alpha: 0.07))
//                       : null,
//                 ),
//                 child: Row(
//                   children: [
//                     // Active indicator
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 180),
//                       width: 4,
//                       height: active ? 25 : 0,
//                       decoration: BoxDecoration(
//                         color: AppTheme.primaryBlue,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),

//                     const SizedBox(width: 12),

//                     Icon(
//                       section.icon,
//                       size: 20,
//                       color: active
//                           ? Colors.white
//                           : Colors.white.withValues(alpha: 0.68),
//                     ),

//                     const SizedBox(width: 12),

//                     Expanded(
//                       child: Text(
//                         section.title,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           color: active
//                               ? Colors.white
//                               : Colors.white.withValues(alpha: 0.78),
//                           fontSize: 13,
//                           fontWeight: active
//                               ? FontWeight.w600
//                               : FontWeight.w500,
//                         ),
//                       ),
//                     ),

//                     // Expand / collapse icon
//                     Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: AnimatedRotation(
//                         turns: expanded ? 0.5 : 0.0,
//                         duration: const Duration(milliseconds: 180),
//                         child: Icon(
//                           Icons.keyboard_arrow_down,
//                           color: Colors.white.withValues(alpha: 0.55),
//                           size: 19,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),

//         // ------------------------------------------------------------
//         // CHILDREN
//         // ------------------------------------------------------------
//         AnimatedCrossFade(
//           firstChild: const SizedBox.shrink(),
//           secondChild: Padding(
//             padding: const EdgeInsets.only(left: 16, bottom: 4),
//             child: Column(
//               children: section.children.map((child) {
//                 return _childSidebarItem(
//                   context,
//                   currentRoute,
//                   child.icon,
//                   child.title,
//                   child.route,
//                 );
//               }).toList(),
//             ),
//           ),
//           crossFadeState: expanded
//               ? CrossFadeState.showSecond
//               : CrossFadeState.showFirst,
//           duration: const Duration(milliseconds: 180),
//         ),
//       ],
//     );
//   }

//   // ==============================================================
//   // MAIN SECTION HEADER
//   // ==============================================================

//   Widget _sectionHeader({required String title}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               title,
//               style: TextStyle(
//                 color: Colors.white.withValues(alpha: 0.48),
//                 fontSize: 10,
//                 fontWeight: FontWeight.w700,
//                 letterSpacing: 1.3,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ==============================================================
//   // MAIN SIDEBAR ITEM
//   // ==============================================================

//   Widget _sidebarItem(
//     BuildContext context,
//     String currentRoute,
//     IconData icon,
//     String title,
//     String route,
//   ) {
//     final selected = currentRoute == route;

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Material(
//         color: selected
//             ? Colors.white.withValues(alpha: 0.13)
//             : Colors.transparent,
//         borderRadius: BorderRadius.circular(9),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(9),
//           hoverColor: Colors.white.withValues(alpha: 0.07),
//           onTap: () {
//             _navigate(context, route);
//           },
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 180),
//             height: 44,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(9),
//               border: selected
//                   ? Border.all(color: Colors.white.withValues(alpha: 0.08))
//                   : null,
//             ),
//             child: Row(
//               children: [
//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 180),
//                   width: 4,
//                   height: selected ? 25 : 0,
//                   decoration: BoxDecoration(
//                     color: AppTheme.primaryBlue,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Icon(
//                   icon,
//                   size: 20,
//                   color: selected
//                       ? Colors.white
//                       : Colors.white.withValues(alpha: 0.62),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: Text(
//                     title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: selected
//                           ? Colors.white
//                           : Colors.white.withValues(alpha: 0.72),
//                       fontSize: 13,
//                       fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
//                     ),
//                   ),
//                 ),

//                 if (selected)
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: Icon(
//                       Icons.chevron_right,
//                       color: Colors.white.withValues(alpha: 0.70),
//                       size: 18,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ==============================================================
//   // CHILD SIDEBAR ITEM
//   // ==============================================================

//   Widget _childSidebarItem(
//     BuildContext context,
//     String currentRoute,
//     IconData icon,
//     String title,
//     String route,
//   ) {
//     final selected = currentRoute == route;

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 2),
//       child: Material(
//         color: selected
//             ? Colors.white.withValues(alpha: 0.10)
//             : Colors.transparent,
//         borderRadius: BorderRadius.circular(8),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(8),
//           hoverColor: Colors.white.withValues(alpha: 0.06),
//           onTap: () {
//             _navigate(context, route);
//           },
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 160),
//             height: 40,
//             padding: const EdgeInsets.only(left: 10, right: 8),
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
//             child: Row(
//               children: [
//                 // Small connecting indicator
//                 Container(
//                   width: 3,
//                   height: selected ? 20 : 14,
//                   decoration: BoxDecoration(
//                     color: selected
//                         ? AppTheme.primaryBlue
//                         : Colors.white.withValues(alpha: 0.20),
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                 ),

//                 const SizedBox(width: 10),

//                 Icon(
//                   icon,
//                   size: 17,
//                   color: selected
//                       ? Colors.white
//                       : Colors.white.withValues(alpha: 0.52),
//                 ),

//                 const SizedBox(width: 10),

//                 Expanded(
//                   child: Text(
//                     title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: selected
//                           ? Colors.white
//                           : Colors.white.withValues(alpha: 0.64),
//                       fontSize: 12,
//                       fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
//                     ),
//                   ),
//                 ),

//                 if (selected)
//                   Icon(
//                     Icons.chevron_right,
//                     color: Colors.white.withValues(alpha: 0.55),
//                     size: 16,
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ================================================================
// // APP FOOTER
// // ================================================================

// class AppFooter extends StatelessWidget {
//   const AppFooter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 42,
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       color: AppTheme.darkNavy,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             'One Cloud Enterprise Platform',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 12,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(width: 10),

//           Text(
//             '© 2026 All rights reserved',
//             style: TextStyle(
//               color: Colors.white.withValues(alpha: 0.60),
//               fontSize: 10,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ================================================================
// // APP LAYOUT
// // ================================================================

// class AppLayout extends StatefulWidget {
//   final Widget child;

//   const AppLayout({super.key, required this.child});

//   @override
//   State<AppLayout> createState() => _AppLayoutState();
// }

// class _AppLayoutState extends State<AppLayout> {
//   late final ValueNotifier<bool> _sidebarOpen;

//   @override
//   void initState() {
//     super.initState();

//     _sidebarOpen = ValueNotifier<bool>(true);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!mounted) return;

//       final width = MediaQuery.of(context).size.width;
//       _sidebarOpen.value = width >= 850;
//     });
//   }

//   @override
//   void dispose() {
//     _sidebarOpen.dispose();
//     super.dispose();
//   }

//   void _toggleSidebar() {
//     _sidebarOpen.value = !_sidebarOpen.value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobile = screenWidth < 850;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Row(
//         children: [
//           // ==========================================================
//           // DESKTOP / TABLET SIDEBAR
//           //
//           // Only this subtree listens to the sidebar state.
//           // The main page is therefore NOT rebuilt when the sidebar
//           // is opened or closed.
//           // ==========================================================
//           if (!isMobile)
//             ValueListenableBuilder<bool>(
//               valueListenable: _sidebarOpen,
//               builder: (context, open, child) {
//                 return AnimatedContainer(
//                   duration: const Duration(milliseconds: 220),
//                   curve: Curves.easeOutCubic,
//                   width: open ? 275.0 : 72.0,
//                   height: double.infinity,
//                   child: ClipRect(
//                     child: OverflowBox(
//                       alignment: Alignment.centerLeft,
//                       minWidth: 0,
//                       maxWidth: 275,
//                       child: AppSidebar(collapsed: !open),
//                     ),
//                   ),
//                 );
//               },
//             ),

//           // ==========================================================
//           // MAIN AREA
//           // ==========================================================
//           Expanded(
//             child: Scaffold(
//               backgroundColor: Colors.white,

//               // ------------------------------------------------------
//               // HEADER
//               // Only the header listens to the sidebar state.
//               // ------------------------------------------------------
//               appBar: PreferredSize(
//                 preferredSize: const Size.fromHeight(68),
//                 child: ValueListenableBuilder<bool>(
//                   valueListenable: _sidebarOpen,
//                   builder: (context, open, _) {
//                     return AppHeader(
//                       sidebarOpen: open,
//                       onMenuPressed: _toggleSidebar,
//                     );
//                   },
//                 ),
//               ),

//               // ------------------------------------------------------
//               // PAGE CONTENT
//               // ------------------------------------------------------
//               body: Stack(
//                 children: [
//                   // Current page is kept outside the sidebar listener.
//                   widget.child,

//                   // ==================================================
//                   // MOBILE SIDEBAR
//                   // ==================================================
//                   if (isMobile)
//                     ValueListenableBuilder<bool>(
//                       valueListenable: _sidebarOpen,
//                       builder: (context, open, _) {
//                         if (!open) {
//                           return const SizedBox.shrink();
//                         }

//                         return Positioned.fill(
//                           child: Row(
//                             children: [
//                               const AppSidebar(),

//                               Expanded(
//                                 child: GestureDetector(
//                                   onTap: _toggleSidebar,
//                                   child: Container(
//                                     color: Colors.black.withValues(alpha: 0.35),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                 ],
//               ),

//               // ------------------------------------------------------
//               // FOOTER
//               // ------------------------------------------------------
//               bottomNavigationBar: const AppFooter(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../routes/routes.dart';
import '../providers/user_provider.dart';

// ================================================================
// APP HEADER
// ================================================================

class AppHeader extends ConsumerWidget implements PreferredSizeWidget {
  final bool sidebarOpen;
  final VoidCallback onMenuPressed;

  const AppHeader({
    super.key,
    required this.sidebarOpen,
    required this.onMenuPressed,
  });

  void _navigate(BuildContext context, String route) {
    if (GoRouterState.of(context).uri.path == route) {
      return;
    }

    context.push(route);
  }

  void _logout(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).logout();
    context.go(AppRoutes.login);
  }

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;

    return AppBar(
      backgroundColor: AppTheme.darkNavy,
      elevation: 0,
      toolbarHeight: 68,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          // ==========================================================
          // SIDEBAR TOGGLE
          // ==========================================================

          Padding(
            padding: const EdgeInsets.only(left: 8, right: 6),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: onMenuPressed,
                borderRadius: BorderRadius.circular(8),
                hoverColor: Colors.white.withValues(alpha: 0.08),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(
                      sidebarOpen
                          ? Icons.menu_open_rounded
                          : Icons.menu_rounded,
                      color: Colors.white.withValues(alpha: 0.90),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 4),

          // ==========================================================
          // LOGO
          // ==========================================================
          Container(
            height: 44,
            width: isMobile ? 125 : 140,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/images/onecloud_logo.png',
              fit: BoxFit.contain,
            ),
          ),

          const Spacer(),

          // ==========================================================
          // DESKTOP MENU
          // ==========================================================
          if (!isMobile) ...[
            TextButton(
              onPressed: () {
                _navigate(context, AppRoutes.dashboard);
              },
              child: const Text(
                'Dashboard',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            TextButton(
              onPressed: () {
                _navigate(context, AppRoutes.features);
              },
              child: const Text(
                'Features',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            TextButton(
              onPressed: () {
                _navigate(context, AppRoutes.contact);
              },
              child: const Text(
                'Contact',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            TextButton(
              onPressed: () {
                _navigate(context, AppRoutes.about);
              },
              child: const Text(
                'About',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            const SizedBox(width: 8),

            // ========================================================
            // PROFILE
            // ========================================================
            if (user.email.isNotEmpty)
              TextButton(
                onPressed: () {
                  _navigate(context, AppRoutes.profile);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      user.name.isNotEmpty ? user.name : user.email,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(width: 6),

            // ========================================================
            // LOGOUT
            // ========================================================
            IconButton(
              tooltip: 'Logout',
              onPressed: () {
                _logout(context, ref);
              },
              icon: const Icon(Icons.logout, color: Colors.white, size: 21),
            ),

            const SizedBox(width: 6),
          ],

          // ==========================================================
          // MOBILE MENU
          // ==========================================================
          if (isMobile)
            IconButton(
              tooltip: 'Profile',
              icon: const Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                context.push(AppRoutes.profile);
              },
            ),

          if (isMobile)
            PopupMenuButton<String>(
              tooltip: 'Menu',
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 28,
              ),
              color: Colors.white,
              elevation: 8,
              offset: const Offset(0, 48),
              onSelected: (value) {
                switch (value) {
                  case 'dashboard':
                    _navigate(context, AppRoutes.dashboard);
                    break;

                  case 'features':
                    _navigate(context, AppRoutes.features);
                    break;

                  case 'contact':
                    _navigate(context, AppRoutes.contact);
                    break;

                  case 'about':
                    _navigate(context, AppRoutes.about);
                    break;

                  case 'profile':
                    _navigate(context, AppRoutes.profile);
                    break;

                  case 'logout':
                    _logout(context, ref);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'dashboard',
                  child: Row(
                    children: [
                      Icon(Icons.dashboard_outlined, size: 20),
                      SizedBox(width: 12),
                      Text('Dashboard'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'features',
                  child: Row(
                    children: [
                      Icon(Icons.apps_outlined, size: 20),
                      SizedBox(width: 12),
                      Text('Features'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'contact',
                  child: Row(
                    children: [
                      Icon(Icons.contact_support_outlined, size: 20),
                      SizedBox(width: 12),
                      Text('Contact'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'about',
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 20),
                      SizedBox(width: 12),
                      Text('About'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 20),
                      SizedBox(width: 12),
                      Text('Logout'),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ================================================================
// SIDEBAR MENU MODEL
// ================================================================

class SidebarChild {
  final String title;
  final IconData icon;
  final String route;

  const SidebarChild({
    required this.title,
    required this.icon,
    required this.route,
  });
}

class SidebarSection {
  final String title;
  final IconData icon;
  final String route;
  final List<SidebarChild> children;

  const SidebarSection({
    required this.title,
    required this.icon,
    required this.route,
    this.children = const [],
  });
}

// ================================================================
// APP SIDEBAR
// ================================================================

class AppSidebar extends ConsumerStatefulWidget {
  final bool collapsed;

  const AppSidebar({super.key, this.collapsed = false});

  @override
  ConsumerState<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends ConsumerState<AppSidebar> {
  final Map<String, bool> _expandedSections = {};

  // ==============================================================
  // ONECLOUD SIDEBAR STRUCTURE
  // ==============================================================

  final List<SidebarSection> _sections = const [
    // ------------------------------------------------------------
    // PLATFORM ADMINISTRATION
    // ------------------------------------------------------------

    SidebarSection(
      title: 'Platform Administration',
      icon: Icons.admin_panel_settings_outlined,
      route: AppRoutes.admin,
      children: [
        SidebarChild(
          title: 'Admin Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.admin,
        ),
        SidebarChild(
          title: 'Global Settings',
          icon: Icons.settings_outlined,
          route: AppRoutes.globalSettings,
        ),
        SidebarChild(
          title: 'Platform Config',
          icon: Icons.tune_outlined,
          route: AppRoutes.platformConfig,
        ),
        SidebarChild(
          title: 'License Management',
          icon: Icons.key_outlined,
          route: AppRoutes.licenseManagement,
        ),
        SidebarChild(
          title: 'Feature Management',
          icon: Icons.extension_outlined,
          route: AppRoutes.featureManagement,
        ),
        SidebarChild(
          title: 'Resource Management',
          icon: Icons.storage_outlined,
          route: AppRoutes.resourceManagement,
        ),
        SidebarChild(
          title: 'System Health',
          icon: Icons.monitor_heart_outlined,
          route: AppRoutes.systemHealth,
        ),
        SidebarChild(
          title: 'Tenant Templates',
          icon: Icons.layers_outlined,
          route: AppRoutes.tenantTemplates,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // HRMS
    // ------------------------------------------------------------
    SidebarSection(
      title: 'HRMS',
      icon: Icons.people_alt_outlined,
      route: AppRoutes.hrms,
      children: [
        SidebarChild(
          title: 'HRMS Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.hrms,
        ),
        SidebarChild(
          title: 'Employee Management',
          icon: Icons.badge_outlined,
          route: AppRoutes.hrmsEmployees,
        ),
        SidebarChild(
          title: 'Attendance',
          icon: Icons.access_time_outlined,
          route: AppRoutes.hrmsAttendance,
        ),
        SidebarChild(
          title: 'Leave',
          icon: Icons.event_busy_outlined,
          route: AppRoutes.hrmsLeave,
        ),
        SidebarChild(
          title: 'Payroll',
          icon: Icons.payments_outlined,
          route: AppRoutes.hrmsPayroll,
        ),
        SidebarChild(
          title: 'Recruitment',
          icon: Icons.person_search_outlined,
          route: AppRoutes.hrmsRecruitment,
        ),
        SidebarChild(
          title: 'Performance',
          icon: Icons.trending_up_outlined,
          route: AppRoutes.hrmsPerformance,
        ),
        SidebarChild(
          title: 'Learning',
          icon: Icons.school_outlined,
          route: AppRoutes.hrmsLearning,
        ),
        SidebarChild(
          title: 'ESS / MSS',
          icon: Icons.manage_accounts_outlined,
          route: AppRoutes.hrmsEssMss,
        ),
        SidebarChild(
          title: 'Asset Management',
          icon: Icons.devices_outlined,
          route: AppRoutes.hrmsAssets,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // CRM
    // ------------------------------------------------------------
    SidebarSection(
      title: 'CRM',
      icon: Icons.handshake_outlined,
      route: AppRoutes.crm,
      children: [
        SidebarChild(
          title: 'Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.crm,
        ),
        SidebarChild(
          title: 'Leads',
          icon: Icons.person_search_outlined,
          route: AppRoutes.crmLeads,
        ),
        SidebarChild(
          title: 'Opportunities',
          icon: Icons.trending_up_outlined,
          route: AppRoutes.crmOpportunities,
        ),
        SidebarChild(
          title: 'Accounts',
          icon: Icons.business_outlined,
          route: AppRoutes.crmAccounts,
        ),
        SidebarChild(
          title: 'Contacts',
          icon: Icons.contacts_outlined,
          route: AppRoutes.crmContacts,
        ),
        SidebarChild(
          title: 'Activities',
          icon: Icons.task_alt_outlined,
          route: AppRoutes.crmActivities,
        ),
        SidebarChild(
          title: 'Pipeline',
          icon: Icons.filter_alt_outlined,
          route: AppRoutes.crmPipeline,
        ),
        SidebarChild(
          title: 'Quotations',
          icon: Icons.request_quote_outlined,
          route: AppRoutes.crmQuotations,
        ),
        SidebarChild(
          title: 'Campaigns',
          icon: Icons.campaign_outlined,
          route: AppRoutes.crmCampaigns,
        ),
        SidebarChild(
          title: 'Customer Support',
          icon: Icons.support_agent_outlined,
          route: AppRoutes.crmCustomerSupport,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // ERP
    // ------------------------------------------------------------
    SidebarSection(
      title: 'ERP',
      icon: Icons.inventory_2_outlined,
      route: AppRoutes.erp,
      children: [
        SidebarChild(
          title: 'ERP Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.erp,
        ),

        SidebarChild(
          title: 'Inventory',
          icon: Icons.inventory_2_outlined,
          route: AppRoutes.inventory,
        ),
        SidebarChild(
          title: 'Warehouses',
          icon: Icons.warehouse_outlined,
          route: AppRoutes.warehouses,
        ),
        SidebarChild(
          title: 'Stock Movements',
          icon: Icons.swap_horiz_outlined,
          route: AppRoutes.stockMovements,
        ),
        SidebarChild(
          title: 'Procurement',
          icon: Icons.shopping_cart_outlined,
          route: AppRoutes.procurement,
        ),
        SidebarChild(
          title: 'Vendors',
          icon: Icons.people_outline,
          route: AppRoutes.vendors,
        ),
        SidebarChild(
          title: 'Sales Orders',
          icon: Icons.receipt_long_outlined,
          route: AppRoutes.salesOrders,
        ),
        SidebarChild(
          title: 'Dispatch',
          icon: Icons.local_shipping_outlined,
          route: AppRoutes.dispatch,
        ),
        SidebarChild(
          title: 'Production',
          icon: Icons.precision_manufacturing_outlined,
          route: AppRoutes.production,
        ),
        SidebarChild(
          title: 'Asset Management',
          icon: Icons.business_center_outlined,
          route: AppRoutes.assetManagement,
        ),
        SidebarChild(
          title: 'Maintenance',
          icon: Icons.build_outlined,
          route: AppRoutes.maintenance,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // FINANCE & ACCOUNTING
    // ------------------------------------------------------------
    SidebarSection(
      title: 'Finance & Accounting',
      icon: Icons.account_balance_wallet_outlined,
      route: AppRoutes.finance,
      children: [
        SidebarChild(
          title: 'Finance Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.finance,
        ),

        SidebarChild(
          title: 'General Ledger',
          icon: Icons.menu_book_outlined,
          route: AppRoutes.financeGeneralLedger,
        ),

        SidebarChild(
          title: 'Accounts Payable',
          icon: Icons.arrow_circle_down_outlined,
          route: AppRoutes.financeAccountsPayable,
        ),

        SidebarChild(
          title: 'Accounts Receivable',
          icon: Icons.arrow_circle_up_outlined,
          route: AppRoutes.financeAccountsReceivable,
        ),

        SidebarChild(
          title: 'Asset Management',
          icon: Icons.business_center_outlined,
          route: AppRoutes.financeAssetManagement,
        ),

        SidebarChild(
          title: 'Budgeting',
          icon: Icons.account_balance_outlined,
          route: AppRoutes.financeBudgeting,
        ),

        SidebarChild(
          title: 'Costing',
          icon: Icons.calculate_outlined,
          route: AppRoutes.financeCosting,
        ),

        SidebarChild(
          title: 'Financial Reports',
          icon: Icons.bar_chart_outlined,
          route: AppRoutes.financeFinancialReports,
        ),

        SidebarChild(
          title: 'Reconciliation',
          icon: Icons.sync_alt_outlined,
          route: AppRoutes.financeReconciliation,
        ),

        SidebarChild(
          title: 'Multi-Currency',
          icon: Icons.currency_exchange_outlined,
          route: AppRoutes.financeMultiCurrency,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // WORKFLOW & AUTOMATION
    // ------------------------------------------------------------
    SidebarSection(
      title: 'Workflow & Automation',
      icon: Icons.account_tree_outlined,
      route: AppRoutes.workflow,
      children: [
        SidebarChild(
          title: 'Workflow Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.workflow,
        ),
        SidebarChild(
          title: 'Workflow Builder',
          icon: Icons.account_tree_outlined,
          route: AppRoutes.workflowBuilder,
        ),
        SidebarChild(
          title: 'Approvals',
          icon: Icons.approval_outlined,
          route: AppRoutes.workflowApprovals,
        ),
        SidebarChild(
          title: 'Business Rules',
          icon: Icons.rule_outlined,
          route: AppRoutes.workflowBusinessRules,
        ),
        SidebarChild(
          title: 'Process Automation',
          icon: Icons.auto_awesome_outlined,
          route: AppRoutes.workflowProcessAutomation,
        ),
        SidebarChild(
          title: 'Task Management',
          icon: Icons.task_outlined,
          route: AppRoutes.workflowTasks,
        ),
        SidebarChild(
          title: 'Triggers',
          icon: Icons.flash_on_outlined,
          route: AppRoutes.workflowTriggers,
        ),
        SidebarChild(
          title: 'SLAs & Escalations',
          icon: Icons.timer_outlined,
          route: AppRoutes.workflowSlas,
        ),
        SidebarChild(
          title: 'Process Monitoring',
          icon: Icons.monitor_outlined,
          route: AppRoutes.workflowMonitoring,
        ),
        SidebarChild(
          title: 'Workflow Templates',
          icon: Icons.dashboard_customize_outlined,
          route: AppRoutes.workflowTemplates,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // DOCUMENT MANAGEMENT
    // ------------------------------------------------------------
    SidebarSection(
      title: 'Document Management',
      icon: Icons.folder_open_outlined,
      route: AppRoutes.documents,
      children: [
        SidebarChild(
          title: 'Document Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.documents,
        ),
        SidebarChild(
          title: 'Document Repository',
          icon: Icons.folder_outlined,
          route: AppRoutes.documentRepository,
        ),
        SidebarChild(
          title: 'Versioning',
          icon: Icons.history_outlined,
          route: AppRoutes.documentVersioning,
        ),
        SidebarChild(
          title: 'File Upload / Download',
          icon: Icons.file_upload_outlined,
          route: AppRoutes.documentUploadDownload,
        ),
        SidebarChild(
          title: 'Access Control',
          icon: Icons.lock_outline,
          route: AppRoutes.documentAccessControl,
        ),
        SidebarChild(
          title: 'Document Templates',
          icon: Icons.description_outlined,
          route: AppRoutes.documentTemplates,
        ),
        SidebarChild(
          title: 'Tagging & Search',
          icon: Icons.local_offer_outlined,
          route: AppRoutes.documentTaggingSearch,
        ),
        SidebarChild(
          title: 'Retention Policies',
          icon: Icons.policy_outlined,
          route: AppRoutes.documentRetentionPolicies,
        ),
        SidebarChild(
          title: 'Audit Trails',
          icon: Icons.fact_check_outlined,
          route: AppRoutes.documentAuditTrails,
        ),
        SidebarChild(
          title: 'OCR Integration',
          icon: Icons.document_scanner_outlined,
          route: AppRoutes.documentOcrIntegration,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // SUBSCRIPTION
    // ------------------------------------------------------------
    SidebarSection(
      title: 'Subscription',
      icon: Icons.card_membership_outlined,
      route: AppRoutes.subscription,
      children: [
        SidebarChild(
          title: 'Subscription Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.subscription,
        ),
        SidebarChild(
          title: 'Plans & Features',
          icon: Icons.view_list_outlined,
          route: AppRoutes.subscriptionPlansFeatures,
        ),
        SidebarChild(
          title: 'Tenant Subscriptions',
          icon: Icons.apartment_outlined,
          route: AppRoutes.tenantSubscriptions,
        ),
        SidebarChild(
          title: 'Usage & Quotas',
          icon: Icons.data_usage_outlined,
          route: AppRoutes.subscriptionUsageQuotas,
        ),
        SidebarChild(
          title: 'Payment Tracking',
          icon: Icons.payment_outlined,
          route: AppRoutes.subscriptionPaymentTracking,
        ),
        SidebarChild(
          title: 'License Allocation',
          icon: Icons.key_outlined,
          route: AppRoutes.subscriptionLicenseAllocation,
        ),
        SidebarChild(
          title: 'Renewals',
          icon: Icons.autorenew_outlined,
          route: AppRoutes.subscriptionRenewals,
        ),
        SidebarChild(
          title: 'Trial Management',
          icon: Icons.timer_outlined,
          route: AppRoutes.subscriptionTrialManagement,
        ),
        SidebarChild(
          title: 'Billing Integration',
          icon: Icons.receipt_long_outlined,
          route: AppRoutes.subscriptionBillingIntegration,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // REVENUE
    // ------------------------------------------------------------
    SidebarSection(
      title: 'Revenue',
      icon: Icons.trending_up_outlined,
      route: AppRoutes.revenue,
      children: [
        SidebarChild(
          title: 'Revenue Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.revenue,
        ),
        SidebarChild(
          title: 'Revenue Tracking',
          icon: Icons.track_changes_outlined,
          route: AppRoutes.revenueTracking,
        ),
        SidebarChild(
          title: 'Usage Analytics',
          icon: Icons.analytics_outlined,
          route: AppRoutes.revenueUsageAnalytics,
        ),
        SidebarChild(
          title: 'Forecasting',
          icon: Icons.insights_outlined,
          route: AppRoutes.revenueForecasting,
        ),
        SidebarChild(
          title: 'Financial Analytics',
          icon: Icons.bar_chart_outlined,
          route: AppRoutes.revenueFinancialAnalytics,
        ),
        SidebarChild(
          title: 'Revenue Recognition',
          icon: Icons.verified_outlined,
          route: AppRoutes.revenueRecognition,
        ),
        SidebarChild(
          title: 'Commission Management',
          icon: Icons.percent_outlined,
          route: AppRoutes.revenueCommissionManagement,
        ),
        SidebarChild(
          title: 'Invoicing',
          icon: Icons.receipt_long_outlined,
          route: AppRoutes.revenueInvoicing,
        ),
        SidebarChild(
          title: 'Integration',
          icon: Icons.integration_instructions_outlined,
          route: AppRoutes.revenueIntegration,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // REPORTING & BI
    // ------------------------------------------------------------
    SidebarSection(
      title: 'Reporting & BI',
      icon: Icons.analytics_outlined,
      route: AppRoutes.reporting,
      children: [
        SidebarChild(
          title: 'Reporting Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.reporting,
        ),
        SidebarChild(
          title: 'Standard Reports',
          icon: Icons.description_outlined,
          route: AppRoutes.reportingStandardReports,
        ),
        SidebarChild(
          title: 'Ad-hoc Reports',
          icon: Icons.edit_note_outlined,
          route: AppRoutes.reportingAdHocReports,
        ),
        SidebarChild(
          title: 'Data Exploration',
          icon: Icons.explore_outlined,
          route: AppRoutes.reportingDataExploration,
        ),
        SidebarChild(
          title: 'BI Management',
          icon: Icons.dashboard_customize_outlined,
          route: AppRoutes.reportingBiManagement,
        ),
        SidebarChild(
          title: 'Data Export',
          icon: Icons.file_download_outlined,
          route: AppRoutes.reportingDataExport,
        ),
        SidebarChild(
          title: 'Scheduled Reports',
          icon: Icons.schedule_outlined,
          route: AppRoutes.reportingScheduledReports,
        ),
        SidebarChild(
          title: 'Data Visualization',
          icon: Icons.bar_chart_outlined,
          route: AppRoutes.reportingDataVisualization,
        ),
        SidebarChild(
          title: 'Self-Service Analytics',
          icon: Icons.auto_graph_outlined,
          route: AppRoutes.reportingSelfServiceAnalytics,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // ENTERPRISE AI
    // ------------------------------------------------------------
    SidebarSection(
      title: 'Enterprise AI',
      icon: Icons.auto_awesome_outlined,
      route: AppRoutes.ai,
      children: [
        SidebarChild(
          title: 'AI Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.ai,
        ),
        SidebarChild(
          title: 'AI Models',
          icon: Icons.psychology_outlined,
          route: AppRoutes.enterpriseAiModels,
        ),
        SidebarChild(
          title: 'Chat / Copilot',
          icon: Icons.smart_toy_outlined,
          route: AppRoutes.enterpriseAiChatCopilot,
        ),
        SidebarChild(
          title: 'Document AI / OCR',
          icon: Icons.document_scanner_outlined,
          route: AppRoutes.enterpriseAiDocumentAiOcr,
        ),
        SidebarChild(
          title: 'Predictive Analytics',
          icon: Icons.insights_outlined,
          route: AppRoutes.enterpriseAiPredictiveAnalytics,
        ),
        SidebarChild(
          title: 'Recommendations',
          icon: Icons.recommend_outlined,
          route: AppRoutes.enterpriseAiRecommendations,
        ),
        SidebarChild(
          title: 'AI Workflows',
          icon: Icons.account_tree_outlined,
          route: AppRoutes.enterpriseAiWorkflows,
        ),
        SidebarChild(
          title: 'Model Management',
          icon: Icons.model_training_outlined,
          route: AppRoutes.enterpriseAiModelManagement,
        ),
        SidebarChild(
          title: 'Prompt Engineering',
          icon: Icons.code_outlined,
          route: AppRoutes.enterpriseAiPromptEngineering,
        ),
        SidebarChild(
          title: 'AI Usage Logs',
          icon: Icons.history_outlined,
          route: AppRoutes.enterpriseAiUsageLogs,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // NOTIFICATION
    // ------------------------------------------------------------
    SidebarSection(
      title: 'Notification',
      icon: Icons.notifications_none_outlined,
      route: AppRoutes.notification,
      children: [
        SidebarChild(
          title: 'Notification Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.notification,
        ),
        SidebarChild(
          title: 'In-App Notifications',
          icon: Icons.notifications_outlined,
          route: AppRoutes.notificationInApp,
        ),
        SidebarChild(
          title: 'Email Notifications',
          icon: Icons.email_outlined,
          route: AppRoutes.notificationEmail,
        ),
        SidebarChild(
          title: 'SMS Notifications',
          icon: Icons.sms_outlined,
          route: AppRoutes.notificationSms,
        ),
        SidebarChild(
          title: 'Push Notifications',
          icon: Icons.phone_android_outlined,
          route: AppRoutes.notificationPush,
        ),
        SidebarChild(
          title: 'Templates',
          icon: Icons.article_outlined,
          route: AppRoutes.notificationTemplates,
        ),
        SidebarChild(
          title: 'Preferences',
          icon: Icons.tune_outlined,
          route: AppRoutes.notificationPreferences,
        ),
        SidebarChild(
          title: 'Schedules',
          icon: Icons.schedule_outlined,
          route: AppRoutes.notificationSchedules,
        ),
        SidebarChild(
          title: 'Delivery Tracking',
          icon: Icons.local_shipping_outlined,
          route: AppRoutes.notificationDeliveryTracking,
        ),
        SidebarChild(
          title: 'Multi-Channel',
          icon: Icons.hub_outlined,
          route: AppRoutes.notificationMultiChannel,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // CALENDAR
    // ------------------------------------------------------------
    SidebarSection(
      title: 'Calendar',
      icon: Icons.calendar_month_outlined,
      route: AppRoutes.calendar,
      children: [
        SidebarChild(
          title: 'Calendar Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.calendar,
        ),
        SidebarChild(
          title: 'User Calendars',
          icon: Icons.calendar_today_outlined,
          route: AppRoutes.calendarUserCalendars,
        ),
        SidebarChild(
          title: 'Team Calendars',
          icon: Icons.groups_outlined,
          route: AppRoutes.calendarTeamCalendars,
        ),
        SidebarChild(
          title: 'Meeting Scheduler',
          icon: Icons.event_available_outlined,
          route: AppRoutes.calendarMeetingScheduler,
        ),
        SidebarChild(
          title: 'Resource Booking',
          icon: Icons.event_seat_outlined,
          route: AppRoutes.calendarRecurringBooking,
        ),
        SidebarChild(
          title: 'Reminders',
          icon: Icons.alarm_outlined,
          route: AppRoutes.calendarReminders,
        ),
        SidebarChild(
          title: 'Integrations',
          icon: Icons.sync_outlined,
          route: AppRoutes.calendarIntegrations,
        ),
        SidebarChild(
          title: 'Availability',
          icon: Icons.av_timer_outlined,
          route: AppRoutes.calendarAvailability,
        ),
        SidebarChild(
          title: 'Event Notifications',
          icon: Icons.notifications_active_outlined,
          route: AppRoutes.calendarEventNotifications,
        ),
        SidebarChild(
          title: 'Shared Calendars',
          icon: Icons.share_outlined,
          route: AppRoutes.calendarSharedCalendars,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // INTEGRATION
    // ------------------------------------------------------------
    SidebarSection(
      title: 'Integration',
      icon: Icons.integration_instructions_outlined,
      route: AppRoutes.integration,
      children: [
        SidebarChild(
          title: 'Integration Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.integration,
        ),
        SidebarChild(
          title: 'API Management',
          icon: Icons.api_outlined,
          route: AppRoutes.integrationApiManagement,
        ),
        SidebarChild(
          title: 'Third-Party Integrations',
          icon: Icons.extension_outlined,
          route: AppRoutes.integrationThirdPartyIntegrations,
        ),
        SidebarChild(
          title: 'Webhooks',
          icon: Icons.webhook_outlined,
          route: AppRoutes.integrationWebhooks,
        ),
        SidebarChild(
          title: 'Event Streaming',
          icon: Icons.stream_outlined,
          route: AppRoutes.integrationEventStreaming,
        ),
        SidebarChild(
          title: 'Data Transformation',
          icon: Icons.transform_outlined,
          route: AppRoutes.integrationDataTransformation,
        ),
        SidebarChild(
          title: 'ETL / Data Sync',
          icon: Icons.sync_alt_outlined,
          route: AppRoutes.integrationEtlDataSync,
        ),
        SidebarChild(
          title: 'Connectors',
          icon: Icons.link_outlined,
          route: AppRoutes.integrationConnectors,
        ),
        SidebarChild(
          title: 'Integration Logs',
          icon: Icons.receipt_long_outlined,
          route: AppRoutes.integrationLogs,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // SEARCH
    // ------------------------------------------------------------
    SidebarSection(
      title: 'Search',
      icon: Icons.search_outlined,
      route: AppRoutes.search,
      children: [
        SidebarChild(
          title: 'Search Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.search,
        ),
        SidebarChild(
          title: 'Global Search',
          icon: Icons.search_outlined,
          route: AppRoutes.searchGlobalSearch,
        ),
        SidebarChild(
          title: 'Index Management',
          icon: Icons.storage_outlined,
          route: AppRoutes.searchIndexManagement,
        ),
        SidebarChild(
          title: 'Search Analytics',
          icon: Icons.analytics_outlined,
          route: AppRoutes.searchAnalytics,
        ),
        SidebarChild(
          title: 'Autocomplete',
          icon: Icons.auto_fix_high_outlined,
          route: AppRoutes.searchAutocomplete,
        ),
        SidebarChild(
          title: 'Relevance Ranking',
          icon: Icons.format_list_numbered_outlined,
          route: AppRoutes.searchRelevanceRanking,
        ),
        SidebarChild(
          title: 'Saved Searches',
          icon: Icons.bookmark_outline,
          route: AppRoutes.searchSavedSearches,
        ),
        SidebarChild(
          title: 'Multi-Tenant Index',
          icon: Icons.layers_outlined,
          route: AppRoutes.searchMultiTenantIndex,
        ),
        SidebarChild(
          title: 'Synonyms',
          icon: Icons.compare_arrows_outlined,
          route: AppRoutes.searchSynonyms,
        ),
        SidebarChild(
          title: 'Suggestion Engine',
          icon: Icons.lightbulb_outline,
          route: AppRoutes.searchSuggestionEngine,
        ),
      ],
    ),

    // ------------------------------------------------------------
    // SECURITY & COMPLIANCE
    // ------------------------------------------------------------
    SidebarSection(
      title: 'Security & Compliance',
      icon: Icons.security_outlined,
      route: AppRoutes.security,
      children: [
        SidebarChild(
          title: 'Security Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.security,
        ),
        SidebarChild(
          title: 'Audit Logs',
          icon: Icons.fact_check_outlined,
          route: AppRoutes.securityAuditLogs,
        ),
        SidebarChild(
          title: 'Activity Tracking',
          icon: Icons.track_changes_outlined,
          route: AppRoutes.securityActivityTracking,
        ),
        SidebarChild(
          title: 'Compliance Reports',
          icon: Icons.assignment_turned_in_outlined,
          route: AppRoutes.securityComplianceReports,
        ),
        SidebarChild(
          title: 'Data Retention',
          icon: Icons.delete_sweep_outlined,
          route: AppRoutes.securityDataRetention,
        ),
        SidebarChild(
          title: 'Policy Management',
          icon: Icons.policy_outlined,
          route: AppRoutes.securityPolicyManagement,
        ),
        SidebarChild(
          title: 'Threat Detection',
          icon: Icons.gpp_maybe_outlined,
          route: AppRoutes.securityThreatDetection,
        ),
        SidebarChild(
          title: 'Vulnerability Management',
          icon: Icons.bug_report_outlined,
          route: AppRoutes.securityVulnerabilityManagement,
        ),
        SidebarChild(
          title: 'Encryption & Key Management',
          icon: Icons.enhanced_encryption_outlined,
          route: AppRoutes.securityEncryptionKeyManagement,
        ),
        SidebarChild(
          title: 'Security Alerts',
          icon: Icons.warning_amber_outlined,
          route: AppRoutes.securityAlerts,
        ),
      ],
    ),
  ];

  // ==============================================================
  // INITIALIZE EXPANSION STATES
  // ==============================================================

  @override
  void initState() {
    super.initState();

    for (final section in _sections) {
      _expandedSections[section.title] = false;
    }

    // ERP open by default because it is our current working module.
    // _expandedSections['ERP'] = true;
  }

  // ==============================================================
  // NAVIGATION
  // ==============================================================

  void _navigate(BuildContext context, String route) {
    final currentRoute = GoRouterState.of(context).uri.path;

    if (currentRoute == route) {
      return;
    }

    context.push(route);
  }

  // ==============================================================
  // CHECK WHETHER SECTION IS ACTIVE
  // ==============================================================

  bool _isSectionActive(SidebarSection section, String currentRoute) {
    if (currentRoute == section.route) {
      return true;
    }

    for (final child in section.children) {
      if (currentRoute == child.route) {
        return true;
      }
    }

    return false;
  }

  // ==============================================================
  // TOGGLE SECTION
  // ==============================================================

  void _toggleSection(String title) {
    setState(() {
      _expandedSections[title] = !(_expandedSections[title] ?? false);
    });
  }

  // ==============================================================
  // BUILD
  // ==============================================================

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    final currentRoute = GoRouterState.of(context).uri.path;

    return Container(
      width: widget.collapsed ? 72 : 275,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.darkNavy,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 14,
            offset: const Offset(3, 0),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ========================================================
            // BRAND
            // ========================================================

            if (!widget.collapsed)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        'assets/images/onecloud_logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'OneCloud',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Enterprise Platform',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.55),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 42,
                    height: 42,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'assets/images/onecloud_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

            // ========================================================
            // NAVIGATION
            // ========================================================
            Expanded(
              child: widget.collapsed
                  ? ListView(
                      padding: const EdgeInsets.fromLTRB(8, 18, 8, 12),
                      children: [
                        ..._sections.map(
                          (section) => _buildCollapsedSection(
                            context,
                            section,
                            currentRoute,
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(12, 18, 12, 12),
                      children: [
                        _sectionHeader(title: 'ENTERPRISE SERVICES'),
                        const SizedBox(height: 6),
                        ..._sections.map(
                          (section) => _buildServiceSection(
                            context,
                            section,
                            currentRoute,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
            ),

            // ========================================================
            // USER AREA
            // ========================================================
            if (widget.collapsed)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Tooltip(
                      message: user.name.isEmpty ? 'Guest User' : user.name,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(9),
                          onTap: () {
                            context.go(AppRoutes.profile);
                          },
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Tooltip(
                      message: 'Logout',
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(9),
                          onTap: () {
                            ref.read(userProvider.notifier).logout();
                            context.go(AppRoutes.login);
                          },
                          child: SizedBox(
                            width: 46,
                            height: 42,
                            child: Center(
                              child: Icon(
                                Icons.logout,
                                color: Colors.white.withValues(alpha: 0.72),
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.go(AppRoutes.profile);
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryBlue,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.name.isEmpty
                                          ? 'Guest User'
                                          : user.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      user.email.isEmpty
                                          ? 'guest@onecloud.com'
                                          : user.email,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.55,
                                        ),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          ref.read(userProvider.notifier).logout();
                          context.go(AppRoutes.login);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white.withValues(alpha: 0.70),
                                size: 19,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.80),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white.withValues(alpha: 0.35),
                                size: 13,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // COLLAPSED SERVICE SECTION
  // ==============================================================

  Widget _buildCollapsedSection(
    BuildContext context,
    SidebarSection section,
    String currentRoute,
  ) {
    final active = _isSectionActive(section, currentRoute);

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Tooltip(
        message: section.title,
        preferBelow: false,
        child: Material(
          color: active
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          child: InkWell(
            borderRadius: BorderRadius.circular(9),
            hoverColor: Colors.white.withValues(alpha: 0.08),
            onTap: () {
              // If the section has a dashboard route, open it.
              // Otherwise open the first available child.
              if (section.route.isNotEmpty) {
                _navigate(context, section.route);
              } else if (section.children.isNotEmpty) {
                _navigate(context, section.children.first.route);
              }
            },
            child: SizedBox(
              width: 56,
              height: 46,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (active)
                    Positioned(
                      left: 0,
                      child: Container(
                        width: 3,
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlue,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  Icon(
                    section.icon,
                    size: 21,
                    color: active
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.68),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // SERVICE SECTION
  // ==============================================================

  Widget _buildServiceSection(
    BuildContext context,
    SidebarSection section,
    String currentRoute,
  ) {
    final expanded = _expandedSections[section.title] ?? false;

    final active = _isSectionActive(section, currentRoute);

    return Column(
      children: [
        // ------------------------------------------------------------
        // PARENT ITEM
        // ------------------------------------------------------------

        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Material(
            color: active
                ? Colors.white.withValues(alpha: 0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            child: InkWell(
              borderRadius: BorderRadius.circular(9),
              hoverColor: Colors.white.withValues(alpha: 0.07),
              onTap: () {
                _toggleSection(section.title);
              },
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: active
                      ? Border.all(color: Colors.white.withValues(alpha: 0.07))
                      : null,
                ),
                child: Row(
                  children: [
                    // Active indicator
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 4,
                      height: active ? 25 : 0,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Icon(
                      section.icon,
                      size: 20,
                      color: active
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.68),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        section.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: active
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.78),
                          fontSize: 13,
                          fontWeight: active
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),

                    // Expand / collapse icon
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: AnimatedRotation(
                        turns: expanded ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 180),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white.withValues(alpha: 0.55),
                          size: 19,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ------------------------------------------------------------
        // CHILDREN
        // ------------------------------------------------------------
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 4),
            child: Column(
              children: section.children.map((child) {
                return _childSidebarItem(
                  context,
                  currentRoute,
                  child.icon,
                  child.title,
                  child.route,
                );
              }).toList(),
            ),
          ),
          crossFadeState: expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 180),
        ),
      ],
    );
  }

  // ==============================================================
  // MAIN SECTION HEADER
  // ==============================================================

  Widget _sectionHeader({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.48),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // MAIN SIDEBAR ITEM
  // ==============================================================

  Widget _sidebarItem(
    BuildContext context,
    String currentRoute,
    IconData icon,
    String title,
    String route,
  ) {
    final selected = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: selected
            ? Colors.white.withValues(alpha: 0.13)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(9),
        child: InkWell(
          borderRadius: BorderRadius.circular(9),
          hoverColor: Colors.white.withValues(alpha: 0.07),
          onTap: () {
            _navigate(context, route);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: selected
                  ? Border.all(color: Colors.white.withValues(alpha: 0.08))
                  : null,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 4,
                  height: selected ? 25 : 0,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                const SizedBox(width: 12),

                Icon(
                  icon,
                  size: 20,
                  color: selected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.62),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.72),
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),

                if (selected)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white.withValues(alpha: 0.70),
                      size: 18,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // CHILD SIDEBAR ITEM
  // ==============================================================

  Widget _childSidebarItem(
    BuildContext context,
    String currentRoute,
    IconData icon,
    String title,
    String route,
  ) {
    final selected = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: selected
            ? Colors.white.withValues(alpha: 0.10)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          hoverColor: Colors.white.withValues(alpha: 0.06),
          onTap: () {
            _navigate(context, route);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            height: 40,
            padding: const EdgeInsets.only(left: 10, right: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                // Small connecting indicator
                Container(
                  width: 3,
                  height: selected ? 20 : 14,
                  decoration: BoxDecoration(
                    color: selected
                        ? AppTheme.primaryBlue
                        : Colors.white.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),

                const SizedBox(width: 10),

                Icon(
                  icon,
                  size: 17,
                  color: selected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.52),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.64),
                      fontSize: 12,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),

                if (selected)
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white.withValues(alpha: 0.55),
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// APP FOOTER
// ================================================================

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: AppTheme.darkNavy,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'One Cloud Enterprise Platform',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 10),

          Text(
            '© 2026 All rights reserved',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.60),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// APP LAYOUT
// ================================================================

class AppLayout extends StatefulWidget {
  final Widget child;

  const AppLayout({super.key, required this.child});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  late final ValueNotifier<bool> _sidebarOpen;

  @override
  void initState() {
    super.initState();

    _sidebarOpen = ValueNotifier<bool>(true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final width = MediaQuery.of(context).size.width;
      _sidebarOpen.value = width >= 850;
    });
  }

  @override
  void dispose() {
    _sidebarOpen.dispose();
    super.dispose();
  }

  void _toggleSidebar() {
    _sidebarOpen.value = !_sidebarOpen.value;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // ==========================================================
          // DESKTOP / TABLET SIDEBAR
          //
          // Only this subtree listens to the sidebar state.
          // The main page is therefore NOT rebuilt when the sidebar
          // is opened or closed.
          // ==========================================================
          if (!isMobile)
            ValueListenableBuilder<bool>(
              valueListenable: _sidebarOpen,
              builder: (context, open, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  width: open ? 275.0 : 72.0,
                  height: double.infinity,
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.centerLeft,
                      minWidth: 0,
                      maxWidth: 275,
                      child: AppSidebar(collapsed: !open),
                    ),
                  ),
                );
              },
            ),

          // ==========================================================
          // MAIN AREA
          // ==========================================================
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.white,

              // ------------------------------------------------------
              // HEADER
              // Only the header listens to the sidebar state.
              // ------------------------------------------------------
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(68),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _sidebarOpen,
                  builder: (context, open, _) {
                    return AppHeader(
                      sidebarOpen: open,
                      onMenuPressed: _toggleSidebar,
                    );
                  },
                ),
              ),

              // ------------------------------------------------------
              // PAGE CONTENT
              // ------------------------------------------------------
              body: Stack(
                children: [
                  // Current page is kept outside the sidebar listener.
                  widget.child,

                  // ==================================================
                  // MOBILE SIDEBAR
                  // ==================================================
                  if (isMobile)
                    ValueListenableBuilder<bool>(
                      valueListenable: _sidebarOpen,
                      builder: (context, open, _) {
                        if (!open) {
                          return const SizedBox.shrink();
                        }

                        return Positioned.fill(
                          child: Row(
                            children: [
                              const AppSidebar(),

                              Expanded(
                                child: GestureDetector(
                                  onTap: _toggleSidebar,
                                  child: Container(
                                    color: Colors.black.withValues(alpha: 0.35),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),

              // ------------------------------------------------------
              // FOOTER
              // ------------------------------------------------------
              bottomNavigationBar: const AppFooter(),
            ),
          ),
        ],
      ),
    );
  }
}
