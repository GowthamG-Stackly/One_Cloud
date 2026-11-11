import 'package:flutter/material.dart';

import '../../app_theme.dart';

/// Tenant configuration screen for OneCloud.
///
/// This screen keeps the latest saved values in memory for the current app
/// session. Connect [_saveConfiguration] to your tenant settings API or a
/// persistent store when that backend becomes available.
class TenantConfigurationPage extends StatefulWidget {
  const TenantConfigurationPage({super.key});

  @override
  State<TenantConfigurationPage> createState() =>
      _TenantConfigurationPageState();
}

class _TenantConfigurationPageState extends State<TenantConfigurationPage> {
  // Keeps saved values available when this page is reopened during this app run.
  static Map<String, dynamic>? _persistedSettings;

  final _formKey = GlobalKey<FormState>();
  final _tenantNameController = TextEditingController();
  final _tenantIdController = TextEditingController();
  final _storageLimitController = TextEditingController();
  final _passwordController = TextEditingController();
  final _idleTimeoutController = TextEditingController();

  String _country = 'India';
  String _timeZone = 'Asia/Kolkata';
  String _currency = 'INR';
  String _timeFormat = '12-hour';
  String _language = 'English';
  String _dateFormat = 'DD/MM/YYYY';
  String _storageUnit = 'GB';
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _mfaMandatory = true;
  bool _showPassword = false;
  bool _tenantEnabled = true;
  bool _isSaving = false;
  bool _hasSaved = false;

  static const _defaultSettings = <String, dynamic>{
    'tenantName': 'ABC Technologies Pvt. Ltd.',
    'tenantId': 'TEN-8493-IN',
    'country': 'India',
    'timeZone': 'Asia/Kolkata',
    'currency': 'INR',
    'timeFormat': '12-hour',
    'language': 'English',
    'dateFormat': 'DD/MM/YYYY',
    'storageLimit': '100',
    'storageUnit': 'GB',
    'emailNotifications': true,
    'smsNotifications': false,
    'password': 'Stackly@Secure2026',
    'idleTimeout': '30',
    'mfaMandatory': true,
    'tenantEnabled': true,
  };

  @override
  void initState() {
    super.initState();
    _applySettings(_persistedSettings ?? _defaultSettings);
  }

  @override
  void dispose() {
    _tenantNameController.dispose();
    _tenantIdController.dispose();
    _storageLimitController.dispose();
    _passwordController.dispose();
    _idleTimeoutController.dispose();
    super.dispose();
  }

  void _applySettings(Map<String, dynamic> values) {
    _tenantNameController.text = values['tenantName'] as String;
    _tenantIdController.text = values['tenantId'] as String;
    _country = values['country'] as String;
    _timeZone = values['timeZone'] as String;
    _currency = values['currency'] as String;
    _timeFormat = values['timeFormat'] as String;
    _language = values['language'] as String;
    _dateFormat = values['dateFormat'] as String;
    _storageLimitController.text = values['storageLimit'] as String;
    _storageUnit = values['storageUnit'] as String;
    _emailNotifications = values['emailNotifications'] as bool;
    _smsNotifications = values['smsNotifications'] as bool;
    _passwordController.text = values['password'] as String;
    _idleTimeoutController.text = values['idleTimeout'] as String;
    _mfaMandatory = values['mfaMandatory'] as bool;
    _tenantEnabled = values['tenantEnabled'] as bool;
  }

  Map<String, dynamic> _readSettings() => {
    'tenantName': _tenantNameController.text.trim(),
    'tenantId': _tenantIdController.text.trim(),
    'country': _country,
    'timeZone': _timeZone,
    'currency': _currency,
    'timeFormat': _timeFormat,
    'language': _language,
    'dateFormat': _dateFormat,
    'storageLimit': _storageLimitController.text.trim(),
    'storageUnit': _storageUnit,
    'emailNotifications': _emailNotifications,
    'smsNotifications': _smsNotifications,
    'password': _passwordController.text,
    'idleTimeout': _idleTimeoutController.text.trim(),
    'mfaMandatory': _mfaMandatory,
    'tenantEnabled': _tenantEnabled,
  };

