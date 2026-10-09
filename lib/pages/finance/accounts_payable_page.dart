import 'package:flutter/material.dart';

import 'finance_widgets.dart';

class AccountsPayablePage extends StatelessWidget {
  const AccountsPayablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FinancePageShell(
      title: 'Accounts Payable',
      subtitle: 'Track vendor invoices, due dates and payments.',
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
            title: 'Accounts Payable List',

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
                      'Vendor',
                      'Date',
                      'Amount',
                      'Status',
                    ],
                    rows: [
                      [
                        'AP-2401',
                        'Global Supplies',
                        '10 Sep 2026',
                        '₹320,000',
                        'Pending',
                      ],
                      [
                        'AP-2402',
                        'Metro Logistics',
                        '09 Sep 2026',
                        '₹185,000',
                        'Paid',
                      ],
                      [
                        'AP-2403',
                        'Tech Solutions',
                        '07 Sep 2026',
                        '₹425,000',
                        'Partial',
                      ],
                      [
                        'AP-2404',
                        'Office World',
                        '05 Sep 2026',
                        '₹95,000',
                        'Overdue',
                      ],
                      [
                        'AP-2405',
                        'Prime Services',
                        '03 Sep 2026',
                        '₹210,000',
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
                      _PayableCard(
                        reference: 'AP-2401',
                        vendor: 'Global Supplies',
                        date: '10 Sep 2026',
                        amount: '₹320,000',
                        status: 'Pending',
                      ),

                      _PayableCard(
                        reference: 'AP-2402',
                        vendor: 'Metro Logistics',
                        date: '09 Sep 2026',
                        amount: '₹185,000',
                        status: 'Paid',
                      ),

                      _PayableCard(
                        reference: 'AP-2403',
                        vendor: 'Tech Solutions',
                        date: '07 Sep 2026',
                        amount: '₹425,000',
                        status: 'Partial',
                      ),

                      _PayableCard(
                        reference: 'AP-2404',
                        vendor: 'Office World',
                        date: '05 Sep 2026',
                        amount: '₹95,000',
                        status: 'Overdue',
                      ),

                      _PayableCard(
                        reference: 'AP-2405',
                        vendor: 'Prime Services',
                        date: '03 Sep 2026',
                        amount: '₹210,000',
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
// MOBILE PAYABLE CARD
// ============================================================================

class _PayableCard extends StatelessWidget {
  final String reference;
  final String vendor;
  final String date;
  final String amount;
  final String status;

  const _PayableCard({
    required this.reference,
    required this.vendor,
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
          // VENDOR
          // ================================================================
          Text(
            'Vendor',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 3),

          Text(
            vendor,
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
                child: _PayableInfo(label: 'Amount', value: amount),
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
// PAYABLE INFO
// ============================================================================

class _PayableInfo extends StatelessWidget {
  final String label;
  final String value;

  const _PayableInfo({required this.label, required this.value});

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
