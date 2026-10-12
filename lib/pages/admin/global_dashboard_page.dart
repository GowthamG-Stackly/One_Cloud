import 'package:flutter/material.dart';

const Color _blue = Color(0xFF2638E8);
const Color _navy = Color(0xFF242B5F);
const Color _ink = Color(0xFF202B40);
const Color _muted = Color(0xFF71809A);
const Color _line = Color(0xFFDCE5F1);
const Color _paleBlue = Color(0xFFF0F6FF);
const Color _purple = Color(0xFF8957FF);
const Color _green = Color(0xFF00B982);
const Color _orange = Color(0xFFFFA900);

class GlobalDashboardPage extends StatefulWidget {
  const GlobalDashboardPage({super.key});

  @override
  State<GlobalDashboardPage> createState() => _GlobalDashboardPageState();
}

class _GlobalDashboardPageState extends State<GlobalDashboardPage> {
  String _currentView = 'dashboard';

  void _openExport() => setState(() => _currentView = 'export');
  void _openAlerts() => setState(() => _currentView = 'alerts');
  void _openActivities() => setState(() => _currentView = 'activities');
  void _goBack() => setState(() => _currentView = 'dashboard');

  @override
  Widget build(BuildContext context) {
    if (_currentView == 'export') {
      return ExportGlobalDashboardPage(onBack: _goBack);
    }
    if (_currentView == 'alerts') {
      return GlobalDashboardSecurityAlertsView(onBack: _goBack);
    }
    if (_currentView == 'activities') {
      return RecentActivitiesPage(onBack: _goBack);
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = constraints.maxWidth < 700;
        final pad = mobile ? 16.0 : 28.0;
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(pad, mobile ? 20 : 28, pad, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _dashboardHeader(mobile),
                  SizedBox(height: mobile ? 20 : 28),
                  const _SectionLabel('PLATFORM OVERVIEW'),
                  const SizedBox(height: 10),
                  _kpis(mobile),
                  const SizedBox(height: 20),
                  const _SectionLabel('QUICK NAVIGATION'),
                  const SizedBox(height: 10),
                  _quickLinks(mobile),
                  const SizedBox(height: 10),
                  if (mobile) ...[
                    _platformHealth(),
                    const SizedBox(height: 10),
                    _systemHealth(),
                    const SizedBox(height: 20),
                    _sectionActionTitle(
                      'Security alerts',
                      'View all alerts',
                      _openAlerts,
                    ),
                    const SizedBox(height: 10),
                    ..._alertData
                        .take(3)
                        .map(
                          (a) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _AlertTile(alert: a, compact: true),
                          ),
                        ),
                    const SizedBox(height: 12),
                    _recentPreview(),
                    const SizedBox(height: 20),
                    SizedBox(width: double.infinity, child: _exportButton()),
                  ] else ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _platformHealth()),
                        const SizedBox(width: 12),
                        Expanded(child: _systemHealth()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _securityPreview()),
                        const SizedBox(width: 12),
                        Expanded(child: _recentPreview()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _exportButton(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _dashboardHeader(bool mobile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Platform Administration / Global Dashboard',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: _muted, fontSize: 11),
              ),
              const SizedBox(height: 6),
              Text(
                'Global Dashboard',
                style: TextStyle(
                  color: _ink,
                  fontSize: mobile ? 21 : 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Refresh dashboard',
          onPressed: () => setState(() {}),
          icon: const Icon(Icons.refresh, color: Color(0xFF526070)),
        ),
      ],
    );
  }

  Widget _kpis(bool mobile) {
    final items = <_KpiData>[
      _KpiData('TOTAL TENANTS', '132', '+8% this month', Icons.people_outline),
      _KpiData(
        'TOTAL USERS',
        '48,920',
        '+13% this month',
        Icons.verified_user_outlined,
      ),
      _KpiData(
        'ACTIVE SUBSCRIPTIONS',
        '1,233',
        '+10% this month',
        Icons.visibility_outlined,
      ),
      _KpiData('ACTIVE SESSIONS', '789', '+6% this month', Icons.trending_up),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: mobile ? 2 : 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: mobile ? 125 : 145,
      ),
      itemBuilder: (_, i) => _KpiCard(data: items[i]),
    );
  }

