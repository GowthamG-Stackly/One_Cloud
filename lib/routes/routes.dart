import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../pages/login_page.dart';
import '../pages/profile_page.dart';
import '../pages/register_page.dart';
import '../pages/about_page.dart';
import '../pages/forgot_password_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/features_page.dart';
import '../pages/contact_page.dart';

import '../pages/admin/admin_dashboard_page.dart';
import '../pages/hrms/hrms_dashboard_page.dart';
import '../pages/crm/crm_dashboard_page.dart';
import '../pages/erp_modules/erp_dashboard_page.dart';
import '../pages/finance/finance_dashboard_page.dart';
import '../pages/workflow/workflow_dashboard_page.dart';
import '../pages/documents/document_dashboard_page.dart';
import '../pages/subscription/subscription_dashboard_page.dart';
import '../pages/revenue/revenue_dashboard_page.dart';
import '../pages/reporting/reporting_dashboard_page.dart';
import '../pages/ai/ai_dashboard_page.dart';
import '../pages/notification/notification_dashboard_page.dart';
import '../pages/calendar/calendar_dashboard_page.dart';
import '../pages/integration/integration_dashboard_page.dart';
import '../pages/search/search_dashboard_page.dart';
import '../pages/security/security_dashboard_page.dart';

import '../pages/admin/global_settings_page.dart';
import '../pages/admin/platform_config_page.dart';
import '../pages/admin/license_management_page.dart';
import '../pages/admin/feature_management_page.dart';
import '../pages/admin/resource_management_page.dart';
import '../pages/admin/system_health_page.dart';
import '../pages/admin/tenant_templates_page.dart';

import '../pages/hrms/hrms_dashboard_page.dart';
import '../pages/hrms/employee_management_page.dart';
import '../pages/hrms/attendance_page.dart';
import '../pages/hrms/leave_page.dart';
import '../pages/hrms/payroll_page.dart';
import '../pages/hrms/recruitment_page.dart';
import '../pages/hrms/performance_page.dart';
import '../pages/hrms/learning_page.dart';
import '../pages/hrms/ess_mss_page.dart';
import '../pages/hrms/asset_management_page.dart';

import '../pages/crm/crm_dashboard_page.dart';
import '../pages/crm/leads_page.dart';
import '../pages/crm/opportunities_page.dart';
import '../pages/crm/accounts_page.dart';
import '../pages/crm/contacts_page.dart';
import '../pages/crm/activities_page.dart';
import '../pages/crm/pipeline_page.dart';
import '../pages/crm/quotations_page.dart';
import '../pages/crm/campaigns_page.dart';
import '../pages/crm/customer_support_page.dart';

import '../pages/erp_modules/inventory_page.dart';
import '../pages/erp_modules/warehouses_page.dart';
import '../pages/erp_modules/stock_movements_page.dart';
import '../pages/erp_modules/procurement_page.dart';
import '../pages/erp_modules/vendors_page.dart';
import '../pages/erp_modules/sales_orders_page.dart';
import '../pages/erp_modules/dispatch_page.dart';
import '../pages/erp_modules/production_page.dart';
import '../pages/erp_modules/asset_management_page.dart';
import '../pages/erp_modules/maintenance_page.dart';

import '../pages/finance/general_ledger_page.dart';
import '../pages/finance/accounts_payable_page.dart';
import '../pages/finance/accounts_receivable_page.dart';
import '../pages/finance/asset_management_page.dart'
    as finance_asset_management;
import '../pages/finance/budgeting_page.dart';
import '../pages/finance/costing_page.dart';
import '../pages/finance/financial_reports_page.dart';
import '../pages/finance/reconciliation_page.dart';
import '../pages/finance/multi_currency_page.dart';

import '../pages/workflow/workflow_builder_page.dart';
import '../pages/workflow/approvals_page.dart';
import '../pages/workflow/business_rules_page.dart';
import '../pages/workflow/process_automation_page.dart';
import '../pages/workflow/task_management_page.dart';
import '../pages/workflow/triggers_page.dart';
import '../pages/workflow/slas_escalations_page.dart';
import '../pages/workflow/process_monitoring_page.dart';
import '../pages/workflow/workflow_templates_page.dart';

import '../providers/user_provider.dart';
import '../widgets/app_layout.dart';

