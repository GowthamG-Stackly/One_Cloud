// import 'package:flutter/material.dart';

// import '../../app_theme.dart';

// class TenantIsolationPage extends StatefulWidget {
//   const TenantIsolationPage({super.key});

//   @override
//   State<TenantIsolationPage> createState() => _TenantIsolationPageState();
// }

// class _TenantIsolationPageState extends State<TenantIsolationPage> {
//   static const List<String> _tenants = [
//     'ABX Technologies Pvt.Ltd',
//     'Stackly Technologies',
//     'Global Tech Solutions',
//     'NextGen Enterprises',
//   ];

//   String _selectedTenant = _tenants.first;
//   final TextEditingController _ipController = TextEditingController();

//   bool _databaseIsolation = true;
//   bool _storageIsolation = true;
//   bool _apiAccess = true;
//   bool _crossTenantAccess = false;
//   bool _privateNetwork = true;
//   bool _ipWhitelisting = true;
//   bool _showSavedMessage = false;

//   bool _savedDatabase = true;
//   bool _savedStorage = true;
//   bool _savedApi = true;
//   bool _savedCrossTenant = false;
//   bool _savedPrivateNetwork = true;
//   bool _savedIpWhitelisting = true;
//   String _savedIp = '';

//   @override
//   void dispose() {
//     _ipController.dispose();
//     super.dispose();
//   }

//   void _saveChanges() {
//     setState(() {
//       _savedDatabase = _databaseIsolation;
//       _savedStorage = _storageIsolation;
//       _savedApi = _apiAccess;
//       _savedCrossTenant = _crossTenantAccess;
//       _savedPrivateNetwork = _privateNetwork;
//       _savedIpWhitelisting = _ipWhitelisting;
//       _savedIp = _ipController.text;
//       _showSavedMessage = true;
//     });
//   }

//   void _resetChanges() {
//     setState(() {
//       _databaseIsolation = _savedDatabase;
//       _storageIsolation = _savedStorage;
//       _apiAccess = _savedApi;
//       _crossTenantAccess = _savedCrossTenant;
//       _privateNetwork = _savedPrivateNetwork;
//       _ipWhitelisting = _savedIpWhitelisting;
//       _ipController.text = _savedIp;
//       _showSavedMessage = false;
//     });
//   }

//   void _refresh() {
//     setState(() => _showSavedMessage = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final width = constraints.maxWidth;
//         final isMobile = width < 600;
//         final horizontalPadding = isMobile ? 12.0 : width < 900 ? 18.0 : 20.0;

