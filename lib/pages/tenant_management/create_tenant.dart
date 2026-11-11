import 'package:flutter/material.dart';

import '../../app_theme.dart';

/// Create Tenant form for the OneCloud Tenant Management module.
///
/// Place this file at:
/// lib/pages/tenant_management/create_tenant.dart
class CreateTenantPage extends StatefulWidget {
  const CreateTenantPage({super.key});

  @override
  State<CreateTenantPage> createState() => _CreateTenantPageState();
}

class _CreateTenantPageState extends State<CreateTenantPage> {
  final _formKey = GlobalKey<FormState>();
  final _tenantName = TextEditingController();
  final _organizationName = TextEditingController();
  final _tenantId = TextEditingController();
  final _domain = TextEditingController();
  final _adminName = TextEditingController();
  final _adminEmail = TextEditingController();
  final _mobile = TextEditingController();

  String _plan = 'Enterprise';
  String _status = 'Active';
  String _timeZone = 'UTC +05:30 (India Standard Time)';
  String _language = 'English';
  String _country = '';
  bool _saving = false;

  static const _plans = ['Starter', 'Professional', 'Business', 'Enterprise'];
  static const _timeZones = [
    'UTC +05:30 (India Standard Time)',
    'UTC +00:00 (Greenwich Mean Time)',
    'UTC -05:00 (Eastern Time)',
    'UTC +01:00 (Central European Time)',
    'UTC +08:00 (China Standard Time)',
    'UTC +09:00 (Japan Standard Time)',
    'UTC +10:00 (Australian Eastern Time)',
  ];
  static const _languages = [
    'English',
    'Hindi',
    'Telugu',
    'Spanish',
    'French',
    'Japanese',
  ];
  static const _countries = [
    'India',
    'United States',
    'United Kingdom',
    'United Arab Emirates',
    'Japan',
    'Australia',
    'Canada',
    'Singapore',
    'Germany',
  ];

  @override
  void initState() {
    super.initState();
    _tenantId.text = _generateTenantId();
  }

  String _generateTenantId() {
    final now = DateTime.now();
    final date =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    return 'TEN-$date-001';
  }

  @override
  void dispose() {
    _tenantName.dispose();
    _organizationName.dispose();
    _tenantId.dispose();
    _domain.dispose();
    _adminName.dispose();
    _adminEmail.dispose();
    _mobile.dispose();
    super.dispose();
  }

  Future<void> _resetForm() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => Dialog(
        backgroundColor: AppTheme.paper,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppTheme.border),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Reset changes?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Discard unsaved changes and restore the last saved settings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.ink3,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.pop(dialogContext, true),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 16,
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

