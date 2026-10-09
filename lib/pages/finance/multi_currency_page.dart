import 'package:flutter/material.dart';

import 'finance_widgets.dart';

class MultiCurrencyPage extends StatelessWidget {
  const MultiCurrencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FinancePageShell(
      title: 'Multi-Currency',
      subtitle: 'Manage currencies and exchange rates.',
      actions: [
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Add New'),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;

          return FinanceSectionCard(
            title: 'Multi-Currency List',
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

                // Desktop
                if (!isMobile)
                  const FinanceTable(
                    columns: [
                      'Currency',
                      'Name',
                      'Rate (INR)',
                      'Base Rate',
                      'Status',
                    ],
                    rows: [
                      ['USD', 'US Dollar', '₹83.25', '1.0000', 'Active'],
                      ['EUR', 'Euro', '₹97.80', '0.9200', 'Active'],
                      ['GBP', 'British Pound', '₹113.60', '0.7900', 'Active'],
                      ['AED', 'UAE Dirham', '₹22.67', '3.6725', 'Active'],
                      ['SGD', 'Singapore Dollar', '₹64.20', '1.2800', 'Active'],
                    ],
                  ),

                // Mobile
                if (isMobile)
                  const Column(
                    children: [
                      _CurrencyCard(
                        currency: 'USD',
                        name: 'US Dollar',
                        rate: '₹83.25',
                        baseRate: '1.0000',
                        status: 'Active',
                      ),
                      _CurrencyCard(
                        currency: 'EUR',
                        name: 'Euro',
                        rate: '₹97.80',
                        baseRate: '0.9200',
                        status: 'Active',
                      ),
                      _CurrencyCard(
                        currency: 'GBP',
                        name: 'British Pound',
                        rate: '₹113.60',
                        baseRate: '0.7900',
                        status: 'Active',
                      ),
                      _CurrencyCard(
                        currency: 'AED',
                        name: 'UAE Dirham',
                        rate: '₹22.67',
                        baseRate: '3.6725',
                        status: 'Active',
                      ),
                      _CurrencyCard(
                        currency: 'SGD',
                        name: 'Singapore Dollar',
                        rate: '₹64.20',
                        baseRate: '1.2800',
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

class _CurrencyCard extends StatelessWidget {
  final String currency;
  final String name;
  final String rate;
  final String baseRate;
  final String status;

  const _CurrencyCard({
    required this.currency,
    required this.name,
    required this.rate,
    required this.baseRate,
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
          // Currency
          Row(
            children: [
              Expanded(
                child: Text(
                  currency,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
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

          const SizedBox(height: 5),

          // Currency Name
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),

          const SizedBox(height: 14),

          // Rate Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _CurrencyInfo(label: 'Rate (INR)', value: rate),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _CurrencyInfo(label: 'Base Rate', value: baseRate),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CurrencyInfo extends StatelessWidget {
  final String label;
  final String value;

  const _CurrencyInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
