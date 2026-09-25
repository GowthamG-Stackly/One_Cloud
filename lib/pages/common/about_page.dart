// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../providers/user_provider.dart';
// import '../../app_theme.dart';

// class AboutPage extends ConsumerWidget {
//   const AboutPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(userProvider);

//     return Scaffold(
//       backgroundColor: const Color(0xFFF4FAF6),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               LayoutBuilder(
//                 builder: (context, size) {
//                   final mobile = size.maxWidth < 700;

//                   return Column(
//                     children: [
//                       _hero(context, mobile, user),
//                       _features(mobile),
//                       _stats(mobile),
//                       const SizedBox(height: 25),
//                     ],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _hero(BuildContext context, bool mobile, dynamic user) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.fromLTRB(
//         mobile ? 20 : 55,
//         mobile ? 35 : 55,
//         mobile ? 20 : 55,
//         35,
//       ),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(colors: [AppTheme.lightBlue, Colors.white]),
//       ),
//       child: Column(
//         children: [
//           const Icon(
//             Icons.inventory_2_rounded,
//             size: 55,
//             color: AppTheme.primaryBlue,
//           ),

//           const SizedBox(height: 15),

//           Text(
//             'Welcome to GT-InStock',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: mobile ? 30 : 44,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),

//           const SizedBox(height: 8),

//           Text(
//             'One Cloud Enterprise Platform',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: mobile ? 25 : 30,
//               fontWeight: FontWeight.w600,
//               color: AppTheme.darkNavy,
//             ),
//           ),

//           const SizedBox(height: 8),

//           Text(
//             'Smart Inventory Management for a Better Tomorrow',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: mobile ? 16 : 21,
//               fontWeight: FontWeight.w600,
//               color: AppTheme.darkNavy,
//             ),
//           ),

//           const SizedBox(height: 14),

//           const Text(
//             'Manage inventory, track stock movements, monitor availability '
//             'and make informed decisions — all in one place.',
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
//           ),

//           const SizedBox(height: 28),

//           Container(
//             constraints: const BoxConstraints(maxWidth: 720),
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(18),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: .07),
//                   blurRadius: 18,
//                   offset: const Offset(0, 6),
//                 ),
//               ],
//             ),
//             child: Wrap(
//               alignment: WrapAlignment.center,
//               spacing: 30,
//               runSpacing: 15,
//               children: [
//                 const Icon(
//                   Icons.account_circle,
//                   size: 55,
//                   color: AppTheme.primaryBlue,
//                 ),

//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       user.name.isEmpty ? 'GT-InStock User' : user.name,
//                       style: const TextStyle(
//                         fontSize: 19,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 3),

//                     Text(
//                       user.email.isEmpty ? 'No email available' : user.email,
//                       style: const TextStyle(color: Colors.black87),
//                     ),

//                     const Text(
//                       'Inventory Management User',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),

//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 15,
//                     vertical: 9,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppTheme.lightBlue,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: const Text(
//                     '●  Active User',
//                     style: TextStyle(
//                       color: AppTheme.darkNavy,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 22),
//         ],
//       ),
//     );
//   }

//   Widget _features(bool mobile) {
//     final features = [
//       [
//         Icons.inventory_2,
//         'Inventory Management',
//         'Organize and manage your products efficiently.',
//       ],
//       [
//         Icons.swap_horiz,
//         'Stock Movement',
//         'Track incoming and outgoing stock easily.',
//       ],
//       [
//         Icons.bar_chart,
//         'Reports & Analytics',
//         'Get insights and make better inventory decisions.',
//       ],
//       [
//         Icons.notifications_active,
//         'Stock Alerts',
//         'Stay informed about low-stock availability.',
//       ],
//     ];