  Widget _quickLinks(bool mobile) {
    final items = <_QuickData>[
      _QuickData(
        'Manage Tenants',
        'Manage accounts & roles',
        Icons.people_outline,
      ),
      _QuickData(
        'Platform Settings',
        'Global configuration',
        Icons.settings_outlined,
      ),
      _QuickData(
        'Generate Report',
        'Renewals & seat usage',
        Icons.insert_drive_file_outlined,
        onTap: _openExport,
      ),
      _QuickData(
        'System Monitoring',
        'Track admin actions',
        Icons.monitor_heart_outlined,
      ),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: mobile ? 2 : 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: mobile ? 122 : 116,
      ),
      itemBuilder: (_, i) => _QuickCard(data: items[i]),
    );
  }

  Widget _platformHealth() {
    return _Panel(
      title: 'Platform Health Status',
      trailing: 'Last 7 Days',
      child: Column(
        children: [
          _HealthBar(
            label: 'CPU Usage',
            value: .67,
            percent: '67%',
            color: _orange,
          ),
          const SizedBox(height: 17),
          _HealthBar(
            label: 'Memory Utilization',
            value: .54,
            percent: '54%',
            color: _green,
          ),
          const SizedBox(height: 17),
          _HealthBar(
            label: 'Disk I/O',
            value: .32,
            percent: '32%',
            color: _green,
          ),
          const SizedBox(height: 17),
          _HealthBar(
            label: 'Network Bandwidth',
            value: .78,
            percent: '78%',
            color: _orange,
          ),
        ],
      ),
    );
  }

  Widget _systemHealth() {
    return _Panel(
      title: 'System Health',
      trailing: 'Last 7 Days',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: const [
              _Legend(color: _purple, label: 'Operational'),
              _Legend(color: Color(0xFF367CFF), label: 'Degraded'),
              _Legend(color: _green, label: 'Down'),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            width: double.infinity,
            child: CustomPaint(painter: _HealthChartPainter()),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TinyText('May 12'),
              _TinyText('May 14'),
              _TinyText('May 16'),
              _TinyText('May 18'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _securityPreview() => _Panel(
    title: 'Security alerts',
    trailingWidget: _TextAction(label: 'View all alerts', onTap: _openAlerts),
    child: Column(
      children: _alertData
          .take(3)
          .map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _AlertTile(alert: a, compact: true),
            ),
          )
          .toList(),
    ),
  );

  Widget _recentPreview() => _Panel(
    title: 'Recent activities',
    trailingWidget: _TextAction(label: 'View All', onTap: _openActivities),
    child: Column(
      children: _activityData
          .take(4)
          .map((a) => _ActivityTile(activity: a, compact: true))
          .toList(),
    ),
  );

  Widget _sectionActionTitle(String title, String action, VoidCallback onTap) =>
      Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: _ink,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          _TextAction(label: action, onTap: onTap),
        ],
      );

  Widget _exportButton() => ElevatedButton.icon(
    onPressed: _openExport,
    icon: const Icon(Icons.file_download_outlined, size: 18),
    label: const Text(
      'Export Report',
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: _blue,
      foregroundColor: Colors.white,
      minimumSize: const Size(0, 48),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      elevation: 0,
    ),
  );
}

class ExportGlobalDashboardPage extends StatefulWidget {
  final VoidCallback onBack;
  const ExportGlobalDashboardPage({super.key, required this.onBack});
  @override
  State<ExportGlobalDashboardPage> createState() =>
      _ExportGlobalDashboardPageState();
}

