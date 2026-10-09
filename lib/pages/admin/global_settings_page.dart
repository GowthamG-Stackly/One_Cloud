import 'package:flutter/material.dart';

import '../../app_theme.dart';

class GlobalSettingsPage extends StatefulWidget {
  const GlobalSettingsPage({super.key});

  @override
  State<GlobalSettingsPage> createState() => _GlobalSettingsPageState();
}

class _GlobalSettingsPageState extends State<GlobalSettingsPage> {
  // ============================================================

  // PLATFORM BEHAVIOR

  // ============================================================

  bool maintenanceMode = false;

  bool forceMfa = true;

  bool allowTenantSelfSignup = false;

  bool enableAiCopilot = true;

  bool dataResidencyLock = true;

  // ============================================================

  // SECURITY

  // ============================================================

  bool multiFactorAuthentication = true;

  // ============================================================

  // NOTIFICATIONS

  // ============================================================

  bool emailNotifications = false;

  bool smsNotifications = false;

  bool pushNotifications = false;

  // ============================================================

  // PLATFORM SETTINGS

  // ============================================================

  bool platformMaintenanceMode = false;

  String defaultLanguage = 'English';

  String timeZone = 'Asia/Kolkata (UTC +05:30)';

  String dateFormat = 'DD/MM/YYYY';

  String timeFormat = '24 Hours';

  String defaultCurrency = 'INR (₹)';

  String passwordExpiry = '90 Days';

  String sessionTimeout = '30 Minutes';

  String maximumLoginAttempts = '5';

  String maximumFileUploadSize = '100 MB';

  String defaultTheme = 'Light';

  // ============================================================

  // BUILD

  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final bool isMobile = width < 700;

              final bool isTablet = width >= 700 && width < 1050;

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  isMobile ? 14 : 16,

                  isMobile ? 10 : 14,

                  isMobile ? 14 : 16,

                  isMobile ? 20 : 24,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // ==================================================

                    // TOP ACTIONS

                    // ==================================================
                    _buildPageHeader(isMobile),

                    SizedBox(height: isMobile ? 12 : 16),

                    // ==================================================

                    // PLATFORM BEHAVIOR