    if (confirmed != true || !mounted) return;
    _formKey.currentState?.reset();
    _tenantName.clear();
    _organizationName.clear();
    _tenantId.text = _generateTenantId();
    _domain.clear();
    _adminName.clear();
    _adminEmail.clear();
    _mobile.clear();
    setState(() {
      _plan = 'Enterprise';
      _status = 'Active';
      _timeZone = _timeZones.first;
      _language = 'English';
      _country = '';
    });
  }

  Future<void> _createTenant() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (_country.isEmpty) {
      _showMessage('Please select a country.', isError: true);
      return;
    }
    setState(() => _saving = true);
    // This page currently validates and confirms the form locally.
    // Connect this method to your tenant API/repository when available.
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (!mounted) return;
    setState(() => _saving = false);

    final orgName = _organizationName.text.trim();
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        contentPadding: const EdgeInsets.fromLTRB(24, 26, 24, 22),
        content: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5EB),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppTheme.success,
                  size: 30,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Tenant Created Successfully',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                '$orgName has been successfully created.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.textMuted, fontSize: 14),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.ink,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (!mounted) return;
    _showMessage('Tenant form completed successfully.');
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? AppTheme.danger : AppTheme.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) return '$label is required';
    return null;
  }

  String? _emailValidator(String? value) {
    final required = _required(value, 'Email address');
    if (required != null) return required;
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _mobileValidator(String? value) {
    final required = _required(value, 'Mobile number');
    if (required != null) return required;
    final digits = value!.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 7 || digits.length > 15) {
      return 'Enter a valid mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.paper,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mobile = constraints.maxWidth < 620;
            final horizontal = mobile
                ? 14.0
                : (constraints.maxWidth < 900 ? 20.0 : 28.0);
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(horizontal, 18, horizontal, 28),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1500),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBreadcrumb(),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Create tenant',
                                style: _pageTitle(mobile),
                              ),
                            ),
                            if (!mobile) ...[
                              const SizedBox(width: 16),
                              _buildActions(),
                            ],
                          ],
                        ),
                        const SizedBox(height: 20),
                        _SectionCard(
                          number: '1',
                          showNumber: !mobile,
                          title: 'Tenant Information',
                          child: _responsiveFields(constraints.maxWidth, [
                            _textField(
                              'Tenant Name',
                              _tenantName,
                              hint: 'Enter tenant name',
                              validator: (v) => _required(v, 'Tenant name'),
                            ),
                            _textField(
                              'Organization Name',
                              _organizationName,
                              hint: 'Enter organization name',
                              validator: (v) =>
                                  _required(v, 'Organization name'),
                            ),
                            _textField(
                              'Tenant ID',
                              _tenantId,
                              readOnly: true,
                              validator: (v) => _required(v, 'Tenant ID'),
                            ),
                            _textField(
                              'Domain / Subdomain',
                              _domain,
                              hint: 'Your company domain',
                              validator: (v) =>
                                  _required(v, 'Domain / subdomain'),
                              helper: 'Example: company.onecloud.com',
                            ),
                          ]),
                        ),
                        const SizedBox(height: 16),
                        _SectionCard(
                          number: '2',
                          showNumber: !mobile,
                          title: 'Subscription',
                          child: _responsiveFields(constraints.maxWidth, [
                            _dropdown<String>(
                              label: 'Subscription Plan',
                              value: _plan,
                              items: _plans,
                              onChanged: (v) => setState(() => _plan = v!),
                            ),
                            _statusField(),
                          ]),
                        ),
                        const SizedBox(height: 16),
                        _SectionCard(
                          number: '3',
                          showNumber: !mobile,
                          title: 'Primary Administrator',
                          child: _responsiveFields(constraints.maxWidth, [
                            _textField(
                              'Full Name',
                              _adminName,
                              hint: 'Enter full name',
                              validator: (v) => _required(v, 'Full name'),
                            ),
                            _textField(
                              'Email Address',
                              _adminEmail,
                              hint: 'Enter email address',
                              keyboardType: TextInputType.emailAddress,
                              validator: _emailValidator,
                            ),
                            _textField(
                              'Mobile Number',
                              _mobile,
                              hint: 'Enter mobile number',
                              keyboardType: TextInputType.phone,
                              validator: _mobileValidator,
                              fullWidth: true,
                            ),
                          ]),
                        ),
                        const SizedBox(height: 16),
                        _SectionCard(
                          number: '4',
                          showNumber: !mobile,
                          title: 'Regional Settings',
                          child: _responsiveFields(constraints.maxWidth, [
                            _dropdown<String>(
                              label: 'TIME ZONE',
                              value: _timeZone,
                              items: _timeZones,
                              onChanged: (v) => setState(() => _timeZone = v!),
                            ),
                            _dropdown<String>(
                              label: 'LANGUAGE',
                              value: _language,
                              items: _languages,
                              onChanged: (v) => setState(() => _language = v!),
                            ),
                            _dropdown<String>(
                              label: 'Country',
                              value: _country.isEmpty ? null : _country,
                              hint: 'Select Country',
                              items: _countries,
                              onChanged: (v) =>
                                  setState(() => _country = v ?? ''),
                              fullWidth: true,
                            ),
                          ]),
                        ),
                        if (mobile) ...[
                          const SizedBox(height: 12),
                          _buildMobileActions(),
                        ] else
                          const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  TextStyle _pageTitle(bool mobile) => TextStyle(
    fontSize: mobile ? 22 : 26,
    fontWeight: FontWeight.w700,
    color: AppTheme.text,
    letterSpacing: -0.5,
  );

  Widget _buildBreadcrumb() => Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 8,
    children: const [
      Text(
        'Tenant Management',
        style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
      ),
      Icon(Icons.chevron_right, size: 15, color: AppTheme.textMuted),
      Text(
        'Create tenant',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppTheme.text,
        ),
      ),
    ],
  );

  Widget _buildActions() => Wrap(
    spacing: 9,
    runSpacing: 8,
    children: [
      OutlinedButton(
        onPressed: _saving ? null : _resetForm,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.text,
          side: const BorderSide(color: AppTheme.border),
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: const Text('Reset'),
      ),
      FilledButton.icon(
        onPressed: _saving ? null : _createTenant,
        style: FilledButton.styleFrom(
          backgroundColor: AppTheme.ink3,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        icon: _saving
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.add, size: 18),
        label: Text(_saving ? 'Creating...' : 'Create Tenant'),
      ),
    ],
  );

  Widget _buildMobileActions() => Row(
    children: [
      Expanded(
        child: OutlinedButton(
          onPressed: _saving ? null : _resetForm,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(46),
            foregroundColor: AppTheme.text,
            side: const BorderSide(color: AppTheme.border),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Reset', maxLines: 1),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: FilledButton.icon(
          onPressed: _saving ? null : _createTenant,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(46),
            backgroundColor: AppTheme.ink3,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: _saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.add, size: 20),
          label: Flexible(
            child: Text(
              _saving ? 'Creating...' : 'Create Tenant',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    ],
  );

  Widget _responsiveFields(double availableWidth, List<Widget> fields) {
    final width = availableWidth;
    final columns = width >= 760 ? 2 : 1;
    if (columns == 1) {
      return Column(
        children: [
          for (var i = 0; i < fields.length; i++) ...[
            fields[i],
            if (i != fields.length - 1) const SizedBox(height: 15),
          ],
        ],
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 16.0;
        final itemWidth = (constraints.maxWidth - gap) / 2;
        return Wrap(
          spacing: gap,
          runSpacing: 15,
          children: fields.map((field) {
            final isFull = field is _FullWidthField;
            return SizedBox(
              width: isFull ? constraints.maxWidth : itemWidth,
              child: isFull ? field.child : field,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _textField(
    String label,
    TextEditingController controller, {
    String? hint,
    bool readOnly = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    String? helper,
    bool fullWidth = false,
  }) {
    final field = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel(label),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            fontSize: MediaQuery.sizeOf(context).width < 620 ? 14 : 13.5,
            color: AppTheme.text,
          ),
          decoration: _inputDecoration(hint: hint).copyWith(
            filled: readOnly,
            fillColor: readOnly ? AppTheme.paperDim : AppTheme.paper,
          ),
        ),
        if (helper != null) ...[
          const SizedBox(height: 4),
          Text(
            helper,
            style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
          ),
        ],
      ],
    );
    return fullWidth ? _FullWidthField(field) : field;
  }

  Widget _dropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    String? hint,
    bool fullWidth = false,
  }) {
    final field = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel(label),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          value: value,
          isExpanded: true,
          hint: hint == null
              ? null
              : Text(hint, overflow: TextOverflow.ellipsis),
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    item.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).width < 620
                          ? 14
                          : 13.5,
                      color: AppTheme.text,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: _inputDecoration(),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.textMuted,
          ),
          validator: (v) => v == null ? '$label is required' : null,
        ),
      ],
    );
    return fullWidth ? _FullWidthField(field) : field;
  }

  Widget _statusField() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _fieldLabel('Status'),
      const SizedBox(height: 10),
      Wrap(
        spacing: 22,
        runSpacing: 8,
        children: [
          _statusChoice('Active', AppTheme.success),
          _statusChoice('Inactive', AppTheme.textMuted),
        ],
      ),
    ],
  );

  Widget _statusChoice(String value, Color color) => InkWell(
    onTap: () => setState(() => _status = value),
    borderRadius: BorderRadius.circular(8),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _status == value
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: _status == value ? color : const Color(0xFFCBD5E1),
            size: 19,
          ),
          const SizedBox(width: 7),
          Text(
            value,
            style: const TextStyle(fontSize: 13, color: AppTheme.text),
          ),
        ],
      ),
    ),
  );

  Widget _fieldLabel(String label) => Text(
    label,
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Color(0xFF4B5563),
    ),
  );

  InputDecoration _inputDecoration({String? hint}) => InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: MediaQuery.sizeOf(context).width < 620 ? 14 : 13,
      color: AppTheme.textMuted,
    ),
    isDense: false,
    contentPadding: EdgeInsets.symmetric(
      horizontal: MediaQuery.sizeOf(context).width < 620 ? 13 : 12,
      vertical: MediaQuery.sizeOf(context).width < 620 ? 13 : 11,
    ),
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
      borderSide: const BorderSide(color: AppTheme.ink3, width: 1.3),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppTheme.danger),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppTheme.danger, width: 1.3),
    ),
  );
}

class _FullWidthField extends StatelessWidget {
  const _FullWidthField(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.number,
    this.showNumber = true,
    required this.title,
    required this.child,
  });

  final String number;
  final bool showNumber;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppTheme.paper,
      border: Border.all(color: AppTheme.border),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width < 620 ? 16 : 15,
            vertical: MediaQuery.sizeOf(context).width < 620 ? 13 : 11,
          ),
          child: Row(
            children: [
              if (showNumber) ...[
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F6FF),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    number,
                    style: const TextStyle(
                      color: AppTheme.info,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.text,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppTheme.border),
        Padding(
          padding: EdgeInsets.all(
            MediaQuery.sizeOf(context).width < 620 ? 16 : 16,
          ),
          child: child,
        ),
      ],
    ),
  );
}