class _ExportGlobalDashboardPageState extends State<ExportGlobalDashboardPage> {
  String _format = 'PDF Document';
  String _interval = 'Last 30 Days';
  bool _includeCharts = false;
  bool _includeTables = false;
  bool _downloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Column(
          children: [
            _DetailHeader(
              title: 'Export Global Dashboard Report',
              subtitle:
                  'Configure and generate a report of your platform insights.',
              onBack: widget.onBack,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final mobile = constraints.maxWidth < 680;
                  final horizontal = mobile ? 16.0 : 28.0;
                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      horizontal,
                      20,
                      horizontal,
                      24,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 980),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: _line),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE9EDFF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.file_download_outlined,
                                      color: _blue,
                                      size: 25,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Create a dashboard report',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: _ink,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Choose a format, reporting period, and the information to include.',
                                          style: TextStyle(
                                            fontSize: 13,
                                            height: 1.4,
                                            color: _muted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 22),
                            _exportSection(
                              title: '1. File format',
                              subtitle: 'Select the file type that best fits your workflow.',
                              child: LayoutBuilder(
                                builder: (context, c) {
                                  final narrow = c.maxWidth < 520;
                                  final options = [
                                    _FormatOption(
                                      'PDF Document',
                                      Icons.picture_as_pdf_outlined,
                                    ),
                                    _FormatOption(
                                      'CSV (Raw Data)',
                                      Icons.data_object_outlined,
                                    ),
                                    _FormatOption(
                                      'Excel Spreadsheet',
                                      Icons.table_chart_outlined,
                                    ),
                                  ];
                                  return narrow
                                      ? Column(
                                          children: options
                                              .map(
                                                (o) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 9,
                                                      ),
                                                  child: _FormatRow(
                                                    option: o,
                                                    selected:
                                                        _format == o.label,
                                                    onTap: () => setState(
                                                      () => _format = o.label,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        )
                                      : Row(
                                          children: options
                                              .map(
                                                (o) => Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: o == options.last
                                                          ? 0
                                                          : 10,
                                                    ),
                                                    child: _FormatCard(
                                                      option: o,
                                                      selected:
                                                          _format == o.label,
                                                      compact: false,
                                                      onTap: () => setState(
                                                        () => _format = o.label,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            _exportSection(
                              title: '2. Reporting period',
                              subtitle: 'Choose the time range for dashboard metrics and activity.',
                              child: Wrap(
                                spacing: 9,
                                runSpacing: 9,
                                children:
                                    ['Today', 'Last 7 Days', 'Last 30 Days']
                                        .map(
                                          (value) => _ChoicePill(
                                            label: value,
                                            selected: _interval == value,
                                            onTap: () => setState(
                                              () => _interval = value,
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _exportSection(
                              title: '3. Report contents',
                              subtitle: 'Customize which sections are included in the export.',
                              child: Column(
                                children: [
                                  _OptionToggle(
                                    title: 'Include charts and visualizations',
                                    subtitle: 'Add platform health and system performance charts.',
                                    value: _includeCharts,
                                    onChanged: (v) =>
                                        setState(() => _includeCharts = v),
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Color(0xFFE6E9EF),
                                  ),
                                  _OptionToggle(
                                    title: 'Include detailed data tables',
                                    subtitle: 'Append detailed metric rows for further analysis.',
                                    value: _includeTables,
                                    onChanged: (v) =>
                                        setState(() => _includeTables = v),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(17),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0F5FF),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFDCE7FF),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.preview_outlined,
                                        color: _blue,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Export summary',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: _ink,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 13),
                                  _SummaryLine(
                                    label: 'File format',
                                    value: _format,
                                  ),
                                  _SummaryLine(
                                    label: 'Reporting period',
                                    value: _interval,
                                  ),
                                  _SummaryLine(
                                    label: 'Charts',
                                    value: _includeCharts
                                        ? 'Included'
                                        : 'Not included',
                                  ),
                                  _SummaryLine(
                                    label: 'Detailed tables',
                                    value: _includeTables
                                        ? 'Included'
                                        : 'Not included',
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Note: this screen currently simulates report generation; connect your export service to create a downloadable file.',
                                    style: TextStyle(
                                      fontSize: 11,
                                      height: 1.4,
                                      color: _muted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: _line)),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 980),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: widget.onBack,
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 50),
                            foregroundColor: _ink,
                            side: const BorderSide(color: _line, width: 1.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: _downloading ? null : _downloadExport,
                          icon: _downloading
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.download_outlined, size: 19),
                          label: Text(
                            _downloading
                                ? 'Preparing report...'
                                : 'Generate Export',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 50),
                            backgroundColor: _blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadExport() {
    setState(() => _downloading = true);
    Future<void>.delayed(const Duration(milliseconds: 450), () {
      if (!mounted) return;
      setState(() => _downloading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Export options selected: $_format • $_interval'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }
}

class GlobalDashboardSecurityAlertsView extends StatefulWidget {
  final VoidCallback onBack;
  const GlobalDashboardSecurityAlertsView({super.key, required this.onBack});
  @override
  State<GlobalDashboardSecurityAlertsView> createState() =>
      _GlobalDashboardSecurityAlertsViewState();
}

class _GlobalDashboardSecurityAlertsViewState
    extends State<GlobalDashboardSecurityAlertsView> {
  String _range = 'Last 7 Days';
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        children: [
          _ListPageHeader(
            title: 'Security alerts',
            range: _range,
            onBack: widget.onBack,
            onRangeChanged: (v) => setState(() => _range = v),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              itemCount: _alertData.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) =>
                  _AlertTile(alert: _alertData[i], compact: false),
            ),
          ),
        ],
      ),
    ),
  );
}

class RecentActivitiesPage extends StatefulWidget {
  final VoidCallback onBack;
  const RecentActivitiesPage({super.key, required this.onBack});
  @override
  State<RecentActivitiesPage> createState() => _RecentActivitiesPageState();
}

class _RecentActivitiesPageState extends State<RecentActivitiesPage> {
  String _range = 'Last 7 Days';
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        children: [
          _ListPageHeader(
            title: 'Recent activities',
            range: _range,
            onBack: widget.onBack,
            onRangeChanged: (v) => setState(() => _range = v),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
              itemCount: _activityData.length,
              separatorBuilder: (_, __) => const SizedBox(height: 24),
              itemBuilder: (_, i) =>
                  _ActivityTile(activity: _activityData[i], compact: false),
            ),
          ),
        ],
      ),
    ),
  );
}

class _DetailHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;
  const _DetailHeader({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(16, 22, 20, 20),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _line)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BackButton(onTap: onBack),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 23,
                  height: 1.15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202337),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Color(0xFF71798A),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _ListPageHeader extends StatelessWidget {
  final String title;
  final String range;
  final VoidCallback onBack;
  final ValueChanged<String> onRangeChanged;
  const _ListPageHeader({
    required this.title,
    required this.range,
    required this.onBack,
    required this.onRangeChanged,
  });
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _line)),
    ),
    child: Row(
      children: [
        _BackButton(onTap: onBack),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202337),
            ),
          ),
        ),
        const SizedBox(width: 6),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: range,
            isDense: true,
            icon: const Icon(Icons.keyboard_arrow_down, size: 19),
            style: const TextStyle(color: Color(0xFF536071), fontSize: 13),
            items: const [
              'Today',
              'Last 7 Days',
              'Last 30 Days',
            ].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: (v) {
              if (v != null) onRangeChanged(v);
            },
          ),
        ),
      ],
    ),
  );
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 44,
    height: 44,
    child: OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        side: const BorderSide(color: _line, width: 1.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Icon(Icons.arrow_back, color: Colors.black, size: 23),
    ),
  );
}

