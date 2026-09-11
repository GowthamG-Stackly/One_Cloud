import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_theme.dart';

import 'package:google_fonts/google_fonts.dart';

class AuthLayout extends StatefulWidget {
  final Widget child;
  final bool reverse;

  const AuthLayout({super.key, required this.child, this.reverse = false});

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  int selectedModule = 0;

  final List<_AuthModule> modules = const [
    _AuthModule(title: 'Dashboard', icon: Icons.dashboard_outlined),
    _AuthModule(title: 'HRMS', icon: Icons.people_outline),
    _AuthModule(title: 'CRM', icon: Icons.handshake_outlined),
    _AuthModule(title: 'ERP', icon: Icons.inventory_2_outlined),
    _AuthModule(
      title: 'Platform Admin',
      icon: Icons.admin_panel_settings_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBlue,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            if (width < 700) {
              return _buildMobile();
            }

            if (width < 1100) {
              return _buildTablet();
            }

            return _buildDesktop();
          },
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktop() {
    final form = Expanded(flex: 8, child: _buildFormArea());

    final content = Expanded(flex: 12, child: _buildDesktopLeft());

    return Row(children: widget.reverse ? [form, content] : [content, form]);
  }

  // ============================================================
  // TABLET
  // ============================================================

  Widget _buildTablet() {
    return Column(
      children: [
        _buildTabletHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: widget.child,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildMobileHeader(),

          Padding(padding: const EdgeInsets.all(16), child: widget.child),

          const SizedBox(height: 8),

          _buildFooter(),
        ],
      ),
    );
  }

  // ============================================================
  // DESKTOP LEFT PANEL
  // ============================================================

