import 'package:flutter/material.dart';

class PlatformBrandingPage extends StatefulWidget {
  const PlatformBrandingPage({super.key});

  @override
  State<PlatformBrandingPage> createState() => _PlatformBrandingPageState();
}

class _PlatformBrandingPageState extends State<PlatformBrandingPage> {
  // ============================================================
  // CONTROLLERS
  // ============================================================

  late final TextEditingController _platformNameController;
  late final TextEditingController _companyNameController;
  late final TextEditingController _taglineController;
  late final TextEditingController _footerController;
  late final TextEditingController _copyrightController;
  late final TextEditingController _welcomeController;

  // ============================================================
  // STATE
  // ============================================================

  bool _darkMode = false;

  String _selectedBackground = 'Glass Gradient';

  Color _primaryColor = const Color(0xFF1976D2);
  Color _secondaryColor = Colors.white;
  Color _accentColor = const Color(0xFF4CAF50);

  String _companyLogoName = 'SYNERGY';

  bool _platformNameError = false;
  bool _taglineError = false;

  DateTime _lastSaved = DateTime.now();

  @override
  void initState() {
    super.initState();

    _platformNameController = TextEditingController(
      text: 'Java Enterprise Suite',
    );

    _companyNameController = TextEditingController(text: 'Oracle Corporation');

    _taglineController = TextEditingController(
      text: 'Empowering Enterprise Intelligence',
    );

    _footerController = TextEditingController(
      text: 'System Maintained by IT Dept.',
    );

    _copyrightController = TextEditingController(
      text: '© 2024 platform branding. All rights reserved.',
    );

    _welcomeController = TextEditingController(
      text:
          'Welcome to Java Enterprise Suite.\nPlease authenticate to continue.',
    );
  }

  @override
  void dispose() {
    _platformNameController.dispose();
    _companyNameController.dispose();
    _taglineController.dispose();
    _footerController.dispose();
    _copyrightController.dispose();
    _welcomeController.dispose();

    super.dispose();
  }

  // ============================================================
  // SAVE
  // ============================================================

  void _saveChanges() {
    final platformName = _platformNameController.text.trim();
    final tagline = _taglineController.text.trim();

    setState(() {
      _platformNameError = platformName.isEmpty;
      _taglineError = tagline.length >= 120;
    });

    if (_platformNameError || _taglineError) {
      return;
    }

    setState(() {
      _lastSaved = DateTime.now();
    });

    _showSuccessDialog();
  }

  // ============================================================
  // CANCEL
  // ============================================================

  void _cancelChanges() {
    setState(() {
      _platformNameController.text = 'Java Enterprise Suite';
      _companyNameController.text = 'Oracle Corporation';
      _taglineController.text = 'Empowering Enterprise Intelligence';
      _footerController.text = 'System Maintained by IT Dept.';
      _copyrightController.text =
          '© 2024 platform branding. All rights reserved.';
      _welcomeController.text =
          'Welcome to Java Enterprise Suite.\nPlease authenticate to continue.';

      _primaryColor = const Color(0xFF1976D2);
      _secondaryColor = Colors.white;
      _accentColor = const Color(0xFF4CAF50);

      _selectedBackground = 'Glass Gradient';

      _platformNameError = false;
      _taglineError = false;
    });
  }