class AppRoutes {
  // ==============================================================
  // AUTHENTICATION
  // ==============================================================

  static const String login = '/';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // ==============================================================
  // GENERAL
  // ==============================================================

  static const String dashboard = '/dashboard';
  static const String about = '/about';
  static const String profile = '/profile';
  static const String features = '/features';
  static const String contact = '/contact';

  // ==============================================================
  // ==============================================================
  // ONECLOUD ENTERPRISE SERVICES
  // ==============================================================
  // ==============================================================

  static const String admin = '/admin';
  static const String hrms = '/hrms';
  static const String crm = '/crm';
  static const String erp = '/erp';
  static const String finance = '/finance';
  static const String workflow = '/workflow';
  static const String documents = '/documents';
  static const String subscription = '/subscription';
  static const String revenue = '/revenue';
  static const String reporting = '/reporting';
  static const String ai = '/ai';
  static const String notification = '/notification';
  static const String calendar = '/calendar';
  static const String integration = '/integration';
  static const String search = '/search';
  static const String security = '/security';

  // Admin MODULES
  static const String globalSettings = '/admin/global-settings';
  static const String platformConfig = '/admin/platform-config';
  static const String licenseManagement = '/admin/license-management';
  static const String featureManagement = '/admin/feature-management';
  static const String resourceManagement = '/admin/resource-management';
  static const String systemHealth = '/admin/system-health';
  static const String tenantTemplates = '/admin/tenant-templates';

  // HRMS MODULES
  static const String hrmsEmployees = '/hrms/employees';
  static const String hrmsAttendance = '/hrms/attendance';
  static const String hrmsLeave = '/hrms/leave';
  static const String hrmsPayroll = '/hrms/payroll';
  static const String hrmsRecruitment = '/hrms/recruitment';
  static const String hrmsPerformance = '/hrms/performance';
  static const String hrmsLearning = '/hrms/learning';
  static const String hrmsEssMss = '/hrms/ess-mss';
  static const String hrmsAssets = '/hrms/assets';

  // CRM MODULES
  static const String crmLeads = '/crm/leads';
  static const String crmOpportunities = '/crm/opportunities';
  static const String crmAccounts = '/crm/accounts';
  static const String crmContacts = '/crm/contacts';
  static const String crmActivities = '/crm/activities';
  static const String crmPipeline = '/crm/pipeline';
  static const String crmQuotations = '/crm/quotations';
  static const String crmCampaigns = '/crm/campaigns';
  static const String crmCustomerSupport = '/crm/customer-support';

  // ERP MODULES
  static const String inventory = '/inventory';
  static const String warehouses = '/warehouses';
  static const String stockMovements = '/stock-movements';
  static const String procurement = '/procurement';
  static const String vendors = '/vendors';
  static const String salesOrders = '/sales-orders';
  static const String dispatch = '/dispatch';
  static const String production = '/production';
  static const String assetManagement = '/asset-management';
  static const String maintenance = '/maintenance';

  // FINANCE & ACCOUNTING MODULES
  static const String financeGeneralLedger = '/finance/general-ledger';
  static const String financeAccountsPayable = '/finance/accounts-payable';
  static const String financeAccountsReceivable =
      '/finance/accounts-receivable';
  static const String financeAssetManagement = '/finance/asset-management';
  static const String financeBudgeting = '/finance/budgeting';
  static const String financeCosting = '/finance/costing';
  static const String financeFinancialReports = '/finance/financial-reports';
  static const String financeReconciliation = '/finance/reconciliation';
  static const String financeMultiCurrency = '/finance/multi-currency';

  // WORKFLOW  & AUTOMATION
  static const String workflowBuilder = '/workflow/builder';
  static const String workflowApprovals = '/workflow/approvals';
  static const String workflowBusinessRules = '/workflow/business-rules';
  static const String workflowProcessAutomation = '/workflow/automation';
  static const String workflowTasks = '/workflow/tasks';
  static const String workflowTriggers = '/workflow/triggers';
  static const String workflowSlas = '/workflow/slas';
  static const String workflowMonitoring = '/workflow/monitoring';
  static const String workflowTemplates = '/workflow/templates';

  // ==============================================================
  // ROUTER
  // ==============================================================

