import 'package:flutter/material.dart';

import 'finance_widgets.dart';

class CostingPage extends StatelessWidget {
  const CostingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FinancePageShell(
      title: 'Costing',
      subtitle: 'Review costs by department, project and activity.',
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
            title: 'Costing List',
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
                // Mobile Search
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

                // Desktop Table
                if (!isMobile)
                  const FinanceTable(
                    columns: [
                      'Cost ID',
                      'Cost Center',
                      'Budget',
                      'Actual',
                      'Used',
                    ],
                    rows: [
                      [
                        'CST-3001',
                        'Warehouse Operations',
                        '₹1,240,000',
                        '₹1,180,000',
                        '95%',
                      ],
                      [
                        'CST-3002',
                        'Distribution',
                        '₹980,000',
                        '₹915,000',
                        '93%',
                      ],
                      [
                        'CST-3003',
                        'Customer Support',
                        '₹620,000',
                        '₹570,000',
                        '92%',
                      ],
                      [
                        'CST-3004',
                        'Technology',
                        '₹1,150,000',
                        '₹1,090,000',
                        '95%',
                      ],
                      [
                        'CST-3005',
                        'Administration',
                        '₹410,000',
                        '₹385,000',
                        '94%',
                      ],
                    ],
                  ),

                // Mobile Cards
                if (isMobile)
                  const Column(
                    children: [
                      _CostCard(
                        costId: 'CST-3001',
                        costCenter: 'Warehouse Operations',
                        budget: '₹1,240,000',
                        actual: '₹1,180,000',
                        used: '95%',
                      ),
                      _CostCard(
                        costId: 'CST-3002',
                        costCenter: 'Distribution',
                        budget: '₹980,000',
                        actual: '₹915,000',
                        used: '93%',
                      ),
                      _CostCard(
                        costId: 'CST-3003',
                        costCenter: 'Customer Support',
                        budget: '₹620,000',
                        actual: '₹570,000',
                        used: '92%',
                      ),
                      _CostCard(
                        costId: 'CST-3004',
                        costCenter: 'Technology',
                        budget: '₹1,150,000',
                        actual: '₹1,090,000',
                        used: '95%',
                      ),
                      _CostCard(
                        costId: 'CST-3005',
                        costCenter: 'Administration',
                        budget: '₹410,000',
                        actual: '₹385,000',
                        used: '94%',
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

class _CostCard extends StatelessWidget {
  final String costId;
  final String costCenter;
  final String budget;
  final String actual;
  final String used;

  const _CostCard({
    required this.costId,
    required this.costCenter,
    required this.budget,
    required this.actual,
    required this.used,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = int.tryParse(used.replaceAll('%', '')) ?? 0;

    final Color usedColor = percentage >= 90
        ? Colors.red.shade700
        : percentage >= 80
        ? Colors.orange.shade700
        : Colors.green.shade700;

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
          // Cost ID
          Text(
            costId,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 5),

          // Cost Center
          Text(
            costCenter,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),

          const SizedBox(height: 14),

          // Budget & Actual
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _CostInfo(label: 'Budget', value: budget),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _CostInfo(label: 'Actual', value: actual),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Used Percentage
          Row(
            children: [
              const Text(
                'Used',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                used,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: usedColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          // Progress
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 7,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(usedColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _CostInfo extends StatelessWidget {
  final String label;
  final String value;

  const _CostInfo({required this.label, required this.value});

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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
