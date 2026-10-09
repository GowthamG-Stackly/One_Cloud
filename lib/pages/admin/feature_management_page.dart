import 'package:flutter/material.dart';

import '../../app_theme.dart';

class FeatureManagementPage extends StatefulWidget {
  const FeatureManagementPage({super.key});

  @override
  State<FeatureManagementPage> createState() => _FeatureManagementPageState();
}

class _FeatureManagementPageState extends State<FeatureManagementPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<_FeatureItem> _features = [
    _FeatureItem(
      name: 'User Management',
      module: 'Identity',
      license: 'Enterprise',
      enabled: true,
    ),
    _FeatureItem(
      name: 'Workflow Engine',
      module: 'Workflow',
      license: 'Enterprise',
      enabled: true,
    ),
    _FeatureItem(
      name: 'AI Assistant',
      module: 'AI Services',
      license: 'Premium',
      enabled: false,
    ),
    _FeatureItem(
      name: 'Reports',
      module: 'Analytics',
      license: 'Standard',
      enabled: true,
    ),
    _FeatureItem(
      name: 'API Access',
      module: 'Integration',
      license: 'Enterprise',
      enabled: true,
    ),
  ];

  String _selectedModule = 'All Modules';
  String _selectedLicense = 'All License Plans';
  String _selectedStatus = 'All Status';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_FeatureItem> get _filteredFeatures {
    final search = _searchController.text.trim().toLowerCase();

    return _features.where((feature) {
      final matchesSearch =
          search.isEmpty ||
          feature.name.toLowerCase().contains(search) ||
          feature.module.toLowerCase().contains(search) ||
          feature.license.toLowerCase().contains(search);

      final matchesModule =
          _selectedModule == 'All Modules' || feature.module == _selectedModule;

      final matchesLicense =
          _selectedLicense == 'All License Plans' ||
          feature.license == _selectedLicense;

      final matchesStatus =
          _selectedStatus == 'All Status' ||
          (_selectedStatus == 'Enable' && feature.enabled) ||
          (_selectedStatus == 'Disable' && !feature.enabled);

      return matchesSearch && matchesModule && matchesLicense && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final bool mobile = width < 700;

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  mobile ? 12 : 20,
                  mobile ? 8 : 12,
                  mobile ? 12 : 20,
                  mobile ? 24 : 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPageHeader(mobile),
                    SizedBox(height: mobile ? 14 : 22),
                    _buildKpiSection(mobile),
                    SizedBox(height: mobile ? 10 : 16),
                    _buildFeatureDirectory(mobile),
                    SizedBox(height: mobile ? 18 : 24),
                    if (mobile) _buildMobileExportButton(),
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

  Widget _buildPageHeader(bool mobile) {
    if (mobile) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Platform Administration / Feature Management',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Text(
                  'Feature Management',
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
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Refresh',
            onPressed: _showRefreshDialog,
            icon: Icon(Icons.sync, color: AppTheme.ink, size: 28),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Platform Administration  /  Feature Management',
                    style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Feature Management',
                    style: TextStyle(
                      color: AppTheme.text,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Control platform feature availability, configuration, and access across the enterprise.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: _showRefreshDialog,
              icon: const Icon(Icons.sync, size: 17),
              label: const Text('Refresh'),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _showExportDialog,
              icon: const Icon(Icons.download_outlined, size: 17),
              label: const Text('Export report'),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // KPI CARDS
  // ============================================================

  Widget _buildKpiSection(bool mobile) {
    final cards = [
      _KpiItem(
        title: 'Total Features',
        value: '65',
        change: '+4.2%',
        icon: Icons.tune,
        color: AppTheme.ink,
        positive: true,
      ),
      _KpiItem(
        title: 'Enabled',
        value: '52',
        change: '+3.6%',
        icon: Icons.check_circle_outline,
        color: AppTheme.success,
        positive: true,
      ),
      _KpiItem(
        title: 'Disabled',
        value: '13',
        change: '-7.1%',
        icon: Icons.error_outline,
        color: AppTheme.danger,
        positive: false,
      ),
    ];

    if (mobile) {
      return Column(
        children: cards.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _buildKpiCard(item, mobile: true),
          );
        }).toList(),
      );
    }

    return Row(
      children: [
        Expanded(child: _buildKpiCard(cards[0])),
        const SizedBox(width: 14),
        Expanded(child: _buildKpiCard(cards[1])),
        const SizedBox(width: 14),
        Expanded(child: _buildKpiCard(cards[2])),
      ],
    );
  }

  Widget _buildKpiCard(_KpiItem item, {bool mobile = false}) {
    return Container(
      width: double.infinity,
      height: mobile ? 182 : 142,
      padding: EdgeInsets.all(mobile ? 20 : 22),
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
                  style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: mobile ? 20 : 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(item.icon, color: item.color, size: mobile ? 25 : 22),
            ],
          ),
          const Spacer(),
          Text(
            item.value,
            style: TextStyle(
              color: AppTheme.ink,
              fontSize: mobile ? 40 : 34,
              height: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(
                item.positive ? Icons.arrow_upward : Icons.arrow_downward,
                color: item.positive ? AppTheme.success : AppTheme.danger,
                size: 13,
              ),
              const SizedBox(width: 2),
              Text(
                item.change,
                style: TextStyle(
                  color: item.positive ? AppTheme.success : AppTheme.danger,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'this month',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FEATURE DIRECTORY
  // ============================================================

  Widget _buildFeatureDirectory(bool mobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(mobile ? 12 : 0),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Column(
        children: [
          _buildFilters(mobile),
          const SizedBox(height: 10),
          mobile ? _buildMobileFeatureCards() : _buildDesktopFeatureTable(),
          _buildPagination(mobile),
        ],
      ),
    );
  }

  Widget _buildFilters(bool mobile) {
    if (mobile) {
      return Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search features...',
              prefixIcon: const Icon(Icons.search, size: 21),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close, size: 18),
                    ),
              filled: true,
              fillColor: AppTheme.paper,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
                borderSide: BorderSide(color: AppTheme.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
                borderSide: BorderSide(color: AppTheme.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
                borderSide: BorderSide(color: AppTheme.ink),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _filterButton(_selectedModule, _moduleOptions(), (
                  value,
                ) {
                  setState(() {
                    _selectedModule = value;
                  });
                }),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: _filterButton(_selectedLicense, _licenseOptions(), (
                  value,
                ) {
                  setState(() {
                    _selectedLicense = value;
                  });
                }),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: _filterButton(
                  _selectedStatus,
                  const ['All Status', 'Enable', 'Disable'],
                  (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search features...',
                prefixIcon: const Icon(Icons.search, size: 21),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _filterButton(_selectedModule, _moduleOptions(), (value) {
            setState(() {
              _selectedModule = value;
            });
          }),
          const SizedBox(width: 10),
          _filterButton(_selectedLicense, _licenseOptions(), (value) {
            setState(() {
              _selectedLicense = value;
            });
          }),
          const SizedBox(width: 10),
          _filterButton(
            _selectedStatus,
            const ['All Status', 'Enable', 'Disable'],
            (value) {
              setState(() {
                _selectedStatus = value;
              });
            },
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () {
              _searchController.clear();
              setState(() {
                _selectedModule = 'All Modules';
                _selectedLicense = 'All License Plans';
                _selectedStatus = 'All Status';
              });
            },
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }

  List<String> _moduleOptions() {
    return const [
      'All Modules',
      'AI Services',
      'Finance',
      'CRM',
      'Identity',
      'Security and Services',
      'Workflow',
      'Analytics',
      'Integration',
    ];
  }

  List<String> _licenseOptions() {
    return const ['All License Plans', 'Enterprise', 'Standard', 'Premium'];
  }

  Widget _filterButton(
    String value,
    List<String> options,
    ValueChanged<String> onSelected,
  ) {
    return PopupMenuButton<String>(
      tooltip: value,
      onSelected: onSelected,
      itemBuilder: (context) {
        return options.map((option) {
          return PopupMenuItem<String>(
            value: option,
            child: Text(option, maxLines: 1, overflow: TextOverflow.ellipsis),
          );
        }).toList();
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 40),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: AppTheme.paper,
          border: Border.all(color: AppTheme.border),
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppTheme.text, fontSize: 12),
              ),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.keyboard_arrow_down, size: 17),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP TABLE
  // ============================================================

  Widget _buildDesktopFeatureTable() {
    final items = _filteredFeatures;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          ...items.map((feature) => _buildDesktopFeatureRow(feature)),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppTheme.ink3,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
      ),
      child: Row(
        children: [
          _tableCell('FEATURE NAME', flex: 2),
          _tableCell('MODULE', flex: 1),
          _tableCell('LICENSE PLAN', flex: 1),
          _tableCell('STATUS', flex: 1),
          _tableCell('CONFIGURE', flex: 1),
          _tableCell('USAGE', flex: 1),
          _tableCell('ACTION', flex: 1),
        ],
      ),
    );
  }

  Widget _tableCell(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopFeatureRow(_FeatureItem feature) {
    return Container(
      constraints: const BoxConstraints(minHeight: 72),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border(bottom: BorderSide(color: AppTheme.border)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                feature.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppTheme.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(child: _desktopText(feature.module)),
          Expanded(child: _desktopText(feature.license)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _statusBadge(feature.enabled),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: OutlinedButton.icon(
                onPressed: () {
                  _showConfigureDialog(feature);
                },
                icon: const Icon(Icons.tune, size: 13),
                label: const Text('Configure', style: TextStyle(fontSize: 11)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 8,
                  ),
                  minimumSize: const Size(0, 36),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                _showUsageDialog(feature);
              },
              child: const Text(
                'View Usage',
                style: TextStyle(
                  fontSize: 11,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: OutlinedButton(
                    onPressed: () {
                      if (feature.enabled) {
                        _showDisableDialog(feature);
                      } else {
                        _showEnableDialog(feature);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: feature.enabled
                          ? AppTheme.danger
                          : AppTheme.success,
                      side: BorderSide(
                        color: feature.enabled
                            ? AppTheme.danger
                            : AppTheme.success,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      minimumSize: const Size(0, 34),
                    ),
                    child: Text(
                      feature.enabled ? 'Disable' : 'Enable',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    _handleAction(value, feature);
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'organization',
                        child: Text('Organization Access'),
                      ),
                      const PopupMenuItem(
                        value: 'history',
                        child: Text('View History'),
                      ),
                    ];
                  },
                  icon: const Icon(Icons.more_vert, size: 19),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktopText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: AppTheme.text, fontSize: 13),
      ),
    );
  }

  // ============================================================
  // MOBILE FEATURE CARDS
  // ============================================================

  Widget _buildMobileFeatureCards() {
    final items = _filteredFeatures;

    if (items.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Icon(Icons.search_off, size: 36, color: AppTheme.textMuted),
            const SizedBox(height: 8),
            Text(
              'No features found',
              style: TextStyle(
                color: AppTheme.text,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: items.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: _buildMobileFeatureCard(feature),
        );
      }).toList(),
    );
  }

  Widget _buildMobileFeatureCard(_FeatureItem feature) {
    return Container(
      width: double.infinity,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppTheme.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${feature.module} · ${feature.license}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _statusBadge(feature.enabled),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final bool verySmall = constraints.maxWidth < 280;

              if (verySmall) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _mobileButton(
                      label: 'Configure',
                      icon: Icons.tune,
                      onPressed: () {
                        _showConfigureDialog(feature);
                      },
                    ),
                    const SizedBox(height: 8),
                    _mobileButton(
                      label: 'Usage',
                      onPressed: () {
                        _showUsageDialog(feature);
                      },
                    ),
                    const SizedBox(height: 8),
                    _mobileButton(
                      label: feature.enabled ? 'Disable' : 'Enable',
                      color: feature.enabled
                          ? AppTheme.danger
                          : AppTheme.success,
                      onPressed: () {
                        if (feature.enabled) {
                          _showDisableDialog(feature);
                        } else {
                          _showEnableDialog(feature);
                        }
                      },
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _mobileButton(
                      label: 'Configure',
                      icon: Icons.tune,
                      onPressed: () {
                        _showConfigureDialog(feature);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _mobileButton(
                      label: 'Usage',
                      onPressed: () {
                        _showUsageDialog(feature);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _mobileButton(
                      label: feature.enabled ? 'Disable' : 'Enable',
                      color: feature.enabled
                          ? AppTheme.danger
                          : AppTheme.success,
                      onPressed: () {
                        if (feature.enabled) {
                          _showDisableDialog(feature);
                        } else {
                          _showEnableDialog(feature);
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _mobileButton({
    required String label,
    IconData? icon,
    Color? color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 46,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 16),
        label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        style: OutlinedButton.styleFrom(
          foregroundColor: color ?? AppTheme.text,
          side: BorderSide(color: color ?? AppTheme.border),
          padding: const EdgeInsets.symmetric(horizontal: 6),
        ),
      ),
    );
  }

  Widget _statusBadge(bool enabled) {
    final color = enabled ? AppTheme.success : AppTheme.danger;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            enabled ? 'Enabled' : 'Disabled',
            style: TextStyle(
              color: color,
              fontSize: 11,
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

  Widget _buildPagination(bool mobile) {
    return Padding(
      padding: EdgeInsets.fromLTRB(mobile ? 10 : 16, 12, mobile ? 10 : 16, 4),
      child: mobile
          ? Column(
              children: [
                Text(
                  'Showing 1-5 of 65 features',
                  style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                ),
                const SizedBox(height: 10),
                _paginationButtons(),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Text(
                    'Showing 1-5 of 65 features',
                    style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                  ),
                ),
                _paginationButtons(),
              ],
            ),
    );
  }

  Widget _paginationButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _pageButton(icon: Icons.chevron_left, selected: false),
        const SizedBox(width: 6),
        _pageButton(text: '1', selected: true),
        const SizedBox(width: 6),
        _pageButton(text: '2', selected: false),
        const SizedBox(width: 6),
        _pageButton(text: '3', selected: false),
        const SizedBox(width: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text('...', style: TextStyle(color: AppTheme.textMuted)),
        ),
        const SizedBox(width: 6),
        _pageButton(text: '13', selected: false),
        const SizedBox(width: 6),
        _pageButton(icon: Icons.chevron_right, selected: false),
      ],
    );
  }

  Widget _pageButton({String? text, IconData? icon, required bool selected}) {
    return SizedBox(
      width: 36,
      height: 36,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: selected ? AppTheme.ink3 : AppTheme.paper,
          foregroundColor: selected ? Colors.white : AppTheme.text,
          side: selected ? BorderSide.none : BorderSide(color: AppTheme.border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: icon != null
            ? Icon(icon, size: 19)
            : Text(text ?? '', style: const TextStyle(fontSize: 12)),
      ),
    );
  }

  // ============================================================
  // MOBILE EXPORT
  // ============================================================

  Widget _buildMobileExportButton() {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: _showExportDialog,
        icon: const Icon(Icons.download_outlined, size: 19),
        label: const Text(
          'Export Report',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ============================================================
  // ACTION HANDLER
  // ============================================================

  void _handleAction(String action, _FeatureItem feature) {
    switch (action) {
      case 'organization':
        _showOrganizationDialog(feature);
        break;
      case 'history':
        _showHistoryDialog(feature);
        break;
    }
  }

  // ============================================================
  // DISABLE DIALOG
  // ============================================================

  void _showDisableDialog(_FeatureItem feature) {
    _showResponsiveDialog(
      child: _ConfirmationDialog(
        title: 'Disable Feature',
        subtitle: feature.name,
        icon: Icons.warning_amber_rounded,
        iconColor: AppTheme.danger,
        warningTitle: 'Warning: Interruption of Service',
        warningText:
            'Disabling "${feature.name}" will immediately revoke access across all active tenant workspaces. Any active API calls, background jobs, or user sessions relying on this feature will be halted.',
        actionText: 'Disable Feature',
        actionColor: AppTheme.danger,
        onAction: () {
          setState(() {
            feature.enabled = false;
          });

          Navigator.of(context).pop();

          _showSnackBar(
            'Feature Disabled',
            '"${feature.name}" has been deactivated across the platform.',
            AppTheme.danger,
          );
        },
      ),
    );
  }

  // ============================================================
  // ENABLE DIALOG
  // ============================================================

  void _showEnableDialog(_FeatureItem feature) {
    _showResponsiveDialog(
      child: _ConfirmationDialog(
        title: 'Enable Feature',
        subtitle: feature.name,
        icon: Icons.check_circle_outline,
        iconColor: AppTheme.success,
        message:
            'Are you sure you want to enable the "${feature.name}" feature? This will immediately make it accessible to all tenant organizations on the Enterprise plan.',
        actionText: 'Enable Feature',
        actionColor: AppTheme.success,
        onAction: () {
          setState(() {
            feature.enabled = true;
          });

          Navigator.of(context).pop();

          _showSnackBar(
            'Feature Enabled',
            '"${feature.name}" has been activated across the platform.',
            AppTheme.success,
          );
        },
      ),
    );
  }

  // ============================================================
  // CONFIGURE DIALOG
  // ============================================================

  void _showConfigureDialog(_FeatureItem feature) {
    bool enabled = feature.enabled;

    _showResponsiveDialog(
      child: StatefulBuilder(
        builder: (context, setDialogState) {
          return _ConfigureDialog(
            feature: feature,
            enabled: enabled,
            onEnabledChanged: (value) {
              setDialogState(() {
                enabled = value;
              });
            },
            onSave: () {
              setState(() {
                feature.enabled = enabled;
              });

              Navigator.of(context).pop();

              _showSnackBar(
                'Configuration Saved',
                'Feature configuration has been updated.',
                AppTheme.success,
              );
            },
          );
        },
      ),
    );
  }

  // ============================================================
  // ORGANIZATION ACCESS
  // ============================================================

  void _showOrganizationDialog(_FeatureItem feature) {
    bool allOrganizations = true;

    _showResponsiveDialog(
      child: StatefulBuilder(
        builder: (context, setDialogState) {
          return _OrganizationDialog(
            feature: feature,
            allOrganizations: allOrganizations,
            onChanged: (value) {
              setDialogState(() {
                allOrganizations = value;
              });
            },
            onSave: () {
              Navigator.of(context).pop();

              _showSnackBar(
                'Access Updated',
                'Organization access has been updated.',
                AppTheme.success,
              );
            },
          );
        },
      ),
    );
  }

  // ============================================================
  // HISTORY
  // ============================================================

  void _showHistoryDialog(_FeatureItem feature) {
    _showResponsiveDialog(
      child: _HistoryDialog(
        feature: feature,
        onRollback: () {
          Navigator.of(context).pop();
          _showRollbackDialog(feature);
        },
      ),
    );
  }

  // ============================================================
  // USAGE
  // ============================================================

  void _showUsageDialog(_FeatureItem feature) {
    _showResponsiveDialog(child: _UsageDialog(feature: feature));
  }

  // ============================================================
  // ROLLBACK
  // ============================================================

  void _showRollbackDialog(_FeatureItem feature) {
    _showResponsiveDialog(
      child: _ConfirmationDialog(
        title: 'Rollback Feature Change',
        subtitle: feature.name,
        icon: Icons.warning_amber_rounded,
        iconColor: AppTheme.danger,
        message: 'Are you sure you want to rollback this feature to its previous configuration?',
        warningTitle: 'Warning',
        warningText: 'This action will restore the previous configuration and may affect feature availability for organizations using this feature.',
        actionText: 'Rollback Change',
        actionColor: AppTheme.danger,
        onAction: () {
          Navigator.of(context).pop();

          _showSnackBar(
            'Configuration Rolled Back',
            '"${feature.name}" has been restored to the previous configuration.',
            AppTheme.success,
          );
        },
      ),
    );
  }

  // ============================================================
  // EXPORT
  // ============================================================

  void _showExportDialog() {
    _showResponsiveDialog(
      child: _ExportDialog(
        onExport: () {
          Navigator.of(context).pop();

          _showSnackBar(
            'Export Started',
            'Feature management report is being generated.',
            AppTheme.success,
          );
        },
      ),
    );
  }

  // ============================================================
  // REFRESH
  // ============================================================

  void _showRefreshDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        Future.delayed(const Duration(milliseconds: 900), () {
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
          }
        });

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: const SizedBox(
            width: 190,
            height: 125,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 34,
                  height: 34,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
                SizedBox(height: 14),
                Text(
                  'Refreshing...',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // RESPONSIVE DIALOG WRAPPER
  // ============================================================

  void _showResponsiveDialog({required Widget child}) {
    showDialog<void>(
      context: context,
      builder: (context) {
        final size = MediaQuery.sizeOf(context);

        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: size.width < 500 ? 12 : 24,
            vertical: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: size.width < 700 ? 620 : 900,
              maxHeight: size.height - 36,
            ),
            child: SingleChildScrollView(child: child),
          ),
        );
      },
    );
  }

  // ============================================================
  // SNACKBAR
  // ============================================================

  void _showSnackBar(String title, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.paper,
        elevation: 8,
        margin: const EdgeInsets.all(16),
        content: Row(
          children: [
            Icon(Icons.check_circle_outline, color: color),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppTheme.text,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// FEATURE MODEL
// ============================================================================

class _FeatureItem {
  final String name;
  final String module;
  final String license;
  bool enabled;

  _FeatureItem({
    required this.name,
    required this.module,
    required this.license,
    required this.enabled,
  });
}

// ============================================================================
// KPI MODEL
// ============================================================================

class _KpiItem {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;
  final bool positive;

  const _KpiItem({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
    required this.positive,
  });
}

// ============================================================================
// CONFIRMATION DIALOG
// ============================================================================

class _ConfirmationDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final String? message;
  final String? warningTitle;
  final String? warningText;
  final String actionText;
  final Color actionColor;
  final VoidCallback onAction;

  const _ConfirmationDialog({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.message,
    this.warningTitle,
    this.warningText,
    required this.actionText,
    required this.actionColor,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 500;

    return Padding(
      padding: EdgeInsets.all(mobile ? 18 : 22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, color: iconColor, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppTheme.text,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close, color: AppTheme.textMuted, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (message != null)
            Text(
              message!,
              style: TextStyle(color: AppTheme.text, fontSize: 13, height: 1.5),
            ),
          if (warningTitle != null && warningText != null) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.danger.withOpacity(0.07),
                border: Border.all(color: AppTheme.danger.withOpacity(0.25)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    warningTitle!,
                    style: TextStyle(
                      color: AppTheme.danger,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    warningText!,
                    style: TextStyle(
                      color: AppTheme.danger,
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: actionColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(actionText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// CONFIGURE DIALOG
// ============================================================================

class _ConfigureDialog extends StatelessWidget {
  final _FeatureItem feature;
  final bool enabled;
  final ValueChanged<bool> onEnabledChanged;
  final VoidCallback onSave;

  const _ConfigureDialog({
    required this.feature,
    required this.enabled,
    required this.onEnabledChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dialogTitle(
            context,
            'Configure Feature',
            'Update settings and access for this feature.',
          ),
          const SizedBox(height: 18),
          _fieldLabel('Feature Name'),
          _readOnlyField(feature.name, Icons.lock_outline),
          const SizedBox(height: 14),
          _fieldLabel('Module *'),
          _dropdownBox(feature.module),
          const SizedBox(height: 14),
          _fieldLabel('Status'),
          _dropdownBox(enabled ? 'Enabled' : 'Disabled', status: enabled),
          const SizedBox(height: 14),
          _fieldLabel('License Plan *'),
          _dropdownBox(feature.license),
          const SizedBox(height: 14),
          _fieldLabel('Access Scope'),
          _dropdownBox('All Organizations'),
          const SizedBox(height: 4),
          Text(
            '12 organizations selected  •  Manage Access',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
          ),
          const SizedBox(height: 16),
          Text(
            'Feature Configuration',
            style: TextStyle(
              color: AppTheme.text,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Switch(value: enabled, onChanged: onEnabledChanged),
              const SizedBox(width: 5),
              Text(
                enabled ? 'Enabled' : 'Disabled',
                style: TextStyle(color: AppTheme.text, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.info.withOpacity(0.07),
              border: Border.all(color: AppTheme.info.withOpacity(0.25)),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppTheme.info, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Changes are validated before saving and recorded in the Audit Log.',
                    style: TextStyle(color: AppTheme.info, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _dialogActions(context, onSave),
        ],
      ),
    );
  }
}

// ============================================================================
// ORGANIZATION DIALOG
// ============================================================================

class _OrganizationDialog extends StatelessWidget {
  final _FeatureItem feature;
  final bool allOrganizations;
  final ValueChanged<bool> onChanged;
  final VoidCallback onSave;

  const _OrganizationDialog({
    required this.feature,
    required this.allOrganizations,
    required this.onChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dialogTitle(
            context,
            'Organization Access',
            'Control which organizations can access this feature.',
          ),
          const SizedBox(height: 20),
          Text(
            'ORGANIZATION ACCESS',
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 10),
          _organizationOption(
            title: 'All Organizations',
            subtitle: 'Enable this feature for all organizations.',
            selected: allOrganizations,
            onTap: () => onChanged(true),
          ),
          const SizedBox(height: 10),
          _organizationOption(
            title: 'Selected Organizations',
            subtitle: 'Enable this feature only for selected organizations.',
            selected: !allOrganizations,
            onTap: () => onChanged(false),
          ),
          const SizedBox(height: 20),
          Text(
            'ACCESS SUMMARY',
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.paperDim,
              border: Border.all(color: AppTheme.border),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              spacing: 20,
              runSpacing: 14,
              children: [
                _summaryItem('FEATURE', feature.name),
                _summaryItem('LICENSE PLAN', feature.license),
                _summaryItem(
                  'SELECTED ORGANIZATIONS',
                  allOrganizations ? 'All' : 'Selected',
                ),
                _summaryItem('LAST UPDATED', '14 Aug 2026, 10:42 AM'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: AppTheme.paperDim,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Only selected organizations will have access to this feature.',
              style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
            ),
          ),
          const SizedBox(height: 20),
          _dialogActions(context, onSave),
        ],
      ),
    );
  }

  Widget _organizationOption({
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: selected ? AppTheme.paperDim : AppTheme.paper,
          border: Border.all(color: selected ? AppTheme.text : AppTheme.border),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: AppTheme.text,
              size: 21,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppTheme.text,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem(String title, String value) {
    return SizedBox(
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppTheme.text,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// HISTORY DIALOG
// ============================================================================

class _HistoryDialog extends StatelessWidget {
  final _FeatureItem feature;
  final VoidCallback onRollback;

  const _HistoryDialog({required this.feature, required this.onRollback});

  @override
  Widget build(BuildContext context) {
    final changes = [
      ['Status Updated', 'Disabled', 'Enabled'],
      ['Status Updated', 'Disabled', 'Enabled'],
      ['Status Updated', 'Disabled', 'Enabled'],
      ['Status Updated', 'Disabled', 'Enabled'],
      ['License Plan Updated', 'Standard', 'Enterprise'],
    ];

    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dialogTitle(
            context,
            'Change History',
            'View previous feature changes and restore an earlier configuration.',
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.paperDim,
              border: Border.all(color: AppTheme.border),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              spacing: 50,
              runSpacing: 15,
              children: [
                _historySummary('FEATURE', feature.name),
                _historySummary('MODULE', feature.module),
                _historySummary(
                  'CURRENT STATUS',
                  feature.enabled ? 'Enabled' : 'Disabled',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _historyTableHeader(),
          ...changes.map((change) => _historyRow(change, onRollback)),
          const SizedBox(height: 12),
          Text(
            'Changes are recorded in the Audit Log.',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _historySummary(String label, String value) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: AppTheme.textMuted, fontSize: 9)),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppTheme.text,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      color: AppTheme.ink3,
      child: const Row(
        children: [
          Expanded(
            child: Text(
              'CHANGE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'PREVIOUS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'NEW VALUE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'ACTION',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyRow(List<String> values, VoidCallback onRollback) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.border),
          left: BorderSide(color: AppTheme.border),
          right: BorderSide(color: AppTheme.border),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              values[0],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppTheme.text, fontSize: 10),
            ),
          ),
          Expanded(
            child: Text(
              values[1],
              style: TextStyle(color: AppTheme.textMuted, fontSize: 10),
            ),
          ),
          Expanded(
            child: Text(
              values[2],
              style: TextStyle(color: AppTheme.text, fontSize: 10),
            ),
          ),
          Expanded(
            child: OutlinedButton(
              onPressed: onRollback,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                minimumSize: const Size(0, 30),
              ),
              child: const Text('Rollback', style: TextStyle(fontSize: 9)),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// USAGE DIALOG
// ============================================================================

class _UsageDialog extends StatelessWidget {
  final _FeatureItem feature;

  const _UsageDialog({required this.feature});

  @override
  Widget build(BuildContext context) {
    final stats = [
      ['Active Orgs', '12', '+8.3%'],
      ['Active Users', '1,248', '+12.1%'],
      ['Total Usage', '3,582', '+5.7%'],
      ['Adoption Rate', '67%', '+3.2%'],
    ];

    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dialogTitle(
            context,
            'Feature Usage Monitoring',
            'View usage and adoption details for this feature.',
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 18,
            runSpacing: 8,
            children: [
              _inlineInfo('Feature', feature.name),
              _inlineInfo('Module', feature.module),
              _inlineInfo('Plan', feature.license),
              _inlineInfo('Status', feature.enabled ? 'Enabled' : 'Disabled'),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Usage Summary',
            style: TextStyle(
              color: AppTheme.text,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 9),
          LayoutBuilder(
            builder: (context, constraints) {
              final mobile = constraints.maxWidth < 500;

              if (mobile) {
                return Column(
                  children: stats.map((stat) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: _usageStat(stat[0], stat[1], stat[2]),
                    );
                  }).toList(),
                );
              }

              return Row(
                children: stats.map((stat) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: _usageStat(stat[0], stat[1], stat[2]),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 18),
          Text(
            'Usage Trend',
            style: TextStyle(
              color: AppTheme.text,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 9),
          _usageChart(),
          const SizedBox(height: 18),
          Text(
            'Recent Activity',
            style: TextStyle(
              color: AppTheme.text,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          _recentUsage('Acme Corporation', '428 activities', '2 min ago'),
          _recentUsage('Globex Industries', '316 activities', '18 min ago'),
          _recentUsage('Intech Solutions', '284 activities', '42 min ago'),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inlineInfo(String label, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: AppTheme.textMuted, fontSize: 10),
        children: [
          TextSpan(text: '$label: '),
          TextSpan(
            text: value,
            style: TextStyle(color: AppTheme.text, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _usageStat(String title, String value, String change) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.paperDim,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: AppTheme.textMuted, fontSize: 9)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: AppTheme.text,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '↑ $change',
            style: TextStyle(
              color: AppTheme.success,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _usageChart() {
    final values = [0.35, 0.55, 0.47, 0.78, 0.88, 0.70, 0.96];

    return Container(
      height: 135,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        color: AppTheme.paperDim,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: values.map((value) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 82 * value,
                        decoration: BoxDecoration(
                          color: AppTheme.ink,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                [
                  'Aug 21',
                  'Aug 22',
                  'Aug 23',
                  'Aug 24',
                  'Aug 25',
                  'Aug 26',
                  'Aug 27',
                ].map((date) {
                  return Text(
                    date,
                    style: TextStyle(color: AppTheme.textMuted, fontSize: 7),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _recentUsage(String company, String usage, String time) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.paperDim,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company,
                  style: TextStyle(
                    color: AppTheme.text,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  usage,
                  style: TextStyle(color: AppTheme.textMuted, fontSize: 9),
                ),
              ],
            ),
          ),
          Text(time, style: TextStyle(color: AppTheme.textMuted, fontSize: 9)),
        ],
      ),
    );
  }
}

// ============================================================================
// EXPORT DIALOG
// ============================================================================

class _ExportDialog extends StatefulWidget {
  final VoidCallback onExport;

  const _ExportDialog({required this.onExport});

  @override
  State<_ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<_ExportDialog> {
  String interval = 'Last 30 Days';
  bool tenantData = true;
  bool rateLimits = false;
  bool licenseNotes = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dialogTitle(
            context,
            'Export Feature Management Report',
            'Download comprehensive feature configuration, license tier and usage metrics.',
          ),
          const SizedBox(height: 18),
          _fieldLabel('Export Report Name'),
          _readOnlyField(
            'Feature_Management_Report_2026-09-02',
            Icons.edit_outlined,
          ),
          const SizedBox(height: 15),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 500) {
                return Column(
                  children: [
                    _exportDropdown(
                      'Export Scope',
                      'All Features (65 records)',
                    ),
                    const SizedBox(height: 12),
                    _exportDropdown('Document Format', 'CSV (Comma Separated)'),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _exportDropdown(
                      'Export Scope',
                      'All Features (65 records)',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _exportDropdown(
                      'Document Format',
                      'CSV (Comma Separated)',
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          _fieldLabel('Telemetry & Usage Interval'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              _intervalButton('Today'),
              _intervalButton('Last 7 Days'),
              _intervalButton('Last 30 Days'),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: AppTheme.paperDim,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Include Data Sections',
                  style: TextStyle(
                    color: AppTheme.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                _checkRow(
                  'Include tenant adoption, daily calls & latency stats',
                  tenantData,
                  (value) {
                    setState(() {
                      tenantData = value;
                    });
                  },
                ),
                _checkRow(
                  'Include rate limits, concurrency & governance flags',
                  rateLimits,
                  (value) {
                    setState(() {
                      rateLimits = value;
                    });
                  },
                ),
                _checkRow(
                  'Include license tier requirements and feature notes',
                  licenseNotes,
                  (value) {
                    setState(() {
                      licenseNotes = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _dialogActions(
            context,
            widget.onExport,
            primaryText: 'Download Export',
            primaryIcon: Icons.download_outlined,
          ),
        ],
      ),
    );
  }

  Widget _intervalButton(String value) {
    final selected = interval == value;

    return TextButton(
      onPressed: () {
        setState(() {
          interval = value;
        });
      },
      style: TextButton.styleFrom(
        backgroundColor: selected ? AppTheme.ink3 : AppTheme.paper,
        foregroundColor: selected ? Colors.white : AppTheme.text,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: selected ? BorderSide.none : BorderSide(color: AppTheme.border),
        ),
      ),
      child: Text(value, style: const TextStyle(fontSize: 11)),
    );
  }

  Widget _checkRow(String text, bool value, ValueChanged<bool> onChanged) {
    return CheckboxListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
      ),
      value: value,
      onChanged: (value) {
        onChanged(value ?? false);
      },
    );
  }
}

// ============================================================================
// SHARED DIALOG HELPERS
// ============================================================================

Widget _dialogTitle(BuildContext context, String title, String subtitle) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppTheme.text,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
            ),
          ],
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.close, color: AppTheme.textMuted, size: 20),
      ),
    ],
  );
}

Widget _fieldLabel(String text) {
  return Text(
    text,
    style: TextStyle(
      color: AppTheme.text,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget _readOnlyField(String text, IconData icon) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 7),
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
    decoration: BoxDecoration(
      color: AppTheme.paperDim,
      border: Border.all(color: AppTheme.border),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
          ),
        ),
        Icon(icon, color: AppTheme.textMuted, size: 17),
      ],
    ),
  );
}

Widget _dropdownBox(String text, {bool? status}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 7),
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
    decoration: BoxDecoration(
      color: AppTheme.paper,
      border: Border.all(color: AppTheme.border),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        if (status != null) ...[
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: status ? AppTheme.success : AppTheme.danger,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
        ],
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppTheme.text, fontSize: 12),
          ),
        ),
        const Icon(Icons.keyboard_arrow_down, size: 18),
      ],
    ),
  );
}

Widget _exportDropdown(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _fieldLabel(label),
      const SizedBox(height: 7),
      _dropdownBox(value),
    ],
  );
}

Widget _dialogActions(
  BuildContext context,
  VoidCallback onPrimary, {
  String primaryText = 'Save Changes',
  IconData? primaryIcon,
}) {
  return Wrap(
    alignment: WrapAlignment.end,
    spacing: 8,
    runSpacing: 8,
    children: [
      OutlinedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'),
      ),
      ElevatedButton.icon(
        onPressed: onPrimary,
        icon: primaryIcon == null
            ? const SizedBox.shrink()
            : Icon(primaryIcon, size: 17),
        label: Text(primaryText),
      ),
    ],
  );
}