//     return Padding(
//       padding: EdgeInsets.all(mobile ? 18 : 40),
//       child: Wrap(
//         spacing: 20,
//         runSpacing: 20,
//         alignment: WrapAlignment.center,
//         children: features.map((item) {
//           return Container(
//             width: mobile ? double.infinity : 255,
//             padding: const EdgeInsets.all(22),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 color: AppTheme.primaryBlue.withValues(alpha: .12),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: .04),
//                   blurRadius: 12,
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Icon(
//                   item[0] as IconData,
//                   color: AppTheme.primaryBlue,
//                   size: 32,
//                 ),

//                 const SizedBox(height: 12),

//                 Text(
//                   item[1] as String,
//                   style: const TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 7),

//                 Text(
//                   item[2] as String,
//                   style: const TextStyle(color: Colors.black54, height: 1.4),
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _stats(bool mobile) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: mobile ? 18 : 40),
//       padding: const EdgeInsets.all(22),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Wrap(
//         alignment: WrapAlignment.spaceEvenly,
//         spacing: 35,
//         runSpacing: 18,
//         children: const [
//           _Stat(Icons.inventory, '1,248+', 'Products Tracked'),
//           _Stat(Icons.people, '50+', 'Active Users'),
//           _Stat(Icons.verified, '99%', 'System Uptime'),
//           _Stat(Icons.trending_up, 'Better', 'Inventory Control'),
//         ],
//       ),
//     );
//   }
// }

// class _Stat extends StatelessWidget {
//   final IconData icon;
//   final String value;
//   final String title;

//   const _Stat(this.icon, this.value, this.title);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, color: AppTheme.primaryBlue, size: 30),

//         const SizedBox(width: 20),