  Future<void> _saveConfiguration() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    // Replace this assignment with your API/database save when available.
    await Future<void>.delayed(const Duration(milliseconds: 350));
    _persistedSettings = _readSettings();
    if (!mounted) return;
    setState(() {
      _isSaving = false;
      _hasSaved = true;
    });
  }

  Widget _successBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border.all(color: AppTheme.success.withValues(alpha: .22)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: AppTheme.success,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Icon(Icons.check_circle, color: AppTheme.success, size: 19),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Your changes have been saved successfully.',
                style: TextStyle(
                  color: AppTheme.success,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _cancelChanges() async {
    _applySettings(_persistedSettings ?? _defaultSettings);
    setState(() => _hasSaved = _persistedSettings != null);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unsaved changes have been discarded.')),
    );
  }

  Future<void> _resetToDefault() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppTheme.paper,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppTheme.border),
        ),
        title: const Text(
          'Reset to default?',
          style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.text),
        ),
        content: const Text(
          'Restore the default tenant configuration values? Your saved settings will not change until you click Save.',
          style: TextStyle(color: AppTheme.textMuted, height: 1.45),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(dialogContext, true),
            icon: const Icon(Icons.restart_alt, size: 18),
            label: const Text('Reset Default'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.ink,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() {
      _applySettings(_defaultSettings);
      _hasSaved = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Default values restored. Click Save to apply them.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 720;
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            isMobile ? 20 : 18,
            12,
            isMobile ? 20 : 18,
            24,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPageHeading(isMobile),
                if (_hasSaved) ...[
                  const SizedBox(height: 14),
                  _successBanner(),
                ],
                const SizedBox(height: 16),
                _buildTenantDetailsCard(isMobile),
                const SizedBox(height: 12),
                _buildRegionalSettingsCard(isMobile),
                const SizedBox(height: 12),
                _buildStorageCard(),
                const SizedBox(height: 12),
                _buildSecurityCard(),
                if (isMobile) ...[
                  const SizedBox(height: 16),
                  _buildMobileActions(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageHeading(bool isMobile) {
    final actions = Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton.icon(
          onPressed: _resetToDefault,
          icon: const Icon(Icons.restart_alt, size: 16),
          label: const Text('Reset Default'),
        ),
        OutlinedButton(onPressed: _cancelChanges, child: const Text('Cancel')),
        ElevatedButton.icon(
          onPressed: _isSaving ? null : _saveConfiguration,
          icon: _isSaving
              ? const SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.save_outlined, size: 16),
          label: Text(_isSaving ? 'Saving...' : 'Save'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3047FF),
            foregroundColor: Colors.white,
            minimumSize: const Size(0, 40),
          ),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 4,
          runSpacing: 3,
          children: [
            const Icon(
              Icons.admin_panel_settings_outlined,
              size: 14,
              color: AppTheme.textMuted,
            ),
            const Text(
              'Platform Administration',
              style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
            ),
            const Icon(
              Icons.chevron_right,
              size: 14,
              color: AppTheme.textMuted,
            ),
            const Text(
              'Tenant Configuration',
              style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Text(
          'Tenant Configuration',
          style: TextStyle(
            fontSize: isMobile ? 23 : 26,
            height: 1.2,
            fontWeight: FontWeight.w700,
            color: AppTheme.text,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Manage regional, security, storage and notification settings for this tenant.',
          style: TextStyle(
            fontSize: 12,
            height: 1.4,
            color: AppTheme.textMuted,
          ),
        ),
        if (!isMobile) ...[
          const SizedBox(height: 12),
          Align(alignment: Alignment.centerRight, child: actions),
        ],
      ],
    );
  }

  Widget _buildMobileActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _cancelChanges,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              foregroundColor: AppTheme.text,
              side: const BorderSide(color: AppTheme.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _isSaving ? null : _saveConfiguration,
            icon: _isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.save_outlined, size: 18),
            label: Text(_isSaving ? 'Saving...' : 'Save'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              backgroundColor: const Color(0xFF172FE0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionCard({
    required String title,
    String? subtitle,
    required Widget child,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
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
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.text,
                  ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
            ),
          ],
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildTenantDetailsCard(bool isMobile) => _sectionCard(
    title: 'Tenant Details',
    subtitle: 'Tenant ID is system-generated and cannot be changed.',
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.success.withValues(alpha: .11),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppTheme.success,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                _tenantEnabled ? 'Enabled' : 'Disabled',
                style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Toggle tenant status',
          onPressed: () => setState(() => _tenantEnabled = !_tenantEnabled),
          icon: const Icon(Icons.edit_note, size: 18, color: AppTheme.text),
          visualDensity: VisualDensity.compact,
        ),
      ],
    ),
    child: LayoutBuilder(
      builder: (context, box) {
        final stacked = isMobile || box.maxWidth < 580;
        final name = _textField(
          _tenantNameController,
          'Tenant Name',
          required: true,
        );
        final id = _textField(
          _tenantIdController,
          'Tenant ID',
          enabled: false,
          mono: true,
        );
        if (stacked)
          return Column(children: [name, const SizedBox(height: 10), id]);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: name),
            const SizedBox(width: 12),
            Expanded(child: id),
          ],
        );
      },
    ),
  );

  Widget _buildRegionalSettingsCard(bool isMobile) => _sectionCard(
    title: 'Regional Settings',
    subtitle: 'Localization applied to all users of this tenant.',
    child: LayoutBuilder(
      builder: (context, box) {
        final columns = isMobile || box.maxWidth < 620 ? 1 : 2;
        final fields = <Widget>[
          _dropdown('Country', _country, [
            'India',
            'United States',
            'United Kingdom',
            'Australia',
            'Japan',
            'United Arab Emirates',
          ], (v) => setState(() => _country = v!)),
          _dropdown('Time Zone', _timeZone, [
            'Asia/Kolkata',
            'UTC',
            'America/New_York',
            'Europe/London',
            'Asia/Tokyo',
            'Asia/Dubai',
          ], (v) => setState(() => _timeZone = v!)),
          _dropdown('Currency', _currency, [
            'INR',
            'USD',
            'GBP',
            'EUR',
            'AUD',
            'JPY',
            'AED',
          ], (v) => setState(() => _currency = v!)),
          _dropdown('Time Format', _timeFormat, [
            '12-hour',
            '24-hour',
          ], (v) => setState(() => _timeFormat = v!)),
          _dropdown('Language', _language, [
            'English',
            'Hindi',
            'Telugu',
            'Japanese',
            'Korean',
            'Arabic',
          ], (v) => setState(() => _language = v!)),
          _dropdown('Standard Date Format', _dateFormat, [
            'DD/MM/YYYY',
            'MM/DD/YYYY',
            'YYYY-MM-DD',
          ], (v) => setState(() => _dateFormat = v!)),
        ];
        if (columns == 1)
          return Column(
            children: [
              for (var i = 0; i < fields.length; i++) ...[
                fields[i],
                if (i != fields.length - 1) const SizedBox(height: 12),
              ],
            ],
          );
        return Column(
          children: [
            for (var i = 0; i < fields.length; i += 2) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: fields[i]),
                  const SizedBox(width: 12),
                  Expanded(child: fields[i + 1]),
                ],
              ),
              if (i < fields.length - 2) const SizedBox(height: 12),
            ],
          ],
        );
      },
    ),
  );

  Widget _buildStorageCard() => _sectionCard(
    title: 'Storage & Notifications',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Storage Limit'),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _storageLimitController,
                keyboardType: TextInputType.number,
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n < 1) {
                    return 'Enter a storage limit greater than 0';
                  }
                  return null;
                },
                decoration: _inputDecoration(),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 78,
              child: DropdownButtonFormField<String>(
                value: _storageUnit,
                isExpanded: true,
                decoration: _inputDecoration(),
                items: ['GB', 'TB']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _storageUnit = v!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: const LinearProgressIndicator(
            value: .23,
            minHeight: 7,
            backgroundColor: Color(0xFFD9D9D9),
            color: Color(0xFF23834D),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '32 GB of 100 GB used',
          style: TextStyle(fontSize: 11, color: AppTheme.text),
        ),
        const SizedBox(height: 12),
        const Divider(height: 1, color: AppTheme.border),
        _switchRow(
          'Email Notifications',
          'System alerts and reports by email.',
          _emailNotifications,
          (v) => setState(() => _emailNotifications = v),
        ),
        const Divider(height: 1, color: AppTheme.border),
        _switchRow(
          'SMS Notifications',
          'Requires a configured SMS provider.',
          _smsNotifications,
          (v) => setState(() => _smsNotifications = v),
        ),
      ],
    ),
  );

  Widget _buildSecurityCard() => _sectionCard(
    title: 'Security & Access Controls',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Enterprise Password Policy'),
        const SizedBox(height: 5),
        TextFormField(
          controller: _passwordController,
          obscureText: !_showPassword,
          validator: (v) {
            final value = v ?? '';
            if (value.length < 8 ||
                !RegExp(r'[A-Z]').hasMatch(value) ||
                !RegExp(r'[a-z]').hasMatch(value) ||
                !RegExp(r'\d').hasMatch(value) ||
                !RegExp(r'[^A-Za-z0-9]').hasMatch(value)) {
              return 'Use at least 8 characters with uppercase, lowercase, number and symbol';
            }
            return null;
          },
          decoration: _inputDecoration(
            prefixIcon: const Icon(Icons.password, size: 18),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _showPassword = !_showPassword),
              icon: Icon(
                _showPassword ? Icons.visibility_off : Icons.visibility,
                size: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Requires symbols, uppercase, lowercase and numerals',
          style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
        ),
        const SizedBox(height: 12),
        _label('Idle session timeout'),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _idleTimeoutController,
                keyboardType: TextInputType.number,
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n < 5 || n > 240)
                    return 'Enter a value between 5 and 240 minutes';
                  return null;
                },
                decoration: _inputDecoration(
                  prefixIcon: const Icon(Icons.timer_outlined, size: 18),
                ),
              ),
            ),
            const SizedBox(width: 9),
            Container(
              width: 88,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Minutes',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        const Text(
          'Range: 5m to 240m. Recommended session expiry limit.',
          style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.verified_user_outlined,
                size: 16,
                color: AppTheme.text,
              ),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  'MFA Mandatory for all Tenant Users',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              Switch.adaptive(
                value: _mfaMandatory,
                onChanged: (v) => setState(() => _mfaMandatory = v),
                activeColor: const Color(0xFF3047FF),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _textField(
    TextEditingController controller,
    String label, {
    bool required = false,
    bool enabled = true,
    bool mono = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, required: required),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          enabled: enabled,
          validator: required
              ? (v) => (v == null || v.trim().isEmpty)
                    ? '$label is required'
                    : null
              : null,
          style: TextStyle(fontSize: 12, fontFamily: mono ? 'monospace' : null),
          decoration: _inputDecoration(
            fillColor: enabled ? Colors.white : AppTheme.paperDim,
          ),
        ),
      ],
    );
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, required: true),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: _inputDecoration(),
          items: options
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _label(String text, {bool required = false}) => RichText(
    text: TextSpan(
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppTheme.text,
      ),
      children: [
        TextSpan(text: text),
        if (required)
          const TextSpan(
            text: ' *',
            style: TextStyle(color: AppTheme.danger),
          ),
      ],
    ),
  );

  InputDecoration _inputDecoration({
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fillColor,
  }) => InputDecoration(
    isDense: true,
    filled: fillColor != null,
    fillColor: fillColor,
    prefixIcon: prefixIcon,
    prefixIconConstraints: const BoxConstraints(minWidth: 38, minHeight: 40),
    suffixIcon: suffixIcon,
    suffixIconConstraints: const BoxConstraints(minWidth: 38, minHeight: 40),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppTheme.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppTheme.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppTheme.ink, width: 1.2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppTheme.danger),
    ),
  );

  Widget _switchRow(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.text,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 10, color: AppTheme.textMuted),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF3047FF),
        ),
      ],
    ),
  );
}
