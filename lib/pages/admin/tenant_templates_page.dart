// import 'package:flutter/material.dart';

// import '../../widgets/submodule_header.dart';

// class TenantTemplatesPage extends StatelessWidget {
//   const TenantTemplatesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final templates = [
//       ['Enterprise', 'All enterprise services', 'Active'],
//       ['Professional', 'Core business services', 'Active'],
//       ['Standard', 'Essential services', 'Active'],
//       ['Starter', 'Basic platform services', 'Draft'],
//     ];

//     return Column(
//       children: [
//         SubmoduleHeader(
//           title: 'Tenant Templates',
//           subtitle: 'Manage reusable tenant configuration templates.',
//           icon: Icons.business_outlined,
//         ),
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(22),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             'Tenant Templates',
//                             style: Theme.of(context).textTheme.titleMedium
//                                 ?.copyWith(fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                         ElevatedButton.icon(
//                           onPressed: () {},
//                           icon: const Icon(Icons.add),
//                           label: const Text('Create Template'),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         columns: const [
//                           DataColumn(label: Text('Template')),
//                           DataColumn(label: Text('Services')),
//                           DataColumn(label: Text('Status')),
//                           DataColumn(label: Text('Action')),
//                         ],
//                         rows: templates.map((template) {
//                           return DataRow(
//                             cells: [
//                               DataCell(Text(template[0])),
//                               DataCell(Text(template[1])),
//                               DataCell(Text(template[2])),
//                               DataCell(
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     IconButton(
//                                       onPressed: () {},
//                                       icon: const Icon(Icons.edit_outlined),
//                                     ),
//                                     IconButton(
//                                       onPressed: () {},
//                                       icon: const Icon(
//                                         Icons.visibility_outlined,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

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
        const SubmoduleHeader(
          title: 'Tenant Templates',
          subtitle: 'Manage reusable tenant configuration templates.',
          icon: Icons.business_outlined,
        ),

        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;

              return SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 12 : 24),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 14 : 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ==================================================
                        // HEADER
                        // ==================================================
                        if (isMobile)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tenant Templates',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),

                              const SizedBox(height: 12),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add, size: 18),
                                  label: const Text('Create Template'),
                                ),
                              ),
                            ],
                          )
                        else
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

                        // ==================================================
                        // RESPONSIVE CONTENT
                        // ==================================================
                        if (isMobile)
                          _MobileTemplateList(templates: templates)
                        else
                          _DesktopTemplateTable(templates: templates),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// MOBILE TEMPLATE LIST
// ============================================================================

class _MobileTemplateList extends StatelessWidget {
  final List<List<String>> templates;

  const _MobileTemplateList({required this.templates});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: templates.map((template) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ========================================================
                // TEMPLATE NAME + ACTIONS
                // ========================================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        template[0],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined, size: 19),
                          ),
                        ),

                        SizedBox(
                          width: 36,
                          height: 36,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.visibility_outlined,
                              size: 19,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ========================================================
                // SERVICES
                // ========================================================
                Text(
                  'Services',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 4),

                Text(
                  template[1],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 12),

                // ========================================================
                // STATUS
                // ========================================================
                Row(
                  children: [
                    Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(width: 10),

                    _StatusBadge(status: template[2]),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ============================================================================
// DESKTOP TABLE
// ============================================================================

class _DesktopTemplateTable extends StatelessWidget {
  final List<List<String>> templates;

  const _DesktopTemplateTable({required this.templates});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 48,
        horizontalMargin: 8,
        columns: const [
          DataColumn(label: Text('Template')),
          DataColumn(label: Text('Services')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Action')),
        ],
        rows: templates.map((template) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  template[0],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),

              DataCell(Text(template[1])),

              DataCell(_StatusBadge(status: template[2])),

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
                      icon: const Icon(Icons.visibility_outlined),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
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
    final isDraft = status == 'Draft';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: isDraft
            ? Colors.orange.withValues(alpha: 0.10)
            : Colors.green.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isDraft ? Colors.orange.shade700 : Colors.green.shade700,
        ),
      ),
    );
  }
}
