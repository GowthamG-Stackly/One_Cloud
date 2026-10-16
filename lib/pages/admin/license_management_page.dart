import 'dart:convert';
import 'dart:typed_data';

import 'package:excel/excel.dart' as xl;
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pw;

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

  // Shared in-memory license store: keeps edits when this page is rebuilt or revisited.
  // For persistence across app restarts, connect this store to local storage or a backend.
  static final List<_License> _licenses = [
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

  List<MapEntry<int, _License>> get _filteredLicenses {
    final query = _searchController.text.trim().toLowerCase();

    return _licenses.asMap().entries.where((entry) {
      final license = entry.value;
      final matchesSearch =
          query.isEmpty ||
          <String>[
            license.keyValue,
            license.organization,
            license.plan,
            license.seats,
            license.type,
            license.expiry,
            license.status,
          ].any((value) => value.toLowerCase().contains(query));

      final matchesOrganization =
          _organization == 'Organization' ||
          license.organization.toLowerCase() == _organization.toLowerCase();

      // The existing UI's license-type choices overlap with plan names, so
      // accept either the type field or the plan field for those selections.
      final matchesType =
          _licenseType == 'License Type' ||
          license.type.toLowerCase() == _licenseType.toLowerCase() ||
          license.plan.toLowerCase() == _licenseType.toLowerCase();

      final matchesStatus =
          _status == 'Status' ||
          license.status.toLowerCase() == _status.toLowerCase();

      return matchesSearch &&
          matchesOrganization &&
          matchesType &&
          matchesStatus;
    }).toList();
  }

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

        ElevatedButton.icon(
          onPressed: _showExportDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.ink,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
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

                  items: _organizationFilterItems,

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

                  items: _licenseTypeFilterItems,

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

                  items: _statusFilterItems,

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

          items: _organizationFilterItems,

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

          items: _licenseTypeFilterItems,

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

          items: _statusFilterItems,

          onChanged: (value) {
            setState(() {
              _status = value;
            });
          },
        ),
      ],
    );
  }

  // Build filter options from the current records so edits and newly created
  // licenses are reflected in the dropdowns immediately.
  List<String> get _organizationFilterItems {
    final values = _licenses
        .map((license) => license.organization.trim())
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return ['Organization', ...values];
  }

  List<String> get _licenseTypeFilterItems {
    final values = <String>{
      ..._licenses.map((license) => license.type.trim()),
      ..._licenses.map((license) => license.plan.trim()),
    }.where((value) => value.isNotEmpty).toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return ['License Type', ...values];
  }

  List<String> get _statusFilterItems {
    final values = _licenses
        .map((license) => license.status.trim())
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return ['Status', ...values];
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
    final filtered = _filteredLicenses;
    if (filtered.isEmpty) {
      return _buildEmptySearchResult();
    }

    return Column(
      children: [
        for (final entry in filtered)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildMobileLicenseCard(entry.value, entry.key),
          ),
      ],
    );
  }

  Widget _buildEmptySearchResult() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.search_off_outlined,
            size: 30,
            color: AppTheme.textMuted,
          ),
          const SizedBox(height: 8),
          const Text(
            'No licenses found',
            style: TextStyle(color: AppTheme.text, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          const Text(
            'Try a different search term or clear the filters.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
          ),
          const SizedBox(height: 10),
          TextButton.icon(
            onPressed: _clearFilters,
            icon: const Icon(Icons.filter_alt_off_outlined, size: 16),
            label: const Text('Clear filters'),
          ),
        ],
      ),
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
              const SizedBox(width: 4),
              IconButton(
                tooltip: 'Edit license',
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints.tightFor(
                  width: 34,
                  height: 34,
                ),
                padding: EdgeInsets.zero,
                onPressed: () => _showEditLicenseDialog(index),
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: AppTheme.ink,
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Text(
            license.organization,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppTheme.text,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 3),

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
          width: 1190,

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

                    SizedBox(width: 120, child: _HeaderText('LICENSE STATUS')),
                    SizedBox(width: 90, child: _HeaderText('ACTIONS')),
                  ],
                ),
              ),

              if (_filteredLicenses.isEmpty)
                SizedBox(
                  width: double.infinity,
                  child: _buildEmptySearchResult(),
                )
              else
                for (final entry in _filteredLicenses)
                  _buildDesktopRow(entry.value, entry.key),
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
                  license.organization,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.text,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  '${license.plan} · ${license.seats}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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

          SizedBox(width: 120, child: _statusBadge(license.status)),
          SizedBox(
            width: 90,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                tooltip: 'Edit license',
                onPressed: () => _showEditLicenseDialog(index),
                icon: const Icon(
                  Icons.edit_outlined,
                  color: AppTheme.ink,
                  size: 19,
                ),
              ),
            ),
          ),
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
            _filteredLicenses.isEmpty
                ? 'Showing 0 of ${_licenses.length} licenses'
                : 'Showing ${_filteredLicenses.length} of ${_licenses.length} licenses',

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

              child: ElevatedButton.icon(
                onPressed: _showExportDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.ink,
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
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
    String organization = '123 Inc';
    String plan = 'Standard';
    String type = 'Enterprise';
    String status = 'Active';
    bool autoRenew = true;
    final seatsController = TextEditingController(text: '50');
    DateTime startDate = DateTime(2026, 9, 1);
    DateTime expiryDate = DateTime(2027, 9, 1);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => _SimpleDialogBox(
          title: 'Create License',
          actionText: 'Create',
          onAction: () {
            final seats = int.tryParse(seatsController.text.trim()) ?? 0;
            if (seats < 1 || !expiryDate.isAfter(startDate)) {
              _message('Enter a valid seat count and expiry date.');
              return;
            }
            setState(
              () => _licenses.insert(
                0,
                _License(
                  keyValue:
                      'LIC-${DateTime.now().millisecondsSinceEpoch % 1000000}-NEW',
                  organization: organization,
                  plan: plan,
                  seats: '$seats Seats',
                  type: type,
                  expiry: _formatLicenseDate(expiryDate),
                  status: status,
                ),
              ),
            );
            Navigator.of(dialogContext, rootNavigator: true).pop();
            _message('License created successfully.');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dialogLabel('Organization'),
              const SizedBox(height: 6),
              _licenseDropdown(organization, [
                '123 Inc',
                'ABC Pvt Ltd',
                'XYZ Ltd',
                'Demo Company',
              ], (v) => setDialogState(() => organization = v)),
              const SizedBox(height: 12),
              _dialogLabel('Organization Plan'),
              const SizedBox(height: 6),
              _licenseDropdown(plan, [
                'Standard',
                'Professional',
                'Enterprise',
                'Custom',
              ], (v) => setDialogState(() => plan = v)),
              const SizedBox(height: 12),
              _dialogLabel('License Type'),
              const SizedBox(height: 6),
              _licenseDropdown(type, [
                'Trial',
                'Free',
                'Standard',
                'Professional',
                'Enterprise',
                'Custom',
              ], (v) => setDialogState(() => type = v)),
              const SizedBox(height: 12),
              _dialogLabel('Number of Seats'),
              const SizedBox(height: 6),
              TextField(
                controller: seatsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '50',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              _dialogLabel('License Status'),
              const SizedBox(height: 6),
              _licenseDropdown(status, [
                'Active',
                'Pending',
                'Suspended',
                'Expired',
              ], (v) => setDialogState(() => status = v)),
              const SizedBox(height: 12),
              _dialogLabel('Start Date'),
              const SizedBox(height: 6),
              _licenseDateButton(
                context,
                startDate,
                (v) => setDialogState(() {
                  startDate = v;
                  if (!expiryDate.isAfter(v))
                    expiryDate = DateTime(v.year + 1, v.month, v.day);
                }),
              ),
              const SizedBox(height: 12),
              _dialogLabel('Expiry Date'),
              const SizedBox(height: 6),
              _licenseDateButton(
                context,
                expiryDate,
                (v) => setDialogState(() => expiryDate = v),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Expanded(child: Text('Auto Renewal')),
                  Switch(
                    value: autoRenew,
                    onChanged: (v) => setDialogState(() => autoRenew = v),
                  ),
                  Text(autoRenew ? 'ON' : 'OFF'),
                ],
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(seatsController.dispose);
  }

  void _showEditLicenseDialog(int index) {
    final license = _licenses[index];
    String organization = license.organization;
    String plan = license.plan;
    String type = license.type;
    String status = license.status;
    final seatsController = TextEditingController(
      text: license.seats.replaceAll(RegExp(r'[^0-9]'), ''),
    );
    DateTime expiryDate =
        _parseLicenseDate(license.expiry) ??
        DateTime.now().add(const Duration(days: 365));

    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => _SimpleDialogBox(
          title: 'Edit License',
          actionText: 'Save Changes',
          onAction: () {
            final seats = int.tryParse(seatsController.text.trim()) ?? 0;
            if (seats < 1) {
              _message('Enter a valid number of seats.');
              return;
            }
            setState(() {
              license.organization = organization;
              license.plan = plan;
              license.type = type;
              license.seats = '$seats Seats';
              license.expiry = _formatLicenseDate(expiryDate);
              license.status = status;

              // Keep filters valid after editing values used by the dropdowns.
              if (!_organizationFilterItems.contains(_organization)) {
                _organization = 'Organization';
              }
              if (!_licenseTypeFilterItems.contains(_licenseType)) {
                _licenseType = 'License Type';
              }
              if (!_statusFilterItems.contains(_status)) {
                _status = 'Status';
              }
            });
            Navigator.of(dialogContext, rootNavigator: true).pop();
            _message('License details updated successfully.');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dialogLabel('License Key'),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.paperDim,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Text(
                  license.keyValue,
                  style: AppTheme.mono(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _dialogLabel('Organization'),
              const SizedBox(height: 6),
              _licenseDropdown(organization, [
                '123 Inc',
                'ABC Pvt Ltd',
                'XYZ Ltd',
                'Demo Company',
              ], (v) => setDialogState(() => organization = v)),
              const SizedBox(height: 12),
              _dialogLabel('Organization Plan'),
              const SizedBox(height: 6),
              _licenseDropdown(plan, [
                'Standard',
                'Professional',
                'Enterprise',
                'Custom',
              ], (v) => setDialogState(() => plan = v)),
              const SizedBox(height: 12),
              _dialogLabel('License Type'),
              const SizedBox(height: 6),
              _licenseDropdown(type, [
                '123 Inc',
                'Trial',
                'Free',
                'Standard',
                'Professional',
                'Enterprise',
                'Custom',
              ], (v) => setDialogState(() => type = v)),
              const SizedBox(height: 12),
              _dialogLabel('Number of Seats'),
              const SizedBox(height: 6),
              TextField(
                controller: seatsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '50',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              _dialogLabel('License Status'),
              const SizedBox(height: 6),
              _licenseDropdown(status, [
                'Active',
                'Expiring',
                'Pending',
                'Suspended',
                'Expired',
                'Rejected',
              ], (v) => setDialogState(() => status = v)),
              const SizedBox(height: 12),
              _dialogLabel('Expiry Date'),
              const SizedBox(height: 6),
              _licenseDateButton(
                context,
                expiryDate,
                (v) => setDialogState(() => expiryDate = v),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(seatsController.dispose);
  }

  DateTime? _parseLicenseDate(String value) {
    const months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };
    final match = RegExp(r'^(\w{3})\s+(\d{1,2}),\s*(\d{4})$')
        .firstMatch(value.trim());
    if (match == null) return null;
    final month = months[match.group(1)];
    final day = int.tryParse(match.group(2)!);
    final year = int.tryParse(match.group(3)!);
    if (month == null || day == null || year == null) return null;
    return DateTime(year, month, day);
  }

  void _showExportDialog() {
    final selected = <String>{
      'License Key',
      'Organization Plan',
      'License Type',
      'Expiry Date',
      'License Status',
    };
    String format = 'Excel (XLSX)';
    DateTime startDate = DateTime(2026, 9, 1);
    DateTime endDate = DateTime(2027, 9, 1);
    bool isExporting = false;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => _SimpleDialogBox(
          title: 'Export Options',
          actionText: isExporting ? 'Preparing...' : 'Download Export',
          onAction: isExporting
              ? () {}
              : () async {
                  if (selected.isEmpty) {
                    _message('Select at least one data field.');
                    return;
                  }
                  if (endDate.isBefore(startDate)) {
                    _message('End date must be on or after start date.');
                    return;
                  }
                  setDialogState(() => isExporting = true);
                  try {
                    await _exportLicenses(
                      fields: selected.toList(),
                      format: format,
                      startDate: startDate,
                      endDate: endDate,
                    );
                    if (dialogContext.mounted) {
                      Navigator.of(dialogContext, rootNavigator: true).pop();
                    }
                    _message('$format license report downloaded successfully.');
                  } catch (error) {
                    if (dialogContext.mounted) {
                      setDialogState(() => isExporting = false);
                    }
                    _message('Export failed: $error');
                  }
                },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dialogLabel('Specific Data'),
              const SizedBox(height: 8),
              for (final field in [
                'License Key',
                'Organization Plan',
                'License Type',
                'Expiry Date',
                'License Status',
              ])
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(field),
                  value: selected.contains(field),
                  onChanged: isExporting
                      ? null
                      : (v) => setDialogState(() {
                          if (v == true) {
                            selected.add(field);
                          } else {
                            selected.remove(field);
                          }
                        }),
                ),
              const SizedBox(height: 8),
              _dialogLabel('Report Date Range'),
              const SizedBox(height: 8),
              LayoutBuilder(
                builder: (context, c) {
                  final start = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Start Date'),
                      const SizedBox(height: 5),
                      _licenseDateButton(
                        context,
                        startDate,
                        (v) => setDialogState(() => startDate = v),
                      ),
                    ],
                  );
                  final end = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('End Date'),
                      const SizedBox(height: 5),
                      _licenseDateButton(
                        context,
                        endDate,
                        (v) => setDialogState(() => endDate = v),
                      ),
                    ],
                  );
                  return c.maxWidth < 430
                      ? Column(
                          children: [start, const SizedBox(height: 10), end],
                        )
                      : Row(
                          children: [
                            Expanded(child: start),
                            const SizedBox(width: 10),
                            Expanded(child: end),
                          ],
                        );
                },
              ),
              const SizedBox(height: 16),
              _dialogLabel('Select Format'),
              const SizedBox(height: 6),
              for (final option in [
                'CSV (Comma-Separated Values)',
                'PDF',
                'Excel (XLSX)',
              ])
                RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  value: option,
                  groupValue: format,
                  title: Text(option),
                  onChanged: isExporting
                      ? null
                      : (v) => setDialogState(() => format = v!),
                ),
              if (isExporting) ...[
                const SizedBox(height: 8),
                const LinearProgressIndicator(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _exportLicenses({
    required List<String> fields,
    required String format,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final headers = <String, String>{
      'License Key': 'License Key',
      'Organization Plan': 'Organization Plan',
      'License Type': 'License Type',
      'Expiry Date': 'Expiry Date',
      'License Status': 'License Status',
    };
    final exportFields = headers.keys.where(fields.contains).toList();
    final chosenHeaders = exportFields.map((key) => headers[key]!).toList();

    String valueFor(_License license, String field) {
      switch (field) {
        case 'License Key':
          return license.keyValue;
        case 'Organization Plan':
          return '${license.plan} (${license.seats})';
        case 'License Type':
          return license.type;
        case 'Expiry Date':
          return license.expiry;
        case 'License Status':
          return license.status;
        default:
          return '';
      }
    }

    // Export the currently available license records. The selected date range
    // is included as report metadata because this demo model has expiry dates,
    // not license-created/updated timestamps to filter reliably.
    final rows = _licenses.map((license) {
      return exportFields.map((field) => valueFor(license, field)).toList();
    }).toList();
    final rangeLabel =
        '${_formatLicenseDate(startDate)} - ${_formatLicenseDate(endDate)}';
    final stamp = DateTime.now().toIso8601String().split('T').first;
    final baseName = 'onecloud_license_management_$stamp';

    if (format == 'CSV (Comma-Separated Values)') {
      String csvCell(String value) => '"${value.replaceAll('"', '""')}"';
      final content = <String>[
        csvCell('License Management Report'),
        csvCell('Report Date Range: $rangeLabel'),
        chosenHeaders.map(csvCell).join(','),
        ...rows.map((row) => row.map(csvCell).join(',')),
      ].join('\r\n');
      await FileSaver.instance.saveFile(
        name: baseName,
        bytes: Uint8List.fromList([0xEF, 0xBB, 0xBF, ...utf8.encode(content)]),
        fileExtension: 'csv',
        mimeType: MimeType.csv,
      );
      return;
    }

    if (format == 'PDF') {
      final document = pw.Document();
      document.addPage(
        pw.MultiPage(
          build: (context) => [
            pw.Text(
              'License Management Report',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 6),
            pw.Text('Report date range: $rangeLabel'),
            pw.SizedBox(height: 16),
            pw.TableHelper.fromTextArray(
              headers: chosenHeaders,
              data: rows,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration: const pw.BoxDecoration(
                color: pdf.PdfColor.fromInt(0xFFEAF2FF),
              ),
              cellStyle: const pw.TextStyle(fontSize: 9),
              cellAlignment: pw.Alignment.centerLeft,
            ),
            pw.SizedBox(height: 12),
            pw.Text('Total licenses exported: ${rows.length}'),
          ],
        ),
      );
      await FileSaver.instance.saveFile(
        name: baseName,
        bytes: await document.save(),
        fileExtension: 'pdf',
        mimeType: MimeType.pdf,
      );
      return;
    }

    final workbook = xl.Excel.createExcel();
    // Rename the default active sheet instead of creating a second sheet.
    // This ensures Excel opens on the sheet that contains the exported data.
    workbook.rename('Sheet1', 'License Management');
    final sheet = workbook['License Management'];
    sheet.appendRow([xl.TextCellValue('License Management Report')]);
    sheet.appendRow([xl.TextCellValue('Report Date Range: $rangeLabel')]);
    sheet.appendRow(
      chosenHeaders.map((value) => xl.TextCellValue(value)).toList(),
    );
    for (final row in rows) {
      sheet.appendRow(row.map((value) => xl.TextCellValue(value)).toList());
    }
    // Explicitly keep the populated sheet as the workbook's default sheet.
    workbook.setDefaultSheet('License Management');
    final bytes = workbook.encode();
    if (bytes == null) {
      throw Exception('Could not generate the Excel workbook.');
    }
    await FileSaver.instance.saveFile(
      name: baseName,
      bytes: Uint8List.fromList(bytes),
      fileExtension: 'xlsx',
      mimeType: MimeType.microsoftExcel,
    );
  }

  void _showRenewDialog(int index) {
    _showLicenseActionDialog(
      title: 'Renew License',
      action: 'Renew',
      license: _licenses[index],
      onDone: () {
        setState(() => _licenses[index].status = 'Active');
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
        setState(() => _licenses[index].status = 'Suspended');
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
        setState(() => _licenses[index].status = 'Active');
        _message('License activated successfully.');
      },
    );
  }

  Future<bool?> _confirmLicenseAction({
    required String title,
    required String description,
    required String action,
    required IconData icon,
    required Color color,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withAlpha(24),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 21),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppTheme.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          description,
          style: const TextStyle(
            color: AppTheme.textMuted,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('No, Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.ink,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text('Yes, $action'),
          ),
        ],
      ),
    );
  }

  void _showLicenseActionDialog({
    required String title,
    required String action,
    required _License license,
    required VoidCallback onDone,
  }) {
    String period = '1 Year';
    DateTime newExpiry = DateTime.now().add(const Duration(days: 365));
    final reasonController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => _SimpleDialogBox(
          title: title,
          actionText: action,
          onAction: () async {
            if ((action == 'Renew' || action == 'Suspend') &&
                reasonController.text.trim().isEmpty) {
              _message('Please enter a reason.');
              return;
            }

            final descriptions = <String, String>{
              'Renew':
                  'Are you sure you want to renew license ${license.keyValue}? '
                  'The expiry date will be updated to ${_formatLicenseDate(newExpiry)}.',
              'Suspend':
                  'Are you sure you want to suspend license ${license.keyValue}? '
                  'The organization may lose access to services until the license is activated again.',
              'Activate':
                  'Are you sure you want to activate license ${license.keyValue}? '
                  'This will restore access for the organization associated with this license.',
            };
            final details = <String, (IconData, Color)>{
              'Renew': (Icons.autorenew_outlined, AppTheme.info),
              'Suspend': (Icons.pause_circle_outline, AppTheme.warning),
              'Activate': (Icons.play_circle_outline, AppTheme.success),
            }[action]!;

            final confirmed = await _confirmLicenseAction(
              title: 'Confirm $action?',
              description: descriptions[action]!,
              action: action,
              icon: details.$1,
              color: details.$2,
            );
            if (confirmed != true || !mounted) return;

            if (action == 'Renew') {
              license.expiry = _formatLicenseDate(newExpiry);
            }
            Navigator.of(dialogContext, rootNavigator: true).pop();
            onDone();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dialogLabel('Selected License'),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.paperDim,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      license.keyValue,
                      style: AppTheme.mono(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Current Expiry: ${license.expiry}',
                      style: const TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${license.plan} · ${license.seats}',
                      style: const TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _statusBadge(license.status),
                  ],
                ),
              ),
              if (action == 'Renew') ...[
                const SizedBox(height: 14),
                _dialogLabel('Renew Period'),
                const SizedBox(height: 6),
                _licenseDropdown(
                  period,
                  ['6 Months', '1 Year', '2 Years', '3 Years'],
                  (v) => setDialogState(() {
                    period = v;
                    final days = v == '6 Months'
                        ? 182
                        : v == '2 Years'
                        ? 730
                        : v == '3 Years'
                        ? 1095
                        : 365;
                    newExpiry = DateTime.now().add(Duration(days: days));
                  }),
                ),
                const SizedBox(height: 12),
                _dialogLabel('New Expiry Date'),
                const SizedBox(height: 6),
                _licenseDateButton(
                  context,
                  newExpiry,
                  (v) => setDialogState(() => newExpiry = v),
                ),
              ],
              if (action == 'Renew' || action == 'Suspend') ...[
                const SizedBox(height: 14),
                _dialogLabel(
                  action == 'Renew' ? 'Renew Reason' : 'Suspend Reason',
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: reasonController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Enter the reason',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
              if (action == 'Activate') ...[
                const SizedBox(height: 14),
                const Text(
                  'This will restore access for the selected license.',
                  style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                ),
              ],
            ],
          ),
        ),
      ),
    ).whenComplete(reasonController.dispose);
  }

  Widget _licenseDropdown(
    String value,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: options
          .map(
            (v) => DropdownMenuItem<String>(
              value: v,
              child: Text(v, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }

  Widget _licenseDateButton(
    BuildContext context,
    DateTime date,
    ValueChanged<DateTime> onChanged,
  ) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          side: BorderSide(color: AppTheme.border),
        ),
        onPressed: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
          );
          if (picked != null) onChanged(picked);
        },
        icon: const Icon(Icons.calendar_month_outlined, size: 17),
        label: Text(_formatLicenseDate(date), overflow: TextOverflow.ellipsis),
      ),
    );
  }

  String _formatLicenseDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}';
  }

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

  String organization;

  String plan;

  String seats;

  String type;

  String expiry;

  String status;

  _License({
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
