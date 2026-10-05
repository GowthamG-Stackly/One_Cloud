import 'package:flutter/material.dart';

import '../../widgets/submodule_header.dart';

class SystemHealthPage extends StatelessWidget {
  const SystemHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      ['API Gateway', 'Healthy', Icons.api_outlined],
      ['Authentication', 'Healthy', Icons.lock_outline],
      ['Database', 'Healthy', Icons.storage_outlined],
      ['Event Streaming', 'Healthy', Icons.stream_outlined],
      ['Notification Service', 'Healthy', Icons.notifications_outlined],
      ['Search Service', 'Healthy', Icons.search_outlined],
    ];

    return Column(
      children: [
        SubmoduleHeader(
          title: 'System Health',
          subtitle: 'Monitor the health of OneCloud platform services.',
          icon: Icons.monitor_heart_outlined,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 34,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Systems Operational',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('Last checked: Just now'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Service Health',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 18),
                        ...services.map(
                          (service) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              service[2] as IconData,
                              color: Colors.blue,
                            ),
                            title: Text(service[0] as String),
                            subtitle: Text(service[1] as String),
                            trailing: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
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
