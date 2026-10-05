import 'package:flutter/material.dart';

import '../../widgets/submodule_header.dart';

class TenantTemplatesPage extends StatelessWidget {
  const TenantTemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final templates = [
      ['Enterprise', 'All enterprise services', 'Active'],
      ['Professional', 'Core business services', 'Active'],
      ['Standard', 'Essential services', 'Active'],
      ['Starter', 'Basic platform services', 'Draft'],
    ];

    return Column(
      children: [
        SubmoduleHeader(
          title: 'Tenant Templates',
          subtitle: 'Manage reusable tenant configuration templates.',
          icon: Icons.business_outlined,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tenant Templates',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text('Create Template'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Template')),
                          DataColumn(label: Text('Services')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: templates.map((template) {
                          return DataRow(
                            cells: [
                              DataCell(Text(template[0])),
                              DataCell(Text(template[1])),
                              DataCell(Text(template[2])),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit_outlined),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.visibility_outlined,
                                      ),
                                    ),
                                  ],
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
          ),
        ),
      ],
    );
  }
}