  static final GoRouter router = GoRouter(
    initialLocation: login,

    redirect: (context, state) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final loggedIn = userProvider.isLoggedIn;
      final location = state.uri.path;

      final isLoginPage = location == login;

      final isPublicPage =
          location == login ||
          location == register ||
          location == forgotPassword ||
          location == features ||
          location == contact;

      // Logged-in users should not return to login.
      if (loggedIn && isLoginPage) {
        return dashboard;
      }

      // Protect the application.
      if (!loggedIn && !isPublicPage) {
        return login;
      }

      return null;
    },

    routes: [
      // ============================================================
      // AUTHENTICATION
      // ============================================================

      GoRoute(
        path: login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),

      GoRoute(
        path: register,
        builder: (context, state) {
          return const RegisterPage();
        },
      ),

      GoRoute(
        path: forgotPassword,
        builder: (context, state) {
          return const ForgotPasswordPage();
        },
      ),

      // ============================================================
      // MAIN APPLICATION
      // ============================================================
      ShellRoute(
        builder: (context, state, child) {
          return AppLayout(child: child);
        },

        routes: [
          // ==========================================================
          // MAIN DASHBOARD
          // ==========================================================

          GoRoute(
            path: dashboard,
            builder: (context, state) {
              return const DashboardPage();
            },
          ),

          // ==========================================================
          // PLATFORM ADMINISTRATION
          // ==========================================================
          GoRoute(
            path: admin,
            builder: (context, state) {
              return const AdminDashboardPage();
            },
          ),

          GoRoute(
            path: globalSettings,
            builder: (context, state) {
              return const GlobalSettingsPage();
            },
          ),

          GoRoute(
            path: platformConfig,
            builder: (context, state) {
              return const PlatformConfigPage();
            },
          ),

          GoRoute(
            path: licenseManagement,
            builder: (context, state) {
              return const LicenseManagementPage();
            },
          ),

          GoRoute(
            path: featureManagement,
            builder: (context, state) {
              return const FeatureManagementPage();
            },
          ),

          GoRoute(
            path: resourceManagement,
            builder: (context, state) {
              return const ResourceManagementPage();
            },
          ),

          GoRoute(
            path: systemHealth,
            builder: (context, state) {
              return const SystemHealthPage();
            },
          ),

          GoRoute(
            path: tenantTemplates,
            builder: (context, state) {
              return const TenantTemplatesPage();
            },
          ),

          // ==========================================================
          // HRMS
          // ==========================================================
          GoRoute(
            path: hrms,
            builder: (context, state) {
              return const HrmsDashboardPage();
            },
          ),
          GoRoute(
            path: hrmsEmployees,
            builder: (context, state) {
              return const EmployeeManagementPage();
            },
          ),

          GoRoute(
            path: hrmsAttendance,
            builder: (context, state) {
              return const AttendancePage();
            },
          ),

          GoRoute(
            path: hrmsLeave,
            builder: (context, state) {
              return const LeavePage();
            },
          ),

          GoRoute(
            path: hrmsPayroll,
            builder: (context, state) {
              return const PayrollPage();
            },
          ),

          GoRoute(
            path: hrmsRecruitment,
            builder: (context, state) {
              return const RecruitmentPage();
            },
          ),

          GoRoute(
            path: hrmsPerformance,
            builder: (context, state) {
              return const PerformancePage();
            },
          ),

          GoRoute(
            path: hrmsLearning,
            builder: (context, state) {
              return const LearningPage();
            },
          ),

          GoRoute(
            path: hrmsEssMss,
            builder: (context, state) {
              return const EssMssPage();
            },
          ),

          GoRoute(
            path: hrmsAssets,
            builder: (context, state) {
              return const HrmsAssetManagementPage();
            },
          ),

          // ==========================================================
          // CRM
          // ==========================================================
          GoRoute(
            path: AppRoutes.crm,
            builder: (context, state) => const CrmDashboardPage(),
          ),

          GoRoute(
            path: AppRoutes.crmLeads,
            builder: (context, state) => const LeadsPage(),
          ),

          GoRoute(
            path: AppRoutes.crmOpportunities,
            builder: (context, state) => const OpportunitiesPage(),
          ),

          GoRoute(
            path: AppRoutes.crmAccounts,
            builder: (context, state) => const AccountsPage(),
          ),

          GoRoute(
            path: AppRoutes.crmContacts,
            builder: (context, state) => const ContactsPage(),
          ),

          GoRoute(
            path: AppRoutes.crmActivities,
            builder: (context, state) => const ActivitiesPage(),
          ),

          GoRoute(
            path: AppRoutes.crmPipeline,
            builder: (context, state) => const PipelinePage(),
          ),

          GoRoute(
            path: AppRoutes.crmQuotations,
            builder: (context, state) => const QuotationsPage(),
          ),

          GoRoute(
            path: AppRoutes.crmCampaigns,
            builder: (context, state) => const CampaignsPage(),
          ),

          GoRoute(
            path: AppRoutes.crmCustomerSupport,
            builder: (context, state) => const CustomerSupportPage(),
          ),

          // ==========================================================
          // ERP MODULES
          // ==========================================================
          GoRoute(
            path: AppRoutes.erp,
            builder: (context, state) {
              return const ErpDashboardPage();
            },
          ),
          GoRoute(
            path: inventory,
            builder: (context, state) {
              return const InventoryPage();
            },
          ),

          GoRoute(
            path: warehouses,
            builder: (context, state) {
              return const WarehousesPage();
            },
          ),

          GoRoute(
            path: stockMovements,
            builder: (context, state) {
              return const StockMovementsPage();
            },
          ),

          GoRoute(
            path: procurement,
            builder: (context, state) {
              return const ProcurementPage();
            },
          ),

          GoRoute(
            path: vendors,
            builder: (context, state) {
              return const VendorsPage();
            },
          ),

          GoRoute(
            path: salesOrders,
            builder: (context, state) {
              return const SalesOrdersPage();
            },
          ),

          GoRoute(
            path: dispatch,
            builder: (context, state) {
              return const DispatchPage();
            },
          ),

          GoRoute(
            path: production,
            builder: (context, state) {
              return const ProductionPage();
            },
          ),

          GoRoute(
            path: assetManagement,
            builder: (context, state) {
              return const AssetManagementPage();
            },
          ),

          GoRoute(
            path: maintenance,
            builder: (context, state) {
              return const MaintenancePage();
            },
          ),

          // ==========================================================
          // FINANCE & ACCOUNTING
          // ==========================================================
          GoRoute(
            path: finance,
            builder: (context, state) {
              return const FinanceDashboardPage();
            },
          ),

          GoRoute(
            path: financeGeneralLedger,
            builder: (context, state) {
              return const GeneralLedgerPage();
            },
          ),

          GoRoute(
            path: financeAccountsPayable,
            builder: (context, state) {
              return const AccountsPayablePage();
            },
          ),

          GoRoute(
            path: financeAccountsReceivable,
            builder: (context, state) {
              return const AccountsReceivablePage();
            },
          ),

          GoRoute(
            path: financeAssetManagement,
            builder: (context, state) =>
                const finance_asset_management.AssetManagementPage(),
          ),

          GoRoute(
            path: financeBudgeting,
            builder: (context, state) {
              return const BudgetingPage();
            },
          ),

          GoRoute(
            path: financeCosting,
            builder: (context, state) {
              return const CostingPage();
            },
          ),

          GoRoute(
            path: financeFinancialReports,
            builder: (context, state) {
              return const FinancialReportsPage();
            },
          ),

          GoRoute(
            path: financeReconciliation,
            builder: (context, state) {
              return const ReconciliationPage();
            },
          ),

          GoRoute(
            path: financeMultiCurrency,
            builder: (context, state) {
              return const MultiCurrencyPage();
            },
          ),

          // ==========================================================
          // WORKFLOW & AUTOMATION
          // ==========================================================
          GoRoute(
            path: workflow,
            builder: (context, state) {
              return const WorkflowDashboardPage();
            },
          ),
          GoRoute(
            path: workflowBuilder,
            builder: (context, state) {
              return const WorkflowBuilderPage();
            },
          ),
          GoRoute(
            path: workflowApprovals,
            builder: (context, state) {
              return const ApprovalsPage();
            },
          ),
          GoRoute(
            path: workflowBusinessRules,
            builder: (context, state) {
              return const BusinessRulesPage();
            },
          ),
          GoRoute(
            path: workflowProcessAutomation,
            builder: (context, state) {
              return const ProcessAutomationPage();
            },
          ),
          GoRoute(
            path: workflowTasks,
            builder: (context, state) {
              return const TaskManagementPage();
            },
          ),
          GoRoute(
            path: workflowTriggers,
            builder: (context, state) {
              return const TriggersPage();
            },
          ),
          GoRoute(
            path: workflowSlas,
            builder: (context, state) {
              return const SlasEscalationsPage();
            },
          ),
          GoRoute(
            path: workflowMonitoring,
            builder: (context, state) {
              return const ProcessMonitoringPage();
            },
          ),
          GoRoute(
            path: workflowTemplates,
            builder: (context, state) {
              return const WorkflowTemplatesPage();
            },
          ),

          // ==========================================================
          // DOCUMENT MANAGEMENT
          // ==========================================================
          GoRoute(
            path: documents,
            builder: (context, state) {
              return const DocumentDashboardPage();
            },
          ),

          // ==========================================================
          // SUBSCRIPTION
          // ==========================================================
          GoRoute(
            path: subscription,
            builder: (context, state) {
              return const SubscriptionDashboardPage();
            },
          ),

          // ==========================================================
          // REVENUE
          // ==========================================================
          GoRoute(
            path: revenue,
            builder: (context, state) {
              return const RevenueDashboardPage();
            },
          ),

          // ==========================================================
          // REPORTING & BI
          // ==========================================================
          GoRoute(
            path: reporting,
            builder: (context, state) {
              return const ReportingDashboardPage();
            },
          ),

          // ==========================================================
          // ENTERPRISE AI
          // ==========================================================
          GoRoute(
            path: ai,
            builder: (context, state) {
              return const AiDashboardPage();
            },
          ),

          // ==========================================================
          // NOTIFICATION
          // ==========================================================
          GoRoute(
            path: notification,
            builder: (context, state) {
              return const NotificationDashboardPage();
            },
          ),

          // ==========================================================
          // CALENDAR
          // ==========================================================
          GoRoute(
            path: calendar,
            builder: (context, state) {
              return const CalendarDashboardPage();
            },
          ),

          // ==========================================================
          // INTEGRATION
          // ==========================================================
          GoRoute(
            path: integration,
            builder: (context, state) {
              return const IntegrationDashboardPage();
            },
          ),

          // ==========================================================
          // SEARCH
          // ==========================================================
          GoRoute(
            path: search,
            builder: (context, state) {
              return const SearchDashboardPage();
            },
          ),

          // ==========================================================
          // SECURITY & COMPLIANCE
          // ==========================================================
          GoRoute(
            path: security,
            builder: (context, state) {
              return const SecurityDashboardPage();
            },
          ),

          // ==========================================================
          // EXISTING PAGES
          // ==========================================================
          GoRoute(
            path: features,
            builder: (context, state) {
              return const FeaturesPage();
            },
          ),

          GoRoute(
            path: contact,
            builder: (context, state) {
              return const ContactPage();
            },
          ),

          GoRoute(
            path: about,
            builder: (context, state) {
              return const AboutPage();
            },
          ),

          GoRoute(
            path: profile,
            builder: (context, state) {
              return const ProfilePage();
            },
          ),

          // ==========================================================
          // ERP MODULES
          // ==========================================================
          GoRoute(
            path: inventory,
            builder: (context, state) {
              return const InventoryPage();
            },
          ),

          GoRoute(
            path: warehouses,
            builder: (context, state) {
              return const WarehousesPage();
            },
          ),

          GoRoute(
            path: stockMovements,
            builder: (context, state) {
              return const StockMovementsPage();
            },
          ),

          GoRoute(
            path: procurement,
            builder: (context, state) {
              return const ProcurementPage();
            },
          ),

          GoRoute(
            path: vendors,
            builder: (context, state) {
              return const VendorsPage();
            },
          ),

          GoRoute(
            path: salesOrders,
            builder: (context, state) {
              return const SalesOrdersPage();
            },
          ),

          GoRoute(
            path: dispatch,
            builder: (context, state) {
              return const DispatchPage();
            },
          ),
        ],
      ),
    ],
  );
}
