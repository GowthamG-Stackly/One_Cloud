import 'package:flutter/material.dart';

import '../../app_theme.dart';

class AssetManagementPage extends StatelessWidget {
  const AssetManagementPage({super.key});

  static const List<Map<String, dynamic>> _assets = [
    {
      'id': 'AST-001',

      'name': 'CNC Machine 01',

      'category': 'Production Equipment',

      'location': 'Plant A',

      'value': '₹18.5L',

      'status': 'Operational',
    },

    {
      'id': 'AST-002',

      'name': 'Forklift FL-12',

      'category': 'Material Handling',

      'location': 'Warehouse 01',

      'value': '₹8.2L',

      'status': 'Operational',
    },

    {
      'id': 'AST-003',

      'name': 'Generator G-05',

      'category': 'Utilities',

      'location': 'Plant B',

      'value': '₹12.4L',

      'status': 'Maintenance',
    },

    {
      'id': 'AST-004',

      'name': 'Packaging Line P-02',

      'category': 'Production Equipment',

      'location': 'Plant A',

      'value': '₹24.8L',

      'status': 'Operational',
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
                            _kpis(),

                            const SizedBox(height: 28),

                            const Text(
                              'Asset Register',

                              style: TextStyle(
                                fontSize: 19,

                                fontWeight: FontWeight.w700,

                                color: AppTheme.text,
                              ),
                            ),

                            const SizedBox(height: 12),

                            _assetList(),
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
              Icons.inventory_2_outlined,

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
                  'Asset Management',

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
                  'Manage enterprise assets, locations, values and lifecycle status.',

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(fontSize: 10, color: AppTheme.textMuted),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          _addAssetButton(context, mobile),
        ],
      ),
    );
  }

  Widget _addAssetButton(BuildContext context, bool mobile) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Add Asset action is ready for backend integration.'),
          ),
        );
      },

      icon: const Icon(Icons.add, size: 15),

      label: Text(
        mobile ? 'Add' : 'Add Asset',

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

  Widget _kpis() {
    final cards = [
      _kpi('Total Assets', '486', Icons.inventory_2_outlined),
      _kpi('Operational', '442', Icons.check_circle_outline),
      _kpi('Under Maintenance', '18', Icons.build_outlined),
      _kpi('Total Asset Value', '₹18.6Cr', Icons.currency_rupee),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 650;

        if (isMobile) {
          return Column(
            children: [
              cards[0],
              const SizedBox(height: 10),
              cards[1],
              const SizedBox(height: 10),
              cards[2],
              const SizedBox(height: 10),
              cards[3],
            ],
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 2.2,
          ),
          itemBuilder: (context, index) => cards[index],
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

  Widget _assetList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 750) {
          return Column(
            children: _assets.map((asset) {
              return _mobileAsset(asset);
            }).toList(),
          );
        }

        return _desktopAssetList();
      },
    );
  }

  Widget _mobileAsset(Map<String, dynamic> asset) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: _card(),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  asset['name'] as String,

                  style: const TextStyle(
                    color: AppTheme.text,

                    fontWeight: FontWeight.w700,

                    fontSize: 16,
                  ),
                ),
              ),

              _status(asset['status'] as String),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            '${asset['id']} • ${asset['category']}',

            style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
          ),

          const SizedBox(height: 5),

          Text(
            '${asset['location']} • ${asset['value']}',

            style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _desktopAssetList() {
    return Container(
      width: double.infinity,

      decoration: _card(),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),

        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: DataTable(
            columnSpacing: 34,

            headingRowColor: WidgetStatePropertyAll(
              AppTheme.ink3.withValues(alpha: 0.06),
            ),

            columns: const [
              DataColumn(label: Text('Asset ID')),

              DataColumn(label: Text('Asset')),

              DataColumn(label: Text('Category')),

              DataColumn(label: Text('Location')),

              DataColumn(label: Text('Value')),

              DataColumn(label: Text('Status')),
            ],

            rows: _assets.map((asset) {
              return DataRow(
                cells: [
                  DataCell(Text(asset['id'] as String)),

                  DataCell(Text(asset['name'] as String)),

                  DataCell(Text(asset['category'] as String)),

                  DataCell(Text(asset['location'] as String)),

                  DataCell(Text(asset['value'] as String)),

                  DataCell(_status(asset['status'] as String)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _status(String value) {
    final isMaintenance = value == 'Maintenance';

    final color = isMaintenance ? AppTheme.amberAI : AppTheme.tealData;

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

  BoxDecoration _card() {
    return BoxDecoration(
      color: AppTheme.paper,

      borderRadius: BorderRadius.circular(14),

      border: Border.all(color: AppTheme.border),
    );
  }
}