Widget _exportSection({
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: _line),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _ink,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12, height: 1.4, color: _muted),
        ),
        const SizedBox(height: 16),
        child,
      ],
    ),
  );
}

class _FormatRow extends StatelessWidget {
  final _FormatOption option;
  final bool selected;
  final VoidCallback onTap;
  const _FormatRow({
    required this.option,
    required this.selected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(11),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFF1F4FF) : Colors.white,
        border: Border.all(
          color: selected ? _blue : _line,
          width: selected ? 1.6 : 1,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Icon(option.icon, color: selected ? _blue : _muted, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              option.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected ? _blue : _ink,
              ),
            ),
          ),
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? _blue : _muted,
            size: 20,
          ),
        ],
      ),
    ),
  );
}

class _SummaryLine extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryLine({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 9),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: _muted),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
        ),
      ],
    ),
  );
}

class _FormHeading extends StatelessWidget {
  final String text;
  const _FormHeading(this.text);
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color(0xFF191D27),
    ),
  );
}

class _FormatOption {
  final String label;
  final IconData icon;
  const _FormatOption(this.label, this.icon);
}

class _FormatCard extends StatelessWidget {
  final _FormatOption option;
  final bool selected;
  final bool compact;
  final VoidCallback onTap;
  const _FormatCard({
    required this.option,
    required this.selected,
    required this.compact,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      constraints: BoxConstraints(minHeight: compact ? 112 : 130),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: compact ? 12 : 18),
      decoration: BoxDecoration(
        border: Border.all(
          color: selected ? _blue : const Color(0xFFDDE3E9),
          width: selected ? 1.7 : 1.3,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            option.icon,
            size: compact ? 30 : 38,
            color: const Color(0xFF6C7484),
          ),
          SizedBox(height: compact ? 12 : 16),
          Text(
            option.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: compact ? 10 : 13,
              color: const Color(0xFF71798A),
            ),
          ),
        ],
      ),
    ),
  );
}

