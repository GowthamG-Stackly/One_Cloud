import 'package:flutter/material.dart';

import '../../app_theme.dart';

class ProductionPage extends StatefulWidget {
  const ProductionPage({super.key});

  @override
  State<ProductionPage> createState() => _ProductionPageState();
}

class _ProductionPageState extends State<ProductionPage> {
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'MO-1001',

      'product': 'Industrial Pump X200',

      'planned': 120,

      'produced': 96,

      'status': 'In Progress',

      'date': '10 Sep 2026',
    },

    {
      'id': 'MO-1002',

      'product': 'Control Panel C50',

      'planned': 80,

      'produced': 80,

      'status': 'Completed',

      'date': '09 Sep 2026',
    },

    {
      'id': 'MO-1003',

      'product': 'Hydraulic Valve V10',

      'planned': 150,

      'produced': 75,

      'status': 'In Progress',

      'date': '08 Sep 2026',
    },

    {
      'id': 'MO-1004',

      'product': 'Motor Assembly M40',

      'planned': 60,

      'produced': 0,

      'status': 'Planned',

      'date': '12 Sep 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              _header(isMobile),

              const SizedBox(height: 24),

              _kpis(isMobile),

              const SizedBox(height: 24),

              _sectionTitle('Production Orders'),

              const SizedBox(height: 12),

              _orderTable(isMobile),
            ],
          ),
        );
      },
    );
  }

  Widget _header(bool isMobile) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 14,

        vertical: 7,
      ),

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
              Icons.precision_manufacturing_outlined,

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
                  'Production',

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
                  'Plan, track and manage production operations.',

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(fontSize: 10, color: AppTheme.textMuted),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          ElevatedButton.icon(
            onPressed: _showCreateOrder,

            icon: const Icon(Icons.add, size: 15),

            label: Text(
              isMobile ? 'Add' : 'Create Production Order',

              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.ink3,

              foregroundColor: AppTheme.paper,

              elevation: 0,

              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),

              minimumSize: const Size(0, 32),

              tapTargetSize: MaterialTapTargetSize.shrinkWrap,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kpis(bool isMobile) {
    final items = [
      ['Active Orders', '12', Icons.assignment],
      ['Units in Production', '1,248', Icons.precision_manufacturing],
      ['Completed Today', '386', Icons.check_circle],
      ['Efficiency', '94.6%', Icons.trending_up],
    ];

    if (isMobile) {
      return Column(
        children: [
          _kpiCard(
            items[0][0] as String,
            items[0][1] as String,
            items[0][2] as IconData,
          ),
          const SizedBox(height: 14),
          _kpiCard(
            items[1][0] as String,
            items[1][1] as String,
            items[1][2] as IconData,
          ),
          const SizedBox(height: 14),
          _kpiCard(
            items[2][0] as String,
            items[2][1] as String,
            items[2][2] as IconData,
          ),
          const SizedBox(height: 14),
          _kpiCard(
            items[3][0] as String,
            items[3][1] as String,
            items[3][2] as IconData,
          ),
        ],
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 2.1,
      ),
      itemBuilder: (context, index) {
        return _kpiCard(
          items[index][0] as String,
          items[index][1] as String,
          items[index][2] as IconData,
        );
      },
    );
  }

  Widget _kpiCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: _cardDecoration(),

      child: Row(
        children: [
          Container(
            width: 44,

            height: 44,

            decoration: BoxDecoration(
              color: AppTheme.ink3.withValues(alpha: 0.10),

              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(icon, color: AppTheme.ink3),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
                ),

                const SizedBox(height: 5),

                Text(
                  value,

                  style: TextStyle(
                    fontSize: 21,

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

  Widget _orderTable(bool isMobile) {
    return Container(
      width: double.infinity,

      decoration: _cardDecoration(),

      child: isMobile
          ? Column(children: _orders.map(_mobileOrderCard).toList())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: DataTable(
                columnSpacing: 28,

                headingRowColor: WidgetStatePropertyAll(AppTheme.paperDim),

                columns: [
                  DataColumn(label: _tableHeader('Order')),

                  DataColumn(label: _tableHeader('Product')),

                  DataColumn(label: _tableHeader('Planned')),

                  DataColumn(label: _tableHeader('Produced')),

                  DataColumn(label: _tableHeader('Progress')),

                  DataColumn(label: _tableHeader('Status')),

                  DataColumn(label: _tableHeader('Date')),
                ],

                rows: _orders.map((order) {
                  final planned = order['planned'] as int;

                  final produced = order['produced'] as int;

                  final progress = planned == 0 ? 0.0 : produced / planned;

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
                          order['product'] as String,

                          style: TextStyle(color: AppTheme.text),
                        ),
                      ),

                      DataCell(
                        Text(
                          '$planned',

                          style: TextStyle(color: AppTheme.textMuted),
                        ),
                      ),

                      DataCell(
                        Text(
                          '$produced',

                          style: TextStyle(color: AppTheme.textMuted),
                        ),
                      ),

                      DataCell(
                        SizedBox(
                          width: 100,

                          child: LinearProgressIndicator(
                            value: progress.clamp(0.0, 1.0),

                            minHeight: 7,

                            borderRadius: BorderRadius.circular(10),

                            backgroundColor: AppTheme.border.withValues(
                              alpha: 0.5,
                            ),

                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppTheme.tealData,
                            ),
                          ),
                        ),
                      ),

                      DataCell(_status(order['status'] as String)),

                      DataCell(
                        Text(
                          order['date'] as String,

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

  Widget _mobileOrderCard(Map<String, dynamic> order) {
    final planned = order['planned'] as int;

    final produced = order['produced'] as int;

    final progress = planned == 0 ? 0.0 : produced / planned;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.border)),
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        title: Text(
          '${order['id']} • ${order['product']}',

          style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.text),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                '$produced / $planned units',

                style: TextStyle(color: AppTheme.textMuted),
              ),

              const SizedBox(height: 7),

              LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),

                minHeight: 6,

                borderRadius: BorderRadius.circular(10),

                backgroundColor: AppTheme.border.withValues(alpha: 0.5),

                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppTheme.tealData,
                ),
              ),
            ],
          ),
        ),

        trailing: _status(order['status'] as String),
      ),
    );
  }

  Widget _status(String value) {
    final isComplete = value == 'Completed';

    final isProgress = value == 'In Progress';

    final color = isComplete
        ? AppTheme.tealData
        : isProgress
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

  Widget _sectionTitle(String title) {
    return Text(
      title,

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

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppTheme.paper,

      borderRadius: BorderRadius.circular(14),

      border: Border.all(color: AppTheme.border),
    );
  }

  void _showCreateOrder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Create Production Order action is ready for backend integration.',
        ),
      ),
    );
  }
}
