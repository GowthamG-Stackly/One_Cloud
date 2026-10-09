import 'package:flutter/material.dart';

import 'finance_widgets.dart';

class GeneralLedgerPage extends StatelessWidget {
  const GeneralLedgerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FinancePageShell(
      title: 'General Ledger',
      subtitle: 'Manage journal entries, accounts and ledger balances.',
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
            title: 'General Ledger List',

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
                      'Date',
                      'Account',
                      'Description',
                      'Debit',
                      'Credit',
                    ],
                    rows: [
                      [
                        'GL-1001',
                        '10 Sep 2026',
                        'Cash & Bank',
                        'Customer payment received',
                        '₹420,000',
                        '₹0',
                      ],
                      [
                        'GL-1002',
                        '10 Sep 2026',
                        'Sales Revenue',
                        'Customer invoice posted',
                        '₹0',
                        '₹610,000',
                      ],
                      [
                        'GL-1003',
                        '09 Sep 2026',
                        'Office Expense',
                        'Monthly office expense',
                        '₹85,000',
                        '₹0',
                      ],
                      [
                        'GL-1004',
                        '09 Sep 2026',
                        'Accounts Payable',
                        'Vendor invoice posted',
                        '₹0',
                        '₹275,000',
                      ],
                      [
                        'GL-1005',
                        '08 Sep 2026',
                        'Depreciation',
                        'Monthly depreciation',
                        '₹145,000',
                        '₹0',
                      ],
                    ],
                  ),

                // ==========================================================
                // MOBILE CARDS
                // ==========================================================
                if (isMobile)
                  Column(
                    children: [
                      _LedgerCard(
                        reference: 'GL-1001',
                        date: '10 Sep 2026',
                        account: 'Cash & Bank',
                        description: 'Customer payment received',
                        debit: '₹420,000',
                        credit: '₹0',
                      ),

                      _LedgerCard(
                        reference: 'GL-1002',
                        date: '10 Sep 2026',
                        account: 'Sales Revenue',
                        description: 'Customer invoice posted',
                        debit: '₹0',
                        credit: '₹610,000',
                      ),

                      _LedgerCard(
                        reference: 'GL-1003',
                        date: '09 Sep 2026',
                        account: 'Office Expense',
                        description: 'Monthly office expense',
                        debit: '₹85,000',
                        credit: '₹0',
                      ),

                      _LedgerCard(
                        reference: 'GL-1004',
                        date: '09 Sep 2026',
                        account: 'Accounts Payable',
                        description: 'Vendor invoice posted',
                        debit: '₹0',
                        credit: '₹275,000',
                      ),

                      _LedgerCard(
                        reference: 'GL-1005',
                        date: '08 Sep 2026',
                        account: 'Depreciation',
                        description: 'Monthly depreciation',
                        debit: '₹145,000',
                        credit: '₹0',
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
// MOBILE LEDGER CARD
// ============================================================================

class _LedgerCard extends StatelessWidget {
  final String reference;
  final String date;
  final String account;
  final String description;
  final String debit;
  final String credit;

  const _LedgerCard({
    required this.reference,
    required this.date,
    required this.account,
    required this.description,
    required this.debit,
    required this.credit,
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
          // REFERENCE / DATE
          // ================================================================

          Row(
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
          // ACCOUNT
          // ================================================================
          Text(
            'Account',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 3),

          Text(
            account,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),

          // ================================================================
          // DESCRIPTION
          // ================================================================
          Text(
            'Description',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 3),

          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13),
          ),

          const SizedBox(height: 14),

          // ================================================================
          // DEBIT / CREDIT
          // ================================================================
          Row(
            children: [
              Expanded(
                child: _AmountBox(label: 'Debit', value: debit),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _AmountBox(label: 'Credit', value: credit),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// AMOUNT BOX
// ============================================================================

class _AmountBox extends StatelessWidget {
  final String label;
  final String value;

  const _AmountBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 3),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