  // ============================================================
  // SUCCESS DIALOG
  // ============================================================

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final width = MediaQuery.of(context).size.width;
        final isMobile = width < 600;

        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 120,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 24 : 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 78,
                    height: 78,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F7EC),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 42,
                      color: Color(0xFF45B35B),
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Changes saved successfully',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF172033),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Your platform branding settings have been updated.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0xFF68788B),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2939E8),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // COMPANY LOGO
  // ============================================================

  void _showCompanyLogoDialog() {
    _showResponsiveDialog(
      title: 'Upload Company logo',
      child: _CompanyLogoDialogContent(
        companyLogoName: _companyLogoName,
        onUpload: () {
          setState(() {
            _companyLogoName = 'Stackly';
          });

          Navigator.of(context).pop();
        },
      ),
    );
  }

  // ============================================================
  // FAVICON
  // ============================================================

  void _showFaviconDialog() {
    _showResponsiveDialog(
      title: 'Upload Favicon',
      child: _FaviconDialogContent(
        onUpload: () {
          Navigator.of(context).pop();
          _showSnackBar('Favicon uploaded successfully.');
        },
      ),
    );
  }

  // ============================================================
  // EMAIL LOGO
  // ============================================================

  void _showEmailLogoDialog() {
    _showResponsiveDialog(
      title: 'Upload Email Header Logo',
      child: _EmailLogoDialogContent(
        onUpload: () {
          Navigator.of(context).pop();
          _showSnackBar('Email header logo uploaded successfully.');
        },
      ),
    );
  }

  // ============================================================
  // BACKGROUND
  // ============================================================

  void _showBackgroundDialog() {
    _showResponsiveDialog(
      title: 'Change Login Background Image',
      child: _BackgroundDialogContent(
        selectedBackground: _selectedBackground,
        onSelect: (value) {
          setState(() {
            _selectedBackground = value;
          });
        },
        onSave: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  // ============================================================
  // COLOR PICKER
  // ============================================================

  void _showColorPicker({
    required String title,
    required Color currentColor,
    required ValueChanged<Color> onSelected,
  }) {
    _showResponsiveDialog(
      title: title,
      child: _ColorPickerContent(
        initialColor: currentColor,
        onCancel: () {
          Navigator.of(context).pop();
        },
        onSelect: (color) {
          onSelected(color);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  // ============================================================
  // PREVIEW
  // ============================================================

  void _showPreview() {
    _showResponsiveDialog(
      title: 'Preview Platform Branding',
      large: true,
      child: _PlatformPreviewContent(
        platformName: _platformNameController.text.trim().isEmpty
            ? 'Java Enterprise Suite'
            : _platformNameController.text.trim(),
        companyName: _companyNameController.text.trim().isEmpty
            ? 'SYNERGY'
            : _companyNameController.text.trim(),
        tagline: _taglineController.text.trim(),
        welcomeMessage: _welcomeController.text.trim(),
        footer: _footerController.text.trim(),
        copyright: _copyrightController.text.trim(),
        primaryColor: _primaryColor,
        selectedBackground: _selectedBackground,
        onClose: () {
          Navigator.of(context).pop();
        },
        onSave: () {
          Navigator.of(context).pop();
          _saveChanges();
        },
      ),
    );
  }

  // ============================================================
  // RESPONSIVE DIALOG
  // ============================================================

  void _showResponsiveDialog({
    required String title,
    required Widget child,
    bool large = false,
  }) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.58),
      builder: (dialogContext) {
        final screenWidth = MediaQuery.of(dialogContext).size.width;

        final screenHeight = MediaQuery.of(dialogContext).size.height;

        final isMobile = screenWidth < 650;

        final maxWidth = large ? 1050.0 : 720.0;

        final maxHeight = screenHeight * 0.90;

        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 0 : 24,
            vertical: isMobile ? 0 : 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isMobile ? 22 : 16),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
            ),
            child: isMobile
                ? SafeArea(
                    child: _MobileDialogShell(title: title, child: child),
                  )
                : _DesktopDialogShell(title: title, child: child),
          ),
        );
      },
    );
  }

  // ============================================================
  // SNACKBAR
  // ============================================================

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

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

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  width < 600 ? 14 : 24,
                  width < 600 ? 12 : 18,
                  width < 600 ? 14 : 24,
                  28,
                ),
                child: _buildResponsiveContent(context, width),
              );
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  // RESPONSIVE CONTENT
  // ============================================================

  Widget _buildResponsiveContent(BuildContext context, double width) {
    final isMobile = width < 700;
    final isTablet = width >= 700 && width < 1100;

    if (isMobile) {
      return _buildMobileLayout(context);
    }

    if (isTablet) {
      return _buildTabletLayout(context);
    }

    return _buildDesktopLayout(context);
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBreadcrumb(),

        const SizedBox(height: 6),

        _buildPageTitle(fontSize: 24),

        const SizedBox(height: 16),

        _buildIdentityCard(context),

        const SizedBox(height: 14),

        _buildVisualAssetsCard(context),

        const SizedBox(height: 14),

        _buildFooterCard(context),

        const SizedBox(height: 14),

        _buildLoginBackgroundCard(context),

        const SizedBox(height: 14),

        _buildWelcomeMessageCard(context),

        const SizedBox(height: 14),

        _buildSecurityCard(context),

        const SizedBox(height: 14),

        _buildThemeCard(context),

        const SizedBox(height: 14),

        _buildLastSaved(),

        const SizedBox(height: 14),

        _buildMobileActionButtons(context),
      ],
    );
  }

  // ============================================================
  // TABLET
  // ============================================================

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBreadcrumb(),

        const SizedBox(height: 6),

        _buildPageHeader(context, compact: true),

        const SizedBox(height: 16),

        _buildIdentityCard(context),

        const SizedBox(height: 14),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildVisualAssetsCard(context)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                children: [
                  _buildLoginBackgroundCard(context),
                  const SizedBox(height: 14),
                  _buildWelcomeMessageCard(context),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        _buildFooterCard(context),

        const SizedBox(height: 14),

        _buildSecurityCard(context),

        const SizedBox(height: 14),

        _buildThemeCard(context),

        const SizedBox(height: 14),

        _buildBottomActions(context),
      ],
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBreadcrumb(),

        const SizedBox(height: 5),

        _buildPageHeader(context),

        const SizedBox(height: 18),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  _buildIdentityCard(context),

                  const SizedBox(height: 14),

                  _buildVisualAssetsCard(context),

                  const SizedBox(height: 14),

                  _buildThemeCard(context),
                ],
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              flex: 3,
              child: Column(
                children: [
                  _buildLoginBackgroundCard(context),

                  const SizedBox(height: 14),

                  _buildWelcomeMessageCard(context),

                  const SizedBox(height: 14),

                  _buildSecurityCard(context),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        _buildLastSaved(),

        const SizedBox(height: 8),

        _buildDesktopFooterActions(context),
      ],
    );
  }

  // ============================================================
  // BREADCRUMB
  // ============================================================

  Widget _buildBreadcrumb() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: const [
        Text(
          'Platform Administration',
          style: TextStyle(fontSize: 11, color: Color(0xFF72849A)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(
            Icons.chevron_right_rounded,
            size: 15,
            color: Color(0xFF9AA7B6),
          ),
        ),
        Text(
          'Platform Branding',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF263445),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PAGE TITLE
  // ============================================================

  Widget _buildPageTitle({double fontSize = 27}) {
    return Text(
      'Platform Branding',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF172033),
      ),
    );
  }

  // ============================================================
  // PAGE HEADER
  // ============================================================

  Widget _buildPageHeader(BuildContext context, {bool compact = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPageTitle(fontSize: compact ? 25 : 28),
              const SizedBox(height: 4),
              const Text(
                'Configure your enterprise platform to create a consistent and recognizable brand experience.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11, color: Color(0xFF697789)),
              ),
            ],
          ),
        ),

        const SizedBox(width: 14),

        Wrap(
          spacing: 8,
          children: [
            OutlinedButton(
              onPressed: _cancelChanges,
              child: const Text('Cancel', style: TextStyle(fontSize: 11)),
            ),
            OutlinedButton(
              onPressed: _showPreview,
              child: const Text('Preview', style: TextStyle(fontSize: 11)),
            ),
            ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(Icons.save_outlined, size: 14),
              label: const Text('Save Changes', style: TextStyle(fontSize: 11)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2939E8),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // IDENTITY CARD
  // ============================================================

  Widget _buildIdentityCard(BuildContext context) {
    return _BrandingCard(
      title: 'Platform Identity',
      trailing: 'Basic Info',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 600;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: 'Platform Name',
                controller: _platformNameController,
                errorText: _platformNameError
                    ? 'Platform name is required'
                    : null,
                onChanged: (_) {
                  if (_platformNameError) {
                    setState(() {
                      _platformNameError = false;
                    });
                  }
                },
              ),

              const SizedBox(height: 14),

              if (stacked)
                Column(
                  children: [
                    _buildTextField(
                      label: 'Company Name',
                      controller: _companyNameController,
                    ),

                    const SizedBox(height: 14),

                    _buildTaglineField(),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Company Name',
                        controller: _companyNameController,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(child: _buildTaglineField()),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // TAGLINE
  // ============================================================

  Widget _buildTaglineField() {
    return _buildTextField(
      label: 'Tagline',
      controller: _taglineController,
      errorText: _taglineError
          ? 'Tagline must be fewer than 120 characters'
          : null,
      maxLength: 120,
      onChanged: (value) {
        setState(() {
          _taglineError = value.length >= 120;
        });
      },
    );
  }

  // ============================================================
  // VISUAL ASSETS
  // ============================================================

  Widget _buildVisualAssetsCard(BuildContext context) {
    return _BrandingCard(
      title: 'Visual Assets',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 600;

          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCompanyLogo(context),

                const SizedBox(height: 18),

                _buildFavicon(context),

                const SizedBox(height: 18),

                _buildEmailLogo(context),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 6, child: _buildCompanyLogo(context)),

              const SizedBox(width: 16),

              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buildFavicon(context),

                    const SizedBox(height: 18),

                    _buildEmailLogo(context),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // COMPANY LOGO
  // ============================================================

  Widget _buildCompanyLogo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAssetLabel('Company Logo', 'PNG, SVG up to 5MB'),

        const SizedBox(height: 8),

        InkWell(
          onTap: _showCompanyLogoDialog,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 155,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFD1DBE6), width: 1.5),
            ),
            child: Center(
              child: Text(
                _companyLogoName.toUpperCase(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF3D4DE4),
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FAVICON
  // ============================================================

  Widget _buildFavicon(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAssetLabel('Favicon', ''),

        const SizedBox(height: 8),

        Wrap(
          spacing: 12,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: const Color(0xFFDCE3E9)),
              ),
              child: const Center(
                child: Icon(
                  Icons.image_outlined,
                  size: 18,
                  color: Color(0xFF9BA8B7),
                ),
              ),
            ),

            OutlinedButton(
              onPressed: _showFaviconDialog,
              child: const Text(
                'Upload Favicon',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // EMAIL LOGO
  // ============================================================

  Widget _buildEmailLogo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAssetLabel('Email Header Logo', ''),

        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: const Color(0xFFDCE3E9)),
                ),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'No file chosen',
                  style: TextStyle(fontSize: 10, color: Color(0xFF8B98A8)),
                ),
              ),
            ),

            const SizedBox(width: 10),

            OutlinedButton(
              onPressed: _showEmailLogoDialog,
              child: const Text('Upload File', style: TextStyle(fontSize: 10)),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // ASSET LABEL
  // ============================================================

  Widget _buildAssetLabel(String title, String helper) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF596779),
            ),
          ),
        ),

        if (helper.isNotEmpty)
          Text(
            helper,
            style: const TextStyle(fontSize: 9, color: Color(0xFF9AA5B1)),
          ),
      ],
    );
  }

  // ============================================================
  // FOOTER CARD
  // ============================================================

  Widget _buildFooterCard(BuildContext context) {
    return _BrandingCard(
      title: 'Footer & Copyright',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 600;

          if (stacked) {
            return Column(
              children: [
                _buildTextField(
                  label: 'Footer Text',
                  controller: _footerController,
                  maxLength: 200,
                ),

                const SizedBox(height: 14),

                _buildTextField(
                  label: 'Copyright Text',
                  controller: _copyrightController,
                ),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: _buildTextField(
                  label: 'Footer Text',
                  controller: _footerController,
                  maxLength: 200,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: _buildTextField(
                  label: 'Copyright Text',
                  controller: _copyrightController,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // LOGIN BACKGROUND
  // ============================================================

  Widget _buildLoginBackgroundCard(BuildContext context) {
    return _BrandingCard(
      title: 'Login Background',
      titleAction: TextButton(
        onPressed: _showBackgroundDialog,
        child: const Text(
          'Change Image',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xFF155BD5),
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 190,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: _buildBackgroundPreview(_selectedBackground),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BACKGROUND PREVIEW
  // ============================================================

  Widget _buildBackgroundPreview(String background) {
    final gradient = _backgroundGradient(background);

    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Center(
        child: Container(
          width: 190,
          height: 125,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.90),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 14,
                width: 65,
                decoration: BoxDecoration(
                  color: const Color(0xFFE1E4E8),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              const SizedBox(height: 9),

              Container(
                height: 14,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE1E4E8),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              const SizedBox(height: 9),

              Container(
                height: 14,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE1E4E8),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              const SizedBox(height: 9),

              Container(
                height: 20,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF171E51),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LinearGradient _backgroundGradient(String name) {
    switch (name) {
      case 'Modern Arch':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFB7D4F0), Color(0xFFF7FAFD)],
        );

      case 'Tech Slate':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF252B35), Color(0xFF4C5563)],
        );

      case 'Mist Valley':
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF8EAFE4), Color(0xFF263E79)],
        );

      case 'Loft Studio':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE1D1B2), Color(0xFF967B5B)],
        );

      case 'Studio Shapes':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFB9D7F0), Color(0xFFE9D3EC)],
        );

      case 'Glass Gradient':
      default:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8E6CF0), Color(0xFF55B8EE)],
        );
    }
  }

  // ============================================================
  // WELCOME MESSAGE
  // ============================================================

  Widget _buildWelcomeMessageCard(BuildContext context) {
    return _BrandingCard(
      title: 'Welcome Message',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome Message',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF596779),
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: _welcomeController,
            maxLines: 4,
            maxLength: 250,
            decoration: InputDecoration(
              hintText: 'Enter welcome message',
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_welcomeController.text.length}/250',
              style: const TextStyle(fontSize: 8, color: Color(0xFF9BA6B2)),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECURITY
  // ============================================================

  Widget _buildSecurityCard(BuildContext context) {
    return _BrandingCard(
      backgroundColor: const Color(0xFFF0F5FA),
      title: 'Security & Rules',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'VALIDATION RULES',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: Color(0xFF445163),
            ),
          ),

          const SizedBox(height: 10),

          _SecurityRule(
            icon: Icons.check_circle_outline,
            text: 'Images: PNG, JPG, SVG max 5MB.\nBackground max 10MB.',
          ),

          const SizedBox(height: 8),

          _SecurityRule(
            icon: Icons.check_circle_outline,
            text: 'Text fields max 100 chars; Messages max 250 chars.',
          ),

          const SizedBox(height: 8),

          _SecurityRule(
            icon: Icons.check_circle_outline,
            text: 'Colors must be valid hex values.',
          ),

          const SizedBox(height: 14),

          const Divider(),

          const SizedBox(height: 12),

          const Text(
            'SECURITY HANDLING',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: Color(0xFF445163),
            ),
          ),

          const SizedBox(height: 10),

          const _SecurityRule(
            icon: Icons.admin_panel_settings_outlined,
            text: 'Super Admin (RBAC) access only.',
          ),

          const SizedBox(height: 8),

          const _SecurityRule(
            icon: Icons.history_rounded,
            text: 'All changes logged to Audit Trail.',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // THEME
  // ============================================================

  Widget _buildThemeCard(BuildContext context) {
    return _BrandingCard(
      title: 'Theme Configuration',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 550;

              final themeButtons = Row(
                children: [
                  Expanded(
                    child: _ThemeButton(
                      title: '☼  Light mode',
                      selected: !_darkMode,
                      onTap: () {
                        setState(() {
                          _darkMode = false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ThemeButton(
                      title: '☾  Dark mode',
                      selected: _darkMode,
                      onTap: () {
                        setState(() {
                          _darkMode = true;
                        });
                      },
                    ),
                  ),
                ],
              );

              if (stacked) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Theme',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF596779),
                      ),
                    ),
                    const SizedBox(height: 9),
                    themeButtons,
                  ],
                );
              }

              return Row(
                children: [
                  const SizedBox(
                    width: 70,
                    child: Text(
                      'Theme',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF596779),
                      ),
                    ),
                  ),
                  Expanded(child: themeButtons),
                ],
              );
            },
          ),

          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 650) {
                return Column(
                  children: [
                    _buildColorField(
                      context,
                      label: 'Primary Color',
                      color: _primaryColor,
                      onTap: () {
                        _showColorPicker(
                          title: 'Primary Color',
                          currentColor: _primaryColor,
                          onSelected: (color) {
                            setState(() {
                              _primaryColor = color;
                            });
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 14),

                    _buildColorField(
                      context,
                      label: 'Secondary Color',
                      color: _secondaryColor,
                      onTap: () {
                        _showColorPicker(
                          title: 'Secondary Color',
                          currentColor: _secondaryColor,
                          onSelected: (color) {
                            setState(() {
                              _secondaryColor = color;
                            });
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 14),

                    _buildColorField(
                      context,
                      label: 'Accent Color',
                      color: _accentColor,
                      onTap: () {
                        _showColorPicker(
                          title: 'Accent Color',
                          currentColor: _accentColor,
                          onSelected: (color) {
                            setState(() {
                              _accentColor = color;
                            });
                          },
                        );
                      },
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _buildColorField(
                      context,
                      label: 'Primary Color',
                      color: _primaryColor,
                      onTap: () {
                        _showColorPicker(
                          title: 'Primary Color',
                          currentColor: _primaryColor,
                          onSelected: (color) {
                            setState(() {
                              _primaryColor = color;
                            });
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: _buildColorField(
                      context,
                      label: 'Secondary Color',
                      color: _secondaryColor,
                      onTap: () {
                        _showColorPicker(
                          title: 'Secondary Color',
                          currentColor: _secondaryColor,
                          onSelected: (color) {
                            setState(() {
                              _secondaryColor = color;
                            });
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: _buildColorField(
                      context,
                      label: 'Accent Color',
                      color: _accentColor,
                      onTap: () {
                        _showColorPicker(
                          title: 'Accent Color',
                          currentColor: _accentColor,
                          onSelected: (color) {
                            setState(() {
                              _accentColor = color;
                            });
                          },
                        );
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

  // ============================================================
  // COLOR FIELD
  // ============================================================

  Widget _buildColorField(
    BuildContext context, {
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: Color(0xFF596779),
          ),
        ),

        const SizedBox(height: 7),

        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(7),
          child: Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: const Color(0xFFDCE3E9)),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: const Color(0xFFD9DEE5)),
                  ),
                ),

                const SizedBox(width: 9),

                Expanded(
                  child: Text(
                    _colorToHex(color),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF596779),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // LAST SAVED
  // ============================================================

  Widget _buildLastSaved() {
    final difference = DateTime.now().difference(_lastSaved);

    String text;

    if (difference.inMinutes <= 0) {
      text = 'Last saved: just now';
    } else {
      text = 'Last saved: ${difference.inMinutes} min ago';
    }

    return Row(
      children: [
        const Icon(Icons.sync_rounded, size: 14, color: Color(0xFF657383)),

        const SizedBox(width: 7),

        Text(
          text,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: Color(0xFF657383),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DESKTOP FOOTER ACTIONS
  // ============================================================

  Widget _buildDesktopFooterActions(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Wrap(
        spacing: 8,
        children: [
          OutlinedButton(
            onPressed: _cancelChanges,
            child: const Text('Cancel', style: TextStyle(fontSize: 11)),
          ),
          OutlinedButton(
            onPressed: _showPreview,
            child: const Text('Preview', style: TextStyle(fontSize: 11)),
          ),
          ElevatedButton.icon(
            onPressed: _saveChanges,
            icon: const Icon(Icons.save_outlined, size: 14),
            label: const Text('Save Changes', style: TextStyle(fontSize: 11)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2939E8),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TABLET / MOBILE ACTIONS
  // ============================================================

  Widget _buildBottomActions(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 500;

        if (stacked) {
          return Column(
            children: [
              _fullButton(
                label: 'Preview',
                outlined: true,
                onPressed: _showPreview,
              ),
              const SizedBox(height: 8),
              _fullButton(label: 'Save', onPressed: _saveChanges),
              const SizedBox(height: 8),
              _fullButton(
                label: 'Cancel',
                outlined: true,
                onPressed: _cancelChanges,
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _fullButton(
                label: 'Preview',
                outlined: true,
                onPressed: _showPreview,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _fullButton(label: 'Save', onPressed: _saveChanges),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _fullButton(
                label: 'Cancel',
                outlined: true,
                onPressed: _cancelChanges,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMobileActionButtons(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _fullButton(
                label: 'Preview',
                outlined: true,
                onPressed: _showPreview,
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: _fullButton(
                label: 'Save',
                onPressed: _saveChanges,
                icon: Icons.save_outlined,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        _fullButton(label: 'Cancel', outlined: true, onPressed: _cancelChanges),
      ],
    );
  }

  Widget _fullButton({
    required String label,
    required VoidCallback onPressed,
    bool outlined = false,
    IconData? icon,
  }) {
    final child = icon == null
        ? Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );

    if (outlined) {
      return SizedBox(
        height: 42,
        width: double.infinity,
        child: OutlinedButton(onPressed: onPressed, child: child),
      );
    }

    return SizedBox(
      height: 42,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2939E8),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        child: child,
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? errorText,
    int? maxLength,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xFF596779),
          ),
        ),

        const SizedBox(height: 7),

        TextField(
          controller: controller,
          maxLength: maxLength,
          onChanged: onChanged,
          decoration: InputDecoration(
            counterText: '',
            errorText: errorText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFDCE3E9)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: errorText == null
                    ? const Color(0xFFDCE3E9)
                    : const Color(0xFFE53935),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: errorText == null
                    ? const Color(0xFF3B4DE8)
                    : const Color(0xFFE53935),
                width: 1.4,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE53935)),
            ),
          ),
          style: const TextStyle(fontSize: 12, color: Color(0xFF253246)),
        ),
      ],
    );
  }

  // ============================================================
  // HEX
  // ============================================================

  String _colorToHex(Color color) {
    final r = (color.r * 255).round();
    final g = (color.g * 255).round();
    final b = (color.b * 255).round();

    return '#${r.toRadixString(16).padLeft(2, '0')}'
            '${g.toRadixString(16).padLeft(2, '0')}'
            '${b.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }
}

// ============================================================================
// BRANDING CARD
// ============================================================================

class _BrandingCard extends StatelessWidget {
  final String title;
  final String? trailing;
  final Widget? titleAction;
  final Widget child;
  final Color backgroundColor;

  const _BrandingCard({
    required this.title,
    required this.child,
    this.trailing,
    this.titleAction,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE3E9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF172033),
                    ),
                  ),
                ),

                if (trailing != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F6F8),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      trailing!,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFF697789),
                      ),
                    ),
                  ),

                if (titleAction != null) titleAction!,
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE7EBEF)),

          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }
}

// ============================================================================
// SECURITY RULE
// ============================================================================

class _SecurityRule extends StatelessWidget {
  final IconData icon;
  final String text;

  const _SecurityRule({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: const Color(0xFF6C7887)),

        const SizedBox(width: 7),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 9,
              height: 1.45,
              color: Color(0xFF687483),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// THEME BUTTON
// ============================================================================

class _ThemeButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeButton({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: selected ? Colors.white : const Color(0xFFF1F4F7),
          foregroundColor: selected
              ? const Color(0xFF263246)
              : const Color(0xFF7B8794),
          side: BorderSide(
            color: selected ? const Color(0xFFDCE3E9) : const Color(0xFFE4E8ED),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

// ============================================================================
// DESKTOP DIALOG SHELL
// ============================================================================

class _DesktopDialogShell extends StatelessWidget {
  final String title;
  final Widget child;

  const _DesktopDialogShell({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 16, 14),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF172033),
                  ),
                ),
              ),

              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close_rounded, size: 21),
              ),
            ],
          ),
        ),

        const Divider(height: 1),

        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: child,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// MOBILE DIALOG SHELL
// ============================================================================

class _MobileDialogShell extends StatelessWidget {
  final String title;
  final Widget child;

  const _MobileDialogShell({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),

        Container(
          width: 80,
          height: 5,
          decoration: BoxDecoration(
            color: const Color(0xFFD3D8E2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 10, 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF172033),
                  ),
                ),
              ),

              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close_rounded, size: 27),
              ),
            ],
          ),
        ),

        const Divider(height: 1),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: child,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// COMPANY LOGO DIALOG
// ============================================================================

class _CompanyLogoDialogContent extends StatelessWidget {
  final String companyLogoName;
  final VoidCallback onUpload;

  const _CompanyLogoDialogContent({
    required this.companyLogoName,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _UploadDropZone(
          icon: Icons.cloud_upload_outlined,
          title: 'Drag & drop your logo here',
          subtitle: 'or click to browse files',
          helper: 'PNG, SVG, JPG format supported — Max 2MB',
        ),

        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFDCE3E9)),
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F9FB),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: const Color(0xFFDCE3E9)),
                ),
                child: Center(
                  child: Text(
                    companyLogoName,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF3E4DE0),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'stackly_logo_brand.svg',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '145 KB  •  Upload complete',
                      style: TextStyle(fontSize: 10, color: Color(0xFF3049EA)),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFFE63352),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: ElevatedButton(
                onPressed: onUpload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2939E8),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Upload'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================================
// FAVICON DIALOG
// ============================================================================

class _FaviconDialogContent extends StatelessWidget {
  final VoidCallback onUpload;

  const _FaviconDialogContent({required this.onUpload});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _UploadDropZone(
          icon: Icons.file_upload_outlined,
          title: 'Drag & drop your favicon here',
          subtitle: 'or click to browse files',
          helper:
              'ICO, PNG format supported — 32x32 or 16x16 pixels recommended',
        ),

        const SizedBox(height: 18),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F5FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFDCE3E9)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BROWSER TAB PREVIEW',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF5E6873),
                ),
              ),

              SizedBox(height: 12),

              _BrowserPreview(),
            ],
          ),
        ),

        const SizedBox(height: 22),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: ElevatedButton(
                onPressed: onUpload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2939E8),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Upload'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================================
