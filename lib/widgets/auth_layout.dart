import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_theme.dart';

class AuthLayout extends StatefulWidget {
  final Widget child;
  final bool reverse;

  const AuthLayout({super.key, required this.child, this.reverse = false});

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  int? selectedModule;

  final List<_AuthModule> modules = const [
    _AuthModule(title: 'HRMS', icon: Icons.people_outline),
    _AuthModule(title: 'CRM', icon: Icons.handshake_outlined),
    _AuthModule(title: 'ERP', icon: Icons.inventory_2_outlined),
    _AuthModule(title: 'FINANCE', icon: Icons.account_balance_outlined),
    _AuthModule(title: 'WORKFLOW', icon: Icons.auto_awesome_outlined),
    _AuthModule(title: 'ANALYTICS', icon: Icons.auto_awesome_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.paper,
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
    final hero = Expanded(flex: 14, child: _buildHeroPanel());

    final form = Expanded(flex: 8, child: _buildFormArea());

    return Row(children: widget.reverse ? [form, hero] : [hero, form]);
  }

  // ============================================================
  // TABLET
  // ============================================================

  Widget _buildTablet() {
    return Column(
      children: [
        _buildTabletHero(),

        Expanded(
          child: Container(
            color: AppTheme.paper,
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
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile() {
    return Column(
      children: [
        _buildMobileHeader(),

        Expanded(
          child: Container(
            width: double.infinity,
            color: AppTheme.paper,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: widget.child,
            ),
          ),
        ),

        _buildMobileFooter(),
      ],
    );
  }

  // ============================================================
  // DESKTOP HERO PANEL
  // ============================================================

  Widget _buildHeroPanel() {
    return Container(
      color: AppTheme.ink,
      child: Stack(
        children: [
          // Ambient circles
          Positioned(
            top: -180,
            right: -140,
            child: _ambientCircle(420, AppTheme.ink3, 0.20),
          ),

          Positioned(
            bottom: -180,
            left: -150,
            child: _ambientCircle(420, AppTheme.ink2, 0.45),
          ),

          Positioned(
            top: 340,
            right: 100,
            child: _ambientCircle(160, AppTheme.tealData, 0.035),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58, vertical: 42),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBrand(),

                const Spacer(flex: 2),

                _buildEyebrow(),

                const SizedBox(height: 22),

                _buildHeroHeading(),

                const SizedBox(height: 22),

                _buildHeroDescription(),

                const SizedBox(height: 42),

                Expanded(flex: 4, child: _buildEnterpriseNetwork()),

                const SizedBox(height: 26),

                _buildTrustBar(),
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
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/images/onecloud_logo.png',
            height: 42,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(width: 16),

        Text(
          'One Enterprise',
          style: GoogleFonts.onest(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // EYEBROW
  // ============================================================

  Widget _buildEyebrow() {
    return Text(
      'CLOUD PLATFORM  ·  HRMS  ·  CRM  ·  ERP  ·  FINANCE  ·  AI',
      style: GoogleFonts.ibmPlexMono(
        color: AppTheme.tealData,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 2.1,
      ),
    );
  }

  // ============================================================
  // HERO HEADING
  // ============================================================

  Widget _buildHeroHeading() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Every operation.\n',
            style: GoogleFonts.onest(
              color: Colors.white,
              fontSize: 48,
              height: 1.05,
              fontWeight: FontWeight.w600,
              letterSpacing: -1.8,
            ),
          ),
          TextSpan(
            text: 'One sign-in.',
            style: GoogleFonts.onest(
              color: AppTheme.amberAI,
              fontSize: 48,
              height: 1.05,
              fontWeight: FontWeight.w600,
              letterSpacing: -1.8,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DESCRIPTION
  // ============================================================

  Widget _buildHeroDescription() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 650),
      child: Text(
        'HR, sales, procurement, finance and your AI copilot — '
        'running on one identity, one policy, one audit trail.',
        style: GoogleFonts.onest(
          color: Colors.white.withValues(alpha: 0.68),
          fontSize: 16,
          height: 1.65,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  // ============================================================
  // ENTERPRISE NETWORK
  // ============================================================

  Widget _buildEnterpriseNetwork() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          painter: _EnterpriseNetworkPainter(selectedModule: selectedModule),
          child: Stack(
            children: [
              // --------------------------------------------------
              // LEFT MODULES
              // Module name -> circle
              // --------------------------------------------------

              Positioned(
                left: 0,
                top: constraints.maxHeight * 0.12,
                child: _networkLabel(0),
              ),

              Positioned(
                left: 0,
                top: constraints.maxHeight * 0.42,
                child: _networkLabel(1),
              ),

              Positioned(
                left: 0,
                top: constraints.maxHeight * 0.72,
                child: _networkLabel(2),
              ),

              // --------------------------------------------------
              // RIGHT MODULES
              // Circle -> module name
              // --------------------------------------------------
              Positioned(
                right: 0,
                top: constraints.maxHeight * 0.12,
                child: _networkLabel(3),
              ),

              Positioned(
                right: 0,
                top: constraints.maxHeight * 0.42,
                child: _networkLabel(4),
              ),

              Positioned(
                right: 0,
                top: constraints.maxHeight * 0.72,
                child: _networkLabel(5),
              ),

              // --------------------------------------------------
              // AI CENTER
              // --------------------------------------------------
              Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.ink3,
                    border: Border.all(
                      color: AppTheme.amberAI.withValues(alpha: 0.65),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.tealData.withValues(alpha: 0.12),
                        blurRadius: 30,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'AI',
                    style: GoogleFonts.ibmPlexMono(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // NETWORK LABEL
  // ============================================================

  Widget _networkLabel(int index) {
    final module = modules[index];
    final isLeft = index <= 2;
    final isSelected = selectedModule == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          selectedModule = isSelected ? null : index;
        });
      },
      child: SizedBox(
        width: 140,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: isLeft
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            // LEFT:
            // MODULE NAME -> CIRCLE
            if (isLeft) ...[
              Flexible(
                child: Text(
                  module.title.toUpperCase(),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.onest(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.58),
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _networkNode(isSelected),
            ],

            // RIGHT:
            // CIRCLE -> MODULE NAME
            if (!isLeft) ...[
              _networkNode(isSelected),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  module.title.toUpperCase(),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.onest(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.58),
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ============================================================
  // NETWORK NODE
  // ============================================================

  Widget _networkNode(bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: 17,
      height: 17,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? AppTheme.amberAI
            : AppTheme.ink3.withValues(alpha: 0.92),
        border: Border.all(
          color: isSelected
              ? AppTheme.amberAI
              : AppTheme.tealData.withValues(alpha: 0.42),
          width: 1.2,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppTheme.amberAI.withValues(alpha: 0.35),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
    );
  }

  // ============================================================
  // TRUST BAR
  // ============================================================

  Widget _buildTrustBar() {
    return Column(
      children: [
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.white.withValues(alpha: 0.10),
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            _trustItem(Icons.shield_outlined, 'SOC 2 Type II'),

            const SizedBox(width: 32),

            _trustItem(Icons.lock_outline, 'ISO 27001'),

            const SizedBox(width: 32),

            _trustItem(Icons.schedule_outlined, '99.95% uptime SLA'),
          ],
        ),
      ],
    );
  }

  Widget _trustItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 17, color: Colors.white.withValues(alpha: 0.52)),

        const SizedBox(width: 8),

        Text(
          text,
          style: GoogleFonts.ibmPlexMono(
            color: Colors.white.withValues(alpha: 0.52),
            fontSize: 11,
            letterSpacing: 0.5,
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
      color: AppTheme.paper,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TABLET HERO
  // ============================================================

  Widget _buildTabletHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 28),
      color: AppTheme.ink,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBrand(),

                const SizedBox(height: 24),

                _buildEyebrow(),

                const SizedBox(height: 14),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Every operation.\n',
                        style: GoogleFonts.onest(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'One sign-in.',
                        style: GoogleFonts.onest(
                          color: AppTheme.amberAI,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'One identity, one policy, one audit trail.',
                  style: GoogleFonts.onest(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 30),

          SizedBox(width: 280, height: 150, child: _buildEnterpriseNetwork()),
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
      color: AppTheme.ink,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBrand(),

          const SizedBox(height: 22),

          Text(
            'Every operation.',
            style: GoogleFonts.onest(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w600,
            ),
          ),

          Text(
            'One sign-in.',
            style: GoogleFonts.onest(
              color: AppTheme.amberAI,
              fontSize: 27,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE FOOTER
  // ============================================================

  Widget _buildMobileFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: AppTheme.ink,
      child: Text(
        'One Enterprise  •  © 2026',
        textAlign: TextAlign.center,
        style: GoogleFonts.ibmPlexMono(
          color: Colors.white.withValues(alpha: 0.45),
          fontSize: 10,
        ),
      ),
    );
  }

  // ============================================================
  // AMBIENT CIRCLE
  // ============================================================

  Widget _ambientCircle(double size, Color color, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: opacity),
      ),
    );
  }
}

// ================================================================
// NETWORK PAINTER
// ================================================================

class _EnterpriseNetworkPainter extends CustomPainter {
  final int? selectedModule;

  const _EnterpriseNetworkPainter({required this.selectedModule});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // The circle is positioned inside a 140px-wide module area.
    // Left: name -> circle
    // Right: circle -> name
    const moduleAreaWidth = 140.0;
    const nodeRadius = 8.5;

    final leftX = moduleAreaWidth - nodeRadius;
    final rightX = size.width - moduleAreaWidth + nodeRadius;

    final topY = size.height * 0.12 + nodeRadius;
    final middleY = size.height * 0.42 + nodeRadius;
    final bottomY = size.height * 0.72 + nodeRadius;

    final points = <Offset>[
      Offset(leftX, topY),
      Offset(leftX, middleY),
      Offset(leftX, bottomY),
      Offset(rightX, topY),
      Offset(rightX, middleY),
      Offset(rightX, bottomY),
    ];

    // ------------------------------------------------------------
    // LIGHT INITIAL NETWORK
    // ------------------------------------------------------------

    final lightPaint = Paint()
      ..color = AppTheme.tealData.withValues(alpha: 0.13)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    // ------------------------------------------------------------
    // ACTIVE NETWORK
    // ------------------------------------------------------------

    final activePaint = Paint()
      ..color = AppTheme.amberAI.withValues(alpha: 0.82)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.7
      ..strokeCap = StrokeCap.round;

    // ------------------------------------------------------------
    // SOFT ACTIVE GLOW
    // ------------------------------------------------------------

    final activeGlowPaint = Paint()
      ..color = AppTheme.amberAI.withValues(alpha: 0.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    for (int i = 0; i < points.length; i++) {
      final point = points[i];

      final path = Path()..moveTo(point.dx, point.dy);

      final controlX = (point.dx + center.dx) / 2;

      path.cubicTo(
        controlX,
        point.dy,
        controlX,
        center.dy,
        center.dx,
        center.dy,
      );

      // All networks are visible initially in a very light tone.
      canvas.drawPath(path, lightPaint);

      // Selected network becomes highlighted.
      if (selectedModule == i) {
        canvas.drawPath(path, activeGlowPaint);
        canvas.drawPath(path, activePaint);
      }
    }

    // ------------------------------------------------------------
    // AI CENTER SUBTLE RING
    // ------------------------------------------------------------

    final ringPaint = Paint()
      ..color = AppTheme.amberAI.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    canvas.drawCircle(center, 43, ringPaint);

    // ------------------------------------------------------------
    // AI CENTER SOFT GLOW
    // ------------------------------------------------------------

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppTheme.tealData.withValues(alpha: 0.14),
          AppTheme.tealData.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: 58));

    canvas.drawCircle(center, 58, glowPaint);
  }

  @override
  bool shouldRepaint(covariant _EnterpriseNetworkPainter oldDelegate) {
    return oldDelegate.selectedModule != selectedModule;
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
