import 'package:flutter/material.dart';

import '../../widgets/enterprise_module_dashboard.dart';

class CalendarDashboardPage extends StatelessWidget {
  const CalendarDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterpriseModuleDashboard(
      title: 'Calendar',
      subtitle: 'Manage schedules, meetings, events and shared calendars.',
      icon: Icons.calendar_month_outlined,
      kpis: [
        ModuleKpi(
          title: 'Today Events',
          value: '24',
          icon: Icons.event_outlined,
        ),
        ModuleKpi(title: 'Meetings', value: '18', icon: Icons.groups_outlined),
        ModuleKpi(
          title: 'Shared Calendars',
          value: '12',
          icon: Icons.calendar_view_month_outlined,
        ),
        ModuleKpi(
          title: 'Reminders',
          value: '36',
          icon: Icons.notifications_active_outlined,
        ),
      ],
      quickActions: [
        ModuleQuickAction(title: 'User Calendars', icon: Icons.person_outline),
        ModuleQuickAction(title: 'Team Calendars', icon: Icons.groups_outlined),
        ModuleQuickAction(
          title: 'Meeting Scheduler',
          icon: Icons.event_available_outlined,
        ),
        ModuleQuickAction(
          title: 'Resource Booking',
          icon: Icons.meeting_room_outlined,
        ),
        ModuleQuickAction(title: 'Reminders', icon: Icons.alarm_outlined),
        ModuleQuickAction(
          title: 'Calendar Integrations',
          icon: Icons.integration_instructions_outlined,
        ),
        ModuleQuickAction(
          title: 'Availability',
          icon: Icons.access_time_outlined,
        ),
        ModuleQuickAction(
          title: 'Shared Calendars',
          icon: Icons.calendar_today_outlined,
        ),
      ],
    );
  }
}