// EMAIL LOGO DIALOG
// ============================================================================

class _EmailLogoDialogContent extends StatelessWidget {
  final VoidCallback onUpload;

  const _EmailLogoDialogContent({required this.onUpload});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _UploadDropZone(
          icon: Icons.cloud_upload_outlined,
          title: 'Drag & drop your email logo here',
          subtitle: 'or click to browse files',
          helper: 'PNG, SVG, JPG format supported — Max 2MB',
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: ElevatedButton(
                onPressed: onUpload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2939E8),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Upload'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================================
// DROP ZONE
// ============================================================================

class _UploadDropZone extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String helper;

  const _UploadDropZone({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.helper,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF3049FF), width: 2),
      ),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0xFFEAF0FF),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 25, color: const Color(0xFF3049FF)),
          ),

          const SizedBox(height: 14),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF172033),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Color(0xFF687483)),
          ),

          const SizedBox(height: 14),

          Text(
            helper,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, color: Color(0xFF687483)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// BROWSER PREVIEW
// ============================================================================

class _BrowserPreview extends StatelessWidget {
  const _BrowserPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFDCE3E9)),
      ),
      child: Row(
        children: [
          _BrowserDot(color: const Color(0xFFFF5F57)),
          const SizedBox(width: 5),
          _BrowserDot(color: const Color(0xFFFFBD2E)),
          const SizedBox(width: 5),
          _BrowserDot(color: const Color(0xFF28C840)),

          const SizedBox(width: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3F7),
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Row(
              children: [
                Icon(Icons.apps_rounded, size: 14, color: Color(0xFF593B72)),
                SizedBox(width: 6),
                Text(
                  'Stackly Portal',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BrowserDot extends StatelessWidget {
  final Color color;

  const _BrowserDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9,
      height: 9,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// ============================================================================
// BACKGROUND DIALOG
// ============================================================================

class _BackgroundDialogContent extends StatelessWidget {
  final String selectedBackground;
  final ValueChanged<String> onSelect;
  final VoidCallback onSave;

  const _BackgroundDialogContent({
    required this.selectedBackground,
    required this.onSelect,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    const backgrounds = [
      'Modern Arch',
      'Glass Gradient',
      'Tech Slate',
      'Mist Valley',
      'Loft Studio',
      'Studio Shapes',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CHOOSE FROM PRESETS',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
            color: Color(0xFF68769A),
          ),
        ),

        const SizedBox(height: 14),

        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth < 500 ? 2 : 3;

            const gap = 10.0;

            final width =
                (constraints.maxWidth - ((columns - 1) * gap)) / columns;

            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: backgrounds.map((name) {
                return SizedBox(
                  width: width,
                  child: _BackgroundPreset(
                    name: name,
                    selected: name == selectedBackground,
                    onTap: () => onSelect(name),
                  ),
                );
              }).toList(),
            );
          },
        ),

        const SizedBox(height: 10),

        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(9),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: const Color(0xFFDCE3E9),
                style: BorderStyle.solid,
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  color: Color(0xFF3049FF),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Upload a custom background...',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFDCE3E9)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SELECTED PREVIEW',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: Color(0xFF68769A),
                ),
              ),

              const SizedBox(height: 12),

              AspectRatio(
                aspectRatio: 1.75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: _gradient(selectedBackground),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                selectedBackground,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF172033),
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'Default Gradient System',
                style: TextStyle(fontSize: 11, color: Color(0xFF68769A)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2939E8),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  LinearGradient _gradient(String name) {
    switch (name) {
      case 'Modern Arch':
        return const LinearGradient(
          colors: [Color(0xFFB7D4F0), Color(0xFFF7FAFD)],
        );

      case 'Tech Slate':
        return const LinearGradient(
          colors: [Color(0xFF252B35), Color(0xFF4C5563)],
        );

      case 'Mist Valley':
        return const LinearGradient(
          colors: [Color(0xFF8EAFE4), Color(0xFF263E79)],
        );

      case 'Loft Studio':
        return const LinearGradient(
          colors: [Color(0xFFE1D1B2), Color(0xFF967B5B)],
        );

      case 'Studio Shapes':
        return const LinearGradient(
          colors: [Color(0xFFB9D7F0), Color(0xFFE9D3EC)],
        );

      case 'Glass Gradient':
      default:
        return const LinearGradient(
          colors: [Color(0xFF9C7BF0), Color(0xFF55B8EE)],
        );
    }
  }
}

// ============================================================================
// BACKGROUND PRESET
// ============================================================================

class _BackgroundPreset extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const _BackgroundPreset({
    required this.name,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? const Color(0xFF3049FF) : const Color(0xFFDCE3E9),
            width: selected ? 2.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  decoration: BoxDecoration(gradient: _gradient(name)),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(5, 7, 5, 5),
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient _gradient(String name) {
    switch (name) {
      case 'Modern Arch':
        return const LinearGradient(
          colors: [Color(0xFFB7D4F0), Color(0xFFF7FAFD)],
        );

      case 'Tech Slate':
        return const LinearGradient(
          colors: [Color(0xFF252B35), Color(0xFF4C5563)],
        );

      case 'Mist Valley':
        return const LinearGradient(
          colors: [Color(0xFF8EAFE4), Color(0xFF263E79)],
        );

      case 'Loft Studio':
        return const LinearGradient(
          colors: [Color(0xFFE1D1B2), Color(0xFF967B5B)],
        );

      case 'Studio Shapes':
        return const LinearGradient(
          colors: [Color(0xFFB9D7F0), Color(0xFFE9D3EC)],
        );

      default:
        return const LinearGradient(
          colors: [Color(0xFF9C7BF0), Color(0xFF55B8EE)],
        );
    }
  }
}

// ============================================================================
// COLOR PICKER
// ============================================================================

class _ColorPickerContent extends StatefulWidget {
  final Color initialColor;
  final VoidCallback onCancel;
  final ValueChanged<Color> onSelect;

  const _ColorPickerContent({
    required this.initialColor,
    required this.onCancel,
    required this.onSelect,
  });

  @override
  State<_ColorPickerContent> createState() => _ColorPickerContentState();
}

class _ColorPickerContentState extends State<_ColorPickerContent> {
  late Color _color;

  late TextEditingController _hexController;
  late TextEditingController _rController;
  late TextEditingController _gController;
  late TextEditingController _bController;

  @override
  void initState() {
    super.initState();

    _color = widget.initialColor;

    _hexController = TextEditingController(text: _hex(_color));

    _rController = TextEditingController(text: '${(_color.r * 255).round()}');

    _gController = TextEditingController(text: '${(_color.g * 255).round()}');

    _bController = TextEditingController(text: '${(_color.b * 255).round()}');
  }

  @override
  void dispose() {
    _hexController.dispose();
    _rController.dispose();
    _gController.dispose();
    _bController.dispose();

    super.dispose();
  }

  void _setColor(Color color) {
    setState(() {
      _color = color;

      _hexController.text = _hex(color);
      _rController.text = '${(color.r * 255).round()}';
      _gController.text = '${(color.g * 255).round()}';
      _bController.text = '${(color.b * 255).round()}';
    });
  }

  String _hex(Color color) {
    final r = (color.r * 255).round();
    final g = (color.g * 255).round();
    final b = (color.b * 255).round();

    return '#${r.toRadixString(16).padLeft(2, '0')}'
            '${g.toRadixString(16).padLeft(2, '0')}'
            '${b.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  Color _fromHex(String value) {
    var hex = value.replaceAll('#', '');

    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    if (hex.length != 8) {
      return _color;
    }

    final valueInt = int.tryParse(hex, radix: 16);

    if (valueInt == null) {
      return _color;
    }

    return Color(valueInt);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color(0xFFFFC477), Color(0xFF050505)],
            ),
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        Container(
          height: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.cyan,
                Colors.blue,
                Colors.purple,
                Colors.pink,
              ],
            ),
          ),
        ),

        const SizedBox(height: 18),

        LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 500;

            if (stacked) {
              return Column(
                children: [
                  _pickerField(
                    'Hex',
                    _hexController,
                    onChanged: (value) {
                      final color = _fromHex(value);

                      _setColor(color);
                    },
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: _pickerField(
                          'R',
                          _rController,
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _pickerField(
                          'G',
                          _gController,
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _pickerField(
                          'B',
                          _bController,
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }

            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _pickerField(
                    'Hex',
                    _hexController,
                    onChanged: (value) {
                      final color = _fromHex(value);

                      _setColor(color);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _pickerField('R', _rController, onChanged: (_) {}),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _pickerField('G', _gController, onChanged: (_) {}),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _pickerField('B', _bController, onChanged: (_) {}),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 22),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: widget.onCancel,
                child: const Text('Cancel'),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  widget.onSelect(_color);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2939E8),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Select'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _pickerField(
    String label,
    TextEditingController controller, {
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xFF172033),
          ),
        ),

        const SizedBox(height: 6),

        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 11,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// PLATFORM PREVIEW
// ============================================================================

class _PlatformPreviewContent extends StatelessWidget {
  final String platformName;
  final String companyName;
  final String tagline;
  final String welcomeMessage;
  final String footer;
  final String copyright;
  final Color primaryColor;
  final String selectedBackground;
  final VoidCallback onClose;
  final VoidCallback onSave;

  const _PlatformPreviewContent({
    required this.platformName,
    required this.companyName,
    required this.tagline,
    required this.welcomeMessage,
    required this.footer,
    required this.copyright,
    required this.primaryColor,
    required this.selectedBackground,
    required this.onClose,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LOGIN PAGE PREVIEW',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
            color: Color(0xFF68769A),
          ),
        ),

        const SizedBox(height: 14),

        AspectRatio(
          aspectRatio: 1.45,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: _backgroundGradient(),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final narrow = constraints.maxWidth < 650;

                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: narrow ? 500 : 560),
                    child: Container(
                      padding: EdgeInsets.all(narrow ? 20 : 28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.diamond_outlined,
                                    color: Colors.white,
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      companyName,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                        color: primaryColor,
                                      ),
                                    ),
                                    const Text(
                                      'ENTERPRISE SOFTWARE',
                                      style: TextStyle(
                                        fontSize: 7,
                                        letterSpacing: 0.8,
                                        color: Color(0xFF68769A),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            Text(
                              'Welcome to $platformName',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF172033),
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              'Please authenticate to continue.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF68769A),
                              ),
                            ),

                            const SizedBox(height: 20),

                            _PreviewField(
                              label: 'Work Email',
                              value: 'renu.kapoor@oracle.com',
                            ),

                            const SizedBox(height: 10),

                            _PreviewField(
                              label: 'Password',
                              value: 'password1234',
                            ),

                            const SizedBox(height: 14),

                            Row(
                              children: [
                                Container(
                                  width: 17,
                                  height: 17,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),

                                const SizedBox(width: 7),

                                const Expanded(
                                  child: Text(
                                    'Remember this device (30 days)',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F7EF),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Text(
                                    'MFA Active',
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Color(0xFF219653),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Sign in to Platform  →',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            Text(
                              tagline.isEmpty
                                  ? 'Empowering Enterprise Intelligence'
                                  : '“$tagline”',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 9,
                                color: Color(0xFF68769A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onClose,
                child: const Text('Cancel'),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2939E8),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  LinearGradient _backgroundGradient() {
    switch (selectedBackground) {
      case 'Modern Arch':
        return const LinearGradient(
          colors: [Color(0xFF102E5D), Color(0xFF63BCEB)],
        );

      case 'Tech Slate':
        return const LinearGradient(
          colors: [Color(0xFF11151C), Color(0xFF3D4755)],
        );

      case 'Mist Valley':
        return const LinearGradient(
          colors: [Color(0xFF183B70), Color(0xFF7095D5)],
        );

      case 'Loft Studio':
        return const LinearGradient(
          colors: [Color(0xFF1B2234), Color(0xFF8B745A)],
        );

      case 'Studio Shapes':
        return const LinearGradient(
          colors: [Color(0xFF173A6A), Color(0xFF65B9E7)],
        );

      case 'Glass Gradient':
      default:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF071B3C), Color(0xFF103E6F), Color(0xFF092329)],
        );
    }
  }
}

// ============================================================================
// PREVIEW FIELD
// ============================================================================

class _PreviewField extends StatelessWidget {
  final String label;
  final String value;

  const _PreviewField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: Color(0xFF172033),
          ),
        ),

        const SizedBox(height: 5),

        Container(
          width: double.infinity,
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: const Color(0xFFDCE3E9)),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: const TextStyle(fontSize: 9, color: Color(0xFF334155)),
          ),
        ),
      ],
    );
  }
}
