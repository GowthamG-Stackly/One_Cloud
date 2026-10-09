import 'package:flutter/material.dart';

import 'finance_widgets.dart';

class ReconciliationPage extends StatelessWidget {
  const ReconciliationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FinancePageShell(
      title: 'Reconciliation',
      subtitle:
          'Match accounting records with bank and transaction statements.',
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
            title: 'Reconciliation List',
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
                      'Reference',
                      'Account',
                      'Book Balance',
                      'Statement Balance',
                      'Status',
                    ],
                    rows: [
                      [
                        'REC-7001',
                        'Main Bank Account',
                        '₹8,420,000',
                        '₹8,420,000',
                        'Matched',
                      ],
                      [
                        'REC-7002',
                        'Operating Account',
                        '₹4,180,000',
                        '₹4,150,000',
                        'Unmatched',
                      ],
                      [
                        'REC-7003',
                        'Petty Cash',
                        '₹125,000',
                        '₹125,000',
                        'Matched',
                      ],
                      [
                        'REC-7004',
                        'Payment Gateway',
                        '₹2,840,000',
                        '₹2,810,000',
                        'Pending',
                      ],
                      [
                        'REC-7005',
                        'Payroll Account',
                        '₹3,250,000',
                        '₹3,250,000',
                        'Matched',
                      ],
                    ],
                  ),

                // Mobile Cards
                if (isMobile)
                  const Column(
                    children: [
                      _ReconciliationCard(
                        reference: 'REC-7001',
                        account: 'Main Bank Account',
                        bookBalance: '₹8,420,000',
                        statementBalance: '₹8,420,000',
                        status: 'Matched',
                      ),
                      _ReconciliationCard(
                        reference: 'REC-7002',
                        account: 'Operating Account',
                        bookBalance: '₹4,180,000',
                        statementBalance: '₹4,150,000',
                        status: 'Unmatched',
                      ),
                      _ReconciliationCard(
                        reference: 'REC-7003',
                        account: 'Petty Cash',
                        bookBalance: '₹125,000',
                        statementBalance: '₹125,000',
                        status: 'Matched',
                      ),
                      _ReconciliationCard(
                        reference: 'REC-7004',
                        account: 'Payment Gateway',
                        bookBalance: '₹2,840,000',
                        statementBalance: '₹2,810,000',
                        status: 'Pending',
                      ),
                      _ReconciliationCard(
                        reference: 'REC-7005',
                        account: 'Payroll Account',
                        bookBalance: '₹3,250,000',
                        statementBalance: '₹3,250,000',
                        status: 'Matched',
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

class _ReconciliationCard extends StatelessWidget {
  final String reference;
  final String account;
  final String bookBalance;
  final String statementBalance;
  final String status;

  const _ReconciliationCard({
    required this.reference,
    required this.account,
    required this.bookBalance,
    required this.statementBalance,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor;
    final Color statusBackground;

    switch (status) {
      case 'Matched':
        statusColor = Colors.green.shade700;
        statusBackground = Colors.green.shade50;
        break;

      case 'Unmatched':
        statusColor = Colors.red.shade700;
        statusBackground = Colors.red.shade50;
        break;

      case 'Pending':
        statusColor = Colors.orange.shade700;
        statusBackground = Colors.orange.shade50;
        break;

      default:
        statusColor = Colors.grey.shade700;
        statusBackground = Colors.grey.shade100;
    }

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
          // Reference
          Text(
            reference,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 5),

          // Account
          Text(
            account,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),

          const SizedBox(height: 14),

          // Balances
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ReconciliationInfo(
                  label: 'Book Balance',
                  value: bookBalance,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ReconciliationInfo(
                  label: 'Statement Balance',
                  value: statementBalance,
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
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
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

class _ReconciliationInfo extends StatelessWidget {
  final String label;
  final String value;

  const _ReconciliationInfo({required this.label, required this.value});

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
