import 'package:flutter/material.dart';

import '../../app_theme.dart';

class PlatformConfigPage extends StatefulWidget {
  const PlatformConfigPage({super.key});

  @override
  State<PlatformConfigPage> createState() => _PlatformConfigPageState();
}

class _PlatformConfigPageState extends State<PlatformConfigPage> {
  late final TextEditingController _platformNameController;
  late final TextEditingController _platformUrlController;

  String _timeZone = 'UTC +05:30 (India Standard Time)';
  String _language = 'ENGLISH';

  @override
  void initState() {
    super.initState();

    _platformNameController = TextEditingController(
      text: 'Java Enterprise Suite',
    );

    _platformUrlController = TextEditingController(
      text: 'https://app.javasuite.enterprise',
    );
  }

  @override
  void dispose() {
    _platformNameController.dispose();
    _platformUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isMobile = constraints.maxWidth < 700;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  isMobile ? 12 : 24,
                  isMobile ? 14 : 22,
                  isMobile ? 12 : 24,
                  24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPageHeading(isMobile),
                    SizedBox(height: isMobile ? 14 : 18),

                    if (isMobile)
                      _buildMobileLayout()
                    else
                      _buildDesktopLayout(),

                    SizedBox(height: isMobile ? 14 : 16),

                    _buildDeploymentNote(isMobile),

                    if (isMobile) ...[
                      const SizedBox(height: 14),
                      _buildMobileActions(),
                    ],
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
  // PAGE HEADING
  // ============================================================

  Widget _buildPageHeading(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 5,
          runSpacing: 3,
          children: [
            Text(
              'Platform Administration',
              style: TextStyle(
                color: const Color(0xFF91A2BD),
                fontSize: isMobile ? 13 : 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '/',
              style: TextStyle(color: const Color(0xFF91A2BD), fontSize: 13),
            ),
            Text(
              'Platform Configuration',
              style: TextStyle(
                color: AppTheme.text,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        Text(
          'Platform Configuration',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppTheme.text,
            fontSize: isMobile ? 24 : 28,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
        ),
        if (!isMobile) ...[
          const SizedBox(height: 5),
          Text(
            'Manage core platform identity, regional defaults, and security handling.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
          ),
        ],
      ],
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  _buildBasicConfiguration(false),
                  const SizedBox(height: 16),
                  _buildRegionalConfiguration(false),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(flex: 4, child: _buildSecurityHandling(false)),
          ],
        ),
        const SizedBox(height: 16),
        _buildCommunicationIntegration(false),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildBasicConfiguration(true),
        const SizedBox(height: 12),
        _buildRegionalConfiguration(true),
        const SizedBox(height: 12),
        _buildSecurityHandling(true),
        const SizedBox(height: 12),
        _buildCommunicationIntegration(true),
      ],
    );
  }

  // ============================================================
  // BASIC CONFIGURATION
  // ============================================================

