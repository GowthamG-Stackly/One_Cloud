import 'package:flutter/material.dart';

import 'finance_widgets.dart';

class AccountsReceivablePage extends StatelessWidget {
  const AccountsReceivablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FinancePageShell(
      title: 'Accounts Receivable',
      subtitle:
          'Track customer invoices, collections and outstanding balances.',
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
            title: 'Accounts Receivable List',

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
                      'Reference',
                      'Customer',
                      'Date',
                      'Amount',
                      'Status',
                    ],
                    rows: [
                      [
                        'AR-4101',
                        'Acme Corporation',
                        '10 Sep 2026',
                        '₹610,000',
                        'Pending',
                      ],
                      [
                        'AR-4102',
                        'Bright Retail',
                        '09 Sep 2026',
                        '₹285,000',
                        'Paid',
                      ],
                      [
                        'AR-4103',
                        'North Star Ltd',
                        '08 Sep 2026',
                        '₹450,000',
                        'Partial',
                      ],
                      [
                        'AR-4104',
                        'Green Foods',
                        '06 Sep 2026',
                        '₹175,000',
                        'Overdue',
                      ],
                      [
                        'AR-4105',
                        'Urban Mart',
                        '04 Sep 2026',
                        '₹390,000',
                        'Paid',
                      ],
                    ],
                  ),

                // ==========================================================
                // MOBILE CARDS
                // ==========================================================
                if (isMobile)
                  Column(
                    children: [
                      _ReceivableCard(
                        reference: 'AR-4101',
                        customer: 'Acme Corporation',
                        date: '10 Sep 2026',
                        amount: '₹610,000',
                        status: 'Pending',
                      ),

                      _ReceivableCard(
                        reference: 'AR-4102',
                        customer: 'Bright Retail',
                        date: '09 Sep 2026',
                        amount: '₹285,000',
                        status: 'Paid',
                      ),

                      _ReceivableCard(
                        reference: 'AR-4103',
                        customer: 'North Star Ltd',
                        date: '08 Sep 2026',
                        amount: '₹450,000',
                        status: 'Partial',
                      ),

                      _ReceivableCard(
                        reference: 'AR-4104',
                        customer: 'Green Foods',
                        date: '06 Sep 2026',
                        amount: '₹175,000',
                        status: 'Overdue',
                      ),

                      _ReceivableCard(
                        reference: 'AR-4105',
                        customer: 'Urban Mart',
                        date: '04 Sep 2026',
                        amount: '₹390,000',
                        status: 'Paid',
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
// MOBILE RECEIVABLE CARD
// ============================================================================

class _ReceivableCard extends StatelessWidget {
  final String reference;
  final String customer;
  final String date;
  final String amount;
  final String status;

  const _ReceivableCard({
    required this.reference,
    required this.customer,
    required this.date,
    required this.amount,
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
          // REFERENCE + DATE
          // ================================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  reference,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Flexible(
                child: Text(
                  date,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ================================================================
          // CUSTOMER
          // ================================================================
          Text(
            'Customer',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 3),

          Text(
            customer,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 12),

          // ================================================================
          // AMOUNT + STATUS
          // ================================================================
          Row(
            children: [
              Expanded(
                child: _ReceivableInfo(label: 'Amount', value: amount),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    _StatusBadge(status: status),
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

// ============================================================================
// RECEIVABLE INFO
// ============================================================================

class _ReceivableInfo extends StatelessWidget {
  final String label;
  final String value;

  const _ReceivableInfo({required this.label, required this.value});

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
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
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
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'Paid':
        backgroundColor = Colors.green.withValues(alpha: 0.10);
        textColor = Colors.green.shade700;
        break;

      case 'Overdue':
        backgroundColor = Colors.red.withValues(alpha: 0.10);
        textColor = Colors.red.shade700;
        break;

      case 'Partial':
        backgroundColor = Colors.orange.withValues(alpha: 0.10);
        textColor = Colors.orange.shade700;
        break;

      default:
        backgroundColor = Colors.blue.withValues(alpha: 0.10);
        textColor = Colors.blue.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