class _ChoicePill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _ChoicePill({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(28),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? _navy : const Color(0xFFF4F6F8),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : const Color(0xFF202637),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

class _OptionToggle extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _OptionToggle({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF22252D),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 13, color: Color(0xFF4D535D)),
              ),
            ],
          ),
        ),
        Switch(value: value, onChanged: onChanged, activeColor: _blue),
      ],
    ),
  );
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);
  @override
  Widget build(BuildContext context) => Text(
    label.toUpperCase(),
    style: const TextStyle(
      color: Color(0xFF91A1BB),
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: .6,
    ),
  );
}

class _KpiData {
  final String title, value, change;
  final IconData icon;
  const _KpiData(this.title, this.value, this.change, this.icon);
}

class _KpiCard extends StatelessWidget {
  final _KpiData data;
  const _KpiCard({required this.data});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: _line),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                data.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 9,
                  height: 1.35,
                  color: Color(0xFF8A9AB4),
                  fontWeight: FontWeight.w600,
                  letterSpacing: .25,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                color: const Color(0xFFE0ECFF),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(data.icon, size: 15, color: _blue),
            ),
          ],
        ),
        const Spacer(),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            data.value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: _ink,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          '↑ ${data.change}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, color: Color(0xFF00A979)),
        ),
      ],
    ),
  );
}

class _QuickData {
  final String title, subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  const _QuickData(this.title, this.subtitle, this.icon, {this.onTap});
}

class _QuickCard extends StatelessWidget {
  final _QuickData data;
  const _QuickCard({required this.data});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: data.onTap,
    borderRadius: BorderRadius.circular(17),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _line),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEEFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(data.icon, color: const Color(0xFF455BFF), size: 21),
          ),
          const Spacer(),
          Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: _muted, fontSize: 10),
          ),
        ],
      ),
    ),
  );
}

