import 'package:flutter/material.dart';

import '../../app_theme.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  static const List<Map<String, dynamic>> _workOrders = [
    {
      'id': 'MWO-2001',

      'asset': 'CNC Machine 01',

      'type': 'Preventive',

      'priority': 'Medium',

      'technician': 'Maintenance Team A',

      'status': 'In Progress',

      'due': '10 Sep 2026',
    },

    {
      'id': 'MWO-2002',

      'asset': 'Generator G-05',

      'type': 'Corrective',

      'priority': 'High',

      'technician': 'Maintenance Team B',

      'status': 'Open',

      'due': '11 Sep 2026',
    },

    {
      'id': 'MWO-2003',

      'asset': 'Packaging Line P-02',

      'type': 'Preventive',

      'priority': 'Low',

      'technician': 'Maintenance Team A',

      'status': 'Scheduled',

      'due': '14 Sep 2026',
    },

    {
      'id': 'MWO-2004',

      'asset': 'Forklift FL-12',

      'type': 'Inspection',

      'priority': 'Medium',

      'technician': 'Maintenance Team C',

      'status': 'Completed',

      'due': '09 Sep 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.paperDim,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool mobile = constraints.maxWidth < 850;
          final double horizontalPadding = mobile ? 16 : 28;
          final double topPadding = mobile ? 16 : 28;

          return SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    topPadding,
                    horizontalPadding,
                    0,
                  ),
                  child: _pageHeader(context, mobile),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      24,
                      horizontalPadding,
                      28,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _kpis(mobile),
                            const SizedBox(height: 24),
                            _sectionTitle(),
                            const SizedBox(height: 12),
                            _workOrderList(mobile),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _pageHeader(BuildContext context, bool mobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 10 : 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.ink3.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.build_outlined,
              color: AppTheme.ink3,
              size: 17,
            ),
          ),
          const SizedBox(width: 9),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Maintenance',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.text,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  'Schedule preventive maintenance and manage maintenance work orders.',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, color: AppTheme.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _createWorkOrderButton(context, mobile),
        ],
      ),
    );
  }

  Widget _createWorkOrderButton(BuildContext context, bool mobile) {
    return ElevatedButton.icon(
      onPressed: () => _message(
        context,
        'Create Work Order action is ready for backend integration.',
      ),
      icon: const Icon(Icons.add, size: 15),
      label: Text(
        mobile ? 'Add' : 'Create Work Order',
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.ink3,
        foregroundColor: AppTheme.paper,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
        minimumSize: const Size(0, 32),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _kpis(bool isMobile) {
    final data = [
      ['Open Work Orders', '24', Icons.assignment_outlined],
      ['Due Today', '5', Icons.today_outlined],
      ['Preventive Tasks', '38', Icons.event_repeat_outlined],
      ['Completed This Month', '142', Icons.task_alt_outlined],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 4,
        crossAxisSpacing: isMobile ? 10 : 14,
        mainAxisSpacing: isMobile ? 10 : 14,
        childAspectRatio: isMobile ? 1.65 : 2.1,
      ),
      itemBuilder: (context, index) {
        return _kpi(
          data[index][0] as String,
          data[index][1] as String,
          data[index][2] as IconData,
        );
      },
    );
  }

  Widget _kpi(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _card(),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppTheme.ink3.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: AppTheme.ink3, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _workOrderList(bool isMobile) {
    if (isMobile) {
      return Column(
        children: _workOrders.map((order) {
          return Container(
            width: double.infinity,

            margin: const EdgeInsets.only(bottom: 10),

            padding: const EdgeInsets.all(16),

            decoration: _card(),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${order['id']} • ${order['asset']}',

                        style: TextStyle(
                          fontWeight: FontWeight.w700,

                          color: AppTheme.text,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    _status(order['status'] as String),
                  ],
                ),

                const SizedBox(height: 9),

                Text(
                  '${order['type']} • ${order['priority']} priority',

                  style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                ),

                const SizedBox(height: 5),

                Text(
                  '${order['technician']} • Due ${order['due']}',

                  style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    return Container(
      width: double.infinity,

      decoration: _card(),

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,

        child: DataTable(
          columnSpacing: 28,

          headingRowColor: const WidgetStatePropertyAll(AppTheme.paperDim),

          columns: [
            DataColumn(label: _tableHeader('Work Order')),

            DataColumn(label: _tableHeader('Asset')),

            DataColumn(label: _tableHeader('Type')),

            DataColumn(label: _tableHeader('Priority')),

            DataColumn(label: _tableHeader('Technician')),

            DataColumn(label: _tableHeader('Status')),

            DataColumn(label: _tableHeader('Due')),
          ],

          rows: _workOrders.map((order) {
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    order['id'] as String,

                    style: TextStyle(
                      fontWeight: FontWeight.w600,

                      color: AppTheme.text,
                    ),
                  ),
                ),

                DataCell(
                  Text(
                    order['asset'] as String,

                    style: TextStyle(color: AppTheme.text),
                  ),
                ),

                DataCell(
                  Text(
                    order['type'] as String,

                    style: TextStyle(color: AppTheme.textMuted),
                  ),
                ),

                DataCell(_priority(order['priority'] as String)),

                DataCell(
                  Text(
                    order['technician'] as String,

                    style: TextStyle(color: AppTheme.textMuted),
                  ),
                ),

                DataCell(_status(order['status'] as String)),

                DataCell(
                  Text(
                    order['due'] as String,

                    style: TextStyle(color: AppTheme.textMuted),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _priority(String value) {
    final color = value == 'High'
        ? AppTheme.amberAI
        : value == 'Medium'
        ? AppTheme.ink3
        : AppTheme.tealData;

    return Text(
      value,

      style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
    );
  }

  Widget _status(String value) {
    final color = value == 'Completed'
        ? AppTheme.tealData
        : value == 'In Progress'
        ? AppTheme.amberAI
        : value == 'Open'
        ? AppTheme.amberAI
        : AppTheme.textMuted;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),

      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),

        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        value,

        style: TextStyle(
          color: color,

          fontSize: 12,

          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _sectionTitle() {
    return Text(
      'Maintenance Work Orders',

      style: TextStyle(
        fontSize: 19,

        fontWeight: FontWeight.w700,

        color: AppTheme.text,
      ),
    );
  }

  Widget _tableHeader(String title) {
    return Text(
      title,

      style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.text),
    );
  }

  BoxDecoration _card() {
    return BoxDecoration(
      color: AppTheme.paper,

      borderRadius: BorderRadius.circular(14),

      border: Border.all(color: AppTheme.border),
    );
  }

  static void _message(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
