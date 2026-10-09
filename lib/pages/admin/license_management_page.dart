import 'package:flutter/material.dart';

import '../../app_theme.dart';

class LicenseManagementPage extends StatefulWidget {
  const LicenseManagementPage({super.key});

  @override
  State<LicenseManagementPage> createState() => _LicenseManagementPageState();
}

class _LicenseManagementPageState extends State<LicenseManagementPage> {
  final TextEditingController _searchController = TextEditingController();

  String _organization = 'Organization';
  String _licenseType = 'License Type';
  String _status = 'Status';

  final Set<int> _selectedLicenses = <int>{};

  final List<_License> _licenses = const [
    _License(
      keyValue: 'LIC-4421-MNPR',
      organization: '123 Inc',
      plan: 'Standard',
      seats: '50 Seats',
      type: '123 Inc',
      expiry: 'Nov 02, 2024',
      status: 'Active',
    ),
    _License(
      keyValue: 'LIC-4421-MNPR',
      organization: '123 Inc',
      plan: 'Standard',
      seats: '50 Seats',
      type: '123 Inc',
      expiry: 'Nov 02, 2024',
      status: 'Expiring',
    ),
    _License(
      keyValue: 'LIC-4421-MNPR',
      organization: '123 Inc',
      plan: 'Standard',
      seats: '50 Seats',
      type: '123 Inc',
      expiry: 'Nov 02, 2024',
      status: 'Expiring',
    ),
    _License(
      keyValue: 'LIC-4421-MNPR',
      organization: '123 Inc',
      plan: 'Standard',
      seats: '50 Seats',
      type: '123 Inc',
      expiry: 'Nov 02, 2024',
      status: 'Rejected',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isMobile = constraints.maxWidth < 850;

              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.all(isMobile ? 12 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPageHeader(isMobile),
                    SizedBox(height: isMobile ? 16 : 22),
                    _buildKpiSection(isMobile),
                    SizedBox(height: isMobile ? 16 : 22),
                    _buildLicenseSection(isMobile),
                    SizedBox(height: isMobile ? 14 : 20),
                    _buildBottomActions(isMobile),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PAGE HEADER
  // ============================================================

  Widget _buildPageHeader(bool isMobile) {
    if (isMobile) {
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Platform Administration / License Management',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Text(
                  'License Management',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppTheme.text,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: _refresh,
            icon: const Icon(
              Icons.refresh_outlined,
              size: 22,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Platform Administration  /  License Management',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
              ),
              const SizedBox(height: 7),
              Text(
                'License Management',
                style: TextStyle(
                  color: AppTheme.text,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Manage platform license across organizations and tenants',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
              ),
            ],
          ),
        ),
        OutlinedButton.icon(
          onPressed: _refresh,
          icon: const Icon(Icons.refresh_outlined, size: 18),
          label: const Text('Refresh'),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: _showExportDialog,
          icon: const Icon(Icons.download_outlined, size: 18),
          label: const Text('Export'),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: _showCreateDialog,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Create License'),
        ),
      ],
    );
  }

  // ============================================================
  // KPI SECTION
  // ============================================================

  Widget _buildKpiSection(bool isMobile) {
    final List<_KpiData> data = [
      const _KpiData(
        title: 'Total Licenses',
        value: '2,458',
        subtitle: '↑ 12% vs last month',
        icon: Icons.key_outlined,
        color: AppTheme.info,
      ),
      const _KpiData(
        title: 'Active Licenses',
        value: '2,104',
        subtitle: '85.6% utilization rate',
        icon: Icons.check_circle_outline,
        color: AppTheme.success,
      ),
      const _KpiData(
        title: 'Expired licenses',
        value: '142',
        subtitle: 'Within next 30 days',
        icon: Icons.warning_amber_outlined,
        color: AppTheme.warning,
      ),
      const _KpiData(
        title: 'Suspended licenses',
        value: '36',
        subtitle: 'Requires admin review',
        icon: Icons.block_outlined,
        color: AppTheme.danger,
      ),
    ];

    if (isMobile) {
      return Column(
        children: [
          for (int i = 0; i < data.length; i++) ...[
            _buildKpiCard(data[i]),
            if (i < data.length - 1) const SizedBox(height: 10),
          ],
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: _buildKpiCard(data[0])),
        const SizedBox(width: 12),
        Expanded(child: _buildKpiCard(data[1])),
        const SizedBox(width: 12),
        Expanded(child: _buildKpiCard(data[2])),
        const SizedBox(width: 12),
        Expanded(child: _buildKpiCard(data[3])),
      ],
    );
  }