//         return SingleChildScrollView(
//           padding: EdgeInsets.fromLTRB(
//             horizontalPadding,
//             isMobile ? 14 : 18,
//             horizontalPadding,
//             24,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildPageHeading(isMobile),
//               if (_showSavedMessage) ...[
//                 const SizedBox(height: 14),
//                 _buildSuccessBanner(),
//               ],
//               const SizedBox(height: 14),
//               _buildTenantSelector(isMobile),
//               const SizedBox(height: 14),
//               _buildSectionCard(
//                 title: 'Isolation Configuration',
//                 icon: Icons.settings_outlined,
//                 children: [
//                   _buildSwitchRow(
//                     title: 'Database Isolation',
//                     subtitle: 'Dedicated database for the tenant',
//                     value: _databaseIsolation,
//                     onChanged: (v) => setState(() => _databaseIsolation = v),
//                   ),
//                   _buildSwitchRow(
//                     title: 'Storage Isolation',
//                     subtitle: 'Dedicated storage for tenant data',
//                     value: _storageIsolation,
//                     onChanged: (v) => setState(() => _storageIsolation = v),
//                   ),
//                   _buildSwitchRow(
//                     title: 'APL Access',
//                     subtitle: 'Restrict API access to the selected tenant',
//                     value: _apiAccess,
//                     onChanged: (v) => setState(() => _apiAccess = v),
//                   ),
//                   _buildSwitchRow(
//                     title: 'Cross - Tenant Access',
//                     subtitle: 'Prevent data access between tenants',
//                     value: _crossTenantAccess,
//                     onChanged: (v) => setState(() => _crossTenantAccess = v),
//                     isLast: true,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 14),
//               _buildSectionCard(
//                 title: 'Network Security',
//                 icon: Icons.shield_outlined,
//                 children: [
//                   _buildSwitchRow(
//                     title: 'Private Network',
//                     subtitle: 'Isolate tenant within private network',
//                     value: _privateNetwork,
//                     onChanged: (v) => setState(() => _privateNetwork = v),
//                   ),
//                   _buildSwitchRow(
//                     title: 'IP whitelisting',
//                     subtitle: 'Allow only specified IP addresses',
//                     value: _ipWhitelisting,
//                     onChanged: (v) => setState(() => _ipWhitelisting = v),
//                   ),
//                   _buildIpAddressRow(isMobile),
//                 ],
//               ),
//               const SizedBox(height: 14),
//               _buildSectionCard(
//                 title: 'Isolation status',
//                 icon: Icons.hub_outlined,
//                 children: [
//                   _buildStatusRow('Database Isolation', _databaseIsolation ? 'Enabled' : 'Disabled', _databaseIsolation),
//                   _buildStatusRow('Storage Isolation', _storageIsolation ? 'Enabled' : 'Disabled', _storageIsolation),
//                   _buildStatusRow('API Security', _apiAccess ? 'Enabled' : 'Disabled', _apiAccess),
//                   _buildStatusRow(
//                     'Compliance Status',
//                     (_databaseIsolation && _storageIsolation && _apiAccess && !_crossTenantAccess)
//                         ? 'Compliant'
//                         : 'Review Required',
//                     _databaseIsolation && _storageIsolation && _apiAccess && !_crossTenantAccess,
//                     isLast: true,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPageHeading(bool isMobile) {
//     final title = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Tenant Isolation',
//           style: TextStyle(
//             color: AppTheme.ink2,
//             fontSize: isMobile ? 22 : 24,
//             fontWeight: FontWeight.w700,
//             height: 1.15,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           'Configure and monitor isolation policies per tenant',
//           style: TextStyle(
//             color: AppTheme.textMuted,
//             fontSize: isMobile ? 12 : 13,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );

//     final actions = Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: [
//         OutlinedButton.icon(
//           onPressed: _refresh,
//           icon: const Icon(Icons.sync, size: 16),
//           label: const Text('Refresh'),
//           style: _actionButtonStyle(),
//         ),
//         OutlinedButton.icon(
//           onPressed: _resetChanges,
//           icon: const Icon(Icons.restart_alt, size: 16),
//           label: const Text('Reset'),
//           style: _actionButtonStyle(),
//         ),
//         ElevatedButton.icon(
//           onPressed: _saveChanges,
//           icon: const Icon(Icons.save_outlined, size: 16),
//           label: const Text('Save'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF304FFE),
//             foregroundColor: Colors.white,
//             elevation: 0,
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
//             textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//           ),
//         ),
//       ],
//     );

//     if (isMobile) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           title,
//           const SizedBox(height: 12),
//           SizedBox(width: double.infinity, child: actions),
//         ],
//       );
//     }

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Expanded(child: title),
//         actions,
//       ],
//     );
//   }

//   ButtonStyle _actionButtonStyle() => OutlinedButton.styleFrom(
//         foregroundColor: AppTheme.ink2,
//         side: const BorderSide(color: AppTheme.border),
//         padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
//         textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//       );

