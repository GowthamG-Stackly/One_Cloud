import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class ErpDashboardPage extends StatelessWidget {
  const ErpDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'ERP',
      subtitle: 'Manage enterprise resource planning and business operations.',
      icon: Icons.inventory_2_outlined,

      kpis: [
        ModuleKpi(
          title: 'Inventory Items',
          value: '2,486',
          icon: Icons.inventory_2_outlined,
        ),
        ModuleKpi(
          title: 'Warehouses',
          value: '12',
          icon: Icons.warehouse_outlined,
        ),
        ModuleKpi(
          title: 'Purchase Orders',
          value: '84',
          icon: Icons.shopping_cart_outlined,
        ),
        ModuleKpi(
          title: 'Sales Orders',
          value: '126',
          icon: Icons.receipt_long_outlined,
        ),
      ],

      quickActions: [
        ModuleQuickAction(title: 'Inventory', icon: Icons.inventory_2_outlined),
        ModuleQuickAction(title: 'Warehouses', icon: Icons.warehouse_outlined),
        ModuleQuickAction(
          title: 'Stock Movements',
          icon: Icons.swap_vert_outlined,
        ),
        ModuleQuickAction(
          title: 'Procurement',
          icon: Icons.shopping_cart_outlined,
        ),
        ModuleQuickAction(title: 'Vendors', icon: Icons.store_outlined),
        ModuleQuickAction(
          title: 'Sales Orders',
          icon: Icons.receipt_long_outlined,
        ),
        ModuleQuickAction(
          title: 'Dispatch',
          icon: Icons.local_shipping_outlined,
        ),
        ModuleQuickAction(title: 'Production', icon: Icons.factory_outlined),
        ModuleQuickAction(
          title: 'Asset Management',
          icon: Icons.inventory_outlined,
        ),
        ModuleQuickAction(title: 'Maintenance', icon: Icons.build_outlined),
      ],
    );
  }
}