  Widget _buildKpiCard(_KpiData item) {
    return Container(
      width: double.infinity,
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.mono(fontSize: 13, color: AppTheme.text),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: item.color.withAlpha(24),
                  shape: BoxShape.circle,
                ),
                child: Icon(item.icon, size: 18, color: item.color),
              ),
            ],
          ),
          const Spacer(),
          Text(
            item.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppTheme.text,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            item.subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: item.title == 'Total Licenses'
                  ? AppTheme.success
                  : AppTheme.textMuted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LICENSE SECTION
  // ============================================================

  Widget _buildLicenseSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 10 : 16),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isMobile ? 'LICENSE LIST' : 'License List',
            style: TextStyle(
              color: isMobile ? AppTheme.textMuted : AppTheme.text,
              fontSize: isMobile ? 12 : 17,
              fontWeight: FontWeight.w700,
              letterSpacing: isMobile ? 0.5 : 0,
            ),
          ),
          SizedBox(height: isMobile ? 10 : 14),
          _buildFilters(isMobile),
          SizedBox(height: isMobile ? 12 : 16),
          if (isMobile) _buildMobileLicenses() else _buildDesktopLicenses(),
          const SizedBox(height: 14),
          _buildPagination(isMobile),
        ],
      ),
    );
  }

  // ============================================================
  // FILTERS
  // ============================================================

  Widget _buildFilters(bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          SizedBox(
            height: 42,
            child: TextField(
              controller: _searchController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, size: 19),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _filter(
                  value: _organization,
                  items: const ['Organization', '123 Inc'],
                  onChanged: (value) {
                    setState(() {
                      _organization = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _filter(
                  value: _licenseType,
                  items: const ['License Type', 'Standard', 'Enterprise'],
                  onChanged: (value) {
                    setState(() {
                      _licenseType = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _filter(
                  value: _status,
                  items: const ['Status', 'Active', 'Expiring', 'Rejected'],
                  onChanged: (value) {
                    setState(() {
                      _status = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 2),
              SizedBox(
                width: 36,
                child: IconButton(
                  onPressed: _clearFilters,
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppTheme.danger,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        SizedBox(
          width: 240,
          height: 40,
          child: TextField(
            controller: _searchController,
            onChanged: (_) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search, size: 18),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _filter(
          width: 145,
          value: _organization,
          items: const ['Organization', '123 Inc'],
          onChanged: (value) {
            setState(() {
              _organization = value;
            });
          },
        ),
        const SizedBox(width: 8),
        _filter(
          width: 145,
          value: _licenseType,
          items: const ['License Type', 'Standard', 'Enterprise'],
          onChanged: (value) {
            setState(() {
              _licenseType = value;
            });
          },
        ),
        const SizedBox(width: 8),
        _filter(
          width: 110,
          value: _status,
          items: const ['Status', 'Active', 'Expiring', 'Rejected'],
          onChanged: (value) {
            setState(() {
              _status = value;
            });
          },
        ),
      ],
    );
  }

  Widget _filter({
    double? width,
    required String value,
    required List<String> items,
    required ValueChanged<String> onChanged,
  }) {
    return SizedBox(
      width: width,
      height: 40,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 9),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ============================================================
  // MOBILE LICENSE CARDS
  // ============================================================

  Widget _buildMobileLicenses() {
    return Column(
      children: [
        for (int index = 0; index < _licenses.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildMobileLicenseCard(_licenses[index], index),
          ),
      ],
    );
  }

  Widget _buildMobileLicenseCard(_License license, int index) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  license.keyValue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.mono(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.ink,
                  ),
                ),
              ),
              const SizedBox(width: 7),
              _statusBadge(license.status),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            '${license.plan} · ${license.seats}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppTheme.textMuted, fontSize: 11),
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Expanded(child: _info('Org Plan', license.organization)),
              const SizedBox(width: 10),
              Expanded(child: _info('Expires', license.expiry)),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Expanded(
                child: _action(
                  Icons.autorenew_outlined,
                  'Renew',
                  AppTheme.ink,
                  () => _showRenewDialog(index),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _action(
                  Icons.pause_circle_outline,
                  'Suspend',
                  AppTheme.warning,
                  () => _showSuspendDialog(index),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _action(
                  Icons.play_circle_outline,
                  'Activate',
                  AppTheme.success,
                  () => _showActivateDialog(index),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: AppTheme.textMuted, fontSize: 10),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppTheme.text,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _action(
    IconData icon,
    String label,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      height: 38,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          foregroundColor: color,
          side: BorderSide(color: color.withAlpha(70)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: Icon(icon, size: 15),
        label: Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP LICENSE TABLE
  // ============================================================

  Widget _buildDesktopLicenses() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1050,
          child: Column(
            children: [
              Container(
                height: 58,
                color: AppTheme.ink3,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Row(
                  children: [
                    SizedBox(width: 220, child: _HeaderText('LICENSE KEY')),
                    SizedBox(
                      width: 220,
                      child: _HeaderText('ORGANIZATION PLAN'),
                    ),
                    SizedBox(width: 200, child: _HeaderText('LICENSE TYPE')),
                    SizedBox(width: 190, child: _HeaderText('EXPIRY DATE')),
                    Expanded(child: _HeaderText('LICENSE STATUS')),
                  ],
                ),
              ),
              for (int index = 0; index < _licenses.length; index++)
                _buildDesktopRow(_licenses[index], index),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopRow(_License license, int index) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppTheme.paper,
        border: Border(bottom: BorderSide(color: AppTheme.border)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 220,
            child: Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: Checkbox(
                    value: _selectedLicenses.contains(index),
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _selectedLicenses.add(index);
                        } else {
                          _selectedLicenses.remove(index);
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    license.keyValue,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.mono(fontSize: 12, color: AppTheme.text),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 220,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  license.plan,
                  style: const TextStyle(
                    color: AppTheme.text,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  license.seats,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              license.type,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.mono(fontSize: 12, color: AppTheme.text),
            ),
          ),
          SizedBox(
            width: 190,
            child: Text(
              license.expiry,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.mono(fontSize: 12, color: AppTheme.text),
            ),
          ),
          Expanded(child: _statusBadge(license.status)),
        ],
      ),
    );
  }

  // ============================================================
  // STATUS
  // ============================================================

  Widget _statusBadge(String status) {
    Color color;
    Color background;

    switch (status.toLowerCase()) {
      case 'active':
        color = AppTheme.success;
        background = AppTheme.success.withAlpha(24);
        break;
      case 'expiring':
        color = AppTheme.warning;
        background = AppTheme.warning.withAlpha(28);
        break;
      case 'rejected':
        color = AppTheme.danger;
        background = AppTheme.danger.withAlpha(24);
        break;
      default:
        color = AppTheme.info;
        background = AppTheme.info.withAlpha(24);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            status,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PAGINATION
  // ============================================================

  Widget _buildPagination(bool isMobile) {
    return Row(
      children: [
        Expanded(
          child: Text(
            isMobile
                ? 'Showing 1–5 of 65 features'
                : 'Showing 1 to 5 of 2,458 entries',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppTheme.textMuted, fontSize: 10),
          ),
        ),
        const SizedBox(width: 5),
        _pageButton(icon: Icons.chevron_left),
        const SizedBox(width: 4),
        _pageButton(text: '1', selected: true),
        const SizedBox(width: 4),
        _pageButton(text: '2'),
        const SizedBox(width: 4),
        _pageButton(text: '3'),
        const SizedBox(width: 4),
        _pageButton(icon: Icons.chevron_right),
      ],
    );
  }

  Widget _pageButton({String? text, IconData? icon, bool selected = false}) {
    return SizedBox(
      width: 32,
      height: 32,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: selected ? AppTheme.ink3 : AppTheme.paper,
          foregroundColor: selected ? Colors.white : AppTheme.text,
          side: BorderSide(color: selected ? AppTheme.ink3 : AppTheme.border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: icon != null
            ? Icon(icon, size: 16)
            : Text(text ?? '', style: const TextStyle(fontSize: 11)),
      ),
    );
  }

  // ============================================================
  // BOTTOM ACTIONS
  // ============================================================

  Widget _buildBottomActions(bool isMobile) {
    if (isMobile) {
      return Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 46,
              child: OutlinedButton.icon(
                onPressed: _showExportDialog,
                icon: const Icon(Icons.download_outlined, size: 17),
                label: const Text('Export'),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 46,
              child: ElevatedButton.icon(
                onPressed: _showCreateDialog,
                icon: const Icon(Icons.add, size: 18),
                label: const Text(
                  'Create License',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        OutlinedButton.icon(
          onPressed: _selectedLicenses.isEmpty
              ? null
              : () {
                  _showRenewDialog(_selectedLicenses.first);
                },
          icon: const Icon(Icons.autorenew_outlined, size: 17),
          label: const Text('Renew'),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: _selectedLicenses.isEmpty
              ? null
              : () {
                  _showSuspendDialog(_selectedLicenses.first);
                },
          icon: const Icon(Icons.pause_circle_outline, size: 17),
          label: const Text('Suspend'),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: _selectedLicenses.isEmpty
              ? null
              : () {
                  _showActivateDialog(_selectedLicenses.first);
                },
          icon: const Icon(Icons.play_circle_outline, size: 17),
          label: const Text('Activate'),
        ),
      ],
    );
  }

  // ============================================================
  // FILTER HELPERS
  // ============================================================

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _organization = 'Organization';
      _licenseType = 'License Type';
      _status = 'Status';
    });
  }

  void _refresh() {
    setState(() {});
  }

  // ============================================================
  // CREATE DIALOG
  // ============================================================

  void _showCreateDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _SimpleDialogBox(
          title: 'Create License',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create a new platform license.',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 18),
              _dialogLabel('Organization'),
              const SizedBox(height: 6),
              _dialogDropdown('Select Organization'),
              const SizedBox(height: 12),
              _dialogLabel('Organization Plan'),
              const SizedBox(height: 6),
              _dialogDropdown('Standard'),
              const SizedBox(height: 12),
              _dialogLabel('License Type'),
              const SizedBox(height: 6),
              _dialogDropdown('Enterprise'),
              const SizedBox(height: 12),
              _dialogLabel('Number of Seats'),
              const SizedBox(height: 6),
              _dialogField('50'),
              const SizedBox(height: 12),
              _dialogLabel('Expiry Date'),
              const SizedBox(height: 6),
              _dialogField('Nov 02, 2027'),
            ],
          ),
          actionText: 'Create',
          onAction: () {
            Navigator.pop(dialogContext);
            _message('License created successfully.');
          },
        );
      },
    );
  }

  // ============================================================
  // EXPORT DIALOG
  // ============================================================

  void _showExportDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _SimpleDialogBox(
          title: 'Export Options',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select the report format.',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 18),
              _dialogLabel('Format'),
              const SizedBox(height: 6),
              _dialogDropdown('Excel (XLSX)'),
              const SizedBox(height: 12),
              _dialogLabel('Date Range'),
              const SizedBox(height: 6),
              _dialogField('Sep 01, 2026 - Sep 01, 2027'),
            ],
          ),
          actionText: 'Download Export',
          onAction: () {
            Navigator.pop(dialogContext);
            _message('Export downloaded successfully.');
          },
        );
      },
    );
  }

  // ============================================================
  // ACTION DIALOGS
  // ============================================================

  void _showRenewDialog(int index) {
    _showLicenseActionDialog(
      title: 'Renew License',
      action: 'Renew',
      license: _licenses[index],
      onDone: () {
        _message('License renewed successfully.');
      },
    );
  }

  void _showSuspendDialog(int index) {
    _showLicenseActionDialog(
      title: 'Suspend License',
      action: 'Suspend',
      license: _licenses[index],
      onDone: () {
        _message('License suspended successfully.');
      },
    );
  }

  void _showActivateDialog(int index) {
    _showLicenseActionDialog(
      title: 'Activate License',
      action: 'Activate',
      license: _licenses[index],
      onDone: () {
        _message('License activated successfully.');
      },
    );
  }

  void _showLicenseActionDialog({
    required String title,
    required String action,
    required _License license,
    required VoidCallback onDone,
  }) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _SimpleDialogBox(
          title: title,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selected License',
                style: TextStyle(
                  color: AppTheme.text,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.paperDim,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      license.keyValue,
                      style: AppTheme.mono(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${license.plan} · ${license.seats}',
                      style: const TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _statusBadge(license.status),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _dialogLabel('Reason'),
              const SizedBox(height: 6),
              _dialogField('Enter the reason'),
            ],
          ),
          actionText: action,
          onAction: () {
            Navigator.pop(dialogContext);
            onDone();
          },
        );
      },
    );
  }

  // ============================================================
  // DIALOG HELPERS
  // ============================================================

  Widget _dialogLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppTheme.text,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _dialogField(String hint) {
    return SizedBox(
      height: 42,
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _dialogDropdown(String value) {
    return SizedBox(
      height: 42,
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        onChanged: (_) {},
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        items: [
          DropdownMenuItem<String>(
            value: value,
            child: Text(value, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  void _message(String text) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

// ============================================================
// SIMPLE DIALOG
// ============================================================

class _SimpleDialogBox extends StatelessWidget {
  final String title;
  final Widget child;
  final String actionText;
  final VoidCallback onAction;

  const _SimpleDialogBox({
    required this.title,
    required this.child,
    required this.actionText,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.of(context).size.width < 600;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: mobile ? 12 : 30,
        vertical: 20,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 520,
          maxHeight: MediaQuery.of(context).size.height * 0.88,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(mobile ? 16 : 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppTheme.text,
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              child,
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.end,
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(onPressed: onAction, child: Text(actionText)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// TABLE HEADER
// ============================================================

class _HeaderText extends StatelessWidget {
  final String text;

  const _HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

// ============================================================
// DATA
// ============================================================

class _License {
  final String keyValue;
  final String organization;
  final String plan;
  final String seats;
  final String type;
  final String expiry;
  final String status;

  const _License({
    required this.keyValue,
    required this.organization,
    required this.plan,
    required this.seats,
    required this.type,
    required this.expiry,
    required this.status,
  });
}

class _KpiData {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _KpiData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}