  Widget _buildDesktopLeft() {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.darkNavy, AppTheme.primaryBlue],
        ),
      ),
      child: Stack(
        children: [
          // Background decoration
          Positioned(top: -100, right: -80, child: _circle(280)),

          Positioned(bottom: -130, left: -110, child: _circle(320)),

          Positioned(top: 260, right: 80, child: _circle(100)),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand
                _buildBrand(),

                const SizedBox(height: 25),

                // Main heading
                _buildHeroText(),

                const SizedBox(height: 18),

                // Feature cards
                _buildFeatureHighlights(),

                const SizedBox(height: 18),

                // Dashboard preview
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 670,
                        maxHeight: 235,
                      ),
                      child: _buildDashboardPreview(),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Platform stats
                _buildPlatformStats(),

                const SizedBox(height: 7),

                // Footer
                _buildFooter(light: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BRAND
  // ============================================================

  Widget _buildBrand() {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(
            Icons.cloud_outlined,
            color: AppTheme.primaryBlue,
            size: 28,
          ),
        ),

        const SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OneCloud',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'ENTERPRISE PLATFORM',
              style: GoogleFonts.roboto(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // HERO TEXT
  // ============================================================
  Widget _buildHeroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==========================================================
        // ONE PLATFORM.
        // ==========================================================

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'ONE ',
                style: GoogleFonts.blackOpsOne(
                  color: AppTheme.lightBlue,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
              TextSpan(
                text: 'PLATFORM.',
                style: GoogleFonts.blackOpsOne(
                  color: AppTheme.primaryBlue,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 2),

        // ==========================================================
        // ENDLESS POSSIBILITIES.
        // ==========================================================
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'ENDLESS ',
                style: GoogleFonts.blackOpsOne(
                  color: AppTheme.primaryBlue,
                  fontSize: 29,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                ),
              ),
              TextSpan(
                text: 'POSSIBILITIES.',
                style: GoogleFonts.blackOpsOne(
                  color: AppTheme.lightBlue,
                  fontSize: 29,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // ==========================================================
        // FIRST DESCRIPTION
        // ==========================================================
        SizedBox(
          width: 600,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'OneCloud ',
                  style: GoogleFonts.poppins(
                    color: AppTheme.lightBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: 'Enterprise ',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: 'Platform ',
                  style: GoogleFonts.poppins(
                    color: AppTheme.primaryBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: 'brings your ',
                  style: GoogleFonts.roboto(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: 'business ',
                  style: GoogleFonts.montserrat(
                    color: AppTheme.lightBlue,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: 'operations ',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: 'together ',
                  style: GoogleFonts.montserrat(
                    color: AppTheme.primaryBlue,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: 'in one connected digital ecosystem.',
                  style: GoogleFonts.roboto(
                    color: Colors.white.withValues(alpha: 0.70),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 7),

        // ==========================================================
        // SECOND DESCRIPTION
        // ==========================================================
        SizedBox(
          width: 610,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Connect ',
                  style: GoogleFonts.poppins(
                    color: AppTheme.lightBlue,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    height: 1.6,
                  ),
                ),
                TextSpan(
                  text: 'people, ',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
                TextSpan(
                  text: 'customers, ',
                  style: GoogleFonts.montserrat(
                    color: AppTheme.primaryBlue,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    height: 1.6,
                  ),
                ),
                TextSpan(
                  text: 'resources ',
                  style: GoogleFonts.poppins(
                    color: AppTheme.lightBlue,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    height: 1.6,
                  ),
                ),
                TextSpan(
                  text: 'and ',
                  style: GoogleFonts.roboto(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                  ),
                ),
                TextSpan(
                  text: 'business ',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    height: 1.6,
                  ),
                ),
                TextSpan(
                  text: 'processes ',
                  style: GoogleFonts.poppins(
                    color: AppTheme.primaryBlue,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    height: 1.6,
                  ),
                ),
                TextSpan(
                  text: 'through a ',
                  style: GoogleFonts.roboto(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                  ),
                ),
                TextSpan(
                  text: 'unified ',
                  style: GoogleFonts.montserrat(
                    color: AppTheme.lightBlue,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    height: 1.6,
                  ),
                ),
                TextSpan(
                  text: 'platform.',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    height: 1.6,
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
  // FEATURE HIGHLIGHTS
  // ============================================================

  Widget _buildFeatureHighlights() {
    return Wrap(
      spacing: 9,
      runSpacing: 8,
      children: [
        _featureItem(Icons.apps_outlined, 'Unified Platform'),
        _featureItem(Icons.extension_outlined, 'Modular Applications'),
        _featureItem(Icons.storage_outlined, 'Centralized Operations'),
        _featureItem(Icons.security_outlined, 'Secure & Scalable'),
      ],
    );
  }

  Widget _featureItem(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.065),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 15),

          const SizedBox(width: 7),

          Text(
            title,
            style: GoogleFonts.roboto(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DASHBOARD PREVIEW
  // ============================================================

  Widget _buildDashboardPreview() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.24),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _dashboardHeader(),

          Expanded(
            child: Row(
              children: [
                _dashboardSidebar(),

                Expanded(child: _dashboardContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DASHBOARD HEADER
  // ============================================================

  Widget _dashboardHeader() {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: AppTheme.darkNavy,
      child: Row(
        children: [
          Container(
            width: 23,
            height: 23,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.cloud_outlined,
              color: Colors.white,
              size: 14,
            ),
          ),

          const SizedBox(width: 7),

          Text(
            'OneCloud',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),

          const Spacer(),

          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 5),

          Text(
            'Connected',
            style: GoogleFonts.roboto(
              color: Colors.white.withValues(alpha: 0.55),
              fontSize: 7,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DASHBOARD SIDEBAR
  // ============================================================

  Widget _dashboardSidebar() {
    return Container(
      width: 125,
      color: AppTheme.darkNavy,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              child: Text(
                'PLATFORM',
                style: GoogleFonts.roboto(
                  color: Colors.white.withValues(alpha: 0.30),
                  fontSize: 6.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),

          ...List.generate(modules.length, (index) {
            return _moduleButton(index, modules[index]);
          }),

          const Spacer(),

          Row(
            children: [
              const Icon(
                Icons.security_outlined,
                color: Colors.white54,
                size: 12,
              ),

              const SizedBox(width: 5),

              Text(
                'Secure',
                style: GoogleFonts.roboto(color: Colors.white38, fontSize: 7),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MODULE BUTTON
  // ============================================================

  Widget _moduleButton(int index, _AuthModule module) {
    final selected = selectedModule == index;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () {
          setState(() {
            selectedModule = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          decoration: BoxDecoration(
            color: selected ? AppTheme.primaryBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            children: [
              Icon(
                module.icon,
                color: selected ? Colors.white : Colors.white54,
                size: 13,
              ),

              const SizedBox(width: 7),

              Expanded(
                child: Text(
                  module.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    color: selected ? Colors.white : Colors.white60,
                    fontSize: 7.5,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),

              if (selected)
                const Icon(Icons.chevron_right, color: Colors.white, size: 11),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DASHBOARD CONTENT
  // ============================================================

  Widget _dashboardContent() {
    switch (selectedModule) {
      case 1:
        return _moduleContent('HRMS', 'People & workforce management', [
          _stat('Employees', '186', Icons.people_outline),
          _stat('Attendance', '92%', Icons.calendar_today_outlined),
          _stat('Leave', '14', Icons.event_available_outlined),
        ]);

      case 2:
        return _moduleContent('CRM', 'Customer relationship management', [
          _stat('Leads', '126', Icons.person_search_outlined),
          _stat('Deals', '42', Icons.handshake_outlined),
          _stat('Accounts', '318', Icons.business_outlined),
        ]);

      case 3:
        return _moduleContent('ERP', 'Enterprise resource management', [
          _stat('Inventory', '2.4K', Icons.inventory_2_outlined),
          _stat('Orders', '186', Icons.shopping_cart_outlined),
          _stat('Dispatch', '32', Icons.local_shipping_outlined),
        ]);

      case 4:
        return _moduleContent(
          'Platform Admin',
          'Manage the OneCloud platform',
          [
            _stat('Tenants', '24', Icons.business_outlined),
            _stat('Roles', '18', Icons.admin_panel_settings_outlined),
            _stat('Health', '99.9%', Icons.monitor_heart_outlined),
          ],
        );

      default:
        return _moduleContent(
          'Business Overview',
          'OneCloud platform summary',
          [
            _stat('Users', '248', Icons.people_outline),
            _stat('Modules', '08', Icons.apps_outlined),
            _stat('Growth', '+18%', Icons.trending_up_outlined),
          ],
        );
    }
  }

  // ============================================================
  // MODULE CONTENT
  // ============================================================

  Widget _moduleContent(String title, String subtitle, List<Widget> stats) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              color: AppTheme.darkNavy,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            subtitle,
            style: GoogleFonts.roboto(
              color: AppTheme.darkNavy.withValues(alpha: 0.50),
              fontSize: 6.5,
            ),
          ),

          const SizedBox(height: 9),

          Row(
            children: stats
                .map(
                  (item) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: item,
                    ),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 8),

          Expanded(child: _chart()),
        ],
      ),
    );
  }

  // ============================================================
  // STAT CARD
  // ============================================================

  Widget _stat(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: AppTheme.lightBlue,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primaryBlue, size: 12),

          const SizedBox(height: 3),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              color: AppTheme.darkNavy.withValues(alpha: 0.50),
              fontSize: 5.5,
            ),
          ),

          Text(
            value,
            style: GoogleFonts.roboto(
              color: AppTheme.darkNavy,
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CHART
  // ============================================================

  Widget _chart() {
    const values = [0.30, 0.42, 0.36, 0.55, 0.48, 0.68, 0.60, 0.82, 0.70, 0.90];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: values
          .map(
            (value) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: FractionallySizedBox(
                  heightFactor: value,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withValues(
                        alpha: 0.25 + value * 0.5,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  // ============================================================
  // PLATFORM STATS
  // ============================================================

  Widget _buildPlatformStats() {
    return Row(
      children: [
        _platformStat('01', 'Unified\nPlatform'),

        const SizedBox(width: 25),

        _platformStat('05+', 'Business\nModules'),

        const SizedBox(width: 25),

        _platformStat('24/7', 'Enterprise\nOperations'),
      ],
    );
  }

  Widget _platformStat(String value, String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(width: 6),

        Text(
          label,
          style: GoogleFonts.roboto(
            color: Colors.white.withValues(alpha: 0.52),
            fontSize: 7,
            height: 1.25,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FORM AREA
  // ============================================================

  Widget _buildFormArea() {
    return Container(
      color: AppTheme.lightBlue,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TABLET HEADER
  // ============================================================

  Widget _buildTabletHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.darkNavy, AppTheme.primaryBlue],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCompactBrand(),

                const SizedBox(height: 12),

                Text(
                  'ONE PLATFORM.',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                Text(
                  'ENDLESS POSSIBILITIES.',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  'Connect your people, processes, '
                  'customers and operations through '
                  'OneCloud Enterprise Platform.',
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 9,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          SizedBox(width: 290, height: 150, child: _buildDashboardPreview()),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE HEADER
  // ============================================================

  Widget _buildMobileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.darkNavy, AppTheme.primaryBlue],
        ),
      ),
      child: Column(
        children: [
          _buildCompactBrand(),

          const SizedBox(height: 15),

          Text(
            'ONE PLATFORM.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),

          Text(
            'ENDLESS POSSIBILITIES.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Connect people, customers, resources '
            'and business operations through one '
            'connected enterprise platform.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: Colors.white70,
              fontSize: 10,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 13),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 7,
            runSpacing: 7,
            children: [
              _mobileFeature(Icons.apps_outlined, 'Unified'),
              _mobileFeature(Icons.extension_outlined, 'Modular'),
              _mobileFeature(Icons.security_outlined, 'Secure'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mobileFeature(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 13),
          const SizedBox(width: 5),
          Text(
            title,
            style: GoogleFonts.roboto(
              color: Colors.white70,
              fontSize: 8,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMPACT BRAND
  // ============================================================

  Widget _buildCompactBrand() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Icon(
            Icons.cloud_outlined,
            color: AppTheme.primaryBlue,
            size: 24,
          ),
        ),

        const SizedBox(width: 9),

        Text(
          'OneCloud',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _buildFooter({bool light = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        'OneCloud Enterprise Platform • © 2026',
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          color: light
              ? Colors.white.withValues(alpha: 0.32)
              : AppTheme.darkNavy.withValues(alpha: 0.50),
          fontSize: 7.5,
        ),
      ),
    );
  }

  // ============================================================
  // BACKGROUND CIRCLE
  // ============================================================

  Widget _circle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.035),
      ),
    );
  }
}

// ================================================================
// AUTH MODULE MODEL
// ================================================================

class _AuthModule {
  final String title;
  final IconData icon;

  const _AuthModule({required this.title, required this.icon});
}