//   Widget _buildSuccessBanner() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       decoration: BoxDecoration(
//         color: AppTheme.paper,
//         borderRadius: BorderRadius.circular(9),
//         border: Border.all(color: const Color(0xFFD4E9DC)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.045),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 5,
//             height: 32,
//             decoration: BoxDecoration(
//               color: const Color(0xFF16834A),
//               borderRadius: BorderRadius.circular(5),
//             ),
//           ),
//           const SizedBox(width: 14),
//           const Icon(Icons.check_circle, color: Color(0xFF16834A), size: 19),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Text(
//               'Your changes has been saved successfully.',
//               style: TextStyle(
//                 color: Color(0xFF16834A),
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: .2,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTenantSelector(bool isMobile) {
//     return Row(
//       children: [
//         const SizedBox(
//           width: 58,
//           child: Text(
//             'Tenant',
//             style: TextStyle(
//               color: AppTheme.ink2,
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//         SizedBox(
//           width: isMobile ? 220 : 240,
//           child: DropdownButtonFormField<String>(
//             value: _selectedTenant,
//             isExpanded: true,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
//               filled: true,
//               fillColor: AppTheme.paper,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(color: AppTheme.border),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(color: AppTheme.border),
//               ),
//             ),
//             icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.ink2),
//             items: _tenants.map((tenant) => DropdownMenuItem(
//               value: tenant,
//               child: Text(tenant, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13)),
//             )).toList(),
//             onChanged: (value) {
//               if (value != null) {
//                 setState(() {
//                   _selectedTenant = value;
//                   _showSavedMessage = false;
//                 });
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSectionCard({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//   }) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppTheme.paper,
//         border: Border.all(color: const Color(0xFFDCDDDF)),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             constraints: const BoxConstraints(minHeight: 70),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
//             color: const Color(0xFFFAFAFA),
//             child: Row(
//               children: [
//                 Icon(icon, color: AppTheme.text, size: 20),
//                 const SizedBox(width: 15),
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: const TextStyle(
//                       color: AppTheme.text,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Divider(height: 1, color: AppTheme.border),
//           ...children,
//         ],
//       ),
//     );
//   }

//   Widget _buildSwitchRow({
//     required String title,
//     required String subtitle,
//     required bool value,
//     required ValueChanged<bool> onChanged,
//     bool isLast = false,
//   }) {
//     return Container(
//       constraints: const BoxConstraints(minHeight: 60),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       decoration: BoxDecoration(
//         border: isLast ? null : const Border(bottom: BorderSide(color: AppTheme.border)),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.text)),
//                 const SizedBox(height: 2),
//                 Text(subtitle, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w500, color: Color(0xFF596070))),
//               ],
//             ),
//           ),
//           const SizedBox(width: 12),
//           Switch.adaptive(
//             value: value,
//             onChanged: onChanged,
//             activeColor: const Color(0xFF315BE8),
//             activeTrackColor: const Color(0xFF315BE8),
//             inactiveThumbColor: Colors.white,
//             inactiveTrackColor: const Color(0xFFB7BDCE),
//             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildIpAddressRow(bool isMobile) {
//     return Container(
//       constraints: const BoxConstraints(minHeight: 60),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: isMobile
//           ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('Allowed IP Address', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
//                 const SizedBox(height: 9),
//                 _ipField(),
//               ],
//             )
//           : Row(
//               children: [
//                 const Expanded(child: Text('Allowed IP Address', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
//                 const SizedBox(width: 20),
//                 SizedBox(width: 320, child: _ipField()),
//               ],
//             ),
//     );
//   }

//   Widget _ipField() {
//     return TextField(
//       controller: _ipController,
//       decoration: InputDecoration(
//         hintText: 'e.g. 192.168.1.0/24, 10.0.0.1',
//         hintStyle: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         isDense: true,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFFBFC3CA)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFFBFC3CA)),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusRow(String title, String status, bool enabled, {bool isLast = false}) {
//     return Container(
//       constraints: const BoxConstraints(minHeight: 60),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       decoration: BoxDecoration(
//         border: isLast ? null : const Border(bottom: BorderSide(color: AppTheme.border)),
//       ),
//       child: Row(
//         children: [
//           Expanded(child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.text))),
//           const SizedBox(width: 12),
//           Icon(Icons.circle, size: 9, color: enabled ? const Color(0xFF20C56B) : AppTheme.warning),
//           const SizedBox(width: 10),
//           SizedBox(
//             width: 96,
//             child: Text(
//               status,
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 color: enabled ? const Color(0xFF16834A) : AppTheme.warning,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_theme.dart';

class TenantIsolationPage extends StatefulWidget {
  const TenantIsolationPage({super.key});

  @override
  State<TenantIsolationPage> createState() => _TenantIsolationPageState();
}

class _TenantIsolationPageState extends State<TenantIsolationPage> {
  static const List<String> _tenants = [
    'ABX Technologies Pvt.Ltd',
    'Stackly Technologies',
    'Global Tech Solutions',
    'NextGen Enterprises',
  ];

  String _selectedTenant = _tenants.first;
  final TextEditingController _ipController = TextEditingController();

  bool _databaseIsolation = true;
  bool _storageIsolation = true;
  bool _apiAccess = true;
  bool _crossTenantAccess = false;
  bool _privateNetwork = true;
  bool _ipWhitelisting = true;

  bool _savedDatabase = true;
  bool _savedStorage = true;
  bool _savedApi = true;
  bool _savedCrossTenant = false;
  bool _savedPrivateNetwork = true;
  bool _savedIpWhitelisting = true;
  String _savedIp = '';

  bool _showSavedMessage = false;
  bool _isSaving = false;
  bool _isRefreshing = false;
  bool _isLoading = true;

  String get _storageKey =>
      'tenant_isolation_${_selectedTenant.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_')}';

  @override
  void initState() {
    super.initState();
    _loadTenantSettings();
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _currentSettings() => {
    'databaseIsolation': _databaseIsolation,
    'storageIsolation': _storageIsolation,
    'apiAccess': _apiAccess,
    'crossTenantAccess': _crossTenantAccess,
    'privateNetwork': _privateNetwork,
    'ipWhitelisting': _ipWhitelisting,
    'allowedIp': _ipController.text,
  };

  void _applySettings(Map<String, dynamic> data) {
    _databaseIsolation = data['databaseIsolation'] as bool? ?? true;
    _storageIsolation = data['storageIsolation'] as bool? ?? true;
    _apiAccess = data['apiAccess'] as bool? ?? true;
    _crossTenantAccess = data['crossTenantAccess'] as bool? ?? false;
    _privateNetwork = data['privateNetwork'] as bool? ?? true;
    _ipWhitelisting = data['ipWhitelisting'] as bool? ?? true;
    _ipController.text = data['allowedIp'] as String? ?? '';
  }

  void _captureSavedSettings() {
    _savedDatabase = _databaseIsolation;
    _savedStorage = _storageIsolation;
    _savedApi = _apiAccess;
    _savedCrossTenant = _crossTenantAccess;
    _savedPrivateNetwork = _privateNetwork;
    _savedIpWhitelisting = _ipWhitelisting;
    _savedIp = _ipController.text;
  }

  Future<void> _loadTenantSettings({bool showLoading = false}) async {
    if (showLoading && mounted) {
      setState(() {
        _isRefreshing = true;
        _showSavedMessage = false;
      });
    } else if (mounted) {
      setState(() => _isLoading = true);
    }

    try {
      final prefs = await SharedPreferences.getInstance();

      // Refresh the plugin cache from browser/device storage before reading.
      // This prevents stale cached values from being applied after a reload.
      await prefs.reload();

      final raw = prefs.getString(_storageKey);
      Map<String, dynamic> settings;
      if (raw != null && raw.isNotEmpty) {
        settings = Map<String, dynamic>.from(jsonDecode(raw) as Map);
      } else {
        settings = {
          'databaseIsolation': true,
          'storageIsolation': true,
          'apiAccess': true,
          'crossTenantAccess': false,
          'privateNetwork': true,
          'ipWhitelisting': true,
          'allowedIp': '',
        };
      }

      if (!mounted) return;
      setState(() {
        _applySettings(settings);
        _captureSavedSettings();
        _showSavedMessage = false;
        _isLoading = false;
        _isRefreshing = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _isRefreshing = false;
      });
      _showMessage(
        'Unable to load saved settings. Please try again.',
        isError: true,
      );
    }
  }

  Future<void> _saveChanges() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
      _showSavedMessage = false;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(_currentSettings());
      final success = await prefs.setString(_storageKey, encoded);

      if (!mounted) return;
      if (!success || prefs.getString(_storageKey) != encoded) {
        throw Exception('Settings could not be stored');
      }

      setState(() {
        _captureSavedSettings();
        _showSavedMessage = true;
        _isSaving = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      _showMessage('Unable to save changes. Please try again.', isError: true);
    }
  }

  Future<void> _refreshSettings() async {
    if (_isRefreshing || !mounted) return;

    setState(() {
      _isRefreshing = true;
      _showSavedMessage = false;
    });

    // showDialog uses the root navigator by default. Keep that exact
    // NavigatorState so closing the dialog cannot pop the page's route.
    final rootNavigator = Navigator.of(context, rootNavigator: true);

    final dialogFuture = showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (dialogContext) => const Dialog(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 38,
                height: 38,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              SizedBox(height: 14),
              Text('Refreshing...', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );

    try {
      // Keep the loading dialog visible briefly so the refresh feedback
      // is noticeable even when SharedPreferences responds immediately.
      await Future.wait([
        _loadTenantSettings(showLoading: true),
        Future<void>.delayed(const Duration(milliseconds: 900)),
      ]);
    } catch (e) {
      if (mounted) {
        _showMessage(
          'Unable to refresh settings. Please try again.',
          isError: true,
        );
      }
    } finally {
      // Close only the root-navigator dialog, never the current page.
      if (rootNavigator.mounted && rootNavigator.canPop()) {
        rootNavigator.pop();
      }

      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    }

    // Consume the dialog route completion future.
    await dialogFuture;
  }

  Future<void> _confirmReset() async {
    final shouldReset = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 390),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Reset to default settings?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.text,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'All changes on this page will be replaced with the default isolation settings.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3047F5),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (shouldReset == true && mounted) {
      setState(() {
        // Default isolation configuration.
        _databaseIsolation = true;
        _storageIsolation = true;
        _apiAccess = true;
        _crossTenantAccess = false;
        _privateNetwork = true;
        _ipWhitelisting = true;
        _ipController.clear();

        // Reset is an unsaved page change. The Save button remains
        // responsible for persisting these defaults.
        _showSavedMessage = false;
      });
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? AppTheme.danger : const Color(0xFF16834A),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _changeTenant(String tenant) {
    setState(() {
      _selectedTenant = tenant;
      _showSavedMessage = false;
      _isLoading = true;
    });
    _loadTenantSettings();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 600;
        final horizontalPadding = isMobile
            ? 12.0
            : width < 900
            ? 18.0
            : 20.0;

        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            isMobile ? 14 : 18,
            horizontalPadding,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPageHeading(isMobile),
              if (_showSavedMessage) ...[
                const SizedBox(height: 14),
                _buildSuccessBanner(),
              ],
              const SizedBox(height: 14),
              _buildTenantSelector(isMobile),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: 'Isolation Configuration',
                icon: Icons.settings_outlined,
                children: [
                  _buildSwitchRow(
                    title: 'Database Isolation',
                    subtitle: 'Dedicated database for the tenant',
                    value: _databaseIsolation,
                    onChanged: (v) => setState(() => _databaseIsolation = v),
                  ),
                  _buildSwitchRow(
                    title: 'Storage Isolation',
                    subtitle: 'Dedicated storage for tenant data',
                    value: _storageIsolation,
                    onChanged: (v) => setState(() => _storageIsolation = v),
                  ),
                  _buildSwitchRow(
                    title: 'APL Access',
                    subtitle: 'Restrict API access to the selected tenant',
                    value: _apiAccess,
                    onChanged: (v) => setState(() => _apiAccess = v),
                  ),
                  _buildSwitchRow(
                    title: 'Cross - Tenant Access',
                    subtitle: 'Prevent data access between tenants',
                    value: _crossTenantAccess,
                    onChanged: (v) => setState(() => _crossTenantAccess = v),
                    isLast: true,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: 'Network Security',
                icon: Icons.shield_outlined,
                children: [
                  _buildSwitchRow(
                    title: 'Private Network',
                    subtitle: 'Isolate tenant within private network',
                    value: _privateNetwork,
                    onChanged: (v) => setState(() => _privateNetwork = v),
                  ),
                  _buildSwitchRow(
                    title: 'IP whitelisting',
                    subtitle: 'Allow only specified IP addresses',
                    value: _ipWhitelisting,
                    onChanged: (v) => setState(() => _ipWhitelisting = v),
                  ),
                  _buildIpAddressRow(isMobile),
                ],
              ),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: 'Isolation status',
                icon: Icons.hub_outlined,
                children: [
                  _buildStatusRow(
                    'Database Isolation',
                    _databaseIsolation ? 'Enabled' : 'Disabled',
                    _databaseIsolation,
                  ),
                  _buildStatusRow(
                    'Storage Isolation',
                    _storageIsolation ? 'Enabled' : 'Disabled',
                    _storageIsolation,
                  ),
                  _buildStatusRow(
                    'API Security',
                    _apiAccess ? 'Enabled' : 'Disabled',
                    _apiAccess,
                  ),
                  _buildStatusRow(
                    'Compliance Status',
                    (_databaseIsolation &&
                            _storageIsolation &&
                            _apiAccess &&
                            !_crossTenantAccess)
                        ? 'Compliant'
                        : 'Review Required',
                    _databaseIsolation &&
                        _storageIsolation &&
                        _apiAccess &&
                        !_crossTenantAccess,
                    isLast: true,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageHeading(bool isMobile) {
    final title = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tenant Isolation',
          style: TextStyle(
            color: AppTheme.ink2,
            fontSize: isMobile ? 22 : 24,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Configure and monitor isolation policies per tenant',
          style: TextStyle(
            color: AppTheme.textMuted,
            fontSize: isMobile ? 12 : 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    final actions = Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton.icon(
          onPressed: _isRefreshing ? null : _refreshSettings,
          icon: const Icon(Icons.sync, size: 16),
          label: const Text('Refresh'),
          style: _actionButtonStyle(),
        ),
        OutlinedButton.icon(
          onPressed: _isSaving || _isRefreshing ? null : _confirmReset,
          icon: const Icon(Icons.restart_alt, size: 16),
          label: const Text('Reset'),
          style: _actionButtonStyle(),
        ),
        ElevatedButton.icon(
          onPressed: _isSaving || _isRefreshing ? null : _saveChanges,
          icon: _isSaving
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.save_outlined, size: 16),
          label: Text(_isSaving ? 'Saving...' : 'Save'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF304FFE),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: actions),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: title),
        actions,
      ],
    );
  }

  ButtonStyle _actionButtonStyle() => OutlinedButton.styleFrom(
    foregroundColor: AppTheme.ink2,
    side: const BorderSide(color: AppTheme.border),
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  );

  Widget _buildSuccessBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: const Color(0xFFD4E9DC)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.045),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF16834A),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(width: 14),
          const Icon(Icons.check_circle, color: Color(0xFF16834A), size: 19),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Your changes has been saved successfully.',
              style: TextStyle(
                color: Color(0xFF16834A),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: .2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTenantSelector(bool isMobile) {
    return Row(
      children: [
        const SizedBox(
          width: 58,
          child: Text(
            'Tenant',
            style: TextStyle(
              color: AppTheme.ink2,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: isMobile ? 220 : 240,
          child: DropdownButtonFormField<String>(
            value: _selectedTenant,
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 9,
              ),
              filled: true,
              fillColor: AppTheme.paper,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppTheme.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppTheme.border),
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.ink2),
            items: _tenants
                .map(
                  (tenant) => DropdownMenuItem(
                    value: tenant,
                    child: Text(
                      tenant,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null && value != _selectedTenant) {
                _changeTenant(value);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border.all(color: const Color(0xFFDCDDDF)),
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 70),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
            color: const Color(0xFFFAFAFA),
            child: Row(
              children: [
                Icon(icon, color: AppTheme.text, size: 20),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: AppTheme.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppTheme.border),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool isLast = false,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 60),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: AppTheme.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF596070),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Semantics(
            label: title,
            value: value ? 'Enabled' : 'Disabled',
            button: true,
            child: GestureDetector(
              onTap: () => onChanged(!value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeInOut,
                width: 32,
                height: 18,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: value
                      ? const Color(0xFF315BE8)
                      : const Color(0xFFB7BDCE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeInOut,
                  alignment: value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIpAddressRow(bool isMobile) {
    return Container(
      constraints: const BoxConstraints(minHeight: 60),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Allowed IP Address',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 9),
                _ipField(),
              ],
            )
          : Row(
              children: [
                const Expanded(
                  child: Text(
                    'Allowed IP Address',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(width: 320, child: _ipField()),
              ],
            ),
    );
  }

  Widget _ipField() {
    return TextField(
      controller: _ipController,
      decoration: InputDecoration(
        hintText: 'e.g. 192.168.1.0/24, 10.0.0.1',
        hintStyle: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFBFC3CA)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFBFC3CA)),
        ),
      ),
    );
  }

  Widget _buildStatusRow(
    String title,
    String status,
    bool enabled, {
    bool isLast = false,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 60),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: AppTheme.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppTheme.text,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            Icons.circle,
            size: 9,
            color: enabled ? const Color(0xFF20C56B) : AppTheme.warning,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 96,
            child: Text(
              status,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: enabled ? const Color(0xFF16834A) : AppTheme.warning,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
