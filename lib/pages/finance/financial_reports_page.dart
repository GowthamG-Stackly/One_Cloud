
import 'package:flutter/material.dart';
import 'finance_widgets.dart';

class FinancialReportsPage extends StatelessWidget {
  const FinancialReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FinancePageShell(
      title: 'Financial Reports',
      subtitle: 'Generate and review standard financial reports.',
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
            title: 'Financial Reports List',
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
                      'Report',
                      'Frequency',
                      'Last Generated',
                      'Status',
                    ],
                    rows: [
                      [
                        'Balance Sheet',
                        'Monthly',
                        '10 Sep 2026',
                        'Generated',
                      ],
                      [
                        'Profit & Loss',
                        'Monthly',
                        '10 Sep 2026',
                        'Generated',
                      ],
                      [
                        'Cash Flow Statement',
                        'Monthly',
                        '10 Sep 2026',
                        'Generated',
                      ],
                      [
                        'Trial Balance',
                        'Daily',
                        '10 Sep 2026',
                        'Generated',
                      ],
                      [
                        'Accounts Receivable Aging',
                        'Weekly',
                        '09 Sep 2026',
                        'Generated',
                      ],
                      [
                        'Accounts Payable Aging',
                        'Weekly',
                        '09 Sep 2026',
                        'Generated',
                      ],
                    ],
                  ),

                // Mobile Cards
                if (isMobile)
                  const Column(
                    children: [
                      _ReportCard(
                        report: 'Balance Sheet',
                        frequency: 'Monthly',
                        lastGenerated: '10 Sep 2026',
                        status: 'Generated',
                      ),
                      _ReportCard(
                        report: 'Profit & Loss',
                        frequency: 'Monthly',
                        lastGenerated: '10 Sep 2026',
                        status: 'Generated',
                      ),
                      _ReportCard(
                        report: 'Cash Flow Statement',
                        frequency: 'Monthly',
                        lastGenerated: '10 Sep 2026',
                        status: 'Generated',
                      ),
                      _ReportCard(
                        report: 'Trial Balance',
                        frequency: 'Daily',
                        lastGenerated: '10 Sep 2026',
                        status: 'Generated',
                      ),
                      _ReportCard(
                        report: 'Accounts Receivable Aging',
                        frequency: 'Weekly',
                        lastGenerated: '09 Sep 2026',
                        status: 'Generated',
                      ),
                      _ReportCard(
                        report: 'Accounts Payable Aging',
                        frequency: 'Weekly',
                        lastGenerated: '09 Sep 2026',
                        status: 'Generated',
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

class _ReportCard extends StatelessWidget {
  final String report;
  final String frequency;
  final String lastGenerated;
  final String status;

  const _ReportCard({
    required this.report,
    required this.frequency,
    required this.lastGenerated,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Report Name
          Text(
            report,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 14),

          // Frequency & Last Generated
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ReportInfo(
                  label: 'Frequency',
                  value: frequency,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ReportInfo(
                  label: 'Last Generated',
                  value: lastGenerated,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Status
          Row(
            children: [
              Text(
                'Status',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportInfo extends StatelessWidget {
  final String label;
  final String value;

  const _ReportInfo({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