class _Panel extends StatelessWidget {
  final String title;
  final String? trailing;
  final Widget? trailingWidget;
  final Widget child;
  const _Panel({
    required this.title,
    required this.child,
    this.trailing,
    this.trailingWidget,
  });
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: _line),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 15, 14, 13),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
              ),
              if (trailingWidget != null)
                trailingWidget!
              else if (trailing != null)
                Text(
                  trailing!,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF94A2BA),
                  ),
                ),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFEDF1F6)),
        Padding(padding: const EdgeInsets.all(16), child: child),
      ],
    ),
  );
}

class _HealthBar extends StatelessWidget {
  final String label, percent;
  final double value;
  final Color color;
  const _HealthBar({
    required this.label,
    required this.value,
    required this.percent,
    required this.color,
  });
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF35435B)),
            ),
          ),
          Text(
            percent,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFFDB7200),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: value,
          minHeight: 8,
          backgroundColor: const Color(0xFFF0F3F8),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    ],
  );
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(label, style: const TextStyle(color: _muted, fontSize: 10)),
    ],
  );
}

class _TinyText extends StatelessWidget {
  final String text;
  const _TinyText(this.text);
  @override
  Widget build(BuildContext context) =>
      Text(text, style: const TextStyle(fontSize: 9, color: Color(0xFF91A0B9)));
}

class _HealthChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final series = <List<Offset>>[
      [
        Offset(0, .72),
        Offset(.16, .61),
        Offset(.32, .66),
        Offset(.48, .43),
        Offset(.64, .48),
        Offset(.80, .37),
        Offset(.97, .31),
      ],
      [
        Offset(0, .98),
        Offset(.16, .86),
        Offset(.32, .75),
        Offset(.48, .81),
        Offset(.64, .66),
        Offset(.80, .71),
        Offset(.97, .56),
      ],
      [
        Offset(0, 1.22),
        Offset(.16, 1.16),
        Offset(.32, 1.19),
        Offset(.48, 1.10),
        Offset(.64, 1.14),
        Offset(.80, 1.06),
        Offset(.97, 1.00),
      ],
    ];
    final colors = [_purple, const Color(0xFF367CFF), _green];
    for (var s = 0; s < series.length; s++) {
      final path = Path();
      for (var i = 0; i < series[s].length; i++) {
        final p = series[s][i];
        final point = Offset(p.dx * size.width, (p.dy / 1.35) * size.height);
        if (i == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = colors[s]
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TextAction extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _TextAction({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onTap,
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      foregroundColor: _blue,
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
    ),
  );
}

class _AlertData {
  final String title, description, time;
  final Color color, background;
  final IconData icon;
  const _AlertData(
    this.title,
    this.description,
    this.time,
    this.color,
    this.background,
    this.icon,
  );
}

const List<_AlertData> _alertData = [
  _AlertData(
    'High CPU Usage',
    'Database server CPU usage is high',
    '1 hour ago',
    Color(0xFF99600F),
    Color(0xFFFBF0DE),
    Icons.warning_amber_outlined,
  ),
  _AlertData(
    'Storage Threshold',
    'Storage utilization reached 80%',
    '2 hour ago',
    Color(0xFF2458BC),
    Color(0xFFEAF1FF),
    Icons.warning_amber_outlined,
  ),
  _AlertData(
    'New Tenant Registration',
    'Techcorp solutions registered',
    '2 hour ago',
    Color(0xFFFF9800),
    Color(0xFFFFFBEA),
    Icons.info_outline,
  ),
  _AlertData(
    'Storage Threshold',
    'Storage utilization reached 80%',
    '3 hour ago',
    Color(0xFF2458BC),
    Color(0xFFEAF1FF),
    Icons.warning_amber_outlined,
  ),
  _AlertData(
    'High CPU Usage',
    'Database server CPU usage is high',
    '6 hour ago',
    Color(0xFF99600F),
    Color(0xFFFBF0DE),
    Icons.warning_amber_outlined,
  ),
];

class _AlertTile extends StatelessWidget {
  final _AlertData alert;
  final bool compact;
  const _AlertTile({required this.alert, required this.compact});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: compact ? 12 : 16,
      vertical: compact ? 12 : 20,
    ),
    decoration: BoxDecoration(
      color: alert.background,
      borderRadius: BorderRadius.circular(compact ? 13 : 18),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(alert.icon, color: alert.color, size: compact ? 17 : 27),
        ),
        SizedBox(width: compact ? 9 : 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                alert.title,
                style: TextStyle(
                  color: alert.color,
                  fontSize: compact ? 12 : 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                alert.description,
                style: TextStyle(
                  color: compact
                      ? alert.color.withOpacity(.9)
                      : const Color(0xFF777777),
                  fontSize: compact ? 10 : 14,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          alert.time,
          textAlign: TextAlign.right,
          style: TextStyle(color: alert.color, fontSize: compact ? 9 : 13),
        ),
      ],
    ),
  );
}

