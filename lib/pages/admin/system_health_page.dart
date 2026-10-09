import 'package:flutter/material.dart';

// ============================================================
// SYSTEM HEALTH COLORS
// ============================================================

const Color systemHealthNavy = Color(0xFF172638);
const Color systemHealthMuted = Color(0xFF667A90);
const Color systemHealthLightMuted = Color(0xFF91A4BB);
const Color systemHealthBorder = Color(0xFFDCE4EC);

const Color systemHealthGreen = Color(0xFF2EA567);
const Color systemHealthGreenDot = Color(0xFF19B97A);

const Color systemHealthAmber = Color(0xFFD58A20);
const Color systemHealthRed = Color(0xFFB53131);

const Color systemHealthBlue1 = Color(0xFF3548E8);
const Color systemHealthBlue2 = Color(0xFF161D55);

// ============================================================
// SYSTEM HEALTH PAGE
// ============================================================

class SystemHealthPage extends StatelessWidget {
  const SystemHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;
        final bool isSmallMobile = constraints.maxWidth < 430;

        return Column(
          children: [
            _buildPageHeader(context, isMobile: isMobile),

            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: isMobile ? 16 : 28,
                  right: isMobile ? 16 : 28,
                  top: isMobile ? 4 : 16,
                  bottom: 28,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1600),
                    child: _buildContent(
                      context,
                      isMobile: isMobile,
                      isSmallMobile: isSmallMobile,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // PAGE HEADER
  // ============================================================

  Widget _buildPageHeader(BuildContext context, {required bool isMobile}) {
    // ==========================================================
    // MOBILE HEADER
    // ==========================================================

    if (isMobile) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(32, 8, 20, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------------
            // BREADCRUMB
            // ----------------------------------------------------

            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Text(
                'Platform Administration / Platform Health Overview',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF92A6BF),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            const SizedBox(height: 7),

            // ----------------------------------------------------
            // TITLE + REFRESH
            // ----------------------------------------------------
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    'Platform Health Overview',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: systemHealthNavy,
                      fontSize: 24,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                SizedBox(
                  width: 42,
                  height: 42,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    tooltip: 'Refresh',
                    onPressed: () {},
                    icon: const Icon(
                      Icons.refresh_rounded,
                      size: 29,
                      color: Color(0xFF56636F),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // ==========================================================
    // DESKTOP HEADER
    // ==========================================================

    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 18, 28, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBreadcrumb(isMobile: false),
                const SizedBox(height: 8),
                const Text(
                  'Platform Health Overview',
                  style: TextStyle(
                    color: systemHealthNavy,
                    fontSize: 29,
                    height: 1.15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.7,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text(
              'Refresh now',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: systemHealthNavy,
              side: const BorderSide(color: systemHealthBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BREADCRUMB
  // ============================================================

  Widget _buildBreadcrumb({required bool isMobile}) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'Platform Administration',
          style: TextStyle(
            color: isMobile ? const Color(0xFF92A6BF) : const Color(0xFF64788F),
            fontSize: isMobile ? 14 : 14,
            fontWeight: FontWeight.w400,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Text(
            '/',
            style: TextStyle(
              color: isMobile
                  ? const Color(0xFF92A6BF)
                  : const Color(0xFF64788F),
              fontSize: 14,
            ),
          ),
        ),

        Text(
          'Platform Health Overview',
          style: TextStyle(
            color: isMobile ? const Color(0xFF92A6BF) : systemHealthNavy,
            fontSize: 14,
            fontWeight: isMobile ? FontWeight.w400 : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CONTENT
  // ============================================================

  Widget _buildContent(
    BuildContext context, {
    required bool isMobile,
    required bool isSmallMobile,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --------------------------------------------------------
        // DESKTOP STATUS BANNER
        // --------------------------------------------------------

        if (!isMobile) ...[_buildStatusBanner(), const SizedBox(height: 20)],

        // --------------------------------------------------------
        // KPI CARDS
        // --------------------------------------------------------
        _buildKpiSection(isMobile: isMobile, isSmallMobile: isSmallMobile),

        SizedBox(height: isMobile ? 28 : 26),

        // --------------------------------------------------------
        // MONITORED SERVICES
        // --------------------------------------------------------
        _buildSectionTitle('MONITORED SERVICES'),

        const SizedBox(height: 12),

        _buildServicesCard(isMobile: isMobile, isSmallMobile: isSmallMobile),

        SizedBox(height: isMobile ? 28 : 26),

        // --------------------------------------------------------
        // ACTIVE INCIDENTS
        // --------------------------------------------------------
        _buildSectionTitle('ACTIVE INCIDENTS'),

        const SizedBox(height: 12),

        _buildIncidentCard(isMobile: isMobile),
      ],
    );
  }

  // ============================================================
  // STATUS BANNER
  // ============================================================

  Widget _buildStatusBanner() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 86),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3DF),
        borderRadius: BorderRadius.circular(14),
        border: const Border(
          left: BorderSide(color: systemHealthAmber, width: 5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: const BoxDecoration(
              color: systemHealthAmber,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 18),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Platform status: Degraded',
                  style: TextStyle(
                    color: systemHealthNavy,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  '1 service degraded, 5 healthy · Last refreshed 1s ago',
                  style: TextStyle(color: systemHealthMuted, fontSize: 13),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF996118),
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 10),

              const Text(
                'Aggregated from 6 sources',
                style: TextStyle(
                  color: Color(0xFF996118),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // KPI SECTION
  // ============================================================

  Widget _buildKpiSection({
    required bool isMobile,
    required bool isSmallMobile,
  }) {
    if (isMobile) {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        childAspectRatio: isSmallMobile ? 1.18 : 1.25,
        children: const [
          SystemHealthKpiCard(
            value: '5',
            label: 'HEALTHY',
            valueColor: systemHealthGreen,
          ),

          SystemHealthKpiCard(
            value: '1',
            label: 'DEGRADED',
            valueColor: systemHealthAmber,
          ),

          SystemHealthKpiCard(
            value: '0',
            label: 'FAILED',
            valueColor: systemHealthRed,
          ),

          SystemHealthKpiCard(
            value: '99.98%',
            label: 'Aggregate uptime (30d)',
            gradient: true,
          ),
        ],
      );
    }

    return const Row(
      children: [
        Expanded(
          child: SystemHealthKpiCard(
            value: '5',
            label: 'HEALTHY',
            valueColor: systemHealthGreen,
          ),
        ),

        SizedBox(width: 20),

        Expanded(
          child: SystemHealthKpiCard(
            value: '1',
            label: 'DEGRADED',
            valueColor: systemHealthAmber,
          ),
        ),

        SizedBox(width: 20),

        Expanded(
          child: SystemHealthKpiCard(
            value: '0',
            label: 'FAILED',
            valueColor: systemHealthRed,
          ),
        ),

        SizedBox(width: 20),

        Expanded(
          child: SystemHealthKpiCard(
            value: '99.98%',
            label: 'Aggregate uptime (30d)',
            gradient: true,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: systemHealthMuted,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    );
  }

  // ============================================================
  // SERVICES CARD
  // ============================================================

  Widget _buildServicesCard({
    required bool isMobile,
    required bool isSmallMobile,
  }) {
    const List<SystemHealthService> services = [
      SystemHealthService(
        name: 'Auth Service',
        description: 'JWT issuance · SSO · MFA',
        uptime: '99.99%',
        healthy: true,
      ),

      SystemHealthService(
        name: 'API Gateway',
        description: 'avg. response 118ms',
        uptime: '99.98%',
        healthy: true,
      ),

      SystemHealthService(
        name: 'Database Cluster',
        description: 'elevated replication lag — investigating',
        uptime: '99.91%',
        healthy: false,
      ),

      SystemHealthService(
        name: 'Message Queue',
        description: '0 dead-letter events',
        uptime: '100%',
        healthy: true,
      ),

      SystemHealthService(
        name: 'Object Storage',
        description: 'files & document uploads',
        uptime: '99.99%',
        healthy: true,
      ),

      SystemHealthService(
        name: 'AI Engine',
        description: 'Copilot & automation inference',
        uptime: '99.95%',
        healthy: true,
      ),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: systemHealthBorder),
        borderRadius: BorderRadius.circular(isMobile ? 20 : 14),
      ),
      child: Column(
        children: [
          for (int i = 0; i < services.length; i++)
            _buildServiceRow(
              services[i],
              isMobile: isMobile,
              isSmallMobile: isSmallMobile,
              isLast: i == services.length - 1,
            ),
        ],
      ),
    );
  }

  // ============================================================
  // SERVICE ROW
  // ============================================================

  Widget _buildServiceRow(
    SystemHealthService service, {
    required bool isMobile,
    required bool isSmallMobile,
    required bool isLast,
  }) {
    // ==========================================================
    // MOBILE SERVICE ROW
    // ==========================================================

    if (isMobile) {
      return Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 118),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(bottom: BorderSide(color: Color(0xFFE8EEF4))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // STATUS DOT
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: service.healthy ? systemHealthGreenDot : Colors.orange,
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(width: 22),

            // SERVICE INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    service.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: systemHealthNavy,
                      fontSize: 19,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    service.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: systemHealthMuted,
                      fontSize: 15,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // UPTIME
            Flexible(
              flex: 0,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isSmallMobile ? 82 : 110),
                child: Text(
                  '${service.uptime} uptime',
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: systemHealthMuted,
                    fontSize: isSmallMobile ? 11 : 14,
                    height: 1.3,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // ==========================================================
    // DESKTOP SERVICE ROW
    // ==========================================================

    return Container(
      width: double.infinity,
      height: 63,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: systemHealthBorder)),
      ),
      child: Row(
        children: [
          // STATUS DOT
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: service.healthy ? systemHealthGreenDot : systemHealthAmber,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 17),

          // SERVICE INFO
          Expanded(
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    service.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: systemHealthNavy,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Flexible(
                  flex: 2,
                  child: Text(
                    service.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: systemHealthMuted,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // UPTIME
          Text(
            '${service.uptime} uptime',
            style: const TextStyle(
              color: systemHealthNavy,
              fontSize: 13,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INCIDENT CARD
  // ============================================================

  Widget _buildIncidentCard({required bool isMobile}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: systemHealthBorder),
        borderRadius: BorderRadius.circular(isMobile ? 20 : 14),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 34 : 22,
        vertical: isMobile ? 24 : 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // INCIDENT DOT
          Container(
            width: isMobile ? 15 : 12,
            height: isMobile ? 15 : 12,
            margin: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
              color: systemHealthAmber,
              shape: BoxShape.circle,
            ),
          ),

          SizedBox(width: isMobile ? 22 : 17),

          // INCIDENT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Database Cluster — elevated replication lag',
                  maxLines: isMobile ? 3 : 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: systemHealthNavy,
                    fontSize: isMobile ? 19 : 15,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: isMobile ? 10 : 5),

                Text(
                  'Read replicas are lagging ~2.4s behind primary. '
                  'No tenant-facing errors detected; monitoring for '
                  'further drift.',
                  style: TextStyle(
                    color: systemHealthMuted,
                    fontSize: isMobile ? 16 : 13,
                    height: isMobile ? 1.55 : 1.35,
                  ),
                ),

                SizedBox(height: isMobile ? 14 : 6),

                const Text(
                  'Started 08:12 UTC · investigating',
                  style: TextStyle(
                    color: systemHealthLightMuted,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// KPI CARD
// ============================================================

class SystemHealthKpiCard extends StatelessWidget {
  final String value;
  final String label;
  final Color? valueColor;
  final bool gradient;

  const SystemHealthKpiCard({
    super.key,
    required this.value,
    required this.label,
    this.valueColor,
    this.gradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 92),
      decoration: BoxDecoration(
        gradient: gradient
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [systemHealthBlue1, systemHealthBlue2],
              )
            : null,
        color: gradient ? null : Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: gradient ? null : Border.all(color: systemHealthBorder),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              style: TextStyle(
                color: gradient ? Colors.white : valueColor,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ),

          const SizedBox(height: 7),

          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: gradient
                  ? const Color(0xFFE1E7FF)
                  : const Color(0xFF6B7F95),
              fontSize: gradient ? 11 : 10,
              fontWeight: gradient ? FontWeight.w600 : FontWeight.w500,
              letterSpacing: gradient ? 0 : 0.7,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SERVICE MODEL
// ============================================================

class SystemHealthService {
  final String name;
  final String description;
  final String uptime;
  final bool healthy;

  const SystemHealthService({
    required this.name,
    required this.description,
    required this.uptime,
    required this.healthy,
  });
}
