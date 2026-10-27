import 'dart:convert';
import 'dart:typed_data';

import 'package:excel/excel.dart' as xl;
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';

import '../../app_theme.dart';

class TenantManagementPage extends StatefulWidget {
  const TenantManagementPage({super.key});

  @override
  State<TenantManagementPage> createState() => _TenantManagementPageState();
}

class _TenantManagementPageState extends State<TenantManagementPage> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selectedIds = <String>{};
  final List<_Tenant> _tenants = _seedTenants();

  String _subscriptionFilter = 'All subscriptions';
  String _statusFilter = 'All statuses';
  String _regionFilter = 'All regions';
  int _page = 1;
  int _pageSize = 5;
  bool _busy = false;

  static const Color _navy = AppTheme.ink3;
  static const Color _deepNavy = AppTheme.ink;
  static const Color _blue = Color(0xFF3046FF);
  static const Color _green = Color(0xFF16A34A);
  static const Color _red = Color(0xFFDC2626);
  static const Color _muted = Color(0xFF687386);
  static const Color _line = Color(0xFFDDE3EC);
  static const Color _paleBlue = Color(0xFFEBF0FF);

  List<_Tenant> get _filteredTenants {
    final query = _searchController.text.trim().toLowerCase();
    return _tenants.where((tenant) {
      final matchesSearch =
          query.isEmpty ||
          tenant.name.toLowerCase().contains(query) ||
          tenant.id.toLowerCase().contains(query) ||
          tenant.plan.toLowerCase().contains(query) ||
          tenant.region.toLowerCase().contains(query) ||
          tenant.email.toLowerCase().contains(query);
      final matchesSubscription =
          _subscriptionFilter == 'All subscriptions' ||
          tenant.plan == _subscriptionFilter;
      final matchesStatus =
          _statusFilter == 'All statuses' ||
          (_statusFilter == 'Active' && tenant.active) ||
          (_statusFilter == 'Inactive' && !tenant.active);
      final matchesRegion =
          _regionFilter == 'All regions' || tenant.region == _regionFilter;
      return matchesSearch &&
          matchesSubscription &&
          matchesStatus &&
          matchesRegion;
    }).toList();
  }

  List<_Tenant> get _pageTenants {
    final all = _filteredTenants;
    final start = (_page - 1) * _pageSize;
    if (start >= all.length) return <_Tenant>[];
    return all.skip(start).take(_pageSize).toList();
  }

  int get _pageCount =>
      (_filteredTenants.length / _pageSize).ceil().clamp(1, 999999).toInt();
  List<_Tenant> get _selectedTenants =>
      _tenants.where((tenant) => _selectedIds.contains(tenant.id)).toList();
  int get _activeCount => _tenants.where((tenant) => tenant.active).length;
  int get _inactiveCount => _tenants.where((tenant) => !tenant.active).length;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final compact = width < 760;
        final mobile = width < 560;
        return ColoredBox(
          color: AppTheme.paper,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              mobile ? 14 : 22,
              22,
              mobile ? 14 : 22,
              28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPageHeader(compact: compact, mobile: mobile),
                const SizedBox(height: 20),
                _buildSummaryCards(compact: compact, mobile: mobile),
                const SizedBox(height: 20),
                const Text(
                  'TENANT LIST',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .65,
                    color: Color(0xFF63788E),
                  ),
                ),
                const SizedBox(height: 14),
                _buildTenantList(compact: compact, mobile: mobile),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageHeader({required bool compact, required bool mobile}) {
    final actions = Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _outlineButton('Refresh', Icons.sync, _refresh),
        _outlineButton('Export', Icons.download_outlined, _showExportDialog),
        _primaryButton('Create Tenant', Icons.add, _showCreateTenant),
      ],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (compact) ...[
          const Text(
            'Tenant Management',
            style: TextStyle(
              fontSize: 29,
              height: 1.12,
              fontWeight: FontWeight.w700,
              color: AppTheme.text,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Create, configure, and manage multiple tenants from a centralized interface.',
            style: TextStyle(fontSize: 14, color: _muted, height: 1.4),
          ),
          const SizedBox(height: 14),
          actions,
        ] else
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tenant Management',
                      style: TextStyle(
                        fontSize: 32,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.text,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Create, configure, and manage multiple tenants from a centralized interface.',
                      style: TextStyle(fontSize: 14.5, color: _muted),
                    ),
                  ],
                ),
              ),
              actions,
            ],
          ),
      ],
    );
  }

  Widget _buildSummaryCards({required bool compact, required bool mobile}) {
    final cards = <Widget>[
      _summaryCard('Total Tenants', '615', Icons.tune, _navy, mobile: mobile),
      _summaryCard(
        'Active Tenants',
        '$_activeCount',
        Icons.check_circle_outline,
        _green,
        mobile: mobile,
      ),
      _summaryCard(
        'Inactive Tenants',
        '$_inactiveCount',
        Icons.error_outline,
        _red,
        mobile: mobile,
      ),
    ];
    if (mobile)
      return Column(
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            if (i > 0) const SizedBox(height: 10),
            cards[i],
          ],
        ],
      );
    return Row(
      children: [
        for (var i = 0; i < cards.length; i++) ...[
          if (i > 0) const SizedBox(width: 16),
          Expanded(child: cards[i]),
        ],
      ],
    );
  }

  Widget _summaryCard(
    String label,
    String value,
    IconData icon,
    Color iconColor, {
    required bool mobile,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 18 : 24,
        vertical: mobile ? 16 : 20,
      ),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border.all(color: const Color(0xFFDCE4F0)),
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080F1330),
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _muted,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 32,
                    height: 1.05,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.ink,
                  ),
                ),
              ],
            ),
          ),
          Icon(icon, color: iconColor, size: 23),
        ],
      ),
    );
  }

  Widget _buildTenantList({required bool compact, required bool mobile}) {
    final filtered = _filteredTenants;
    final visible = _pageTenants;
    final allPageSelected =
        visible.isNotEmpty && visible.every((t) => _selectedIds.contains(t.id));
    final start = filtered.isEmpty ? 0 : (_page - 1) * _pageSize + 1;
    final end = (_page * _pageSize).clamp(0, filtered.length);

    return Container(
      padding: EdgeInsets.all(mobile ? 12 : 17),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border.all(color: const Color(0xFFD8D8D8)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: mobile ? double.infinity : 263,
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() => _page = 1),
              decoration: _inputDecoration(
                mobile ? 'Search features...' : 'Search',
                prefix: const Icon(Icons.search, size: 20),
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (mobile)
            LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 400;
                return Row(
                  children: [
                    Expanded(
                      flex: 13,
                      child: _filterDropdown(
                        _subscriptionFilter,
                        const [
                          'All subscriptions',
                          'Starter',
                          'Business',
                          'Enterprise',
                        ],
                        (v) => setState(() {
                          _subscriptionFilter = v!;
                          _page = 1;
                        }),
                        'Subscription',
                      ),
                    ),
                    SizedBox(width: compact ? 5 : 8),
                    Expanded(
                      flex: 9,
                      child: _filterDropdown(
                        _statusFilter,
                        const ['All statuses', 'Active', 'Inactive'],
                        (v) => setState(() {
                          _statusFilter = v!;
                          _page = 1;
                        }),
                        'Status',
                      ),
                    ),
                    SizedBox(width: compact ? 5 : 8),
                    Expanded(
                      flex: 9,
                      child: _filterDropdown(
                        _regionFilter,
                        const [
                          'All regions',
                          'North America',
                          'Europe',
                          'Asia Pacific',
                          'India',
                        ],
                        (v) => setState(() {
                          _regionFilter = v!;
                          _page = 1;
                        }),
                        'Region',
                      ),
                    ),
                    SizedBox(width: compact ? 3 : 6),
                    Expanded(
                      flex: 10,
                      child: TextButton(
                        onPressed: () => setState(() {
                          _searchController.clear();
                          _subscriptionFilter = 'All subscriptions';
                          _statusFilter = 'All statuses';
                          _regionFilter = 'All regions';
                          _page = 1;
                        }),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF5145FF),
                          padding: EdgeInsets.symmetric(
                            horizontal: compact ? 1 : 4,
                            vertical: 9,
                          ),
                          minimumSize: const Size(0, 40),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Clear Filters',
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: compact ? 11 : 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          else
            Wrap(
              spacing: 10,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _filterDropdown(
                  _subscriptionFilter,
                  const [
                    'All subscriptions',
                    'Starter',
                    'Business',
                    'Enterprise',
                  ],
                  (v) => setState(() {
                    _subscriptionFilter = v!;
                    _page = 1;
                  }),
                  'Subscription',
                ),
                _filterDropdown(
                  _statusFilter,
                  const ['All statuses', 'Active', 'Inactive'],
                  (v) => setState(() {
                    _statusFilter = v!;
                    _page = 1;
                  }),
                  'Status',
                ),
                _filterDropdown(
                  _regionFilter,
                  const [
                    'All regions',
                    'North America',
                    'Europe',
                    'Asia Pacific',
                    'India',
                  ],
                  (v) => setState(() {
                    _regionFilter = v!;
                    _page = 1;
                  }),
                  'Region',
                ),
                TextButton(
                  onPressed: () => setState(() {
                    _searchController.clear();
                    _subscriptionFilter = 'All subscriptions';
                    _statusFilter = 'All statuses';
                    _regionFilter = 'All regions';
                    _page = 1;
                  }),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF5145FF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 9,
                    ),
                    minimumSize: const Size(0, 40),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Clear Filters',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 10),
          if (!mobile) _buildBulkActions(mobile: mobile),
          if (!mobile) const SizedBox(height: 9),
          if (mobile) ...[
            for (final tenant in visible) _mobileTenantCard(tenant),
            if (visible.isEmpty)
              const Padding(
                padding: EdgeInsets.all(28),
                child: Center(child: Text('No tenants match your filters.')),
              ),
          ] else
            _desktopTable(visible, allPageSelected),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFE0E4EA)),
          const SizedBox(height: 10),
          _buildPagination(
            start: start,
            end: end,
            total: filtered.length,
            mobile: mobile,
          ),
          if (mobile) ...[
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _showExportDialog,
                icon: const Icon(Icons.download_outlined, size: 19),
                label: const Text(
                  'Export Report',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBulkActions({required bool mobile}) {
    final count = _selectedIds.length;

    final selection = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: count > 0,
          tristate: true,
          onChanged: (_) => setState(() {
            if (count > 0) {
              _selectedIds.clear();
            } else {
              _selectedIds.addAll(_pageTenants.map((t) => t.id));
            }
          }),
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(
          '$count tenant${count == 1 ? '' : 's'} selected',
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: AppTheme.text,
          ),
        ),
      ],
    );

    final actions = [
      _smallAction(
        'Enable',
        _green,
        Icons.check_circle_outline,
        () => _confirmStatus(active: true),
      ),
      _smallAction(
        'Disable',
        _red,
        Icons.block_outlined,
        () => _confirmStatus(active: false),
      ),
      _smallAction(
        'Configure',
        _navy,
        Icons.tune,
        _configureSelected,
        neutral: true,
      ),
      _smallAction(
        'Backup',
        _navy,
        Icons.backup_outlined,
        _backupSelected,
        neutral: true,
      ),
    ];

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 58),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: mobile ? 9 : 10),
      decoration: BoxDecoration(
        color: _paleBlue,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF9BB4FF)),
      ),
      child: mobile
          ? Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [selection, ...actions],
            )
          : Row(
              children: [
                selection,
                const Spacer(),
                ...[
                  for (var i = 0; i < actions.length; i++) ...[
                    if (i > 0) const SizedBox(width: 10),
                    actions[i],
                  ],
                ],
              ],
            ),
    );
  }

  Widget _desktopTable(List<_Tenant> visible, bool allPageSelected) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD9DEE8)),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          children: [
            Container(
              color: _navy,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 17),
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  const Expanded(flex: 4, child: _TableHeading('TENANT NAME')),
                  const Expanded(flex: 3, child: _TableHeading('TENANT ID')),
                  const Expanded(flex: 4, child: _TableHeading('LICENSE PLAN')),
                  const Expanded(flex: 3, child: _TableHeading('STATUS')),
                  const Expanded(flex: 3, child: _TableHeading('CREATED ON')),
                  const SizedBox(width: 34),
                ],
              ),
            ),
            if (visible.isEmpty)
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text('No tenants match your filters.'),
              )
            else
              ...visible.map((tenant) => _desktopTenantRow(tenant)),
          ],
        ),
      ),
    );
  }

  Widget _desktopTenantRow(_Tenant tenant) {
    return InkWell(
      onTap: () => _showTenantDetails(tenant),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE7EAF0))),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Checkbox(
                value: _selectedIds.contains(tenant.id),
                onChanged: (v) => setState(
                  () => v == true
                      ? _selectedIds.add(tenant.id)
                      : _selectedIds.remove(tenant.id),
                ),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(tenant.name, style: const TextStyle(fontSize: 14)),
            ),
            Expanded(
              flex: 3,
              child: Text(tenant.id, style: const TextStyle(fontSize: 14)),
            ),
            Expanded(
              flex: 4,
              child: Text(tenant.plan, style: const TextStyle(fontSize: 14)),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: _statusPill(tenant.active),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                tenant.createdOn,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(
              width: 34,
              child: PopupMenuButton<String>(
                tooltip: 'Tenant actions',
                icon: const Icon(Icons.more_vert, size: 19, color: _muted),
                onSelected: (action) {
                  if (action == 'edit') _showConfigureTenant(tenant);
                  if (action == 'toggle')
                    _confirmStatus(active: !tenant.active, specific: [tenant]);
                  if (action == 'backup')
                    _downloadJson([tenant], 'tenant_${tenant.id}_backup.json');
                  if (action == 'view') _showTenantDetails(tenant);
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'view', child: Text('View details')),
                  PopupMenuItem(value: 'edit', child: Text('Configure')),
                  PopupMenuItem(
                    value: 'toggle',
                    child: Text('Enable / Disable'),
                  ),
                  PopupMenuItem(value: 'backup', child: Text('Backup')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobileTenantCard(_Tenant tenant) {
    Widget actionButton({
      required String label,
      required VoidCallback onPressed,
      required Color color,
      IconData? icon,
    }) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color.withValues(alpha: 0.32)),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
          minimumSize: const Size(0, 40),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14),
              const SizedBox(width: 4),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.fromLTRB(13, 13, 13, 12),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border.all(color: const Color(0xFFDCE4F0)),
        borderRadius: BorderRadius.circular(17),
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
                      tenant.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.5,
                        color: AppTheme.ink,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${tenant.id} · ${tenant.plan}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: _muted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _statusPill(tenant.active),
            ],
          ),
          const SizedBox(height: 13),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 7.0;
              // During responsive breakpoint changes Flutter can briefly lay
              // out this card with zero available width. Never pass a negative
              // width to SizedBox, which causes BoxConstraints assertions.
              final availableWidth = constraints.maxWidth.isFinite
                  ? constraints.maxWidth
                  : 0.0;
              final width = ((availableWidth - gap * 2) / 3)
                  .clamp(0.0, double.infinity)
                  .toDouble();
              if (availableWidth < 90) {
                return Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    actionButton(
                      label: 'Configure',
                      onPressed: () => _showConfigureTenant(tenant),
                      color: _navy,
                      icon: Icons.tune,
                    ),
                    actionButton(
                      label: 'Backup',
                      onPressed: () => _downloadJson([
                        tenant,
                      ], 'tenant_${tenant.id}_backup.json'),
                      color: _navy,
                    ),
                    actionButton(
                      label: tenant.active ? 'Disable' : 'Enable',
                      onPressed: () => _confirmStatus(
                        active: !tenant.active,
                        specific: [tenant],
                      ),
                      color: tenant.active ? _red : _green,
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  SizedBox(
                    width: width,
                    child: actionButton(
                      label: 'Configure',
                      onPressed: () => _showConfigureTenant(tenant),
                      color: _navy,
                      icon: Icons.tune,
                    ),
                  ),
                  const SizedBox(width: gap),
                  SizedBox(
                    width: width,
                    child: actionButton(
                      label: 'Backup',
                      onPressed: () => _downloadJson([
                        tenant,
                      ], 'tenant_${tenant.id}_backup.json'),
                      color: _navy,
                    ),
                  ),
                  const SizedBox(width: gap),
                  SizedBox(
                    width: width,
                    child: actionButton(
                      label: tenant.active ? 'Disable' : 'Enable',
                      onPressed: () => _confirmStatus(
                        active: !tenant.active,
                        specific: [tenant],
                      ),
                      color: tenant.active ? _red : _green,
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

  Widget _mobileInfo(String label, String value) => SizedBox(
    width: 130,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: _muted)),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );

  Widget _buildPagination({
    required int start,
    required int end,
    required int total,
    required bool mobile,
  }) {
    final pages = _paginationNumbers();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 12 : 20, vertical: 12),
      color: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 520;
          final pagination = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _paginationArrow(
                icon: Icons.chevron_left,
                tooltip: 'Previous page',
                enabled: _page > 1,
                onTap: () => setState(() => _page--),
              ),
              const SizedBox(width: 8),
              for (final pageNumber in pages)
                if (pageNumber == -1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '…',
                      style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 15),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: InkWell(
                      onTap: () => setState(() => _page = pageNumber),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 46,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: pageNumber == _page
                              ? AppTheme.ink3
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$pageNumber',
                          style: TextStyle(
                            fontSize: 15,
                            color: pageNumber == _page
                                ? Colors.white
                                : AppTheme.ink,
                          ),
                        ),
                      ),
                    ),
                  ),
              const SizedBox(width: 8),
              _paginationArrow(
                icon: Icons.chevron_right,
                tooltip: 'Next page',
                enabled: _page < _pageCount,
                onTap: () => setState(() => _page++),
              ),
            ],
          );

          final count = Text(
            total == 0
                ? 'Showing 0 of 0 tenants'
                : 'Showing $start-$end of $total tenants',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.ink2,
            ),
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                count,
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: pagination,
                ),
              ],
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [count, pagination],
          );
        },
      ),
    );
  }

  Widget _paginationArrow({
    required IconData icon,
    required String tooltip,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 46,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: enabled
                  ? const Color(0xFFD1D5DB)
                  : const Color(0xFFE5E7EB),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 26,
            color: enabled ? AppTheme.ink2 : const Color(0xFFD1D5DB),
          ),
        ),
      ),
    );
  }

  List<int> _paginationNumbers() {
    final last = _pageCount;
    if (last <= 5) return List<int>.generate(last, (i) => i + 1);
    if (_page <= 3) return [1, 2, 3, -1, last];
    if (_page >= last - 2) return [1, -1, last - 2, last - 1, last];
    return [1, -1, _page, -1, last];
  }

  Widget _filterDropdown(
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
    String label,
  ) {
    return Container(
      constraints: const BoxConstraints(minWidth: 0, maxWidth: 180),
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: _line),
        borderRadius: BorderRadius.circular(9),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 17),
          style: const TextStyle(fontSize: 12, color: AppTheme.text),
          items: options
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item == 'All subscriptions'
                        ? 'Subscription'
                        : item == 'All statuses'
                        ? 'Status'
                        : item == 'All regions'
                        ? 'Region'
                        : item,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, {Widget? prefix}) =>
      InputDecoration(
        hintText: hint,
        prefixIcon: prefix,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        hintStyle: const TextStyle(color: _muted, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: _line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: _line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: _blue),
        ),
      );

  Widget _outlineButton(String label, IconData icon, VoidCallback onPressed) =>
      OutlinedButton.icon(
        onPressed: _busy ? null : onPressed,
        icon: Icon(icon, size: 17),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF1C2938),
          side: const BorderSide(color: _line),
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      );

  Widget _primaryButton(String label, IconData icon, VoidCallback onPressed) =>
      ElevatedButton.icon(
        onPressed: _busy ? null : onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: _blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      );

  Widget _smallAction(
    String label,
    Color color,
    IconData icon,
    VoidCallback onPressed, {
    bool neutral = false,
  }) => OutlinedButton.icon(
    onPressed: _selectedIds.isEmpty ? null : onPressed,
    icon: Icon(icon, size: 14),
    label: Text(label),
    style: OutlinedButton.styleFrom(
      foregroundColor: neutral ? AppTheme.ink : color,
      backgroundColor: Colors.white,
      side: BorderSide(
        color: neutral ? const Color(0xFF6478FF) : color.withOpacity(.75),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      minimumSize: const Size(0, 29),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    ),
  );

  Widget _statusPill(bool active) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(
      color: active ? const Color(0xFFE4F6EB) : const Color(0xFFFFE9E9),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? _green : _red,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          active ? 'Active' : 'Inactive',
          style: TextStyle(
            color: active ? const Color(0xFF15803D) : _red,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );

  Future<void> _showCreateTenant() async {
    final result = await _showTenantForm();
    if (result == null) return;
    setState(() {
      final id = _nextTenantId();
      _tenants.insert(
        0,
        _Tenant(
          id: id,
          name: result.name,
          plan: result.plan,
          region: result.region,
          createdOn: _today(),
          active: result.active,
          email: result.email,
          industry: result.industry,
          contact: result.contact,
          companySize: result.companySize,
        ),
      );
      _page = 1;
      _selectedIds.clear();
    });
    _toast('Tenant created successfully.');
  }

  Future<void> _showEditTenant(_Tenant tenant) async {
    final result = await _showTenantForm(existing: tenant);
    if (result == null) return;
    setState(() {
      tenant.name = result.name;
      tenant.plan = result.plan;
      tenant.region = result.region;
      tenant.email = result.email;
      tenant.industry = result.industry;
      tenant.contact = result.contact;
      tenant.companySize = result.companySize;
      tenant.active = result.active;
    });
    _toast('Tenant configuration saved.');
  }

  Future<_TenantFormResult?> _showTenantForm({_Tenant? existing}) async {
    final formKey = GlobalKey<FormState>();
    final name = TextEditingController(text: existing?.name ?? '');
    final email = TextEditingController(text: existing?.email ?? '');
    final contact = TextEditingController(text: existing?.contact ?? '');
    final industry = TextEditingController(
      text: existing?.industry ?? 'Technology',
    );
    final size = TextEditingController(
      text: existing?.companySize ?? '11–50 employees',
    );
    String plan = existing?.plan ?? 'Enterprise';
    String region = existing?.region ?? 'India';
    bool active = existing?.active ?? true;
    final result = await showDialog<_TenantFormResult>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          final narrow = MediaQuery.of(context).size.width < 520;
          return AlertDialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.symmetric(
              horizontal: narrow ? 14 : 28,
              vertical: 22,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: Text(
              existing == null ? 'Create Tenant' : 'Configure Tenant',
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: AppTheme.ink,
              ),
            ),
            content: SizedBox(
              width: 470,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _formField(
                        name,
                        'Organization name *',
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Enter organization name'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      _formField(
                        email,
                        'Organization email *',
                        keyboard: TextInputType.emailAddress,
                        validator: (v) =>
                            v == null ||
                                !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                    .hasMatch(v.trim())
                            ? 'Enter a valid email address'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      _formField(
                        contact,
                        'Contact number',
                        keyboard: TextInputType.phone,
                      ),
                      const SizedBox(height: 12),
                      _formField(industry, 'Industry'),
                      const SizedBox(height: 12),
                      _formField(size, 'Organization size'),
                      const SizedBox(height: 12),
                      _dialogDropdown<String>('License plan', plan, const [
                        'Starter',
                        'Business',
                        'Enterprise',
                      ], (v) => setDialogState(() => plan = v!)),
                      const SizedBox(height: 12),
                      _dialogDropdown<String>('Region', region, const [
                        'North America',
                        'Europe',
                        'Asia Pacific',
                        'India',
                      ], (v) => setDialogState(() => region = v!)),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: active,
                        activeColor: _green,
                        title: const Text('Tenant is active'),
                        onChanged: (v) => setDialogState(() => active = v),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  Navigator.pop(
                    dialogContext,
                    _TenantFormResult(
                      name: name.text.trim(),
                      email: email.text.trim(),
                      contact: contact.text.trim(),
                      industry: industry.text.trim(),
                      companySize: size.text.trim(),
                      plan: plan,
                      region: region,
                      active: active,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _blue,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  existing == null ? 'Create Tenant' : 'Save Changes',
                ),
              ),
            ],
          );
        },
      ),
    );
    name.dispose();
    email.dispose();
    contact.dispose();
    industry.dispose();
    size.dispose();
    return result;
  }

  Widget _formField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboard,
    String? Function(String?)? validator,
  }) => TextFormField(
    controller: controller,
    keyboardType: keyboard,
    validator: validator,
    decoration: _inputDecoration(label),
  );

  Widget _dialogDropdown<T>(
    String label,
    T value,
    List<T> values,
    ValueChanged<T?> onChanged,
  ) => DropdownButtonFormField<T>(
    value: value,
    decoration: _inputDecoration(label),
    items: values
        .map((v) => DropdownMenuItem<T>(value: v, child: Text('$v')))
        .toList(),
    onChanged: onChanged,
  );

  Future<void> _confirmStatus({
    required bool active,
    List<_Tenant>? specific,
  }) async {
    final targets = specific ?? _selectedTenants;
    if (targets.isEmpty) {
      _toast('Select at least one tenant first.');
      return;
    }
    final singular = targets.length == 1;
    final tenant = targets.first;
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(dialogContext).size.width < 380 ? 12 : 20,
          vertical: 18,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsets.fromLTRB(
          MediaQuery.of(dialogContext).size.width < 380 ? 13 : 17,
          13,
          MediaQuery.of(dialogContext).size.width < 380 ? 13 : 17,
          4,
        ),
        content: SizedBox(
          width: MediaQuery.of(dialogContext).size.width < 380 ? 270 : 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: active
                          ? const Color(0xFFE8FBF1)
                          : const Color(0xFFFFEEEE),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      active
                          ? Icons.check_circle_outline
                          : Icons.block_outlined,
                      color: active ? _green : _red,
                      size: 19,
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          active
                              ? 'Enable Tenant${singular ? '' : 's'}'
                              : 'Disable Tenant${singular ? '' : 's'}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.ink,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          active
                              ? 'Are you sure you want to enable ${singular ? 'this tenant' : 'these tenants'}?'
                              : 'Are you sure you want to disable ${singular ? 'this tenant' : 'these tenants'}?',
                          style: const TextStyle(fontSize: 11.5, color: _muted),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    icon: const Icon(Icons.close, color: Color(0xFF98A2B3)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFFF0FCF5)
                      : const Color(0xFFFFF1F2),
                  border: Border.all(
                    color: active
                        ? const Color(0xFFCCF5DB)
                        : const Color(0xFFFFD6DA),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  active
                      ? 'Once enabled, ${singular ? 'the tenant will' : 'the selected tenants will'} be able to access the platform.'
                      : '${singular ? 'The tenant' : 'The selected tenants'} will not be able to access the platform after being disabled.',
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.3,
                    color: active ? const Color(0xFF16803D) : _red,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFF2C68EF),
                    child: Text(
                      tenant.name.isNotEmpty
                          ? tenant.name[0].toUpperCase()
                          : 'T',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          singular
                              ? tenant.name
                              : '${targets.length} tenants selected',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.ink,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          singular
                              ? tenant.industry
                              : 'Selected tenant records',
                          style: const TextStyle(fontSize: 10.5, color: _muted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(14, 3, 14, 12),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: _line),
              foregroundColor: const Color(0xFF344054),
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (!mounted) return;
              setState(() {
                for (final item in targets) {
                  item.active = active;
                }
                _selectedIds.removeAll(targets.map((t) => t.id));
              });
              // Close the confirmation dialog first so the success notice
              // is displayed over the normal page, not over the dimmed dialog.
              Navigator.pop(dialogContext, true);
            },
            icon: Icon(
              active ? Icons.check_circle_outline : Icons.block_outlined,
              size: 17,
            ),
            label: Text(
              active
                  ? 'Enable Tenant${singular ? '' : 's'}'
                  : 'Disable Tenant${singular ? '' : 's'}',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: active ? _green : _red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;

    _showTenantStatusNotice(
      active: active,
      title: active ? 'Tenant Enabled' : 'Tenant Disabled',
      message: active
          ? (singular
                ? "'${tenant.name}' has been activated across the platform."
                : '${targets.length} tenants have been activated across the platform.')
          : (singular
                ? "'${tenant.name}' has been deactivated across the platform."
                : '${targets.length} tenants have been deactivated across the platform.'),
    );
  }

  void _showTenantStatusNotice({
    required bool active,
    required String title,
    required String message,
  }) {
    if (!mounted) return;
    final overlay = Overlay.of(context, rootOverlay: true);
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (overlayContext) => Stack(
        fit: StackFit.expand,
        children: [
          // Keep the same dimmed backdrop while the success notice is visible.
          // The confirmation dialog itself closes before this overlay is shown.
          const Positioned.fill(child: ColoredBox(color: Color(0x99000000))),
          Positioned(
            top: (MediaQuery.of(overlayContext).size.height / 2 - 85).clamp(
              12.0,
              double.infinity,
            ),
            left: 14,
            right: 14,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 390),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: active
                            ? const Color(0xFFB7E8C8)
                            : const Color(0xFFFFC7C7),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            decoration: BoxDecoration(
                              color: active ? _green : _red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.check_circle_outline,
                            color: active ? _green : _red,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.ink,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  message,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    height: 1.25,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
    overlay.insert(entry);
    Future<void>.delayed(const Duration(seconds: 3), () {
      entry.remove();
      entry.dispose();
    });
  }

  Future<void> _configureSelected() async {
    final targets = _selectedTenants;
    if (targets.isEmpty) {
      _toast('Select a tenant to configure.');
      return;
    }
    // The Configure Tenant form edits one tenant at a time. When multiple
    // rows are selected, open the form for the first selected tenant.
    await _showConfigureTenant(targets.first);
  }

  Future<void> _showConfigureTenant(_Tenant tenant) async {
    String plan = tenant.plan;
    String region = tenant.region == 'India'
        ? 'India (Asia South)'
        : tenant.region;
    String storageLimit = tenant.storageLimitGb.toString();
    bool active = tenant.active;

    final result = await showDialog<_TenantConfigureResult>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          final narrow = MediaQuery.of(context).size.width < 560;
          final inputBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(color: _line),
          );
          InputDecoration decoration(String label) => InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: inputBorder,
            enabledBorder: inputBorder,
            focusedBorder: inputBorder.copyWith(
              borderSide: const BorderSide(color: _blue, width: 1.4),
            ),
          );
          Widget dropdown(
            String label,
            String value,
            List<String> options,
            ValueChanged<String?> onChanged,
            String helper,
          ) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.ink,
                  ),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: value,
                  isExpanded: true,
                  decoration: decoration(label),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: _muted,
                  ),
                  items: options
                      .map(
                        (option) => DropdownMenuItem(
                          value: option,
                          child: Text(
                            option,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                ),
                const SizedBox(height: 4),
                Text(
                  helper,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF8A9AB2),
                  ),
                ),
              ],
            );
          }

          return Dialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.symmetric(
              horizontal: narrow ? 14 : 28,
              vertical: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500,
                maxHeight: MediaQuery.of(context).size.height * 0.88,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  narrow ? 14 : 20,
                  narrow ? 14 : 18,
                  narrow ? 14 : 20,
                  14,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                                'Configure Tenant',
                                style: const TextStyle(
                                  fontSize: 18,
                                  height: 1.2,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.ink,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Update the key settings for ${tenant.name}.',
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFF71829D),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          tooltip: 'Close',
                          onPressed: () => Navigator.pop(dialogContext),
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Color(0xFF9AA5B5),
                            size: 23,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    dropdown(
                      'Subscription Plan',
                      plan,
                      const ['Starter', 'Business', 'Enterprise'],
                      (v) => setDialogState(() => plan = v!),
                      'Defines feature access and usage limits.',
                    ),
                    const SizedBox(height: 12),
                    dropdown(
                      'Region',
                      region,
                      const [
                        'North America',
                        'Europe',
                        'Asia Pacific',
                        'India (Asia South)',
                      ],
                      (v) => setDialogState(() => region = v!),
                      'Select the primary region for this tenant.',
                    ),
                    const SizedBox(height: 17),
                    const Text(
                      'Storage Limit',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.ink,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: storageLimit,
                            keyboardType: TextInputType.number,
                            onChanged: (v) => storageLimit = v,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              border: inputBorder,
                              enabledBorder: inputBorder,
                              focusedBorder: inputBorder.copyWith(
                                borderSide: const BorderSide(
                                  color: _blue,
                                  width: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 49,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            border: Border.all(color: _line),
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(9),
                            ),
                          ),
                          child: const Text(
                            'GB',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF71829D),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Maximum storage allowed for this tenant.',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF8A9AB2),
                      ),
                    ),
                    const SizedBox(height: 17),
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.ink,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RadioListTile<bool>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      activeColor: _blue,
                      value: true,
                      groupValue: active,
                      onChanged: (v) => setDialogState(() => active = v!),
                      title: const Text(
                        'Active',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.ink,
                        ),
                      ),
                      subtitle: const Text(
                        'Tenant can access the platform',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF8A9AB2),
                        ),
                      ),
                    ),
                    RadioListTile<bool>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      activeColor: _blue,
                      value: false,
                      groupValue: active,
                      onChanged: (v) => setDialogState(() => active = v!),
                      title: const Text(
                        'Inactive',
                        style: TextStyle(fontSize: 13, color: AppTheme.ink),
                      ),
                      subtitle: const Text(
                        'Tenant access will be restricted',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF8A9AB2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: Color(0xFFEEF1F5), height: 1),
                    const SizedBox(height: 12),
                    Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF344054),
                            side: const BorderSide(color: _line),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 13,
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final parsed = int.tryParse(storageLimit);
                            if (parsed == null || parsed <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Enter a valid storage limit.'),
                                ),
                              );
                              return;
                            }
                            Navigator.pop(
                              dialogContext,
                              _TenantConfigureResult(
                                plan: plan,
                                region: region,
                                active: active,
                                storageLimitGb: parsed,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _blue,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 13,
                            ),
                          ),
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    if (result == null || !mounted) return;
    setState(() {
      tenant.plan = result.plan;
      tenant.region = result.region == 'India (Asia South)'
          ? 'India'
          : result.region;
      tenant.active = result.active;
      tenant.storageLimitGb = result.storageLimitGb;
      _selectedIds.remove(tenant.id);
    });
    _toast('Tenant configuration saved.');
  }

  Future<void> _showTenantDetails(_Tenant tenant) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          tenant.name,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        content: SizedBox(
          width: 430,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _detailRow('Tenant ID', tenant.id),
                _detailRow('License plan', tenant.plan),
                _detailRow('Status', tenant.active ? 'Active' : 'Inactive'),
                _detailRow('Region', tenant.region),
                _detailRow('Created on', tenant.createdOn),
                _detailRow('Email', tenant.email),
                _detailRow(
                  'Contact number',
                  tenant.contact.isEmpty ? '—' : tenant.contact,
                ),
                _detailRow('Industry', tenant.industry),
                _detailRow('Organization size', tenant.companySize),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _showConfigureTenant(tenant);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Configure'),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: const TextStyle(color: _muted, fontSize: 13),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );

  Future<void> _backupSelected() async {
    final targets = List<_Tenant>.from(_selectedTenants);
    if (targets.isEmpty) {
      _toast('Select tenant records to back up.');
      return;
    }

    String backupType = 'Full Backup';
    String storageLocation = 'Cloud Storage (Default)';
    bool starting = false;

    final shouldStart = await showDialog<bool>(
      context: context,
      barrierDismissible: !starting,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          final singleTenant = targets.length == 1
              ? targets.first.name
              : '${targets.length} selected tenants';
          String helpForType() {
            switch (backupType) {
              case 'Incremental Backup':
                return 'Includes tenant data changed since the previous backup.';
              case 'Configuration Only':
                return 'Includes tenant settings and configuration details only.';
              default:
                return 'Creates a complete backup of all selected tenant data.';
            }
          }

          Widget fieldLabel(String label) => Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.text,
                ),
                children: [
                  TextSpan(text: label),
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Color(0xFFEF4444)),
                  ),
                ],
              ),
            ),
          );

          InputDecoration dropdownDecoration() => InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0xFFDDE3EC)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0xFFDDE3EC)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: AppTheme.ink3, width: 1.4),
            ),
            filled: true,
            fillColor: Colors.white,
          );

          return Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 24,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 535),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 21, 22, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 47,
                          height: 47,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF4FF),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Icon(
                            Icons.storage_rounded,
                            color: Color(0xFF245BEB),
                            size: 23,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Backup Tenant',
                                style: TextStyle(
                                  fontSize: 21,
                                  height: 1.2,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.ink,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Create a backup for $singleTenant.',
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFF71819B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: 'Close',
                          visualDensity: VisualDensity.compact,
                          onPressed: starting
                              ? null
                              : () => Navigator.of(dialogContext).pop(false),
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Color(0xFF98A2B3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    fieldLabel('Backup Type'),
                    DropdownButtonFormField<String>(
                      value: backupType,
                      isExpanded: true,
                      decoration: dropdownDecoration(),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      items: const [
                        DropdownMenuItem(
                          value: 'Full Backup',
                          child: Text('Full Backup'),
                        ),
                        DropdownMenuItem(
                          value: 'Incremental Backup',
                          child: Text('Incremental Backup'),
                        ),
                        DropdownMenuItem(
                          value: 'Configuration Only',
                          child: Text('Configuration Only'),
                        ),
                      ],
                      onChanged: starting
                          ? null
                          : (value) {
                              if (value != null)
                                setDialogState(() => backupType = value);
                            },
                    ),
                    const SizedBox(height: 7),
                    Text(
                      helpForType(),
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF91A0B8),
                      ),
                    ),
                    const SizedBox(height: 17),
                    fieldLabel('Storage Location'),
                    DropdownButtonFormField<String>(
                      value: storageLocation,
                      isExpanded: true,
                      decoration: dropdownDecoration(),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      items: const [
                        DropdownMenuItem(
                          value: 'Cloud Storage (Default)',
                          child: Text('Cloud Storage (Default)'),
                        ),
                        DropdownMenuItem(
                          value: 'Local Download',
                          child: Text('Local Download'),
                        ),
                      ],
                      onChanged: starting
                          ? null
                          : (value) {
                              if (value != null)
                                setDialogState(() => storageLocation = value);
                            },
                    ),
                    const SizedBox(height: 7),
                    Text(
                      storageLocation == 'Cloud Storage (Default)'
                          ? 'Cloud storage is not connected in this demo; the generated backup will be copied for saving.'
                          : 'The generated backup data will be copied so you can save it as a JSON file.',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF91A0B8),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Divider(height: 1, color: Color(0xFFEEF1F5)),
                    const SizedBox(height: 13),
                    Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        OutlinedButton(
                          onPressed: starting
                              ? null
                              : () => Navigator.of(dialogContext).pop(false),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF344054),
                            side: const BorderSide(color: Color(0xFFDDE3EC)),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 13,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: starting
                              ? null
                              : () async {
                                  setDialogState(() => starting = true);
                                  await Future<void>.delayed(
                                    const Duration(milliseconds: 650),
                                  );
                                  if (dialogContext.mounted)
                                    Navigator.of(dialogContext).pop(true);
                                },
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF245BEB),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 13,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          icon: starting
                              ? const SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.storage_rounded, size: 16),
                          label: Text(
                            starting ? 'Preparing Backup…' : 'Start Backup',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    if (shouldStart != true || !mounted) return;
    final selectedData = targets.map((tenant) {
      final data = tenant.toJson();
      if (backupType == 'Configuration Only') {
        return <String, dynamic>{
          'tenantId': data['tenantId'],
          'tenantName': data['tenantName'],
          'licensePlan': data['licensePlan'],
          'region': data['region'],
          'status': data['status'],
        };
      }
      return data;
    }).toList();
    final payload = <String, dynamic>{
      'backupName':
          'onecloud_tenant_backup_${DateTime.now().millisecondsSinceEpoch}',
      'backupType': backupType,
      'storageLocation': storageLocation,
      'createdAt': DateTime.now().toIso8601String(),
      'tenantCount': selectedData.length,
      'tenants': selectedData,
    };
    final filename =
        'onecloud_tenant_backup_${DateTime.now().millisecondsSinceEpoch}.json';
    await _downloadText(
      filename,
      const JsonEncoder.withIndent('  ').convert(payload),
      'application/json;charset=utf-8',
    );
    if (!mounted) return;
    _toast(
      storageLocation == 'Cloud Storage (Default)'
          ? 'Backup prepared. JSON data copied to clipboard; cloud storage is not connected.'
          : 'Backup prepared. JSON data copied to clipboard; save it as $filename.',
    );
  }

  Future<void> _downloadJson(List<_Tenant> targets, String filename) async {
    final payload = targets.map((tenant) => tenant.toJson()).toList();
    await _downloadText(
      filename,
      const JsonEncoder.withIndent('  ').convert(payload),
      'application/json;charset=utf-8',
    );
  }

  Future<void> _downloadText(
    String filename,
    String content,
    String mime,
  ) async {
    final dot = filename.lastIndexOf('.');
    final extension = dot >= 0 ? filename.substring(dot + 1) : 'txt';
    final name = dot >= 0 ? filename.substring(0, dot) : filename;
    await FileSaver.instance.saveFile(
      name: name,
      bytes: Uint8List.fromList(utf8.encode(content)),
      fileExtension: extension,
      mimeType: MimeType.text,
    );
  }

  Future<void> _showExportDialog() async {
    if (_busy) return;
    String scope = 'All Tenants';
    String format = 'Excel (.xlsx)';
    bool working = false;
    final fields = <String>[
      'Tenant Name',
      'Tenant ID',
      'Domain',
      'Subscription Plan',
      'Status',
      'Region',
      'Storage Used',
      'Created On',
      'Last Backup',
      'Actions',
    ];
    final selectedFields = <String>{...fields};

    final selectedFormat = await showDialog<_TenantExportRequest>(
      context: context,
      barrierDismissible: !working,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          final narrow = MediaQuery.of(context).size.width < 560;
          final border = Border.all(color: const Color(0xFFDDE5F0));
          Widget radioScope(String value, String title, String subtitle) {
            final selected = scope == value;
            return InkWell(
              onTap: working ? null : () => setDialogState(() => scope = value),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Icon(
                      selected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: selected ? _blue : const Color(0xFFC8D3E2),
                      size: 21,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: selected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: AppTheme.ink,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFF71829D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          Widget formatOption(
            String value,
            IconData icon,
            String title,
            String subtitle,
            Color iconColor,
          ) {
            final selected = format == value;
            return InkWell(
              borderRadius: BorderRadius.circular(9),
              onTap: working
                  ? null
                  : () => setDialogState(() => format = value),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selected ? const Color(0xFFF5F8FF) : Colors.white,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: selected ? _blue : const Color(0xFFE5EAF2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          size: 19,
                          color: selected ? _blue : const Color(0xFFC8D3E2),
                        ),
                        const SizedBox(width: 7),
                        Icon(icon, size: 17, color: iconColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.ink,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.only(left: 26),
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 10.5,
                          height: 1.25,
                          color: Color(0xFF71829D),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Dialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.symmetric(
              horizontal: narrow ? 12 : 28,
              vertical: 18,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 570),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 20, 22, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 43,
                          height: 43,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F6FF),
                            border: Border.all(color: const Color(0xFFD8E7FF)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.download_rounded,
                            color: Color(0xFF2563EB),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Export Tenants',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.ink,
                                ),
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                'Export tenant data in your preferred format.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF71829D),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: working
                              ? null
                              : () => Navigator.pop(dialogContext),
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Color(0xFF9AA5B5),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Export Scope',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.ink,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: border,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          radioScope(
                            'All Tenants',
                            'All Tenants',
                            'Export data of all tenants (${_tenants.length} tenants)',
                          ),
                          const Divider(height: 1, color: Color(0xFFEDF1F7)),
                          radioScope(
                            'Selected Tenants',
                            'Selected Tenants',
                            'Export data of only selected tenants (${_selectedIds.length} selected)',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 17),
                    const Text(
                      'File Format',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.ink,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        formatOption(
                          'Excel (.xlsx)',
                          Icons.table_chart_rounded,
                          'Excel (.xlsx)',
                          'Recommended for data analysis',
                          const Color(0xFF079669),
                        ),
                        const SizedBox(height: 6),
                        formatOption(
                          'CSV (.csv)',
                          Icons.description_outlined,
                          'CSV (.csv)',
                          'Lightweight file format',
                          const Color(0xFF64748B),
                        ),
                        const SizedBox(height: 6),
                        formatOption(
                          'PDF (.pdf)',
                          Icons.picture_as_pdf_rounded,
                          'PDF (.pdf)',
                          'Formatted report for sharing',
                          const Color(0xFFF43F5E),
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Export Columns',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.ink,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: working
                              ? null
                              : () => setDialogState(() {
                                  if (selectedFields.length == fields.length) {
                                    selectedFields.clear();
                                  } else {
                                    selectedFields.addAll(fields);
                                  }
                                }),
                          child: Text(
                            selectedFields.length == fields.length
                                ? 'Deselect All'
                                : 'Select All',
                          ),
                        ),
                      ],
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final columns = 2;
                        return GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 6,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          childAspectRatio: constraints.maxWidth < 360
                              ? 2.5
                              : 3.2,
                          children: fields
                              .map(
                                (field) => InkWell(
                                  onTap: working
                                      ? null
                                      : () => setDialogState(() {
                                          if (!selectedFields.add(field))
                                            selectedFields.remove(field);
                                        }),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 3,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: Checkbox(
                                            value: selectedFields.contains(
                                              field,
                                            ),
                                            activeColor: const Color(
                                              0xFF2D65F5,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            onChanged: working
                                                ? null
                                                : (v) => setDialogState(() {
                                                    if (v == true)
                                                      selectedFields.add(field);
                                                    else
                                                      selectedFields.remove(
                                                        field,
                                                      );
                                                  }),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            field,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF34445D),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    const Divider(height: 1, color: Color(0xFFEEF1F5)),
                    const SizedBox(height: 12),
                    Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        OutlinedButton(
                          onPressed: working
                              ? null
                              : () => Navigator.pop(dialogContext),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF344054),
                            side: const BorderSide(color: Color(0xFFDDE3EC)),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 21,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: working
                              ? null
                              : () async {
                                  if (scope == 'Selected Tenants' &&
                                      _selectedIds.isEmpty) {
                                    ScaffoldMessenger.of(this.context)
                                        .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Select at least one tenant, or choose All Tenants.',
                                            ),
                                          ),
                                        );
                                    return;
                                  }
                                  if (selectedFields.isEmpty) {
                                    ScaffoldMessenger.of(
                                      this.context,
                                    ).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Select at least one export column.',
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  setDialogState(() => working = true);
                                  Navigator.pop(
                                    dialogContext,
                                    _TenantExportRequest(
                                      scope: scope,
                                      format: format,
                                      fields: fields
                                          .where(selectedFields.contains)
                                          .toList(),
                                    ),
                                  );
                                },
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF3046FF),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          icon: const Icon(Icons.download_rounded, size: 16),
                          label: const Text(
                            'Export',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    if (selectedFormat == null || !mounted) return;
    final rows = selectedFormat.scope == 'All Tenants'
        ? _tenants.toList()
        : _selectedTenants;
    if (rows.isEmpty) {
      _toast('There are no tenant records to export.');
      return;
    }
    try {
      setState(() => _busy = true);
      final values = rows.map((t) => _exportValues(t)).toList();
      final columns = selectedFormat.fields;
      final stamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .replaceAll('.', '-');
      final baseName = 'onecloud_tenants_$stamp';
      late Uint8List bytes;
      late String filename;
      late String mime;
      if (selectedFormat.format == 'CSV (.csv)') {
        final csv = <String>[
          columns.map(_csvCell).join(','),
          ...values.map(
            (row) =>
                columns.map((field) => _csvCell(row[field] ?? '')).join(','),
          ),
        ].join('\r\n');
        bytes = Uint8List.fromList(utf8.encode('\uFEFF$csv'));
        filename = '$baseName.csv';
        mime = 'text/csv;charset=utf-8';
      } else if (selectedFormat.format == 'Excel (.xlsx)') {
        final workbook = xl.Excel.createExcel();
        workbook.rename('Sheet1', 'Tenants');
        final sheet = workbook['Tenants'];
        sheet.appendRow(columns.map((c) => xl.TextCellValue(c)).toList());
        for (final row in values) {
          sheet.appendRow(
            columns.map((c) => xl.TextCellValue(row[c] ?? '')).toList(),
          );
        }
        final encodedWorkbook = workbook.encode();
        if (encodedWorkbook == null) {
          throw Exception('Could not generate the Excel workbook.');
        }
        bytes = Uint8List.fromList(encodedWorkbook);
        filename = '$baseName.xlsx';
        mime =
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      } else {
        final pdfDocument = pw.Document();
        pdfDocument.addPage(
          pw.MultiPage(
            pageFormat: pdf.PdfPageFormat.a4.landscape,
            margin: const pw.EdgeInsets.all(24),
            build: (_) => [
              pw.Text(
                'OneCloud — Tenant Export',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                'Generated: ${DateTime.now().toLocal()}  •  Tenants: ${rows.length}',
                style: const pw.TextStyle(fontSize: 9),
              ),
              pw.SizedBox(height: 14),
              pw.TableHelper.fromTextArray(
                headers: columns,
                data: values
                    .map((row) => columns.map((c) => row[c] ?? '').toList())
                    .toList(),
                headerStyle: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                  color: pdf.PdfColors.white,
                ),
                headerDecoration: const pw.BoxDecoration(
                  color: pdf.PdfColor.fromInt(0xFF102A56),
                ),
                cellStyle: const pw.TextStyle(fontSize: 7),
                cellAlignment: pw.Alignment.centerLeft,
                border: pw.TableBorder.all(
                  color: pdf.PdfColors.grey300,
                  width: .5,
                ),
              ),
            ],
          ),
        );
        bytes = Uint8List.fromList(await pdfDocument.save());
        filename = '$baseName.pdf';
        mime = 'application/pdf';
      }
      final extension = selectedFormat.format == 'Excel (.xlsx)'
          ? 'xlsx'
          : selectedFormat.format == 'CSV (.csv)'
          ? 'csv'
          : 'pdf';
      final mimeType = selectedFormat.format == 'Excel (.xlsx)'
          ? MimeType.microsoftExcel
          : selectedFormat.format == 'CSV (.csv)'
          ? MimeType.csv
          : MimeType.pdf;
      await FileSaver.instance.saveFile(
        name: baseName,
        bytes: bytes,
        fileExtension: extension,
        mimeType: mimeType,
      );
      if (mounted) {
        _toast(
          '${rows.length} tenant record${rows.length == 1 ? '' : 's'} exported successfully.',
        );
      }
    } catch (error) {
      if (mounted) _toast('Export failed: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Map<String, String> _exportValues(_Tenant t) => {
    'Tenant Name': t.name,
    'Tenant ID': t.id,
    'Domain': t.email.contains('@') ? t.email.split('@').last : '',
    'Subscription Plan': t.plan,
    'Status': t.active ? 'Active' : 'Inactive',
    'Region': t.region,
    'Storage Used': '0 GB',
    'Created On': t.createdOn,
    'Last Backup': 'Not available',
    'Actions': 'Configure; Backup',
  };

  String _csvCell(String value) => '"${value.replaceAll('"', '""')}"';

  void _refresh() {
    setState(() {
      _page = 1;
      _selectedIds.clear();
    });
    _toast('Tenant list refreshed.');
  }

  void _toast(String message, {Color color = AppTheme.ink}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
  }

  String _nextTenantId() {
    var next = _tenants.length + 1;
    var id = 'TEN-${next.toString().padLeft(3, '0')}';
    while (_tenants.any((tenant) => tenant.id == id)) {
      next++;
      id = 'TEN-${next.toString().padLeft(3, '0')}';
    }
    return id;
  }

  String _today() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
  }
}

class _TableHeading extends StatelessWidget {
  const _TableHeading(this.label);
  final String label;
  @override
  Widget build(BuildContext context) => Text(
    label,
    style: const TextStyle(
      fontSize: 12.5,
      color: Colors.white,
      fontWeight: FontWeight.w700,
      letterSpacing: .35,
    ),
  );
}

class _TenantExportRequest {
  const _TenantExportRequest({
    required this.scope,
    required this.format,
    required this.fields,
  });
  final String scope;
  final String format;
  final List<String> fields;
}

class _Tenant {
  _Tenant({
    required this.id,
    required this.name,
    required this.plan,
    required this.region,
    required this.createdOn,
    required this.active,
    required this.email,
    required this.industry,
    required this.contact,
    required this.companySize,
    this.storageLimitGb = 200,
  });
  final String id;
  String name;
  String plan;
  String region;
  String createdOn;
  bool active;
  String email;
  String industry;
  String contact;
  String companySize;
  int storageLimitGb;

  Map<String, dynamic> toJson() => {
    'tenantId': id,
    'tenantName': name,
    'licensePlan': plan,
    'status': active ? 'Active' : 'Inactive',
    'region': region,
    'createdOn': createdOn,
    'email': email,
    'contact': contact,
    'industry': industry,
    'organizationSize': companySize,
    'storageLimitGb': storageLimitGb,
  };
}

class _TenantFormResult {
  const _TenantFormResult({
    required this.name,
    required this.email,
    required this.contact,
    required this.industry,
    required this.companySize,
    required this.plan,
    required this.region,
    required this.active,
  });
  final String name, email, contact, industry, companySize, plan, region;
  final bool active;
}

class _TenantConfigureResult {
  const _TenantConfigureResult({
    required this.plan,
    required this.region,
    required this.active,
    required this.storageLimitGb,
  });
  final String plan;
  final String region;
  final bool active;
  final int storageLimitGb;
}

List<_Tenant> _seedTenants() {
  const names = [
    'ABC LTD',
    'ABC LTD',
    'ABC LTD',
    'ABC LTD',
    'ABC LTD',
    'Northstar Systems',
    'BluePeak Technologies',
    'Vertex Global',
    'NovaWorks',
    'Cedar Labs',
    'Summit Digital',
    'Orbit Solutions',
    'Pioneer Group',
    'Evergreen Systems',
    'Atlas Consulting',
    'Silverline Tech',
    'BrightPath Ltd',
    'Quantum Bridge',
    'Redwood Partners',
    'Aster Networks',
    'Cloud Harbor',
    'Meridian Labs',
    'Cobalt Industries',
    'Lumen Group',
    'Crescent Software',
    'Ironwood Digital',
    'Maple Leaf Systems',
    'Horizon Works',
    'Keystone Tech',
    'Pinnacle Data',
    'BlueOrbit Ltd',
    'NexaCore',
    'Westbridge Inc',
    'TerraNova Group',
    'FusionPoint',
    'Apex Dynamics',
    'CloudSpring',
    'Vector Labs',
    'OmniStack',
    'Clearview Systems',
    'Greenfield Tech',
    'PrimePath',
    'HelioWorks',
    'CoreBridge',
    'Redstone Digital',
    'Skyline Systems',
    'NextWave Group',
    'Oakstone Labs',
    'CrownPeak',
    'DeltaWorks',
    'Zenith Partners',
    'Arbor Technologies',
    'Mosaic Systems',
    'InnovaSphere',
    'Bridgewell Ltd',
    'Peakline Software',
    'TruNorth Group',
    'Solstice Labs',
    'Unified Tech',
    'Everpath Systems',
    'SilverOak Digital',
    'Bluewater Solutions',
    'CoreVista',
    'Northstar Digital',
    'Aurum Systems',
  ];
  const regions = ['India', 'Asia Pacific', 'Europe', 'North America'];
  const plans = ['Enterprise', 'Business', 'Starter'];
  return List<_Tenant>.generate(65, (i) {
    final firstFive = i < 5;
    return _Tenant(
      id: i == 0
          ? 'ten00x'
          : (firstFive
                ? 'ten00x-${i + 1}'
                : 'TEN-${(i + 1).toString().padLeft(3, '0')}'),
      name: names[i],
      plan: firstFive ? 'Enterprise' : plans[i % plans.length],
      region: regions[i % regions.length],
      createdOn: '10-05-2026',
      active: !<int>{
        8,
        12,
        17,
        24,
        31,
        35,
        42,
        45,
        48,
        51,
        54,
        56,
        61,
      }.contains(i),
      email: 'admin${i + 1}@example.com',
      industry: i % 2 == 0 ? 'Technology Solutions' : 'Business Services',
      contact: '+91 90000 ${(10000 + i).toString()}',
      companySize: i % 3 == 0 ? '51–200 employees' : '11–50 employees',
    );
  });
}
