import 'package:flutter/material.dart';

import '../../widgets/submodule_header.dart';

class ResourceManagementPage extends StatelessWidget {
  const ResourceManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = [
      ['API Services', '42', 'Healthy'],
      ['Compute Resources', '18', 'Healthy'],
      ['Storage', '2.4 TB', 'Normal'],
      ['Database Instances', '12', 'Healthy'],
    ];

    return Column(
      children: [
        SubmoduleHeader(
          title: 'Resource Management',
          subtitle: 'Monitor and manage platform resources.',
          icon: Icons.dns_outlined,
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
                    Text(
                      'Platform Resources',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 18),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Resource')),
                          DataColumn(label: Text('Quantity')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: resources.map((resource) {
                          return DataRow(
                            cells: [
                              DataCell(Text(resource[0])),
                              DataCell(Text(resource[1])),
                              DataCell(
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      size: 9,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(resource[2]),
                                  ],
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.visibility_outlined),
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
