import 'package:flutter/material.dart';

class ProcessMonitoringPage extends StatelessWidget {
  const ProcessMonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Process Monitoring')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;

          return SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Process Monitoring',
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Monitor workflow execution and process status.',
                  style: TextStyle(fontSize: isMobile ? 14 : 16),
                ),
                const SizedBox(height: 24),

                _ProcessCard(
                  title: 'Purchase Approval Workflow',
                  subtitle: 'Running • Step 4 of 6',
                  status: 'Running',
                  isMobile: isMobile,
                ),

                _ProcessCard(
                  title: 'Invoice Processing',
                  subtitle: 'Completed • 18 minutes ago',
                  status: 'Completed',
                  isMobile: isMobile,
                ),

                _ProcessCard(
                  title: 'Employee Onboarding',
                  subtitle: 'Waiting for HR approval',
                  status: 'Waiting',
                  isMobile: isMobile,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProcessCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final bool isMobile;

  const _ProcessCard({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color statusBackground;

    switch (status) {
      case 'Completed':
        statusColor = Colors.green.shade700;
        statusBackground = Colors.green.shade50;
        break;

      case 'Waiting':
        statusColor = Colors.orange.shade700;
        statusBackground = Colors.orange.shade50;
        break;

      default:
        statusColor = Colors.blue.shade700;
        statusBackground = Colors.blue.shade50;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 14 : 16),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.monitor_outlined, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  const Icon(Icons.monitor_outlined, size: 24),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: statusBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
