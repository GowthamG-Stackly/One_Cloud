import 'package:flutter/material.dart';

import 'finance_widgets.dart';

class BudgetingPage extends StatelessWidget {
  const BudgetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FinancePageShell(
      title: 'Budgeting',
      subtitle: 'Plan budgets and compare planned versus actual spending.',
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
            title: 'Budgeting List',

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
                      'Budget ID',
                      'Department',
                      'Budget',
                      'Actual',
                      'Used',
                    ],
                    rows: [
                      [
                        'BUD-2026-01',
                        'Operations',
                        '₹5,000,000',
                        '₹4,320,000',
                        '86%',
                      ],
                      [
                        'BUD-2026-02',
                        'Sales & Marketing',
                        '₹3,500,000',
                        '₹2,980,000',
                        '85%',
                      ],
                      [
                        'BUD-2026-03',
                        'Human Resources',
                        '₹2,800,000',
                        '₹2,450,000',
                        '88%',
                      ],
                      [
                        'BUD-2026-04',
                        'Technology',
                        '₹4,200,000',
                        '₹3,760,000',
                        '90%',
                      ],
                      [
                        'BUD-2026-05',
                        'Administration',
                        '₹1,600,000',
                        '₹1,210,000',
                        '76%',
                      ],
                    ],
                  ),

                // ==========================================================
                // MOBILE CARDS
                // ==========================================================
                if (isMobile)
                  Column(
                    children: [
                      _BudgetCard(
                        budgetId: 'BUD-2026-01',
                        department: 'Operations',
                        budget: '₹5,000,000',
                        actual: '₹4,320,000',
                        used: '86%',
                      ),

                      _BudgetCard(
                        budgetId: 'BUD-2026-02',
                        department: 'Sales & Marketing',
                        budget: '₹3,500,000',
                        actual: '₹2,980,000',
                        used: '85%',
                      ),

                      _BudgetCard(
                        budgetId: 'BUD-2026-03',
                        department: 'Human Resources',
                        budget: '₹2,800,000',
                        actual: '₹2,450,000',
                        used: '88%',
                      ),

                      _BudgetCard(
                        budgetId: 'BUD-2026-04',
                        department: 'Technology',
                        budget: '₹4,200,000',
                        actual: '₹3,760,000',
                        used: '90%',
                      ),

                      _BudgetCard(
                        budgetId: 'BUD-2026-05',
                        department: 'Administration',
                        budget: '₹1,600,000',
                        actual: '₹1,210,000',
                        used: '76%',
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
// MOBILE BUDGET CARD
// ============================================================================

class _BudgetCard extends StatelessWidget {
  final String budgetId;
  final String department;
  final String budget;
  final String actual;
  final String used;

  const _BudgetCard({
    required this.budgetId,
    required this.department,
    required this.budget,
    required this.actual,
    required this.used,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = int.tryParse(used.replaceAll('%', '')) ?? 0;

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
          // BUDGET ID
          // ================================================================

          Text(
            budgetId,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 5),

          // ================================================================
          // DEPARTMENT
          // ================================================================
          Text(
            department,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),

          const SizedBox(height: 14),

          // ================================================================
          // BUDGET + ACTUAL
          // ================================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _BudgetInfo(label: 'Budget', value: budget),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _BudgetInfo(label: 'Actual', value: actual),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ================================================================
          // USED
          // ================================================================
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
                  color: percentage >= 90
                      ? Colors.red.shade700
                      : percentage >= 80
                      ? Colors.orange.shade700
                      : Colors.green.shade700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          // ================================================================
          // PROGRESS BAR
          // ================================================================
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 7,
              backgroundColor: Colors.grey.shade200,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// BUDGET INFO
// ============================================================================

class _BudgetInfo extends StatelessWidget {
  final String label;
  final String value;

  const _BudgetInfo({required this.label, required this.value});

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
