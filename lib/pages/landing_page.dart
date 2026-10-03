import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../app_theme.dart';
import '../routes/routes.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  static const double _headerHeight = 76.0;

  final ScrollController _scrollController = ScrollController();

  final GlobalKey _whyKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _howKey = GlobalKey();
  final GlobalKey _clientsKey = GlobalKey();

  late final AnimationController _heroController;
  late final AnimationController _signalController;
  late final AnimationController _floatController;

  int _featureIndex = 0;
  int _faqIndex = -1;
  String _activeSection = 'hero';

  final List<Map<String, String>> _features = [
    {
      'number': '01',
      'tag': 'HR & Workforce',
      'title': 'One Platform for Every HR Workflow',
      'image': 'assets/images/hr_module.png',
    },
    {
      'number': '02',
      'tag': 'Finance',
      'title': 'Close Faster. Report Smarter.',
      'image': 'assets/images/finance_module.png',
    },
    {
      'number': '03',
      'tag': 'Payroll',
      'title': 'Error-Free Payroll, Every Cycle',
      'image': 'assets/images/payroll_module.png',
    },
    {
      'number': '04',
      'tag': 'CRM',
      'title': 'Source Smarter. Spend Leaner.',
      'image': 'assets/images/crm_module.png',
    },
    {
      'number': '05',
      'tag': 'Operations',
      'title': 'Streamline Every Operational Process',
      'image': 'assets/images/operations_module.png',
    },
  ];

  final List<Map<String, String>> _faqs = [
    {
      'q': 'What is One Enterprise Cloud?',
      'a': 'One Enterprise Cloud brings your business functions together on one connected platform.',
    },
    {
      'q': 'Are the modules available separately?',
      'a': 'Yes. Enterprise modules can be used according to your business requirements.',
    },
    {
      'q': 'How can I start using the platform?',
      'a':
          'Create your account and get started with your enterprise workspace.',
    },
    {
      'q': 'Can the platform scale with my organization?',
      'a': 'Yes. The platform is designed to support growing enterprise operations.',
    },
  ];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_updateActiveSection);

    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..forward();

    _signalController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveSection);
    _scrollController.dispose();
    _heroController.dispose();
    _signalController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _updateActiveSection() {
    if (!_scrollController.hasClients) return;

    String next = 'hero';

    final sections = <MapEntry<String, GlobalKey>>[
      MapEntry('why', _whyKey),
      MapEntry('features', _featuresKey),
      MapEntry('how', _howKey),
      MapEntry('clients', _clientsKey),
    ];

    for (final entry in sections) {
      final context = entry.value.currentContext;
      if (context == null) continue;

      final renderObject = context.findRenderObject();
      if (renderObject is! RenderBox || !renderObject.hasSize) continue;

      final top = renderObject.localToGlobal(Offset.zero).dy;
      if (top <= _headerHeight + 20) {
        next = entry.key;
      }
    }

    if (next != _activeSection && mounted) {
      setState(() => _activeSection = next);
    }
  }

  Future<void> _goToSection(GlobalKey key) async {
    final context = key.currentContext;
    if (context == null) return;

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.02,
    );
  }

  void _goToLogin() {
    context.go(AppRoutes.login);
  }

  Widget _primaryButton({required String text, VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
          decoration: BoxDecoration(
            color: AppTheme.info,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(color: AppTheme.info.withOpacity(0.28), blurRadius: 22),
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _outlineButton({required String text, VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.65)),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required String title,
    required String section,
    required VoidCallback onTap,
  }) {
    final active = _activeSection == section;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: active
                ? AppTheme.info.withOpacity(0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: active ? Colors.white : Colors.white.withOpacity(0.70),
                  fontSize: 12,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: active ? 22 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: AppTheme.info,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 700;
        final horizontalPadding = width >= 1400
            ? 34.0
            : width >= 1150
            ? 24.0
            : isMobile
            ? 14.0
            : 18.0;

        return Container(
          height: _headerHeight,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          decoration: BoxDecoration(
            color: AppTheme.ink.withOpacity(0.975),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.07)),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.20),
                blurRadius: 22,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1500),
              child: isMobile
                  ? Row(
                      children: [
                        Image.asset(
                          'assets/images/stackly_logo.png',
                          height: 36,
                          fit: BoxFit.contain,
                        ),
                        const Spacer(),
                        PopupMenuButton<String>(
                          tooltip: 'Menu',
                          offset: const Offset(0, 48),
                          color: AppTheme.ink2,
                          elevation: 14,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.10),
                            ),
                          ),
                          icon: const Icon(
                            Icons.menu_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                          onSelected: (value) {
                            switch (value) {
                              case 'why':
                                _goToSection(_whyKey);
                                break;
                              case 'features':
                                _goToSection(_featuresKey);
                                break;
                              case 'how':
                                _goToSection(_howKey);
                                break;
                              case 'clients':
                                _goToSection(_clientsKey);
                                break;
                              case 'get_started':
                                _goToLogin();
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem<String>(
                              value: 'why',
                              child: _MobilePopupItem(
                                icon: Icons.hub_outlined,
                                title: 'Why One Enterprise',
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'features',
                              child: _MobilePopupItem(
                                icon: Icons.auto_awesome_outlined,
                                title: 'Features',
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'how',
                              child: _MobilePopupItem(
                                icon: Icons.account_tree_outlined,
                                title: 'How it works',
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'clients',
                              child: _MobilePopupItem(
                                icon: Icons.groups_outlined,
                                title: 'Clients',
                              ),
                            ),
                            const PopupMenuDivider(),
                            const PopupMenuItem<String>(
                              value: 'get_started',
                              child: _MobilePopupItem(
                                icon: Icons.arrow_forward_rounded,
                                title: 'Get Started',
                                highlighted: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              'assets/images/stackly_logo.png',
                              height: 40,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          flex: 5,
                          child: Center(
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 590),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.025),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.05),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _navItem(
                                    title: 'Why One Enterprise',
                                    section: 'why',
                                    onTap: () => _goToSection(_whyKey),
                                  ),
                                  _navItem(
                                    title: 'Features',
                                    section: 'features',
                                    onTap: () => _goToSection(_featuresKey),
                                  ),
                                  _navItem(
                                    title: 'How it works',
                                    section: 'how',
                                    onTap: () => _goToSection(_howKey),
                                  ),
                                  _navItem(
                                    title: 'Clients',
                                    section: 'clients',
                                    onTap: () => _goToSection(_clientsKey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _outlineButton(
                                    text: 'Talk to sales',
                                    onTap: () {},
                                  ),
                                  const SizedBox(width: 9),
                                  _primaryButton(
                                    text: 'Get Started',
                                    onTap: _goToLogin,
                                  ),
                                ],
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

  Widget _sectionTitle(String title, String subtitle) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.60),
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  double _sectionPadding(double width) {
    if (width >= 1500) return 90;
    if (width >= 1250) return 64;
    if (width >= 1050) return 45;
    if (width >= 700) return 32;
    return 18;
  }

  Widget _hero() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 700;
        final isTablet = width >= 700 && width < 1050;
        final heroHeight = isMobile
            ? 700.0
            : isTablet
            ? 700.0
            : 735.0;
        final layout = HeroNetworkLayout(size: Size(width, heroHeight));

        return SizedBox(
          height: heroHeight,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              const Positioned.fill(child: _LandingBackground()),
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      _signalController,
                      _floatController,
                    ]),
                    builder: (context, child) => CustomPaint(
                      painter: HeroNetworkPainter(
                        progress: _signalController.value,
                        floatProgress: _floatController.value,
                        layout: layout,
                        mobileMode: isMobile,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _signalController,
                    builder: (context, child) {
                      final pulse =
                          (math.sin(_signalController.value * math.pi * 2) +
                              1) /
                          2;
                      return CustomPaint(
                        painter: HeroCenterGlowPainter(
                          center: layout.center,
                          pulse: pulse,
                        ),
                      );
                    },
                  ),
                ),
              ),
              _heroContent(layout),
              ...layout.cards.map((card) => _positionedHeroCard(card: card)),
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      _signalController,
                      _floatController,
                    ]),
                    builder: (context, child) => CustomPaint(
                      painter: HeroNetworkPainter(
                        progress: _signalController.value,
                        floatProgress: _floatController.value,
                        layout: layout,
                        signalsOnly: true,
                        mobileMode: isMobile,
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

  Widget _heroContent(HeroNetworkLayout layout) {
    // Mobile keeps the headline small and centered inside the network hub.
    // The full supporting description is placed below the network design,
    // followed by the actions so nothing competes with the six module paths.
    if (layout.isMobile) {
      return Positioned.fill(
        child: IgnorePointer(
          ignoring: false,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Compact network hub title.
              Positioned(
                left: layout.contentLeft,
                right: layout.contentRight,
                top: layout.contentTop,
                child: AnimatedBuilder(
                  animation: _heroController,
                  builder: (context, child) {
                    final value = Curves.easeOutCubic.transform(
                      _heroController.value,
                    );
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 10 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: _heroTitle(layout.titleSize),
                ),
              ),

              // Full hero description comes after the bottom of the network.
              Positioned(
                left: 22,
                right: 22,
                top: 430,
                child: AnimatedBuilder(
                  animation: _heroController,
                  builder: (context, child) {
                    final value = Curves.easeOutCubic.transform(
                      _heroController.value,
                    );
                    return Opacity(opacity: value, child: child);
                  },
                  child: Text(
                    'Bring your business operations together in one connected cloud platform designed to simplify how teams, processes, data and workflows work together.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.74),
                      fontSize: layout.bodySize,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              // Actions remain below the description and outside the network.
              Positioned(
                left: 12,
                right: 12,
                top: layout.actionTop,
                child: AnimatedBuilder(
                  animation: _heroController,
                  builder: (context, child) {
                    final value = Curves.easeOutCubic.transform(
                      _heroController.value,
                    );
                    return Opacity(opacity: value, child: child);
                  },
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        _primaryButton(text: 'Get Started', onTap: _goToLogin),
                        _outlineButton(text: 'Talk to sales', onTap: () {}),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Positioned(
      left: layout.contentLeft,
      right: layout.contentRight,
      top: layout.contentTop,
      child: AnimatedBuilder(
        animation: _heroController,
        builder: (context, child) {
          final value = Curves.easeOutCubic.transform(_heroController.value);
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 22 * (1 - value)),
              child: child,
            ),
          );
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: layout.contentMaxWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _heroBadge(),
              const SizedBox(height: 24),
              _heroTitle(layout.titleSize),
              const SizedBox(height: 20),
              Text(
                'Bring your business operations together in one connected cloud platform designed to simplify how teams, processes, data and workflows work together.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.72),
                  fontSize: layout.bodySize,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 25),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  _primaryButton(text: 'Get Started', onTap: _goToLogin),
                  _outlineButton(text: 'Talk to sales', onTap: () {}),
                ],
              ),
              const SizedBox(height: 22),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 7,
                children: const [
                  _HeroCheck(text: 'Enterprise-ready'),
                  _HeroCheck(text: 'Secure by design'),
                  _HeroCheck(text: 'Built to scale'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heroBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.info.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppTheme.info.withOpacity(0.30)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, color: AppTheme.info, size: 13),
          SizedBox(width: 8),
          Text(
            'ONE ENTERPRISE CLOUD PLATFORM',
            style: TextStyle(
              color: AppTheme.info,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroTitle(double size) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'One Platform.\n',
            style: TextStyle(
              color: Colors.white,
              fontSize: size,
              fontWeight: FontWeight.w700,
              height: 1.02,
            ),
          ),
          TextSpan(
            text: 'Every ',
            style: TextStyle(
              color: const Color(0xFFDDE8FF),
              fontSize: size,
              fontWeight: FontWeight.w700,
              height: 1.02,
            ),
          ),
          TextSpan(
            text: 'Business\n',
            style: TextStyle(
              color: AppTheme.info,
              fontSize: size,
              fontWeight: FontWeight.w700,
              height: 1.02,
            ),
          ),
          TextSpan(
            text: 'Function.',
            style: TextStyle(
              color: AppTheme.info,
              fontSize: size,
              fontWeight: FontWeight.w700,
              height: 1.02,
            ),
          ),
        ],
      ),
    );
  }

  Widget _positionedHeroCard({required HeroModulePosition card}) {
    return Positioned(
      left: card.left,
      right: card.right,
      top: card.top,
      child: AnimatedBuilder(
        animation: _floatController,
        builder: (context, child) {
          final offset =
              math.sin((_floatController.value + card.phase) * math.pi * 2) * 5;

          return Transform.translate(offset: Offset(0, offset), child: child);
        },
        child: _moduleCard(
          icon: card.icon,
          title: card.title,
          width: card.width,
        ),
      ),
    );
  }

  Widget _moduleCard({
    required IconData icon,
    required String title,
    required double width,
  }) {
    return Container(
      width: width,
      height: width <= 105 ? 54 : 62,
      padding: EdgeInsets.all(width <= 105 ? 7 : 10),
      decoration: BoxDecoration(
        color: AppTheme.ink2.withOpacity(0.94),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppTheme.info.withOpacity(0.68)),
        boxShadow: [
          BoxShadow(color: AppTheme.info.withOpacity(0.13), blurRadius: 22),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.info, size: 21),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: width <= 105 ? 9.5 : 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _whySection() {
    final items = <Map<String, dynamic>>[
      {
        'icon': Icons.hub_outlined,
        'title': 'Truly Unified Platform',
        'description': 'One system for HR, Finance, Payroll, Procurement and Operations. No silos, no rekeying, every module shares a single data layer.',
      },
      {
        'icon': Icons.speed_outlined,
        'title': 'Deployment in Weeks',
        'description': 'Go live faster than traditional ERP. Pre built templates, zero code configuration and guided onboarding.',
      },
      {
        'icon': Icons.security_outlined,
        'title': 'Enterprise Grade Security',
        'description': 'ISO 27001, SOC 2 Type II, and GDPR compliant. Role based access, audit trails and encrypted data at rest and in transit.',
      },
      {
        'icon': Icons.insights_outlined,
        'title': 'Real Time Intelligence',
        'description': 'AI powered dashboards surface insights the moment they matter workforce costs, cash flow, procurement risks and more.',
      },
      {
        'icon': Icons.language_outlined,
        'title': 'Multi Entity Ready',
        'description': 'Multi currency, multi language and multi entity support out of the box. Operate across entities without extra setup.',
      },
      {
        'icon': Icons.extension_outlined,
        'title': 'Open Integration Ecosystem',
        'description': '200+ pre built connectors to Salesforce, SAP, Workday, banking APIs and government portals. Rest API for custom integrations.',
      },
    ];

    return Container(
      key: _whyKey,
      padding: EdgeInsets.symmetric(
        horizontal: _sectionPadding(MediaQuery.sizeOf(context).width),
        vertical: 88,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              _sectionTitle(
                'Why One Enterprise Cloud',
                'Everything Your Enterprise Needs, Connected in One Platform',
              ),
              const SizedBox(height: 44),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.sizeOf(context).width >= 1050
                      ? 3
                      : MediaQuery.sizeOf(context).width >= 700
                      ? 2
                      : 1,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: MediaQuery.sizeOf(context).width < 700
                      ? 1.45
                      : 1.65,
                ),
                itemBuilder: (context, index) {
                  return _GlassCard(
                    icon: items[index]['icon'] as IconData,
                    title: items[index]['title'] as String,
                    description: items[index]['description'] as String,
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featuresSection() {
    final feature = _features[_featureIndex];

    return Container(
      key: _featuresKey,
      padding: EdgeInsets.symmetric(
        horizontal: _sectionPadding(MediaQuery.sizeOf(context).width),
        vertical: 88,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1150),
          child: Column(
            children: [
              _sectionTitle(
                'Features Benefits by Module',
                'A unified platform designed to bring people, processes, data, and business functions together.',
              ),
              const SizedBox(height: 44),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                transitionBuilder: (child, animation) {
                  final slide = Tween<Offset>(
                    begin: const Offset(0.04, 0),
                    end: Offset.zero,
                  ).animate(animation);

                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(position: slide, child: child),
                  );
                },
                child: Container(
                  key: ValueKey(_featureIndex),
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.045),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppTheme.info.withOpacity(0.12)),
                  ),
                  child: LayoutBuilder(
                    builder: (context, box) {
                      final stacked = box.maxWidth < 760;
                      if (stacked) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _featureText(feature),
                            const SizedBox(height: 24),
                            _featureImage(feature),
                          ],
                        );
                      }
                      return Row(
                        children: [
                          Expanded(child: _featureText(feature)),
                          const SizedBox(width: 38),
                          Expanded(child: _featureImage(feature)),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _featureControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: 'Previous feature',
          onPressed: _featureIndex > 0
              ? () => setState(() => _featureIndex--)
              : null,
          icon: const Icon(Icons.chevron_left, color: Colors.white),
        ),
        Text(
          '${_featureIndex + 1} / ${_features.length}',
          style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 11),
        ),
        IconButton(
          tooltip: 'Next feature',
          onPressed: _featureIndex < _features.length - 1
              ? () => setState(() => _featureIndex++)
              : null,
          icon: const Icon(Icons.chevron_right, color: Colors.white),
        ),
      ],
    );
  }

  Widget _featureText(Map<String, String> feature) {
    const bullets = [
      'Employee Self Service Portal',
      'Recruitment & ATS',
      'Performance Management',
      'Learning & Development',
      'Leave & Attendance Management',
      'Org Chart & Succession Planning',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          feature['number']!,
          style: TextStyle(
            color: Colors.white.withOpacity(0.75),
            fontSize: 58,
            fontWeight: FontWeight.w200,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.info.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            feature['tag']!,
            style: const TextStyle(
              color: AppTheme.info,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          feature['title']!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 11,
          children: bullets.map((text) => Bullet(text: text)).toList(),
        ),
      ],
    );
  }

  Widget _featureImage(Map<String, String> feature) {
    return SizedBox(
      height: 245,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.info.withOpacity(0.45)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(
            feature['image']!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.business_center_outlined,
                  color: AppTheme.info,
                  size: 70,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _howItWorksSection() {
    const steps = [
      ['01', 'Connect', 'Bring your enterprise functions together.'],
      ['02', 'Integrate', 'Connect teams, applications and workflows.'],
      ['03', 'Automate', 'Simplify repetitive business processes.'],
      ['04', 'Analyze', 'Use connected insights to make decisions.'],
    ];

    return Container(
      key: _howKey,
      padding: EdgeInsets.symmetric(
        horizontal: _sectionPadding(MediaQuery.sizeOf(context).width),
        vertical: 88,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1250),
          child: Column(
            children: [
              _sectionTitle(
                'How It Works',
                'See how One Enterprise Cloud connects your business.',
              ),
              const SizedBox(height: 44),
              LayoutBuilder(
                builder: (context, box) {
                  if (box.maxWidth < 760) {
                    return Column(
                      children: [
                        _steps(steps),
                        const SizedBox(height: 35),
                        _howWorksText(),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(child: _steps(steps)),
                      const SizedBox(width: 65),
                      Expanded(child: _howWorksText()),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _steps(List<List<String>> steps) {
    return Column(
      children: steps
          .map(
            (step) => Container(
              margin: const EdgeInsets.only(bottom: 13),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              decoration: BoxDecoration(
                color: AppTheme.ink2,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.info.withOpacity(0.23)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppTheme.info.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Center(
                      child: Text(
                        step[0],
                        style: const TextStyle(
                          color: AppTheme.info,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step[1],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          step[2],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _howWorksText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'How ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: '4-Step',
                style: TextStyle(
                  color: AppTheme.info,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: '\nthe Process Works',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'From connecting your business functions to gaining actionable insights, everything works together through one connected enterprise platform.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.60),
            fontSize: 12,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 22),
        _primaryButton(text: 'Get Started', onTap: _goToLogin),
      ],
    );
  }

  Widget _clientsSection() {
    return Container(
      key: _clientsKey,
      padding: EdgeInsets.symmetric(
        horizontal: _sectionPadding(MediaQuery.sizeOf(context).width),
        vertical: 88,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              _sectionTitle(
                'What Our Clients Say',
                'Trusted by teams looking to simplify and connect their enterprise operations.',
              ),
              const SizedBox(height: 44),
              Row(
                children: [
                  Expanded(
                    child: _clientCard(
                      'Business Leader',
                      'One connected platform makes it easier for our teams to work together and get the visibility we need.',
                      Icons.person,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _clientCard(
                      'Operations Head',
                      'The connected enterprise approach helps us simplify processes and keep our business functions aligned.',
                      Icons.person_outline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _clientCard(String name, String description, IconData icon) {
    return Container(
      constraints: const BoxConstraints(minHeight: 210),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.055),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.info.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 21,
                backgroundColor: Colors.white,
                child: Icon(icon, color: AppTheme.info),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            '★★★★★',
            style: TextStyle(color: Color(0xFFFFC02B), letterSpacing: 2),
          ),
          const SizedBox(height: 15),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.62),
              fontSize: 12,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _faqSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _sectionPadding(MediaQuery.sizeOf(context).width),
        vertical: 88,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1150),
          child: Column(
            children: [
              _sectionTitle(
                'Frequently Asked Questions',
                'Find answers to the questions you may have about the platform.',
              ),
              const SizedBox(height: 44),
              LayoutBuilder(
                builder: (context, box) {
                  if (box.maxWidth < 760) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Question &\nAnswers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 28),
                        _faqList(),
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 4,
                        child: Text(
                          'Question &\nAnswers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.w300,
                            height: 1.05,
                          ),
                        ),
                      ),
                      const SizedBox(width: 55),
                      Expanded(flex: 6, child: _faqList()),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _faqList() {
    return Column(
      children: List.generate(_faqs.length, (index) {
        final open = _faqIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              _faqIndex = open ? -1 : index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 230),
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(open ? 0.09 : 0.045),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppTheme.info.withOpacity(open ? 0.35 : 0.12),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _faqs[index]['q']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      open ? Icons.remove : Icons.add,
                      color: Colors.white54,
                      size: 18,
                    ),
                  ],
                ),
                if (open) ...[
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _faqs[index]['a']!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.58),
                        fontSize: 11,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _finalCta() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1350),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 60),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 58),
            decoration: BoxDecoration(
              color: AppTheme.ink2,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppTheme.info.withOpacity(0.30)),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.info.withOpacity(0.08),
                  blurRadius: 35,
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Ready to unify your\nenterprise operations?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 17),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 650),
                  child: Text(
                    'Start your journey with one connected enterprise platform designed to bring your business functions together.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.60),
                      fontSize: 12,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                _primaryButton(text: 'Get Started', onTap: _goToLogin),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _footer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 55, 28, 25),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08))),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1350),
          child: Column(
            children: [
              LayoutBuilder(
                builder: (context, box) {
                  if (box.maxWidth < 760) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _footerBrand(),
                        const SizedBox(height: 35),
                        _footerColumns(),
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _footerBrand()),
                      const SizedBox(width: 55),
                      Expanded(flex: 3, child: _footerColumns()),
                    ],
                  );
                },
              ),
              const SizedBox(height: 35),
              Divider(color: Colors.white.withOpacity(0.08)),
              const SizedBox(height: 18),
              Text(
                '© 2026 Stackly. All rights reserved.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.40),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _footerBrand() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/stackly_logo.png', height: 34),
          const SizedBox(height: 15),
          Text(
            'The connected enterprise platform designed to bring every business function together.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.50),
              fontSize: 11,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerColumns() {
    return LayoutBuilder(
      builder: (context, box) {
        final children = [
          _footerColumn('Platform', const [
            'Why One Enterprise',
            'Features',
            'How It Works',
            'Clients',
          ]),
          _footerColumn('Company', const [
            'About',
            'Careers',
            'Contact',
            'Partners',
          ]),
          _footerColumn('Resources', const [
            'Documentation',
            'Security',
            'Support',
            'Privacy',
          ]),
        ];
        if (box.maxWidth < 560) {
          return Wrap(
            spacing: 28,
            runSpacing: 28,
            children: children
                .map((e) => SizedBox(width: (box.maxWidth - 28) / 2, child: e))
                .toList(),
          );
        }
        return Row(children: children.map((e) => Expanded(child: e)).toList());
      },
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 14),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Text(
              item,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withOpacity(0.45),
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Mobile Landing Page uses the AuthLayout visual language only.
  // Desktop/tablet continue using the existing Landing Page unchanged.
  Widget _buildMobileAuthStyleLanding() {
    return const _MobileAuthStyleLanding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            return _buildMobileAuthStyleLanding();
          }

          return DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppTheme.ink, AppTheme.ink2, AppTheme.ink],
              ),
            ),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: LandingHeaderDelegate(
                    height: _headerHeight,
                    child: _header(),
                  ),
                ),
                SliverToBoxAdapter(child: _hero()),
                SliverToBoxAdapter(child: _whySection()),
                SliverToBoxAdapter(child: _featuresSection()),
                SliverToBoxAdapter(child: _howItWorksSection()),
                SliverToBoxAdapter(child: _clientsSection()),
                SliverToBoxAdapter(child: _faqSection()),
                SliverToBoxAdapter(child: _finalCta()),
                SliverToBoxAdapter(child: _footer()),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// MOBILE LANDING — AUTH LAYOUT STYLE
// ============================================================================

class _MobileAuthStyleLanding extends StatefulWidget {
  const _MobileAuthStyleLanding();

  @override
  State<_MobileAuthStyleLanding> createState() =>
      _MobileAuthStyleLandingState();
}

class _MobileAuthStyleLandingState extends State<_MobileAuthStyleLanding>
    with SingleTickerProviderStateMixin {
  int? _selectedCard;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _goToLogin() {
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final compact = width < 380;

        final logoWidth = compact ? 122.0 : 140.0;
        final titleSize = compact ? 27.0 : 30.0;
        final networkTop = compact ? 160.0 : 168.0;
        final ctaHeight = compact ? 112.0 : 120.0;
        final networkBottom = ctaHeight + 4;

        return ColoredBox(
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Subtle blue atmosphere behind the network.
              Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0, -0.05),
                        radius: 1.0,
                        colors: [
                          const Color(0xFF0B3C8F).withOpacity(0.18),
                          Colors.black.withOpacity(0.10),
                          Colors.black,
                        ],
                        stops: const [0.0, 0.42, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              // Stackly logo.
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

              // Platform label.
              Positioned(
                top: 60,
                left: 20,
                right: 20,
                child: Text(
                  'CLOUD PLATFORM  ·  HRMS  ·  CRM  ·  ERP  ·  FINANCE  ·  AI',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: GoogleFonts.ibmPlexMono(
                    color: const Color(0xFF7D899D),
                    fontSize: compact ? 6.8 : 7.2,
                    letterSpacing: 0.75,
                  ),
                ),
              ),

              // AuthLayout-style title.
              Positioned(
                top: 82,
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

              // Exact visual language of the AuthLayout network.
              Positioned(
                top: networkTop,
                left: 0,
                right: 0,
                bottom: networkBottom,
                child: LayoutBuilder(
                  builder: (context, networkBox) {
                    final scale = math
                        .min(
                          networkBox.maxWidth / 600.0,
                          networkBox.maxHeight / 500.0,
                        )
                        .clamp(0.0, 1.0)
                        .toDouble();

                    return Center(
                      child: SizedBox(
                        width: 600 * scale,
                        height: 500 * scale,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: SizedBox(
                            width: 600,
                            height: 500,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 410,
                                    height: 410,
                                    child: CustomPaint(
                                      painter: _MobileEnterpriseRingPainter(),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: _MobileNetworkLinesPainter(
                                      selectedCard: _selectedCard,
                                      animation: _pulseController,
                                    ),
                                  ),
                                ),
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
                                      border: Border.all(
                                        color: Color(0xFF2878FF),
                                        width: 1.2,
                                      ),
                                      boxShadow: [
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
                                _mobileModuleCard(
                                  index: 0,
                                  left: 15,
                                  top: 65,
                                  icon: Icons.people_alt_outlined,
                                  title: 'People',
                                  subtitle: 'Manage users & teams',
                                ),
                                _mobileModuleCard(
                                  index: 1,
                                  right: 15,
                                  top: 65,
                                  icon: Icons.inventory_2_outlined,
                                  title: 'Applications',
                                  subtitle: 'Integrate & manage',
                                ),
                                _mobileModuleCard(
                                  index: 2,
                                  left: 15,
                                  bottom: 65,
                                  icon: Icons.shield_outlined,
                                  title: 'Security',
                                  subtitle: 'Protect every access',
                                ),
                                _mobileModuleCard(
                                  index: 3,
                                  right: 15,
                                  bottom: 65,
                                  icon: Icons.bar_chart_outlined,
                                  title: 'Analytics',
                                  subtitle: 'Turn data into insights',
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

              // Compact CTA visually connected to the bottom of the network.
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: ctaHeight,
                child: SafeArea(
                  top: false,
                  child: Transform.translate(
                    offset: const Offset(0, -8),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, compact ? 2 : 3, 20, 0),
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'One connected platform for your enterprise.',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.68),
                              fontSize: compact ? 9.5 : 10.5,
                              fontWeight: FontWeight.w400,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: compact ? 124 : 132,
                            height: compact ? 32 : 34,
                            child: ElevatedButton(
                              onPressed: _goToLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2166F3),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Get Started',
                                    style: GoogleFonts.inter(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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

  Widget _mobileModuleCard({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    final selected = _selectedCard == index;

    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCard = selected ? null : index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: 154,
          height: 128,
          padding: const EdgeInsets.fromLTRB(16, 16, 12, 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF0A1428) : const Color(0xFF080D16),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: selected
                  ? const Color(0xFF1680FF)
                  : const Color(0xFF164DAD),
              width: selected ? 1.5 : 1,
            ),
            boxShadow: selected
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
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF083D78)
                      : const Color(0xFF062544),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: selected
                        ? const Color(0xFF1680FF)
                        : const Color(0xFF0C65B7),
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: const Color(0xFF1678FF), size: 20),
              ),
              const Spacer(),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: selected
                      ? const Color(0xFFB2C4DD)
                      : const Color(0xFF8A95A8),
                  fontSize: 9.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileEnterpriseRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

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

    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFF1265FF).withOpacity(0.75);
    canvas.drawCircle(center, radius - 13, innerPaint);

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
  bool shouldRepaint(covariant _MobileEnterpriseRingPainter oldDelegate) =>
      false;
}

class _MobileNetworkLinesPainter extends CustomPainter {
  final int? selectedCard;
  final Animation<double> animation;

  _MobileNetworkLinesPainter({
    required this.selectedCard,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final points = [
      const Offset(168, 135),
      Offset(size.width - 168, 135),
      const Offset(168, 365),
      Offset(size.width - 168, 365),
    ];

    for (var i = 0; i < points.length; i++) {
      final selected = selectedCard == i;

      if (selected) {
        final glow = Paint()
          ..color = const Color(0x6600BFFF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

        _drawConnection(canvas, glow, points[i], center);
      }

      final line = Paint()
        ..color = selected
            ? const Color(0xFF1680FF)
            : const Color(0xFF68768D).withOpacity(0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? 2.2 : 1.4
        ..strokeCap = StrokeCap.round;

      _drawConnection(canvas, line, points[i], center);

      // All four signals use the exact same progress.
      // Therefore they leave 1E together and reach the modules together.
      final progress = animation.value;

      _drawSignal(canvas, points[i], center, progress);
    }
  }

  void _drawConnection(
    Canvas canvas,
    Paint paint,
    Offset start,
    Offset center,
  ) {
    final path = Path()..moveTo(start.dx, start.dy);

    final controlX = (start.dx + center.dx) / 2;

    path.cubicTo(controlX, start.dy, controlX, center.dy, center.dx, center.dy);

    canvas.drawPath(path, paint);
  }

  void _drawSignal(
    Canvas canvas,
    Offset module,
    Offset center,
    double progress,
  ) {
    final path = Path()..moveTo(module.dx, module.dy);

    final controlX = (module.dx + center.dx) / 2;

    path.cubicTo(
      controlX,
      module.dy,
      controlX,
      center.dy,
      center.dx,
      center.dy,
    );

    final metric = path.computeMetrics().first;

    // The path is module -> center.
    // Reverse the distance so the light travels center -> module.
    final distance = metric.length * (1.0 - progress);

    final tangent = metric.getTangentForOffset(distance);

    if (tangent == null) return;

    final position = tangent.position;

    // Large, soft dandelion-style glow.
    final outerGlow = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0x664FDFFF),
          Color(0x304FDFFF),
          Color(0x124FDFFF),
          Color(0x004FDFFF),
        ],
        stops: [0.0, 0.28, 0.62, 1.0],
      ).createShader(Rect.fromCircle(center: position, radius: 20))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position, 20, outerGlow);

    // Soft inner halo.
    final haloPaint = Paint()
      ..color = const Color(0x554FDFFF)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawCircle(position, 7.5, haloPaint);

    // Main glowing light ball.
    final ballPaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0xFFFFFFFF),
          Color(0xFFE2FAFF),
          Color(0xFF7BE4FF),
          Color(0x006DDFFF),
        ],
        stops: [0.0, 0.18, 0.48, 1.0],
      ).createShader(Rect.fromCircle(center: position, radius: 6.5))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position, 6.5, ballPaint);
  }

  @override
  bool shouldRepaint(covariant _MobileNetworkLinesPainter oldDelegate) {
    return oldDelegate.selectedCard != selectedCard;
  }
}

class HeroModulePosition {
  final String title;
  final IconData icon;
  final double? left;
  final double? right;
  final double top;
  final double width;
  final double phase;

  const HeroModulePosition({
    required this.title,
    required this.icon,
    this.left,
    this.right,
    required this.top,
    required this.width,
    required this.phase,
  });

  Offset anchor(Size size) {
    // Connection paths stop at the card boundary. The animated signal gets
    // its own tiny entry segment so the static paths never draw over cards.
    final x = left != null ? left! + width : size.width - right!;

    return Offset(x, top + 31);
  }
}

class HeroNetworkLayout {
  final Size size;
  late final Offset center;
  late final List<HeroModulePosition> cards;
  late final double contentLeft;
  late final double contentRight;
  late final double contentTop;
  late final double titleSize;
  late final double bodySize;
  late final double contentMaxWidth;
  late final double actionTop;
  late final bool isMobile;

  HeroNetworkLayout({required this.size}) {
    final width = size.width;
    isMobile = width < 700;

    if (isMobile) {
      // Mobile keeps the network as the primary hero visual. The headline and
      // actions start only after the network, preventing visual collisions.
      final cardWidth = width < 360
          ? 86.0
          : width < 410
          ? 94.0
          : 102.0;
      final side = width < 360
          ? 7.0
          : width < 410
          ? 10.0
          : 14.0;
      const centerY = 255.0;

      center = Offset(width / 2, centerY);

      cards = [
        HeroModulePosition(
          title: 'Workflow',
          icon: Icons.account_tree_outlined,
          left: side,
          top: 96,
          width: cardWidth,
          phase: 0.00,
        ),
        HeroModulePosition(
          title: 'AI',
          icon: Icons.auto_awesome_outlined,
          left: side,
          top: 205,
          width: cardWidth,
          phase: 0.17,
        ),
        HeroModulePosition(
          title: 'Finance',
          icon: Icons.account_balance_wallet_outlined,
          left: side,
          top: 314,
          width: cardWidth,
          phase: 0.34,
        ),
        HeroModulePosition(
          title: 'HRMS',
          icon: Icons.groups_outlined,
          right: side,
          top: 96,
          width: cardWidth,
          phase: 0.08,
        ),
        HeroModulePosition(
          title: 'CRM',
          icon: Icons.handshake_outlined,
          right: side,
          top: 205,
          width: cardWidth,
          phase: 0.25,
        ),
        HeroModulePosition(
          title: 'ERP',
          icon: Icons.dashboard_customize_outlined,
          right: side,
          top: 314,
          width: cardWidth,
          phase: 0.42,
        ),
      ];

      contentLeft = 14.0;
      contentRight = 14.0;
      // The headline sits directly in the clear center of the network.
      // The action buttons remain below the network so they never compete
      // with the six module cards or the animated connection paths.
      contentTop = 205.0;
      actionTop = 525.0;
      contentMaxWidth = math.min(width - 30.0, 290.0);
      titleSize = width < 360
          ? 19.0
          : width < 410
          ? 21.0
          : 23.0;
      bodySize = width < 360 ? 12.0 : 12.5;
      return;
    }

    final cardWidth = width >= 1250
        ? 145.0
        : width >= 1050
        ? 136.0
        : 124.0;
    final outer = width >= 1400
        ? 115.0
        : width >= 1200
        ? 82.0
        : 35.0;
    final middle = width >= 1400
        ? 92.0
        : width >= 1200
        ? 60.0
        : 28.0;
    final centerY = size.height * 0.49;
    center = Offset(width / 2, centerY);
    cards = [
      HeroModulePosition(
        title: 'Workflow',
        icon: Icons.account_tree_outlined,
        left: outer,
        top: 116,
        width: cardWidth,
        phase: 0.00,
      ),
      HeroModulePosition(
        title: 'AI',
        icon: Icons.auto_awesome_outlined,
        left: middle,
        top: 302,
        width: cardWidth,
        phase: 0.17,
      ),
      HeroModulePosition(
        title: 'Finance',
        icon: Icons.account_balance_wallet_outlined,
        left: outer + 4,
        top: size.height - 205,
        width: cardWidth,
        phase: 0.34,
      ),
      HeroModulePosition(
        title: 'HRMS',
        icon: Icons.groups_outlined,
        right: outer,
        top: 116,
        width: cardWidth,
        phase: 0.08,
      ),
      HeroModulePosition(
        title: 'CRM',
        icon: Icons.handshake_outlined,
        right: middle,
        top: 302,
        width: cardWidth,
        phase: 0.25,
      ),
      HeroModulePosition(
        title: 'ERP',
        icon: Icons.dashboard_customize_outlined,
        right: outer + 4,
        top: size.height - 205,
        width: cardWidth,
        phase: 0.42,
      ),
    ];
    contentLeft = width * 0.25;
    contentRight = width * 0.25;
    contentTop = size.height * 0.135;
    actionTop = size.height * 0.135;
    contentMaxWidth = 650;
    titleSize = width >= 1400
        ? 62
        : width >= 1150
        ? 56
        : 49;
    bodySize = width >= 1200 ? 15 : 14;
  }
}

class _LandingBackground extends StatelessWidget {
  const _LandingBackground();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -0.05),
          radius: 1.05,
          colors: [
            AppTheme.info.withOpacity(0.20),
            AppTheme.ink2.withOpacity(0.55),
            AppTheme.ink,
          ],
          stops: const [0.0, 0.38, 1.0],
        ),
      ),
    );
  }
}

class HeroCenterGlowPainter extends CustomPainter {
  final Offset center;
  final double pulse;

  HeroCenterGlowPainter({required this.center, required this.pulse});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = 225 + pulse * 35;

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppTheme.info.withOpacity(0.12 + pulse * 0.08),
          AppTheme.info.withOpacity(0.035),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant HeroCenterGlowPainter oldDelegate) {
    return oldDelegate.center != center || oldDelegate.pulse != pulse;
  }
}

class HeroNetworkPainter extends CustomPainter {
  final double progress;
  final double floatProgress;
  final HeroNetworkLayout layout;
  final bool signalsOnly;
  final bool mobileMode;

  HeroNetworkPainter({
    required this.progress,
    required this.floatProgress,
    required this.layout,
    this.signalsOnly = false,
    this.mobileMode = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (signalsOnly) {
      _drawConnectionSignals(canvas, size);
      return;
    }

    _drawOrbitLines(canvas, size);
    _drawCenterHub(canvas, size);
    _drawModuleConnections(canvas, size);
    _drawOrbitSignals(canvas, size);
  }

  void _drawOrbitLines(Canvas canvas, Size size) {
    // Keep the reference-style orbital background extremely subtle. These
    // are decorative only; the six module paths below carry the actual flow.
    final arcs = <_OrbitArc>[
      _OrbitArc(
        rect: Rect.fromLTWH(
          -size.width * 0.12,
          size.height * 0.12,
          size.width * 1.24,
          size.height * 0.78,
        ),
        opacity: 0.075,
        strokeWidth: 0.85,
      ),
      _OrbitArc(
        rect: Rect.fromLTWH(
          size.width * 0.02,
          size.height * 0.25,
          size.width * 0.96,
          size.height * 0.52,
        ),
        opacity: 0.05,
        strokeWidth: 0.7,
      ),
    ];

    for (final arc in arcs) {
      final line = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = arc.strokeWidth
        ..color = AppTheme.info.withOpacity(arc.opacity);

      canvas.drawArc(arc.rect, math.pi, math.pi, false, line);
    }
  }

  /// A subtle central network ring. Every module connection begins on this
  /// ring, so the animated signal has a clear origin in the hero center.
  void _drawCenterHub(Canvas canvas, Size size) {
    final pulse = (math.sin(progress * math.pi * 2) + 1) / 2;

    if (mobileMode) {
      // On mobile the headline itself is the network hub. Keep only a soft
      // glow behind it; do not draw a separate circle that competes with the
      // words in the middle.
      final glowRadius = 145.0 + pulse * 10;
      final glow = Paint()
        ..shader =
            RadialGradient(
              colors: [
                AppTheme.info.withOpacity(0.11 + pulse * 0.05),
                AppTheme.info.withOpacity(0.025),
                Colors.transparent,
              ],
            ).createShader(
              Rect.fromCircle(center: layout.center, radius: glowRadius),
            );
      canvas.drawCircle(layout.center, glowRadius, glow);
      return;
    }

    final outerRadius = 112.0 + pulse * 5;
    final innerRadius = 92.0 + pulse * 3;

    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..color = AppTheme.info.withOpacity(0.025 + pulse * 0.02)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    canvas.drawCircle(layout.center, outerRadius, glow);

    final outer = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.85
      ..color = AppTheme.info.withOpacity(0.12);

    canvas.drawCircle(layout.center, outerRadius, outer);

    final inner = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.65
      ..color = AppTheme.info.withOpacity(0.075);

    canvas.drawCircle(layout.center, innerRadius, inner);
  }

  /// Creates six real paths from the central hub ring to the module cards.
  /// The path direction is intentionally center -> module so the signal
  /// animation can visibly travel outward from OneCloud to each module.
  void _drawModuleConnections(Canvas canvas, Size size) {
    for (var index = 0; index < layout.cards.length; index++) {
      final card = layout.cards[index];
      final end = _animatedAnchor(card, size);
      final connection = _connectionFor(card, end, size, index);

      // One clean connection per module. No wide glow is drawn across the
      // cards, so the module surfaces remain clear and readable.
      final glow = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7
        ..strokeCap = StrokeCap.round
        ..color = AppTheme.info.withOpacity(0.075)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7);

      canvas.drawPath(connection.path, glow);

      final line = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.35
        ..strokeCap = StrokeCap.round
        ..color = AppTheme.info.withOpacity(0.42);

      canvas.drawPath(connection.path, line);

      final startGlow = Paint()
        ..color = AppTheme.info.withOpacity(0.16)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

      canvas.drawCircle(connection.start, 4.5, startGlow);

      final startCore = Paint()..color = AppTheme.info.withOpacity(0.60);

      canvas.drawCircle(connection.start, 2.2, startCore);
    }
  }

  void _drawOrbitSignals(Canvas canvas, Size size) {
    if (mobileMode) return;
    final pulse = (math.sin(progress * math.pi * 2) + 1) / 2;

    final signalPaths = <_OrbitSignal>[
      _OrbitSignal(
        rect: Rect.fromLTWH(
          -size.width * 0.16,
          size.height * 0.10,
          size.width * 1.32,
          size.height * 0.86,
        ),
        phase: 0.00,
      ),
      _OrbitSignal(
        rect: Rect.fromLTWH(
          -size.width * 0.06,
          size.height * 0.20,
          size.width * 1.12,
          size.height * 0.66,
        ),
        phase: 0.34,
      ),
      _OrbitSignal(
        rect: Rect.fromLTWH(
          size.width * 0.07,
          size.height * 0.31,
          size.width * 0.86,
          size.height * 0.48,
        ),
        phase: 0.68,
      ),
    ];

    for (final signal in signalPaths) {
      final t = (progress * 0.20 + signal.phase) % 1.0;
      final angle = math.pi + t * math.pi;
      final center = signal.rect.center;
      final rx = signal.rect.width / 2;
      final ry = signal.rect.height / 2;

      final point = Offset(
        center.dx + math.cos(angle) * rx,
        center.dy + math.sin(angle) * ry,
      );

      final glow = Paint()
        ..color = AppTheme.info.withOpacity(0.22 + pulse * 0.10)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7);

      canvas.drawCircle(point, 4.5, glow);

      final core = Paint()
        ..color = AppTheme.info.withOpacity(0.62 + pulse * 0.20);

      canvas.drawCircle(point, 1.5, core);
    }
  }

  /// Draws glowing signals outward from the central hub toward every module.
  /// A short trail is drawn behind each moving signal to make the direction
  /// of travel obvious instead of looking like a random pulsing dot.
  void _drawConnectionSignals(Canvas canvas, Size size) {
    for (var index = 0; index < layout.cards.length; index++) {
      final card = layout.cards[index];
      final end = _animatedAnchor(card, size);
      final connection = _connectionFor(card, end, size, index);
      final metric = connection.path.computeMetrics().first;

      // Stagger the six signals, but keep them moving outward from the hub.
      final t = (progress * 0.30 + card.phase + index * 0.035) % 1.0;
      final distance = metric.length * t;
      final tangent = metric.getTangentForOffset(distance);
      if (tangent == null) continue;

      final pulse = (math.sin((progress + card.phase) * math.pi * 2) + 1) / 2;

      // Long but narrow trail. It follows the same path and never crosses
      // another module.
      final trailDistance = math.max(0.0, distance - 75.0);
      final trailTangent = metric.getTangentForOffset(trailDistance);
      if (trailTangent != null) {
        final trail = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.2
          ..strokeCap = StrokeCap.round
          ..shader =
              LinearGradient(
                colors: [
                  AppTheme.info.withOpacity(0.0),
                  AppTheme.info.withOpacity(0.55 + pulse * 0.20),
                ],
              ).createShader(
                Rect.fromPoints(trailTangent.position, tangent.position),
              );

        canvas.drawLine(trailTangent.position, tangent.position, trail);
      }

      final point = tangent.position;

      // Strong signal core.
      final glow = Paint()
        ..color = AppTheme.info.withOpacity(0.52 + pulse * 0.24)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 11);

      canvas.drawCircle(point, 9.5, glow);

      final core = Paint()..color = Colors.white.withOpacity(0.92);
      canvas.drawCircle(point, 2.8, core);

      // When the signal reaches the card, add only a short entry segment.
      // The static path itself still stops exactly at the card boundary.
      if (t > 0.88) {
        final entryProgress = (t - 0.88) / 0.12;
        final entryLength = 16.0 * entryProgress;
        final entryPoint = connection.end + connection.direction * entryLength;

        final entryGlow = Paint()
          ..color = AppTheme.info.withOpacity(0.38 + pulse * 0.22)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7);

        canvas.drawLine(connection.end, entryPoint, entryGlow);

        final entryCore = Paint()..color = AppTheme.info.withOpacity(0.90);

        canvas.drawCircle(entryPoint, 3.2, entryCore);
      }
    }
  }

  Offset _animatedAnchor(HeroModulePosition card, Size size) {
    final base = card.anchor(size);
    final offset = math.sin((floatProgress + card.phase) * math.pi * 2) * 5;

    return base + Offset(0, offset);
  }

  _ModuleConnection _connectionFor(
    HeroModulePosition card,
    Offset end,
    Size size,
    int index,
  ) {
    final vector = end - layout.center;
    final distance = vector.distance;
    final direction = distance == 0 ? const Offset(1, 0) : vector / distance;

    // The title is the actual network hub. Connections begin at the edge of
    // the central text area, so every path visually comes FROM the words and
    // travels outward to its module instead of starting from a separate dot.
    final start = _textHubBoundary(direction);
    final controlDistance = mobileMode ? 38.0 : 120.0;
    final firstControl = start + direction * controlDistance;
    final secondControl = end - direction * (mobileMode ? 34.0 : 120.0);

    final path = Path()..moveTo(start.dx, start.dy);
    path.cubicTo(
      firstControl.dx,
      firstControl.dy,
      secondControl.dx,
      secondControl.dy,
      end.dx,
      end.dy,
    );

    return _ModuleConnection(
      start: start,
      end: end,
      path: path,
      direction: direction,
    );
  }

  Offset _textHubBoundary(Offset direction) {
    final dx = direction.dx.abs();
    final dy = direction.dy.abs();

    if (mobileMode) {
      // Approximate the visible three-line mobile headline as an ellipse.
      // This keeps the path visually attached to the text without drawing
      // through the letters themselves.
      final rx = math.min(layout.contentMaxWidth * 0.39, 104.0);
      final ry = 46.0;
      final denominator = math.sqrt(
        (dx * dx) / (rx * rx) + (dy * dy) / (ry * ry),
      );
      final radius = denominator == 0 ? 0.0 : 1.0 / denominator;
      return layout.center + direction * radius;
    }

    // Desktop/tablet title block is wider and taller.
    final rx = math.min(layout.contentMaxWidth * 0.43, 285.0);
    final ry = 118.0;
    final denominator = math.sqrt(
      (dx * dx) / (rx * rx) + (dy * dy) / (ry * ry),
    );
    final radius = denominator == 0 ? 0.0 : 1.0 / denominator;
    return layout.center + direction * radius;
  }

  @override
  bool shouldRepaint(covariant HeroNetworkPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.floatProgress != floatProgress ||
        oldDelegate.layout.size != layout.size ||
        oldDelegate.signalsOnly != signalsOnly ||
        oldDelegate.mobileMode != mobileMode;
  }
}

class _ModuleConnection {
  final Offset start;
  final Offset end;
  final Offset direction;
  final Path path;

  const _ModuleConnection({
    required this.start,
    required this.end,
    required this.direction,
    required this.path,
  });
}

class _OrbitArc {
  final Rect rect;
  final double opacity;
  final double strokeWidth;

  const _OrbitArc({
    required this.rect,
    required this.opacity,
    required this.strokeWidth,
  });
}

class _OrbitSignal {
  final Rect rect;
  final double phase;

  const _OrbitSignal({required this.rect, required this.phase});
}

class _GlassCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final int index;

  const _GlassCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  State<_GlassCard> createState() => _GlassCardState();
}

class _MobilePopupItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool highlighted;

  const _MobilePopupItem({
    required this.icon,
    required this.title,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 17,
          color: highlighted ? AppTheme.info : Colors.white70,
        ),
        const SizedBox(width: 11),
        Text(
          title,
          style: TextStyle(
            color: highlighted ? AppTheme.info : Colors.white,
            fontSize: 12,
            fontWeight: highlighted ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _GlassCardState extends State<_GlassCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500 + widget.index * 80),
    );

    Future.delayed(Duration(milliseconds: widget.index * 90), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = Curves.easeOutCubic.transform(_controller.value);

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 22 * (1 - value)),
            child: child,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: const EdgeInsets.all(23),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.055),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.info.withOpacity(0.18)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.info.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(widget.icon, color: AppTheme.info, size: 21),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    widget.description,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.60),
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroCheck extends StatelessWidget {
  final String text;

  const _HeroCheck({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check, color: AppTheme.success, size: 15),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(color: Colors.white.withOpacity(0.70), fontSize: 11),
        ),
      ],
    );
  }
}

class Bullet extends StatelessWidget {
  final String text;

  const Bullet({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.circle, size: 5, color: AppTheme.info),
        const SizedBox(width: 7),
        Text(
          text,
          style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 10),
        ),
      ],
    );
  }
}

class LandingHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  LandingHeaderDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: AppTheme.ink,
      elevation: overlapsContent ? 4 : 0,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant LandingHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
