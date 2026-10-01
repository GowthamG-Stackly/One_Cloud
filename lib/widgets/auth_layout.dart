import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthLayout extends StatefulWidget {
  final Widget child;
  final bool reverse;
  final bool scrollable;

  const AuthLayout({
    super.key,
    required this.child,
    this.reverse = false,
    this.scrollable = false,
  });

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  int? selectedCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // =========================================================
          // MOBILE
          // =========================================================

          if (constraints.maxWidth < 700) {
            return _buildMobile();
          }

          // =========================================================
          // TABLET
          // =========================================================

          if (constraints.maxWidth < 1100) {
            return _buildTablet();
          }

          // =========================================================
          // DESKTOP
          // =========================================================

          return _buildDesktop();
        },
      ),
    );
  }

  // ==============================================================
  // DESKTOP
  // ==============================================================

  Widget _buildDesktop() {
    final hero = Expanded(flex: 10, child: _buildHero());

    final auth = Expanded(flex: 8, child: _buildAuth());

    return Row(children: widget.reverse ? [auth, hero] : [hero, auth]);
  }

  // ==============================================================
  // DESKTOP HERO
  // ==============================================================

  Widget _buildHero() {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(42, 38, 42, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------------------------------
            // LOGO
            // ------------------------------------------------------

            Image.asset(
              'assets/images/stackly_logo.png',
              width: 158,
              height: 42,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),

            const SizedBox(height: 27),

            // ------------------------------------------------------
            // PLATFORM TEXT
            // ------------------------------------------------------
            Text(
              'CLOUD PLATFORM  ·  HRMS  ·  CRM  ·  ERP  ·  FINANCE  ·  AI',
              style: GoogleFonts.ibmPlexMono(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.8,
              ),
            ),

            const SizedBox(height: 18),

            // ------------------------------------------------------
            // TITLE
            // ------------------------------------------------------
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'One identity.\n',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 47,
                      height: 1.05,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1.8,
                    ),
                  ),
                  TextSpan(
                    text: 'Infinite ',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF2166F3),
                      fontSize: 47,
                      height: 1.05,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1.8,
                    ),
                  ),
                  TextSpan(
                    text: 'Potential.',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 47,
                      height: 1.05,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1.8,
                    ),
                  ),
                ],
              ),
            ),

            // ------------------------------------------------------
            // NETWORK
            // ------------------------------------------------------
            Expanded(
              child: Center(
                child: FittedBox(fit: BoxFit.scaleDown, child: _buildNetwork()),
              ),
            ),

            const SizedBox(height: 12),

            // ------------------------------------------------------
            // BOTTOM INFO
            // ------------------------------------------------------
            _buildBottomInfo(),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // NETWORK
  // ==============================================================

  Widget _buildNetwork() {
    return SizedBox(
      width: 600,
      height: 500,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ========================================================
          // ENTERPRISE RING
          // ========================================================

          Center(
            child: SizedBox(
              width: 410,
              height: 410,
              child: CustomPaint(painter: _EnterpriseRingPainter()),
            ),
          ),

          // ========================================================
          // CONNECTION LINES
          // ========================================================
          Positioned.fill(
            child: CustomPaint(
              painter: _NetworkLinesPainter(selectedCard: selectedCard),
            ),
          ),

          // ========================================================
          // CENTER 1E
          // ========================================================
          Center(
            child: Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF123E9E),
                    Color(0xFF1768FF),
                    Color(0xFF0B2A72),
                    Color(0xFF06152F),
                  ],
                  stops: [0.0, 0.38, 0.72, 1.0],
                ),
                border: Border.all(color: const Color(0xFF2878FF), width: 1.2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x770066FF),
                    blurRadius: 24,
                    spreadRadius: 4,
                  ),
                  BoxShadow(
                    color: Color(0x3300BFFF),
                    blurRadius: 42,
                    spreadRadius: 6,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                '1E',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 43,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -2,
                ),
              ),
            ),
          ),

          // ========================================================
          // PEOPLE
          // ========================================================
          Positioned(
            left: 15,
            top: 65,
            child: _buildModuleCard(
              index: 0,
              icon: Icons.people_alt_outlined,
              title: 'People',
              subtitle: 'Manage users & teams',
            ),
          ),

          // ========================================================
          // APPLICATIONS
          // ========================================================
          Positioned(
            right: 15,
            top: 65,
            child: _buildModuleCard(
              index: 1,
              icon: Icons.inventory_2_outlined,
              title: 'Applications',
              subtitle: 'Integrate & manage',
            ),
          ),

          // ========================================================
          // SECURITY
          // ========================================================
          Positioned(
            left: 15,
            bottom: 65,
            child: _buildModuleCard(
              index: 2,
              icon: Icons.shield_outlined,
              title: 'Security',
              subtitle: 'Protect every access',
            ),
          ),

          // ========================================================
          // ANALYTICS
          // ========================================================
          Positioned(
            right: 15,
            bottom: 65,
            child: _buildModuleCard(
              index: 3,
              icon: Icons.bar_chart_outlined,
              title: 'Analytics',
              subtitle: 'Turn data into insights',
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // MODULE CARD
  // ==============================================================

  Widget _buildModuleCard({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = selectedCard == index;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCard = isSelected ? null : index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          width: 154,
          height: 128,
          padding: const EdgeInsets.fromLTRB(16, 16, 12, 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF0A1428)
                : const Color(0xFF080D16),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF1680FF)
                  : const Color(0xFF164DAD),
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x990066FF),
                      blurRadius: 24,
                      spreadRadius: 3,
                    ),
                    BoxShadow(
                      color: Color(0x5500CFFF),
                      blurRadius: 45,
                      spreadRadius: 5,
                    ),
                  ]
                : const [
                    BoxShadow(
                      color: Color(0x330066FF),
                      blurRadius: 18,
                      spreadRadius: 1,
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------------------------------------------
              // ICON
              // ----------------------------------------------------

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF083D78)
                      : const Color(0xFF062544),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1680FF)
                        : const Color(0xFF0C65B7),
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? const [
                          BoxShadow(
                            color: Color(0x990066FF),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: const Color(0xFF1678FF), size: 20),
              ),

              const Spacer(),

              // ----------------------------------------------------
              // TITLE
              // ----------------------------------------------------
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 4),

              // ----------------------------------------------------
              // SUBTITLE
              // ----------------------------------------------------
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: isSelected
                      ? const Color(0xFFB2C4DD)
                      : const Color(0xFF8A95A8),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // BOTTOM INFO
  // ==============================================================

  Widget _buildBottomInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBottomItem('Secure'),

        const SizedBox(width: 38),

        _buildBottomItem('Scalable'),

        const SizedBox(width: 38),

        _buildBottomItem('Future-Ready'),

        const Spacer(),

        Text(
          'BUILT FOR\nA BRIGHTER\nTOMORROW',
          style: GoogleFonts.ibmPlexMono(
            color: const Color(0xFF68748C),
            fontSize: 8,
            height: 1.25,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomItem(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 42, height: 1, color: const Color(0xFF2166F3)),
        const SizedBox(height: 8),
        Text(
          text,
          style: GoogleFonts.ibmPlexMono(
            color: const Color(0xFF68748C),
            fontSize: 8,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  // ==============================================================
  // DESKTOP AUTH
  // ==============================================================

  Widget _buildAuth() {
    final formWidth = widget.scrollable ? 540.0 : 457.0;

    return Container(
      color: Colors.white,
      child: widget.scrollable
          ? SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
              child: Center(
                child: SizedBox(width: formWidth, child: widget.child),
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 25,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: SizedBox(width: formWidth, child: widget.child),
                ),
              ),
            ),
    );
  }

  // ==============================================================
  // TABLET
  // ==============================================================

  Widget _buildTablet() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 310,
          child: _buildTabletHero(),
        ),
        Expanded(child: _buildAuth()),
      ],
    );
  }

  Widget _buildTabletHero() {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/stackly_logo.png',
                  width: 145,
                  height: 38,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerLeft,
                ),

                const SizedBox(height: 20),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'One identity.\n',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 32,
                          height: 1.05,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Infinite ',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF2166F3),
                          fontSize: 32,
                          height: 1.05,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Potential.',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 32,
                          height: 1.05,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          SizedBox(
            width: 350,
            height: 280,
            child: FittedBox(fit: BoxFit.scaleDown, child: _buildNetwork()),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // MOBILE
  // ==============================================================

  Widget _buildMobile() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        // ----------------------------------------------------------
        // RESPONSIVE VALUES
        // ----------------------------------------------------------

        final logoWidth = screenWidth < 380 ? 120.0 : 140.0;

        final titleSize = screenWidth < 380 ? 27.0 : 30.0;

        final heroBottom = screenHeight < 650 ? 155.0 : 175.0;

        return SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              // ====================================================
              // BLACK BACKGROUND
              // ====================================================

              Positioned.fill(child: Container(color: Colors.black)),

              // ====================================================
              // LOGO
              // ====================================================
              Positioned(
                top: 16,
                left: 20,
                child: Image.asset(
                  'assets/images/stackly_logo.png',
                  width: logoWidth,
                  height: 38,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerLeft,
                ),
              ),

              // ====================================================
              // TITLE
              // ====================================================
              Positioned(
                top: 68,
                left: 20,
                right: 20,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'One identity.\n',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: titleSize,
                          height: 1.04,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1.1,
                        ),
                      ),
                      TextSpan(
                        text: 'Infinite ',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF2166F3),
                          fontSize: titleSize,
                          height: 1.04,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1.1,
                        ),
                      ),
                      TextSpan(
                        text: 'Potential.',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: titleSize,
                          height: 1.04,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ====================================================
              // PLATFORM TEXT
              // ====================================================
              Positioned(
                top: 142,
                left: 20,
                right: 20,
                child: Text(
                  'CLOUD PLATFORM  ·  HRMS  ·  CRM  ·  ERP  ·  FINANCE  ·  AI',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: GoogleFonts.ibmPlexMono(
                    color: const Color(0xFF7D899D),
                    fontSize: 7.2,
                    letterSpacing: 0.8,
                  ),
                ),
              ),

              // ====================================================
              // NETWORK BACKGROUND
              // ====================================================
              //
              // The network is constrained to the available
              // mobile area so it cannot overflow.
              //
              Positioned(
                top: 145,
                left: 0,
                right: 0,
                bottom: heroBottom,
                child: LayoutBuilder(
                  builder: (context, networkConstraints) {
                    final availableWidth = networkConstraints.maxWidth;

                    final availableHeight = networkConstraints.maxHeight;

                    final scaleByWidth = availableWidth / 600;

                    final scaleByHeight = availableHeight / 500;

                    final scale = scaleByWidth < scaleByHeight
                        ? scaleByWidth
                        : scaleByHeight;

                    // Never force a minimum scale on small screens.
                    // The previous minimum (0.45) could make the fixed
                    // 600x500 network larger than the available area.
                    final safeScale = scale.clamp(0.0, 1.0);

                    return Center(
                      child: SizedBox(
                        width: 600 * safeScale,
                        height: 500 * safeScale,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: _buildNetwork(),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ====================================================
              // WHITE FORM AREA
              // ====================================================
              //
              // IMPORTANT:
              // This is intentionally WHITE.
              //
              // The form uses full available width.
              //
              // Scrolling is allowed.
              //
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: heroBottom,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: screenWidth - 40),
                        child: SizedBox(
                          width: double.infinity,
                          child: widget.child,
                        ),
                      ),
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
}

// ==================================================================
// ENTERPRISE RING PAINTER
// ==================================================================

class _EnterpriseRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = size.width / 2 - 8;

    // ==============================================================
    // OUTER GLOW
    // ==============================================================

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16)
      ..shader = const SweepGradient(
        colors: [
          Color(0x00005CFF),
          Color(0x88005CFF),
          Color(0xCC00D9FF),
          Color(0xAA0066FF),
          Color(0x00005CFF),
        ],
        stops: [0.0, 0.25, 0.48, 0.75, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, glowPaint);

    // ==============================================================
    // MAIN RING
    // ==============================================================

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        colors: [
          Color(0xFF0648D8),
          Color(0xFF006BFF),
          Color(0xFF00D9FF),
          Color(0xFF007BFF),
          Color(0xFF063CC2),
          Color(0xFF0648D8),
        ],
        stops: [0.0, 0.22, 0.46, 0.64, 0.84, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, ringPaint);

    // ==============================================================
    // INNER RING
    // ==============================================================

    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFF1265FF).withValues(alpha: 0.75);

    canvas.drawCircle(center, radius - 13, innerPaint);

    // ==============================================================
    // CYAN HIGHLIGHT
    // ==============================================================

    final cyanPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF00E1FF);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -2.65,
      1.25,
      false,
      cyanPaint,
    );

    // ==============================================================
    // BOTTOM GLOW
    // ==============================================================

    final bottomGlow = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0x550078FF), Color(0x000078FF)])
              .createShader(
                Rect.fromCircle(
                  center: Offset(center.dx, center.dy + radius + 20),
                  radius: 120,
                ),
              );

    canvas.drawCircle(
      Offset(center.dx, center.dy + radius + 20),
      120,
      bottomGlow,
    );
  }

  @override
  bool shouldRepaint(covariant _EnterpriseRingPainter oldDelegate) {
    return false;
  }
}