                    // ==================================================
                    _buildSectionCard(
                      title: 'Platform behavior',

                      child: Column(
                        children: [
                          _buildSwitchSetting(
                            title: 'Maintenance mode',

                            subtitle: 'Blocks tenant access platform-wide during scheduled updates.',

                            value: maintenanceMode,

                            onChanged: (value) {
                              setState(() {
                                maintenanceMode = value;
                              });
                            },
                          ),

                          _buildDivider(),

                          _buildSwitchSetting(
                            title: 'Force MFA for all tenants',

                            subtitle: 'Overrides tenant-level MFA settings and requires it globally.',

                            value: forceMfa,

                            onChanged: (value) {
                              setState(() {
                                forceMfa = value;
                              });
                            },
                          ),

                          _buildDivider(),

                          _buildSwitchSetting(
                            title: 'Allow tenant self-signup',

                            subtitle: 'New organizations can create a workspace without Super Admin approval.',

                            value: allowTenantSelfSignup,

                            onChanged: (value) {
                              setState(() {
                                allowTenantSelfSignup = value;
                              });
                            },
                          ),

                          _buildDivider(),

                          _buildSwitchSetting(
                            title: 'Enable AI Copilot platform-wide',

                            subtitle: 'Makes the AI Copilot available to all tenants regardless of plan.',

                            value: enableAiCopilot,

                            onChanged: (value) {
                              setState(() {
                                enableAiCopilot = value;
                              });
                            },
                          ),

                          _buildDivider(),

                          _buildSwitchSetting(
                            title: 'Data residency lock',

                            subtitle: 'Prevents tenant data from being stored outside its assigned region.',

                            value: dataResidencyLock,

                            onChanged: (value) {
                              setState(() {
                                dataResidencyLock = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ==================================================

                    // REGIONAL SETTINGS

                    // ==================================================
                    _buildSectionCard(
                      title: 'Regional settings',

                      child: _buildResponsiveFields(
                        columns: isMobile
                            ? 1
                            : isTablet
                            ? 2
                            : 3,

                        children: [
                          _buildTextField(
                            label: 'Default language',

                            value: defaultLanguage,

                            requiredField: true,

                            helperText: 'Required',

                            onChanged: (value) {
                              defaultLanguage = value;
                            },
                          ),

                          _buildTextField(
                            label: 'Time zone',

                            value: timeZone,

                            requiredField: true,

                            helperText: 'Required',

                            onChanged: (value) {
                              timeZone = value;
                            },
                          ),

                          _buildTextField(
                            label: 'Date format',

                            value: dateFormat,

                            onChanged: (value) {
                              dateFormat = value;
                            },
                          ),

                          _buildTextField(
                            label: 'Time format',

                            value: timeFormat,

                            onChanged: (value) {
                              timeFormat = value;
                            },
                          ),

                          _buildTextField(
                            label: 'Default currency',

                            value: defaultCurrency,

                            requiredField: true,

                            helperText: 'Required',

                            onChanged: (value) {
                              defaultCurrency = value;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ==================================================

                    // SECURITY SETTINGS

                    // ==================================================
                    _buildSectionCard(
                      title: 'Security settings',

                      child: Column(
                        children: [
                          _buildResponsiveFields(
                            columns: isMobile
                                ? 1
                                : isTablet
                                ? 2
                                : 3,

                            children: [
                              _buildTextField(
                                label: 'Password expiry',

                                value: passwordExpiry,

                                helperText: 'Must be between 30 and 365 days',

                                onChanged: (value) {
                                  passwordExpiry = value;
                                },
                              ),

                              _buildTextField(
                                label: 'Session timeout',

                                value: sessionTimeout,

                                helperText: 'Must be between 5 and 240 minutes',

                                onChanged: (value) {
                                  sessionTimeout = value;
                                },
                              ),

                              _buildTextField(
                                label: 'Maximum login attempts',

                                value: maximumLoginAttempts,

                                helperText: 'Must be between 3 and 10',

                                onChanged: (value) {
                                  maximumLoginAttempts = value;
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          _buildDivider(),

                          const SizedBox(height: 14),

                          _buildSwitchSetting(
                            title: 'Multi-Factor Authentication',

                            subtitle: 'Requires a second verification step at sign-in, platform-wide.',

                            value: multiFactorAuthentication,

                            onChanged: (value) {
                              setState(() {
                                multiFactorAuthentication = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ==================================================

                    // NOTIFICATION + CONFIGURATION

                    // ==================================================
                    if (isMobile)
                      Column(
                        children: [
                          _buildNotificationCard(),

                          const SizedBox(height: 14),

                          _buildConfigurationCard(),
                        ],
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Expanded(child: _buildNotificationCard()),

                          const SizedBox(width: 14),

                          Expanded(child: _buildConfigurationCard()),
                        ],
                      ),

                    const SizedBox(height: 14),

                    // ==================================================

                    // PLATFORM SETTINGS

                    // ==================================================
                    _buildSectionCard(
                      title: 'Platform settings',

                      child: Column(
                        children: [
                          _buildResponsiveFields(
                            columns: isMobile
                                ? 1
                                : isTablet
                                ? 2
                                : 3,

                            children: [
                              _buildTextField(
                                label: 'Maximum file upload size',

                                value: maximumFileUploadSize,

                                helperText: 'Must be a positive value within the allowed platform limit',

                                onChanged: (value) {
                                  maximumFileUploadSize = value;
                                },
                              ),

                              _buildTextField(
                                label: 'Default theme',

                                value: defaultTheme,

                                onChanged: (value) {
                                  defaultTheme = value;
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          _buildDivider(),

                          const SizedBox(height: 14),

                          _buildSwitchSetting(
                            title: 'Maintenance mode',

                            subtitle: 'Blocks tenant access platform-wide during scheduled updates.',

                            value: platformMaintenanceMode,

                            onChanged: (value) {
                              setState(() {
                                platformMaintenanceMode = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ==================================================

                    // BOTTOM ACTIONS

                    // ==================================================
                    _buildBottomActions(isMobile: isMobile),
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

  // TOP ACTIONS

  // ============================================================

  // ============================================================
  // PAGE HEADER
  // ============================================================

  Widget _buildPageHeader(bool isMobile) {
    if (isMobile) {
      return Column(
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
                      'Platform Administration / Global Settings',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Global Settings',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppTheme.text,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Text(
                    //   'Manage platform-wide behavior, regional defaults, security, notifications, and configuration.',
                    //   maxLines: 3,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextStyle(
                    //     color: AppTheme.textMuted,
                    //     fontSize: 11,
                    //     height: 1.3,
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                tooltip: 'Refresh',
                onPressed: () => setState(() {}),
                icon: Icon(Icons.refresh, color: AppTheme.ink, size: 26),
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Platform Administration  /  Global Settings',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
              ),
              const SizedBox(height: 7),
              Text(
                'Global Settings',
                style: TextStyle(
                  color: AppTheme.text,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Manage platform-wide behavior, regional defaults, security, notifications, and configuration.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        _buildRefreshButton(),
        const SizedBox(width: 8),
        _buildResetButton(),
        const SizedBox(width: 8),
        _buildSaveButton(),
      ],
    );
  }

  // BOTTOM ACTIONS

  // ============================================================

  Widget _buildBottomActions({required bool isMobile}) {
    if (isMobile) {
      return Row(
        children: [
          Expanded(child: _buildResetButton()),

          const SizedBox(width: 8),

          Expanded(child: _buildSaveButton()),
        ],
      );
    }

    return Align(
      alignment: Alignment.centerRight,

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          _buildResetButton(),

          const SizedBox(width: 8),

          _buildSaveButton(),
        ],
      ),
    );
  }

  // ============================================================

  // BUTTONS

  // ============================================================

  Widget _buildRefreshButton() {
    return OutlinedButton.icon(
      onPressed: () {
        setState(() {});
      },

      icon: const Icon(Icons.refresh, size: 17),

      label: const Text('Refresh'),
    );
  }

  Widget _buildResetButton() {
    return OutlinedButton(
      onPressed: _resetSettings,

      child: const Text('Reset'),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton.icon(
      onPressed: _saveSettings,

      icon: const Icon(Icons.save_outlined, size: 17),

      label: const Text('Save'),
    );
  }

  // ============================================================

  // SECTION CARD

  // ============================================================

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: AppTheme.paper,

        border: Border.all(color: AppTheme.border),

        borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 15, 18, 14),

            child: Text(
              title,

              style: TextStyle(
                color: AppTheme.text,

                fontSize: 14,

                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Divider(height: 1, color: AppTheme.border),

          Padding(padding: const EdgeInsets.all(14), child: child),
        ],
      ),
    );
  }

  // ============================================================

  // SWITCH SETTING

  // ============================================================

  Widget _buildSwitchSetting({
    required String title,

    required String subtitle,

    required bool value,

    required ValueChanged<bool> onChanged,
  }) {
    return Row(
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

                  fontSize: 13,

                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,

                maxLines: 3,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(
                  color: AppTheme.textMuted,

                  fontSize: 11,

                  height: 1.35,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        Switch.adaptive(value: value, onChanged: onChanged),
      ],
    );
  }

  // ============================================================

  // TEXT FIELD

  // ============================================================

  Widget _buildTextField({
    required String label,

    required String value,

    required ValueChanged<String> onChanged,

    bool requiredField = false,

    String? helperText,
  }) {
    return _SettingsTextField(
      label: label,

      value: value,

      requiredField: requiredField,

      helperText: helperText,

      onChanged: onChanged,
    );
  }

  // ============================================================

  // RESPONSIVE FIELDS

  // ============================================================

  Widget _buildResponsiveFields({
    required int columns,

    required List<Widget> children,
  }) {
    if (columns == 1) {
      return Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],

            if (i != children.length - 1) const SizedBox(height: 12),
          ],
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;

        final itemWidth =
            (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,

          runSpacing: 12,

          children: children
              .map((child) => SizedBox(width: itemWidth, child: child))
              .toList(),
        );
      },
    );
  }

  // ============================================================

  // NOTIFICATION CARD

  // ============================================================

  Widget _buildNotificationCard() {
    return _buildSmallCard(
      title: 'Notification settings',

      child: Column(
        children: [
          _buildCheckboxRow(
            title: 'Email notifications',

            value: emailNotifications,

            onChanged: (value) {
              setState(() {
                emailNotifications = value ?? false;
              });
            },
          ),

          const SizedBox(height: 8),

          _buildCheckboxRow(
            title: 'SMS notifications',

            value: smsNotifications,

            onChanged: (value) {
              setState(() {
                smsNotifications = value ?? false;
              });
            },
          ),

          const SizedBox(height: 8),

          _buildCheckboxRow(
            title: 'Push notifications',

            value: pushNotifications,

            onChanged: (value) {
              setState(() {
                pushNotifications = value ?? false;
              });
            },
          ),
        ],
      ),
    );
  }

  // ============================================================

  // CONFIGURATION CARD

  // ============================================================

  Widget _buildConfigurationCard() {
    return _buildSmallCard(
      title: 'Configuration information',

      child: Column(
        children: [
          _buildInfoRow(label: 'Last updated by', value: 'Super Administrator'),

          const SizedBox(height: 12),

          _buildInfoRow(
            label: 'Last updated on',

            value: '31-Jul-2026 09:30 AM',
          ),
        ],
      ),
    );
  }

  // ============================================================

  // SMALL CARD

  // ============================================================

  Widget _buildSmallCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: AppTheme.paper,

        border: Border.all(color: AppTheme.border),

        borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 13),

            child: Text(
              title,

              style: TextStyle(
                color: AppTheme.text,

                fontSize: 13,

                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Divider(height: 1, color: AppTheme.border),

          Padding(padding: const EdgeInsets.all(14), child: child),
        ],
      ),
    );
  }

  // ============================================================

  // CHECKBOX

  // ============================================================

  Widget _buildCheckboxRow({
    required String title,

    required bool value,

    required ValueChanged<bool?> onChanged,
  }) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },

      borderRadius: BorderRadius.circular(6),

      child: Row(
        children: [
          SizedBox(
            width: 24,

            height: 24,

            child: Checkbox(value: value, onChanged: onChanged),
          ),

          const SizedBox(width: 7),

          Expanded(
            child: Text(
              title,

              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                color: AppTheme.text,

                fontSize: 12,

                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================

  // INFO ROW

  // ============================================================

  Widget _buildInfoRow({required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Expanded(
          child: Text(
            label,

            style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
          ),
        ),

        const SizedBox(width: 12),

        Flexible(
          child: Text(
            value,

            textAlign: TextAlign.right,

            maxLines: 2,

            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              color: AppTheme.text,

              fontSize: 11,

              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================

  // DIVIDER

  // ============================================================

  Widget _buildDivider() {
    return Divider(height: 1, color: AppTheme.border);
  }

  // ============================================================

  // RESET

  // ============================================================

  void _resetSettings() {
    setState(() {
      maintenanceMode = false;

      forceMfa = true;

      allowTenantSelfSignup = false;

      enableAiCopilot = true;

      dataResidencyLock = true;

      multiFactorAuthentication = true;

      emailNotifications = false;

      smsNotifications = false;

      pushNotifications = false;

      platformMaintenanceMode = false;

      defaultLanguage = 'English';

      timeZone = 'Asia/Kolkata (UTC +05:30)';

      dateFormat = 'DD/MM/YYYY';

      timeFormat = '24 Hours';

      defaultCurrency = 'INR (₹)';

      passwordExpiry = '90 Days';

      sessionTimeout = '30 Minutes';

      maximumLoginAttempts = '5';

      maximumFileUploadSize = '100 MB';

      defaultTheme = 'Light';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings reset successfully.')),
    );
  }

  // ============================================================

  // SAVE

  // ============================================================

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Global settings saved successfully.')),
    );
  }
}

// ============================================================================

// RESPONSIVE TEXT FIELD

// ============================================================================

class _SettingsTextField extends StatefulWidget {
  final String label;

  final String value;

  final bool requiredField;

  final String? helperText;

  final ValueChanged<String> onChanged;

  const _SettingsTextField({
    required this.label,

    required this.value,

    required this.requiredField,

    required this.helperText,

    required this.onChanged,
  });

  @override
  State<_SettingsTextField> createState() => _SettingsTextFieldState();
}

class _SettingsTextFieldState extends State<_SettingsTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant _SettingsTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value && _controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        RichText(
          maxLines: 1,

          overflow: TextOverflow.ellipsis,

          text: TextSpan(
            text: widget.label,

            style: TextStyle(
              color: AppTheme.text,

              fontSize: 11,

              fontWeight: FontWeight.w600,
            ),

            children: widget.requiredField
                ? [
                    const TextSpan(
                      text: ' *',

                      style: TextStyle(color: Colors.red),
                    ),
                  ]
                : null,
          ),
        ),

        const SizedBox(height: 6),

        SizedBox(
          height: 40,

          child: TextField(
            controller: _controller,

            onChanged: widget.onChanged,

            textInputAction: TextInputAction.next,

            style: TextStyle(color: AppTheme.text, fontSize: 12),

            decoration: InputDecoration(
              filled: true,

              fillColor: AppTheme.paper,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,

                vertical: 10,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),

                borderSide: BorderSide(color: AppTheme.border),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),

                borderSide: BorderSide(color: AppTheme.border),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),

                borderSide: BorderSide(color: AppTheme.tealData),
              ),
            ),
          ),
        ),

        if (widget.helperText != null) ...[
          const SizedBox(height: 4),

          Text(
            widget.helperText!,

            maxLines: 2,

            overflow: TextOverflow.ellipsis,

            style: TextStyle(color: AppTheme.textMuted, fontSize: 9),
          ),
        ],
      ],
    );
  }
}