  Widget _buildBasicConfiguration(bool isMobile) {
    return _sectionCard(
      title: 'Basic Configuration',
      icon: Icons.settings_outlined,
      isMobile: isMobile,
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 18 : 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _fieldLabel('PLATFORM NAME'),
            const SizedBox(height: 7),
            _textField(
              controller: _platformNameController,
              hint: 'Java Enterprise Suite',
            ),
            const SizedBox(height: 16),
            _fieldLabel('PLATFORM URL'),
            const SizedBox(height: 7),
            _textField(
              controller: _platformUrlController,
              hint: 'https://app.javasuite.enterprise',
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // REGIONAL CONFIGURATION
  // ============================================================

  Widget _buildRegionalConfiguration(bool isMobile) {
    return _sectionCard(
      title: 'Regional Configuration',
      icon: Icons.language_outlined,
      isMobile: isMobile,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _fieldLabel('DEFAULT TIME ZONE'),
            const SizedBox(height: 7),
            _dropdownField(
              value: _timeZone,
              items: const [
                'UTC +05:30 (India Standard Time)',
                'UTC +00:00 (Coordinated Universal Time)',
                'UTC +01:00 (Central European Time)',
                'UTC -05:00 (Eastern Standard Time)',
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _timeZone = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            _fieldLabel('DEFAULT LANGUAGE'),
            const SizedBox(height: 7),
            _dropdownField(
              value: _language,
              items: const ['ENGLISH', 'HINDI', 'TELUGU'],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _language = value;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECURITY
  // ============================================================

  Widget _buildSecurityHandling(bool isMobile) {
    return _sectionCard(
      title: 'Security Handling',
      icon: Icons.security_outlined,
      isMobile: isMobile,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
            child: Column(
              children: [
                _securityItem(
                  icon: Icons.verified_user_outlined,
                  title: 'Configuration version control',
                  subtitle: 'All changes are tracked and can be rolled back.',
                ),
                const SizedBox(height: 20),
                _securityItem(
                  icon: Icons.lock_outline,
                  title: 'Encryption of sensitive credentials',
                  subtitle: 'API keys and passwords are AES-256 encrypted.',
                ),
                const SizedBox(height: 20),
                _securityItem(
                  icon: Icons.manage_search_outlined,
                  title: 'Audit logs',
                  subtitle: 'Comprehensive logging of administrative actions.',
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.paperDim,
              border: Border(top: BorderSide(color: AppTheme.border)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppTheme.info.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.health_and_safety_outlined,
                    color: AppTheme.info,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'System Health',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppTheme.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Optimal State',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppTheme.success,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _securityItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 27, child: Icon(icon, color: AppTheme.info, size: 21)),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                softWrap: true,
                style: TextStyle(
                  color: AppTheme.text,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                softWrap: true,
                style: TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // COMMUNICATION & INTEGRATION
  // ============================================================

  Widget _buildCommunicationIntegration(bool isMobile) {
    return _sectionCard(
      title: 'Communication & Integration',
      icon: Icons.hub_outlined,
      isMobile: isMobile,
      child: Column(
        children: [
          _integrationRow(
            title: 'SMTP Configuration',
            subtitle: 'Manage email server settings',
            isMobile: isMobile,
            onPressed: _showSmtpDialog,
          ),
          _integrationDivider(),
          _integrationRow(
            title: 'SMS Gateway',
            subtitle: 'Twilio integration settings',
            isMobile: isMobile,
            onPressed: _showSmsDialog,
          ),
          _integrationDivider(),
          _integrationRow(
            title: 'API Gateway',
            subtitle: 'External system access tokens',
            isMobile: isMobile,
            onPressed: _showApiDialog,
          ),
        ],
      ),
    );
  }

  Widget _integrationRow({
    required String title,
    required String subtitle,
    required bool isMobile,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: isMobile ? 14 : 15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    fontSize: isMobile ? 13 : 13,
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
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              minimumSize: Size(isMobile ? 92 : 98, isMobile ? 38 : 36),
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 14),
              side: BorderSide(color: AppTheme.info.withOpacity(0.45)),
              foregroundColor: AppTheme.info,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: Text(
              'Configure',
              style: TextStyle(
                fontSize: isMobile ? 11 : 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _integrationDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Divider(height: 1, thickness: 1, color: AppTheme.border),
    );
  }

  // ============================================================
  // SECTION CARD
  // ============================================================

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
    required bool isMobile,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.paper,
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(
          isMobile ? 18 : AppTheme.radiusLarge,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: isMobile ? 17 : 14,
            ),
            decoration: BoxDecoration(
              color: AppTheme.paper,
              border: Border(bottom: BorderSide(color: AppTheme.border)),
            ),
            child: Row(
              children: [
                if (!isMobile) ...[
                  Icon(icon, color: AppTheme.info, size: 19),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppTheme.text,
                      fontSize: isMobile ? 19 : 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }

  // ============================================================
  // FIELD LABEL
  // ============================================================

  Widget _fieldLabel(String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppTheme.textMuted,
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.35,
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _textField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      maxLines: 1,
      style: TextStyle(
        color: AppTheme.text,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AppTheme.paper,
        hintText: hint,
        hintStyle: TextStyle(color: AppTheme.textMuted, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.info, width: 1.2),
        ),
      ),
    );
  }

  // ============================================================
  // DROPDOWN
  // ============================================================

  Widget _dropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: AppTheme.textMuted,
        size: 20,
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppTheme.text,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AppTheme.paper,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.border),
        ),
      ),
    );
  }

  // ============================================================
  // DEPLOYMENT NOTE
  // ============================================================

  Widget _buildDeploymentNote(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 16),
      decoration: BoxDecoration(
        color: AppTheme.paperDim,
        borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: AppTheme.info, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deployment Note',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppTheme.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Changes to Core Platform configurations may require a service restart for integrated modules to reflect the updates completely.',
                  softWrap: true,
                  style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: isMobile ? 11.5 : 13,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE ACTIONS
  // ============================================================

  Widget _buildMobileActions() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 52,
            child: OutlinedButton(
              onPressed: _cancelChanges,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.text,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                side: BorderSide(color: AppTheme.border, width: 1.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Cancel',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _saveConfiguration,
              icon: const Icon(Icons.save_outlined, size: 18),
              label: const Text(
                'Save',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SAVE / CANCEL
  // ============================================================

  void _saveConfiguration() {
    _showMessage('Platform configuration saved successfully.');
  }

  void _cancelChanges() {
    setState(() {
      _platformNameController.text = 'Java Enterprise Suite';
      _platformUrlController.text = 'https://app.javasuite.enterprise';
      _timeZone = 'UTC +05:30 (India Standard Time)';
      _language = 'ENGLISH';
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, maxLines: 2, overflow: TextOverflow.ellipsis),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // SMTP DIALOG
  // ============================================================

  void _showSmtpDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _ConfigurationDialog(
          title: 'Configure SMTP',
          subtitle: 'See your SMTP server details to enable outgoing email notifications.',
          children: [
            _dialogField(label: 'SMTP Host', initialValue: 'Smtp.stackly.com'),
            _dialogField(label: 'Port', initialValue: '587'),
            _dialogField(
              label: 'User name',
              initialValue: 'noreply@stackly.com',
            ),
            _dialogField(
              label: 'Password',
              initialValue: 'password123',
              obscureText: true,
            ),
            _dialogDropdown(
              label: 'Encryption',
              value: 'TLS',
              items: const ['TLS', 'SSL', 'None'],
            ),
            _dialogTwoColumns(
              left: _dialogField(
                label: 'From Email',
                initialValue: 'noreply@stackly.com',
              ),
              right: _dialogField(
                label: 'From Name',
                initialValue: 'Stackly Platform',
              ),
            ),
          ],
          bottomLeading: OutlinedButton.icon(
            onPressed: () {
              _showMessage('SMTP connection test successful.');
            },
            icon: const Icon(Icons.send_outlined, size: 17),
            label: const Text('Test Connection'),
          ),
          onSave: () {
            Navigator.of(dialogContext).pop();
            _showMessage('SMTP configuration saved successfully.');
          },
        );
      },
    );
  }

  // ============================================================
  // SMS DIALOG
  // ============================================================

  void _showSmsDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _ConfigurationDialog(
          title: 'SMS Gateway Configuration',
          subtitle: 'Configure SMS Gateway settings to send SMS from the application.',
          children: [
            _dialogTwoColumns(
              left: _dialogField(
                label: 'Gateway Provider',
                initialValue: 'Stackly',
              ),
              right: _dialogField(
                label: 'Gateway Name',
                initialValue: 'Stackly Primary',
              ),
            ),
            _dialogTwoColumns(
              left: _dialogField(
                label: 'API Base URL',
                initialValue: 'https://api.stackly.com/2010-04-01',
                helper: 'Base URL for Stackly API',
              ),
              right: _dialogField(
                label: 'Account SID',
                initialValue: 'ACXXXXXXXXXXXXXXXXXXXX',
                obscureText: true,
                helper: 'Your Stackly Account SID',
              ),
            ),
            _dialogTwoColumns(
              left: _dialogField(
                label: 'From Number/ Sender ID',
                initialValue: '+14155552671',
                helper: 'Phone number or Sender ID to send SMS',
              ),
              right: _dialogField(
                label: 'Connection Timeout (Seconds)',
                initialValue: '30',
                helper: 'Timeout for API requests',
              ),
            ),
            _dialogTwoColumns(
              left: _dialogField(
                label: 'Auth Token',
                initialValue: 'XXXXXXXXXXXXXXXXXXXX',
                obscureText: true,
                helper: 'Your Stackly Auth Token',
              ),
              right: _dialogField(
                label: 'Messaging Service SID (Optional)',
                initialValue: 'MGXXXXXXXXXXXXXXXXXXXX',
                helper: 'Stackly Messaging Service SID',
              ),
            ),
            _dialogSwitch(
              title: 'Enable Gateway',
              label: 'Enable this SMS gateway',
            ),
          ],
          onSave: () {
            Navigator.of(dialogContext).pop();
            _showMessage('SMS gateway configuration saved successfully.');
          },
        );
      },
    );
  }

  // ============================================================
  // API DIALOG
  // ============================================================

  void _showApiDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _ConfigurationDialog(
          title: 'API Gateway Configuration',
          subtitle: 'Configure API Gateway settings to connect and communicate with external services.',
          children: [
            _dialogTwoColumns(
              left: _dialogField(
                label: 'Gateway Name',
                initialValue: 'Main API Gateway',
              ),
              right: _dialogField(
                label: 'Environment',
                initialValue: 'Production',
              ),
            ),
            _dialogTwoColumns(
              left: _dialogField(
                label: 'Base URL',
                initialValue: 'https://api.stackly.com/V1',
                helper: 'Base URL of the API Gateway',
              ),
              right: _dialogField(
                label: 'API Version',
                initialValue: 'V1',
                helper: 'API version (e.g., v1, v2)',
              ),
            ),
            _dialogTwoColumns(
              left: _dialogField(
                label: 'Authentication Type',
                initialValue: 'API Key',
              ),
              right: _dialogField(
                label: 'API Key',
                initialValue: 'XXXXXXXXXXXXXXXXXXXX',
                obscureText: true,
              ),
            ),
            _dialogTwoColumns(
              left: _dialogField(
                label: 'API Secret',
                initialValue: 'XXXXXXXXXXXXXXXXXXXX',
                obscureText: true,
                helper: 'Secret used to authenticate API requests',
              ),
              right: _dialogField(
                label: 'Header Name (Optional)',
                initialValue: 'X-API-Key',
                helper: 'Custom header name for API key',
              ),
            ),
            _dialogTwoColumns(
              left: _dialogField(
                label: 'Request Timeout (Seconds)',
                initialValue: '30',
                helper: 'Timeout for API requests',
              ),
              right: _dialogField(
                label: 'Retry Attempts',
                initialValue: '3',
                helper: 'Number of retry attempts on failure',
              ),
            ),
            _dialogTwoColumns(
              left: _dialogField(
                label: 'Rate Limit (requests/minute)',
                initialValue: '100',
                helper: 'Maximum requests allowed per minute',
              ),
              right: _dialogSwitch(
                title: 'Enable Gateway',
                label: 'Enable the API gateway',
              ),
            ),
          ],
          bottomLeading: OutlinedButton.icon(
            onPressed: () {
              _showMessage('API gateway connection test successful.');
            },
            icon: const Icon(Icons.send_outlined, size: 17),
            label: const Text('Test Connection'),
          ),
          onSave: () {
            Navigator.of(dialogContext).pop();
            _showMessage('API gateway configuration saved successfully.');
          },
        );
      },
    );
  }

  // ============================================================
  // DIALOG HELPERS
  // ============================================================

  Widget _dialogField({
    required String label,
    required String initialValue,
    bool obscureText = false,
    String? helper,
  }) {
    return _DialogInput(
      label: label,
      initialValue: initialValue,
      obscureText: obscureText,
      helper: helper,
    );
  }

  Widget _dialogDropdown({
    required String label,
    required String value,
    required List<String> items,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dialogLabel(label),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: value,
            isExpanded: true,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
            onChanged: (_) {},
            decoration: _dialogDecoration(),
          ),
        ],
      ),
    );
  }

  Widget _dialogTwoColumns({required Widget left, required Widget right}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool singleColumn = constraints.maxWidth < 560;

        if (singleColumn) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [left, const SizedBox(height: 14), right],
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: left),
              const SizedBox(width: 10),
              Expanded(child: right),
            ],
          ),
        );
      },
    );
  }

  Widget _dialogSwitch({required String title, required String label}) {
    return StatefulBuilder(
      builder: (context, setLocalState) {
        bool enabled = true;

        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dialogLabel(title),
              const SizedBox(height: 7),
              Row(
                children: [
                  Switch(
                    value: enabled,
                    onChanged: (value) {
                      setLocalState(() {
                        enabled = value;
                      });
                    },
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      label,
                      softWrap: true,
                      style: TextStyle(color: AppTheme.text, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _dialogLabel(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: AppTheme.text,
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  InputDecoration _dialogDecoration() {
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: AppTheme.paper,
      contentPadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: AppTheme.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: AppTheme.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: AppTheme.info),
      ),
    );
  }
}

// ================================================================
// CONFIGURATION DIALOG
// ================================================================

class _ConfigurationDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final Widget? bottomLeading;
  final VoidCallback onSave;

  const _ConfigurationDialog({
    required this.title,
    required this.subtitle,
    required this.children,
    required this.onSave,
    this.bottomLeading,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final bool mobile = size.width < 600;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: mobile ? 10 : 30,
        vertical: mobile ? 12 : 25,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 680,
          maxHeight: size.height * 0.92,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                mobile ? 16 : 20,
                mobile ? 16 : 18,
                mobile ? 16 : 20,
                8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppTheme.text,
                      fontSize: mobile ? 17 : 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    softWrap: true,
                    style: TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 11.5,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: mobile ? 16 : 20,
                  vertical: 6,
                ),
                child: Column(children: children),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                mobile ? 16 : 20,
                8,
                mobile ? 16 : 20,
                mobile ? 16 : 18,
              ),
              child: mobile
                  ? _mobileDialogActions(context)
                  : _desktopDialogActions(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobileDialogActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (bottomLeading != null) ...[
          SizedBox(width: double.infinity, child: bottomLeading),
          const SizedBox(height: 9),
        ],
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: onSave,
                child: const Text(
                  'Save',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _desktopDialogActions(BuildContext context) {
    return Row(
      children: [
        if (bottomLeading != null) bottomLeading!,
        const Spacer(),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onSave,
          child: const Text('Save Configuration'),
        ),
      ],
    );
  }
}

// ================================================================
// DIALOG INPUT
// ================================================================

class _DialogInput extends StatefulWidget {
  final String label;
  final String initialValue;
  final bool obscureText;
  final String? helper;

  const _DialogInput({
    required this.label,
    required this.initialValue,
    this.obscureText = false,
    this.helper,
  });

  @override
  State<_DialogInput> createState() => _DialogInputState();
}

class _DialogInputState extends State<_DialogInput> {
  late final TextEditingController _controller;
  late bool _obscure;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initialValue);

    _obscure = widget.obscureText;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget.label,
              style: TextStyle(
                color: AppTheme.text,
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
              ),
              children: const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _controller,
            obscureText: _obscure,
            maxLines: 1,
            style: TextStyle(color: AppTheme.text, fontSize: 12.5),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: AppTheme.paper,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 11,
              ),
              suffixIcon: widget.obscureText
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 38,
                        minHeight: 38,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 18,
                        color: AppTheme.text,
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: AppTheme.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: AppTheme.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: AppTheme.info),
              ),
            ),
          ),
          if (widget.helper != null) ...[
            const SizedBox(height: 4),
            Text(
              widget.helper!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(
                color: AppTheme.textMuted,
                fontSize: 9,
                height: 1.25,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