// ==================================================================
// NETWORK LINES PAINTER
// ==================================================================

class _NetworkLinesPainter extends CustomPainter {
  final int? selectedCard;

  const _NetworkLinesPainter({required this.selectedCard});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final points = [
      const Offset(168, 135),
      Offset(size.width - 168, 135),
      const Offset(168, 365),
      Offset(size.width - 168, 365),
    ];

    for (int i = 0; i < points.length; i++) {
      final isSelected = selectedCard == i;

      // ==========================================================
      // GLOW
      // ==========================================================

      if (isSelected) {
        final glowPaint = Paint()
          ..color = const Color(0x6600BFFF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

        _drawConnection(canvas, glowPaint, points[i], center);
      }

      // ==========================================================
      // MAIN LINE
      // ==============================================================

      final linePaint = Paint()
        ..color = isSelected
            ? const Color(0xFF1680FF)
            : const Color(0xFF68768D).withValues(alpha: 0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isSelected ? 2.2 : 1.4
        ..strokeCap = StrokeCap.round;

      _drawConnection(canvas, linePaint, points[i], center);
    }
  }

  void _drawConnection(
    Canvas canvas,
    Paint paint,
    Offset start,
    Offset center,
  ) {
    final path = Path();

    path.moveTo(start.dx, start.dy);

    final controlX = (start.dx + center.dx) / 2;

    path.cubicTo(controlX, start.dy, controlX, center.dy, center.dx, center.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _NetworkLinesPainter oldDelegate) {
    return oldDelegate.selectedCard != selectedCard;
  }
}
