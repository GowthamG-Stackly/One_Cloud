import 'package:flutter/material.dart';

import 'finance_widgets.dart';

class AssetManagementPage extends StatelessWidget {
  const AssetManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FinancePageShell(
      title: 'Asset Management',
      subtitle: 'Manage company assets and depreciation.',
      actions: [
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Add New'),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return FinanceSectionCard(
            title: 'Asset Management List',

            // ============================================================
            // DESKTOP SEARCH
            // ============================================================
            trailing: isMobile
                ? null
                : SizedBox(
                    width: 220,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                      ),
                    ),
                  ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==========================================================
                // MOBILE SEARCH
                // ==========================================================

                if (isMobile) ...[
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      isDense: true,
                    ),
                  ),

                  const SizedBox(height: 16),
                ],

                // ==========================================================
                // DESKTOP TABLE
                // ==========================================================
                if (!isMobile)
                  const FinanceTable(
                    columns: [
                      'Asset ID',
                      'Asset',
                      'Category',
                      'Value',
                      'Status',
                    ],
                    rows: [
                      [
                        'AST-1001',
                        'Office Building',
                        'Property',
                        '₹12,500,000',
                        'Active',
                      ],
                      [
                        'AST-1002',
                        'Delivery Vehicles',
                        'Vehicles',
                        '₹4,200,000',
                        'Active',
                      ],
                      [
                        'AST-1003',
                        'Laptop Equipment',
                        'IT Equipment',
                        '₹1,850,000',
                        'Active',
                      ],
                      [
                        'AST-1004',
                        'Warehouse Equipment',
                        'Equipment',
                        '₹2,400,000',
                        'Maintenance',
                      ],
                      [
                        'AST-1005',
                        'Office Furniture',
                        'Furniture',
                        '₹850,000',
                        'Active',
                      ],
                    ],
                  ),

                // ==========================================================
                // MOBILE CARDS
                // ==========================================================
                if (isMobile)
                  Column(
                    children: [
                      _AssetCard(
                        assetId: 'AST-1001',
                        asset: 'Office Building',
                        category: 'Property',
                        value: '₹12,500,000',
                        status: 'Active',
                      ),

                      _AssetCard(
                        assetId: 'AST-1002',
                        asset: 'Delivery Vehicles',
                        category: 'Vehicles',
                        value: '₹4,200,000',
                        status: 'Active',
                      ),

                      _AssetCard(
                        assetId: 'AST-1003',
                        asset: 'Laptop Equipment',
                        category: 'IT Equipment',
                        value: '₹1,850,000',
                        status: 'Active',
                      ),

                      _AssetCard(
                        assetId: 'AST-1004',
                        asset: 'Warehouse Equipment',
                        category: 'Equipment',
                        value: '₹2,400,000',
                        status: 'Maintenance',
                      ),

                      _AssetCard(
                        assetId: 'AST-1005',
                        asset: 'Office Furniture',
                        category: 'Furniture',
                        value: '₹850,000',
                        status: 'Active',
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// MOBILE ASSET CARD
// ============================================================================

class _AssetCard extends StatelessWidget {
  final String assetId;
  final String asset;
  final String category;
  final String value;
  final String status;

  const _AssetCard({
    required this.assetId,
    required this.asset,
    required this.category,
    required this.value,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================================================================
          // ASSET ID + STATUS
          // ================================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  assetId,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              _StatusBadge(status: status),
            ],
          ),

          const SizedBox(height: 12),

          // ================================================================
          // ASSET
          // ================================================================
          Text(
            'Asset',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 3),

          Text(
            asset,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 12),

          // ================================================================
          // CATEGORY + VALUE
          // ================================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _AssetInfo(label: 'Category', value: category),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _AssetInfo(label: 'Value', value: value),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ASSET INFO
// ============================================================================

class _AssetInfo extends StatelessWidget {
  final String label;
  final String value;

  const _AssetInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

// ============================================================================
// STATUS BADGE
// ============================================================================

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isMaintenance = status == 'Maintenance';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: isMaintenance
            ? Colors.orange.withValues(alpha: 0.10)
            : Colors.green.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isMaintenance ? Colors.orange.shade700 : Colors.green.shade700,
        ),
      ),
    );
  }
}