class _ActivityData {
  final String title, description, time;
  final Color color, background;
  final IconData icon;
  const _ActivityData(
    this.title,
    this.description,
    this.time,
    this.color,
    this.background,
    this.icon,
  );
}

const List<_ActivityData> _activityData = [
  _ActivityData(
    'New Tenant Created',
    'by Admin users',
    '10 min ago',
    Color(0xFFCC8B00),
    Color(0xFFFFF8E7),
    Icons.warning_amber_outlined,
  ),
  _ActivityData(
    'License Updated',
    'by Admin users.',
    '1 hour ago',
    Color(0xFFFFA000),
    Color(0xFFFFF8E7),
    Icons.warning_amber_outlined,
  ),
  _ActivityData(
    'Backup Completed',
    'Daily snapshot of primary database cluster successful.',
    'Yesterday',
    Color(0xFF16804B),
    Color(0xFFE7F7EE),
    Icons.info_outline,
  ),
  _ActivityData(
    'User Added',
    'Superadmin granted access to monitoring module.',
    '3 hours ago',
    Color(0xFF367CFF),
    Color(0xFFEDF4FF),
    Icons.info_outline,
  ),
  _ActivityData(
    'License Updated',
    'by Admin users.',
    '1 hour ago',
    Color(0xFFFFA000),
    Color(0xFFFFF8E7),
    Icons.warning_amber_outlined,
  ),
  _ActivityData(
    'User Added',
    'Superadmin granted access to monitoring module.',
    '3 hours ago',
    Color(0xFF367CFF),
    Color(0xFFEDF4FF),
    Icons.info_outline,
  ),
  _ActivityData(
    'License Updated',
    'by Admin users.',
    '1 hour ago',
    Color(0xFFFFA000),
    Color(0xFFFFF8E7),
    Icons.warning_amber_outlined,
  ),
  _ActivityData(
    'Backup Completed',
    'Daily snapshot of primary database cluster successful.',
    'Yesterday',
    Color(0xFF16804B),
    Color(0xFFE7F7EE),
    Icons.info_outline,
  ),
];

class _ActivityTile extends StatelessWidget {
  final _ActivityData activity;
  final bool compact;
  const _ActivityTile({required this.activity, required this.compact});
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: compact ? 12 : 0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: compact ? 35 : 48,
          height: compact ? 35 : 48,
          decoration: BoxDecoration(
            color: activity.background,
            borderRadius: BorderRadius.circular(compact ? 9 : 50),
          ),
          child: Icon(
            activity.icon,
            color: activity.color,
            size: compact ? 17 : 24,
          ),
        ),
        SizedBox(width: compact ? 10 : 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.title,
                style: TextStyle(
                  fontSize: compact ? 12 : 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF20283A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                activity.description,
                style: TextStyle(
                  fontSize: compact ? 10 : 13,
                  height: 1.4,
                  color: const Color(0xFF747474),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          activity.time,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: compact ? 9 : 12,
            color: const Color(0xFF9AA4B4),
          ),
        ),
      ],
    ),
  );
}