//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               value,
//               style: const TextStyle(
//                 color: AppTheme.darkNavy,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             Text(title, style: const TextStyle(color: Colors.black54)),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_theme.dart';
import '../../providers/user_provider.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return LayoutBuilder(
      builder: (context, size) {
        final mobile = size.maxWidth < 700;
        final tablet = size.maxWidth >= 700 && size.maxWidth < 1100;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            mobile
                ? 16
                : tablet
                ? 24
                : 36,
            mobile ? 20 : 28,
            mobile
                ? 16
                : tablet
                ? 24
                : 36,
            35,
          ),
          child: Column(
            children: [
              _hero(context, mobile, tablet, user),
              const SizedBox(height: 22),
              _features(mobile, tablet),
              const SizedBox(height: 22),
              _stats(mobile, tablet),
              const SizedBox(height: 22),
              _platformOverview(mobile, tablet),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // HERO
  // ---------------------------------------------------------------------------

  Widget _hero(BuildContext context, bool mobile, bool tablet, dynamic user) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        mobile
            ? 20
            : tablet
            ? 35
            : 55,
        mobile ? 28 : 42,
        mobile
            ? 20
            : tablet
            ? 35
            : 55,
        mobile ? 28 : 38,
      ),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        children: [
          // Platform icon
          Container(
            width: mobile ? 64 : 78,
            height: mobile ? 64 : 78,
            decoration: BoxDecoration(
              color: AppTheme.ink3.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.cloud_outlined,
              size: mobile ? 34 : 42,
              color: AppTheme.ink3,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            'Welcome to OneCloud',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: mobile
                  ? 28
                  : tablet
                  ? 36
                  : 44,
              height: 1.15,
              fontWeight: FontWeight.w800,
              color: AppTheme.ink,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'OneCloud Enterprise Platform',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: mobile
                  ? 20
                  : tablet
                  ? 25
                  : 30,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: AppTheme.ink3,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'One unified platform for modern enterprise operations',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: mobile
                  ? 14
                  : tablet
                  ? 16
                  : 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.text,
            ),
          ),

          const SizedBox(height: 12),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 780),
            child: const Text(
              'OneCloud brings enterprise functions together in a '
              'connected platform, helping organizations manage people, '
              'customers, operations, finance, workflows, documents, '
              'analytics, integrations, and security from one place.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textMuted,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: 28),

          _userCard(mobile: mobile, user: user),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // USER CARD
  // ---------------------------------------------------------------------------

  Widget _userCard({required bool mobile, required dynamic user}) {
    final name = user.name.isEmpty ? 'OneCloud User' : user.name;
    final email = user.email.isEmpty ? 'No email available' : user.email;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 820),
      padding: EdgeInsets.all(mobile ? 16 : 20),
      decoration: BoxDecoration(
        color: AppTheme.paperDim,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: mobile
          ? Column(
              children: [
                _userAvatar(),
                const SizedBox(height: 14),
                _userDetails(name, email, center: true),
                const SizedBox(height: 14),
                _activeBadge(),
              ],
            )
          : Row(
              children: [
                _userAvatar(),
                const SizedBox(width: 16),
                Expanded(child: _userDetails(name, email, center: false)),
                const SizedBox(width: 16),
                _activeBadge(),
              ],
            ),
    );
  }

  Widget _userAvatar() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppTheme.ink3.withValues(alpha: 0.10),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person_outline_rounded,
        size: 28,
        color: AppTheme.ink3,
      ),
    );
  }

  Widget _userDetails(String name, String email, {required bool center}) {
    return Column(
      crossAxisAlignment: center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          name,
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            fontSize: 17,
            color: AppTheme.text,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
        ),
        const SizedBox(height: 3),
        const Text(
          'OneCloud Enterprise Platform User',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: AppTheme.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _activeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: AppTheme.tealData.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.tealData.withValues(alpha: 0.25)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: AppTheme.tealData),
          SizedBox(width: 7),
          Text(
            'Active User',
            style: TextStyle(
              color: AppTheme.tealData,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PLATFORM FEATURES
  // ---------------------------------------------------------------------------

  Widget _features(bool mobile, bool tablet) {
    final features = [
      const _FeatureData(
        icon: Icons.admin_panel_settings_outlined,
        title: 'Platform Administration',
        description:
            'Manage platform configuration, organizations, users, '
            'licenses, resources, settings, and system health.',
        accent: AppTheme.ink3,
      ),
      const _FeatureData(
        icon: Icons.people_outline_rounded,
        title: 'HRMS',
        description:
            'Manage employees, attendance, leave, payroll, recruitment, '
            'performance, learning, and employee services.',
        accent: AppTheme.tealData,
      ),
      const _FeatureData(
        icon: Icons.handshake_outlined,
        title: 'CRM',
        description:
            'Manage leads, opportunities, accounts, contacts, activities, '
            'quotations, campaigns, and customer relationships.',
        accent: AppTheme.amberAI,
      ),
      const _FeatureData(
        icon: Icons.inventory_2_outlined,
        title: 'ERP',
        description:
            'Connect inventory, warehouses, procurement, vendors, sales '
            'orders, dispatch, and operational processes.',
        accent: AppTheme.ink3,
      ),
      const _FeatureData(
        icon: Icons.account_balance_outlined,
        title: 'Finance & Accounting',
        description:
            'Support general ledger, accounts payable, accounts receivable, '
            'budgeting, costing, reconciliation, and financial reporting.',
        accent: AppTheme.tealData,
      ),
      const _FeatureData(
        icon: Icons.account_tree_outlined,
        title: 'Workflow & Automation',
        description:
            'Build approvals, business rules, automated processes, tasks, '
            'triggers, SLAs, and workflow templates.',
        accent: AppTheme.amberAI,
      ),
      const _FeatureData(
        icon: Icons.description_outlined,
        title: 'Document Management',
        description:
            'Organize enterprise documents with repositories, versions, '
            'access controls, tagging, retention, and audit trails.',
        accent: AppTheme.ink3,
      ),
      const _FeatureData(
        icon: Icons.psychology_outlined,
        title: 'Enterprise AI',
        description:
            'Bring intelligent assistance, enterprise insights, and '
            'AI-powered capabilities into business operations.',
        accent: AppTheme.amberAI,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          eyebrow: 'PLATFORM CAPABILITIES',
          title: 'Everything connected in OneCloud',
          description:
              'OneCloud provides a unified foundation for managing '
              'enterprise operations across multiple business domains.',
        ),

        const SizedBox(height: 16),

        LayoutBuilder(
          builder: (context, constraints) {
            final columns = mobile
                ? 1
                : tablet
                ? 2
                : 4;

            const gap = 14.0;

            final cardWidth = columns == 1
                ? constraints.maxWidth
                : (constraints.maxWidth - (gap * (columns - 1))) / columns;

            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: features
                  .map(
                    (feature) => SizedBox(
                      width: cardWidth,
                      child: _FeatureCard(feature: feature),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // STATS
  // ---------------------------------------------------------------------------

  Widget _stats(bool mobile, bool tablet) {
    const stats = [
      _PlatformStat(
        icon: Icons.apps_outlined,
        value: '15+',
        title: 'Enterprise Modules',
        accent: AppTheme.ink3,
      ),
      _PlatformStat(
        icon: Icons.business_outlined,
        value: 'Multi',
        title: 'Tenant Architecture',
        accent: AppTheme.tealData,
      ),
      _PlatformStat(
        icon: Icons.auto_awesome_outlined,
        value: 'AI',
        title: 'Enterprise Intelligence',
        accent: AppTheme.amberAI,
      ),
      _PlatformStat(
        icon: Icons.security_outlined,
        value: 'Secure',
        title: 'Enterprise Security',
        accent: AppTheme.ink3,
      ),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(mobile ? 18 : 24),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = mobile
              ? 1
              : tablet
              ? 2
              : 4;

          const gap = 12.0;

          final itemWidth = columns == 1
              ? constraints.maxWidth
              : (constraints.maxWidth - (gap * (columns - 1))) / columns;

          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: stats
                .map(
                  (stat) => SizedBox(
                    width: itemWidth,
                    child: _PlatformStatCard(stat: stat),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PLATFORM OVERVIEW
  // ---------------------------------------------------------------------------

  Widget _platformOverview(bool mobile, bool tablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(mobile ? 18 : 25),
      decoration: BoxDecoration(
        color: AppTheme.ink,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ONECLOUD ENTERPRISE PLATFORM',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1.1,
              color: AppTheme.amberAI,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'A connected foundation for enterprise operations',
            style: TextStyle(
              fontSize: mobile ? 22 : 28,
              height: 1.2,
              color: AppTheme.paper,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'OneCloud is designed to bring core enterprise capabilities '
            'together through a unified platform architecture. Teams can '
            'work across business functions while maintaining centralized '
            'administration, security, workflows, data, and integrations.',
            style: TextStyle(
              fontSize: 13,
              height: 1.6,
              color: AppTheme.textMuted,
            ),
          ),

          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              final columns = mobile
                  ? 1
                  : tablet
                  ? 2
                  : 3;

              const gap = 12.0;

              final width = columns == 1
                  ? constraints.maxWidth
                  : (constraints.maxWidth - (gap * (columns - 1))) / columns;

              const items = [
                _OverviewItem(
                  icon: Icons.hub_outlined,
                  title: 'Unified Platform',
                  description: 'Connect business domains through one enterprise platform.',
                ),
                _OverviewItem(
                  icon: Icons.sync_alt_rounded,
                  title: 'Connected Operations',
                  description: 'Enable information and workflows to move across modules.',
                ),
                _OverviewItem(
                  icon: Icons.security_outlined,
                  title: 'Enterprise Foundation',
                  description: 'Centralize security, administration, configuration, and access.',
                ),
              ];

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: items
                    .map(
                      (item) => SizedBox(
                        width: width,
                        child: _OverviewCard(item: item),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION HEADER
// =============================================================================

class _SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String description;

  const _SectionHeader({
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: const TextStyle(
            fontSize: 10,
            letterSpacing: 1,
            color: AppTheme.ink3,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 21,
            color: AppTheme.text,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              height: 1.5,
              color: AppTheme.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// FEATURE CARD
// =============================================================================

class _FeatureCard extends StatelessWidget {
  final _FeatureData feature;

  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.paper,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(13),
        child: Container(
          constraints: const BoxConstraints(minHeight: 190),
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppTheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: feature.accent.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(feature.icon, size: 21, color: feature.accent),
              ),

              const SizedBox(height: 14),

              Text(
                feature.title,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.text,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 7),

              Text(
                feature.description,
                style: const TextStyle(
                  fontSize: 10.5,
                  height: 1.5,
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureData {
  final IconData icon;
  final String title;
  final String description;
  final Color accent;

  const _FeatureData({
    required this.icon,
    required this.title,
    required this.description,
    required this.accent,
  });
}

// =============================================================================
// PLATFORM STAT CARD
// =============================================================================

class _PlatformStatCard extends StatelessWidget {
  final _PlatformStat stat;

  const _PlatformStatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.paperDim,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: stat.accent.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(stat.icon, size: 20, color: stat.accent),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.value,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppTheme.text,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  stat.title,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w500,
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

class _PlatformStat {
  final IconData icon;
  final String value;
  final String title;
  final Color accent;

  const _PlatformStat({
    required this.icon,
    required this.value,
    required this.title,
    required this.accent,
  });
}

// =============================================================================
// OVERVIEW CARD
// =============================================================================

class _OverviewCard extends StatelessWidget {
  final _OverviewItem item;

  const _OverviewCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.paper.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.paper.withValues(alpha: 0.10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppTheme.amberAI.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(item.icon, size: 19, color: AppTheme.amberAI),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.paper,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.45,
                    color: AppTheme.textMuted,
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

class _OverviewItem {
  final IconData icon;
  final String title;
  final String description;

  const _OverviewItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
