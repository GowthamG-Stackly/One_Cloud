import 'package:flutter/material.dart';

import '../../widgets/submodule_header.dart';

class LicenseManagementPage extends StatelessWidget {
  const LicenseManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final licenses = [
      ['Enterprise', '12', 'Active'],
      ['Professional', '8', 'Active'],
      ['Standard', '4', 'Active'],
      ['Trial', '6', 'Trial'],
    ];

    return Column(
      children: [
        SubmoduleHeader(
          title: 'License Management',
          subtitle: 'Manage platform licenses and allocations.',
          icon: Icons.card_membership_outlined,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 900 ? 4 : 2;

                    return GridView.count(
                      crossAxisCount: columns,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 2.2,
                      children: const [
                        _Kpi('Total Licenses', '30'),
                        _Kpi('Allocated', '24'),
                        _Kpi('Available', '6'),
                        _Kpi('Expiring Soon', '3'),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'License Overview',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                              label: const Text('Add License'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Plan')),
                              DataColumn(label: Text('Quantity')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Action')),
                            ],
                            rows: licenses.map((license) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(license[0])),
                                  DataCell(Text(license[1])),
                                  DataCell(Text(license[2])),
                                  DataCell(
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.more_vert),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Kpi extends StatelessWidget {
  final String title;
  final String value;

  const _Kpi(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
