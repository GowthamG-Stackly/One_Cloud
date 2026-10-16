// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../providers/user_provider.dart';

// class SuperAdminDashboardPage extends ConsumerWidget {
//   const SuperAdminDashboardPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(userProvider);

//     final userName = user.name.trim().isEmpty
//         ? 'Super Admin'
//         : user.name.trim();

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return _SuperAdminDashboardBody(
//           width: constraints.maxWidth,
//           userName: userName,
//         );
//       },
//     );
//   }
// }

// // ================================================================
// // DASHBOARD BODY
// // ================================================================

// class _SuperAdminDashboardBody extends StatelessWidget {
//   final double width;
//   final String userName;

//   const _SuperAdminDashboardBody({required this.width, required this.userName});

//   bool get isMobile => width < 700;

//   double get horizontalPadding {
//     if (width < 360) return 10;
//     if (width < 700) return 14;
//     if (width < 1100) return 20;
//     return 28;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.fromLTRB(
//           horizontalPadding,
//           14,
//           horizontalPadding,
//           24,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _SuperAdminDashboardHeader(userName: userName, isMobile: isMobile),

//             const SizedBox(height: 18),

//             const _SuperAdminSectionTitle(title: 'PLATFORM OVERVIEW'),

//             const SizedBox(height: 10),

//             _SuperAdminPlatformOverview(width: width),

//             const SizedBox(height: 18),

//             const _SuperAdminSectionTitle(title: 'SYSTEM STATUS'),

//             const SizedBox(height: 10),

//             _SuperAdminSystemStatus(width: width),

//             const SizedBox(height: 18),

//             const _SuperAdminResourceUtilization(),

//             const SizedBox(height: 18),

//             const _SuperAdminSectionTitle(title: 'QUICK NAVIGATION'),

//             const SizedBox(height: 10),

//             _SuperAdminQuickNavigation(width: width),

//             const SizedBox(height: 18),

//             if (isMobile) ...[
//               const _SuperAdminSecurityAlerts(),

//               const SizedBox(height: 16),

//               const _SuperAdminRecentActivities(),

//               const SizedBox(height: 18),

//               const _SuperAdminMobileExportButton(),
//             ] else
//               const _SuperAdminDesktopBottomSection(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ================================================================
// // HEADER
// // ================================================================

// class _SuperAdminDashboardHeader extends StatelessWidget {
//   final String userName;
//   final bool isMobile;

//   const _SuperAdminDashboardHeader({
//     required this.userName,
//     required this.isMobile,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             Text(
//               isMobile ? 'Dashboard' : 'Super Admin Dashboard',
//               style: const TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xFF172033),
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(height: 7),

//         if (isMobile)
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Expanded(
//                     child: Text(
//                       'Super Admin Dashboard',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 21,
//                         fontWeight: FontWeight.w800,
//                         color: Color(0xFF172033),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   _SuperAdminSmallButton(
//                     icon: Icons.refresh_rounded,
//                     onTap: () {},
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 4),

//               Text(
//                 'Welcome back, $userName',
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(fontSize: 11, color: Color(0xFF7B8794)),
//               ),
//             ],
//           )
//         else
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Super Admin Dashboard',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w800,
//                         color: Color(0xFF172033),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(width: 12),

//               OutlinedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.refresh_rounded, size: 15),
//                 label: const Text('Refresh', style: TextStyle(fontSize: 11)),
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: const Color(0xFF172033),
//                   side: const BorderSide(color: Color(0xFFDCE2E8)),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 10,
//                   ),
//                 ),
//               ),

//               const SizedBox(width: 8),

//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.download_outlined, size: 15),
//                 label: const Text(
//                   'Export report',
//                   style: TextStyle(fontSize: 11),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF2939E8),
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 13,
//                     vertical: 10,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//         if (!isMobile)
//           Padding(
//             padding: const EdgeInsets.only(top: 4),
//             child: Text(
//               'Welcome back, $userName',
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(fontSize: 11, color: Color(0xFF7B8794)),
//             ),
//           ),
//       ],
//     );
//   }
// }

// // ================================================================
// // SECTION TITLE
// // ================================================================

// class _SuperAdminSectionTitle extends StatelessWidget {
//   final String title;

//   const _SuperAdminSectionTitle({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 12,
//         letterSpacing: 0.6,
//         fontWeight: FontWeight.w700,
//         color: Color(0xFF68788B),
//       ),
//     );
//   }
// }

// // ================================================================
// // PLATFORM OVERVIEW
// // ================================================================

// class _SuperAdminPlatformOverview extends StatelessWidget {
//   final double width;

//   const _SuperAdminPlatformOverview({required this.width});

//   @override
//   Widget build(BuildContext context) {
//     final cards = [
//       const _SuperAdminKpiCard(
//         title: 'TOTAL USERS',
//         value: '96,412',
//         subtitle: '↑ 1.8% this month',
//         icon: Icons.people_outline_rounded,
//         iconColor: Color(0xFF19A568),
//         iconBackground: Color(0xFFE9F8F0),
//       ),
//       const _SuperAdminKpiCard(
//         title: 'ACTIVE USERS',
//         value: '78,930',
//         subtitle: '● 4,215 online now',
//         icon: Icons.check_circle_outline_rounded,
//         iconColor: Color(0xFF336CF4),
//         iconBackground: Color(0xFFEAF0FF),
//       ),
//       const _SuperAdminKpiCard(
//         title: 'ORGANIZATIONS',
//         value: '1,842',
//         subtitle: '↑ 4.2% this month',
//         icon: Icons.apartment_outlined,
//         iconColor: Color(0xFFD58B1D),
//         iconBackground: Color(0xFFFFF3DE),
//       ),
//       const _SuperAdminKpiCard(
//         title: 'LICENSES ACTIVE',
//         value: '2,140',
//         subtitle: '27 expiring < 30 days',
//         icon: Icons.description_outlined,
//         iconColor: Colors.white,
//         iconBackground: Colors.white,
//         primary: true,
//       ),
//     ];

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final available = constraints.maxWidth;

//         int columns;

//         if (available < 520) {
//           columns = 1;
//         } else if (available < 900) {
//           columns = 2;
//         } else {
//           columns = 4;
//         }

//         const gap = 14.0;

//         final cardWidth = (available - ((columns - 1) * gap)) / columns;

//         return Wrap(
//           spacing: gap,
//           runSpacing: gap,
//           children: cards.map((card) {
//             return SizedBox(width: cardWidth, child: card);
//           }).toList(),
//         );
//       },
//     );
//   }
// }

// // ================================================================
// // KPI CARD
// // ================================================================

// class _SuperAdminKpiCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final String subtitle;
//   final IconData icon;
//   final Color iconColor;
//   final Color iconBackground;
//   final bool primary;

//   const _SuperAdminKpiCard({
//     required this.title,
//     required this.value,
//     required this.subtitle,
//     required this.icon,
//     required this.iconColor,
//     required this.iconBackground,
//     this.primary = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 128,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: primary
//             ? const LinearGradient(
//                 colors: [Color(0xFF303FE4), Color(0xFF111847)],
//               )
//             : null,
//         color: primary ? null : Colors.white,
//         borderRadius: BorderRadius.circular(11),
//         border: primary ? null : Border.all(color: const Color(0xFFDCE3E9)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 9,
//                     letterSpacing: 0.8,
//                     color: primary
//                         ? const Color(0xFFDCE3FF)
//                         : const Color(0xFF728094),
//                   ),
//                 ),
//               ),

//               const SizedBox(width: 8),

//               Container(
//                 width: 30,
//                 height: 30,
//                 decoration: BoxDecoration(
//                   color: iconBackground,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   icon,
//                   size: 17,
//                   color: primary ? const Color(0xFF18255F) : iconColor,
//                 ),
//               ),
//             ],
//           ),

//           const Spacer(),

//           Text(
//             value,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w800,
//               color: primary ? Colors.white : const Color(0xFF172033),
//             ),
//           ),

//           const SizedBox(height: 5),

//           Text(
//             subtitle,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               fontSize: 10,
//               fontWeight: FontWeight.w600,
//               color: primary ? Colors.white : const Color(0xFF21945F),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ================================================================
// // SYSTEM STATUS
// // ================================================================

// class _SuperAdminSystemStatus extends StatelessWidget {
//   final double width;

//   const _SuperAdminSystemStatus({required this.width});

//   @override
//   Widget build(BuildContext context) {
//     final statuses = [
//       const _SuperAdminStatusCard(
//         title: 'SERVER STATUS',
//         value: 'Healthy',
//         color: Color(0xFF29A66A),
//       ),
//       const _SuperAdminStatusCard(
//         title: 'DATABASE',
//         value: 'Connected',
//         color: Color(0xFF29A66A),
//       ),
//       const _SuperAdminStatusCard(
//         title: 'API GATEWAY',
//         value: 'Running',
//         color: Color(0xFF29A66A),
//       ),
//       const _SuperAdminStatusCard(
//         title: 'STORAGE',
//         value: '68% used',
//         color: Color(0xFFD38A1B),
//       ),
//     ];

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final available = constraints.maxWidth;

//         final columns = available < 520
//             ? 1
//             : available < 900
//             ? 2
//             : 4;

//         const gap = 14.0;

//         final cardWidth = (available - ((columns - 1) * gap)) / columns;

//         return Wrap(
//           spacing: gap,
//           runSpacing: gap,
//           children: statuses.map((status) {
//             return SizedBox(width: cardWidth, child: status);
//           }).toList(),
//         );
//       },
//     );
//   }
// }

// // ================================================================
// // STATUS CARD
// // ================================================================

// class _SuperAdminStatusCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final Color color;

//   const _SuperAdminStatusCard({
//     required this.title,
//     required this.value,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 67,
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: const Color(0xFFDCE3E9)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontSize: 8,
//               letterSpacing: 0.7,
//               color: Color(0xFF7B8794),
//             ),
//           ),

//           const Spacer(),

//           Row(
//             children: [
//               Container(
//                 width: 8,
//                 height: 8,
//                 decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//               ),

//               const SizedBox(width: 6),

//               Expanded(
//                 child: Text(
//                   value,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF172033),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ================================================================
// // RESOURCE UTILIZATION
// // ================================================================

// class _SuperAdminResourceUtilization extends StatelessWidget {
//   const _SuperAdminResourceUtilization();

//   @override
//   Widget build(BuildContext context) {
//     return _SuperAdminPanel(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const _SuperAdminPanelTitle(title: 'RESOURCE UTILIZATION'),

//           const SizedBox(height: 16),

//           LayoutBuilder(
//             builder: (context, constraints) {
//               if (constraints.maxWidth < 600) {
//                 return const Column(
//                   children: [
//                     _SuperAdminResource(
//                       title: 'CPU usage',
//                       value: '42%',
//                       progress: 0.42,
//                     ),

//                     SizedBox(height: 15),

//                     _SuperAdminResource(
//                       title: 'Memory usage',
//                       value: '57%',
//                       progress: 0.57,
//                     ),

//                     SizedBox(height: 15),

//                     _SuperAdminResource(
//                       title: 'Storage',
//                       value: '68%',
//                       progress: 0.68,
//                       green: true,
//                     ),
//                   ],
//                 );
//               }

//               const gap = 28.0;

//               final itemWidth = (constraints.maxWidth - (gap * 2)) / 3;

//               return Row(
//                 children: [
//                   SizedBox(
//                     width: itemWidth,
//                     child: const _SuperAdminResource(
//                       title: 'CPU usage',
//                       value: '42%',
//                       progress: 0.42,
//                     ),
//                   ),

//                   const SizedBox(width: gap),

//                   SizedBox(
//                     width: itemWidth,
//                     child: const _SuperAdminResource(
//                       title: 'Memory usage',
//                       value: '57%',
//                       progress: 0.57,
//                     ),
//                   ),

//                   const SizedBox(width: gap),

//                   SizedBox(
//                     width: itemWidth,
//                     child: const _SuperAdminResource(
//                       title: 'Storage',
//                       value: '68%',
//                       progress: 0.68,
//                       green: true,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ================================================================
// // RESOURCE
// // ================================================================

// class _SuperAdminResource extends StatelessWidget {
//   final String title;
//   final String value;
//   final double progress;
//   final bool green;

//   const _SuperAdminResource({
//     required this.title,
//     required this.value,
//     required this.progress,
//     this.green = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(fontSize: 11, color: Color(0xFF334155)),
//               ),
//             ),

//             Text(
//               value,
//               style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
//             ),
//           ],
//         ),

//         const SizedBox(height: 7),

//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: LinearProgressIndicator(
//             value: progress,
//             minHeight: 7,
//             backgroundColor: const Color(0xFFEFF2F4),
//             valueColor: AlwaysStoppedAnimation<Color>(
//               green ? const Color(0xFF55BFA0) : const Color(0xFF285B7F),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ================================================================
// // QUICK NAVIGATION
// // ================================================================

// class _SuperAdminQuickNavigation extends StatelessWidget {
//   final double width;

//   const _SuperAdminQuickNavigation({required this.width});

//   @override
//   Widget build(BuildContext context) {
//     final actions = [
//       const _SuperAdminQuickCard(
//         title: 'User Management',
//         subtitle: 'Manage accounts & roles',
//         icon: Icons.people_outline_rounded,
//         green: true,
//       ),
//       const _SuperAdminQuickCard(
//         title: 'Platform Settings',
//         subtitle: 'Global configuration',
//         icon: Icons.settings_outlined,
//       ),
//       const _SuperAdminQuickCard(
//         title: 'License Management',
//         subtitle: 'Renewals & seat usage',
//         icon: Icons.description_outlined,
//       ),
//       const _SuperAdminQuickCard(
//         title: 'Audit Logs',
//         subtitle: 'Track admin actions',
//         icon: Icons.article_outlined,
//       ),
//       const _SuperAdminQuickCard(
//         title: 'Notifications',
//         subtitle: 'Notification centre',
//         icon: Icons.notifications_none_rounded,
//         green: true,
//       ),
//       const _SuperAdminQuickCard(
//         title: 'Backup & Recovery',
//         subtitle: 'Snapshots & restore',
//         icon: Icons.inventory_2_outlined,
//         green: true,
//       ),
//       const _SuperAdminQuickCard(
//         title: 'Reports',
//         subtitle: 'Platform analytics',
//         icon: Icons.show_chart_rounded,
//         green: true,
//       ),
//       const _SuperAdminQuickCard(
//         title: 'Security Center',
//         subtitle: 'Threats & policies',
//         icon: Icons.shield_outlined,
//         green: true,
//       ),
//     ];

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final available = constraints.maxWidth;

//         int columns;

//         if (available < 360) {
//           columns = 1;
//         } else if (available < 900) {
//           columns = 2;
//         } else if (available < 1150) {
//           columns = 3;
//         } else {
//           columns = 4;
//         }

//         const gap = 14.0;

//         final cardWidth = (available - ((columns - 1) * gap)) / columns;

//         return Wrap(
//           spacing: gap,
//           runSpacing: gap,
//           children: actions.map((card) {
//             return SizedBox(width: cardWidth, child: card);
//           }).toList(),
//         );
//       },
//     );
//   }
// }

// // ================================================================
// // QUICK CARD
// // ================================================================

// class _SuperAdminQuickCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final bool green;

//   const _SuperAdminQuickCard({
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     this.green = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 108,
//       padding: const EdgeInsets.all(13),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: const Color(0xFFDCE3E9)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 32,
//             height: 32,
//             decoration: BoxDecoration(
//               color: green ? const Color(0xFFEAF8F1) : const Color(0xFFEAF0FF),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               icon,
//               size: 17,
//               color: green ? const Color(0xFF24A574) : const Color(0xFF334BE5),
//             ),
//           ),

//           const Spacer(),

//           Text(
//             title,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontSize: 10.5,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF172033),
//             ),
//           ),

//           const SizedBox(height: 3),

//           Text(
//             subtitle,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(fontSize: 8.5, color: Color(0xFF8190A0)),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ================================================================
// // DESKTOP BOTTOM SECTION
// // ================================================================

// class _SuperAdminDesktopBottomSection extends StatelessWidget {
//   const _SuperAdminDesktopBottomSection();

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         const gap = 16.0;

//         final leftWidth = (constraints.maxWidth * 0.57) - (gap / 2);

//         final rightWidth = constraints.maxWidth - leftWidth - gap;

//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: leftWidth,
//               child: const _SuperAdminSecurityAlerts(),
//             ),

//             const SizedBox(width: gap),

//             SizedBox(
//               width: rightWidth,
//               child: const _SuperAdminRecentActivities(),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// // ================================================================
// // SECURITY ALERTS
// // ================================================================

// class _SuperAdminSecurityAlerts extends StatelessWidget {
//   const _SuperAdminSecurityAlerts();

//   @override
//   Widget build(BuildContext context) {
//     return _SuperAdminPanel(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const _SuperAdminPanelHeading(title: 'Security alerts'),

//           const SizedBox(height: 12),

//           const _SuperAdminAlert(
//             icon: Icons.warning_amber_rounded,
//             title: '27 licenses expiring within 30 days',
//             subtitle: 'Review renewals before Sep 22.',
//             background: Color(0xFFFFF2DA),
//             color: Color(0xFFA86D19),
//           ),

//           const SizedBox(height: 8),

//           const _SuperAdminAlert(
//             icon: Icons.info_outline_rounded,
//             title: '3 organizations awaiting activation approval',
//             subtitle: 'Submitted via self-signup, pending review.',
//             background: Color(0xFFEAF1FF),
//             color: Color(0xFF2E67D8),
//           ),

//           const SizedBox(height: 8),

//           const _SuperAdminAlert(
//             icon: Icons.lock_outline_rounded,
//             title: 'Unusual login pattern detected',
//             subtitle: 'Delta Retail Group – 3 logins from new locations.',
//             background: Color(0xFFFFF2DA),
//             color: Color(0xFFA86D19),
//           ),

//           const SizedBox(height: 10),

//           SizedBox(
//             width: double.infinity,
//             height: 34,
//             child: OutlinedButton(
//               onPressed: () {},
//               child: const Text(
//                 'View all alerts',
//                 style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ================================================================
// // ALERT
// // ================================================================

// class _SuperAdminAlert extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final Color background;
//   final Color color;

//   const _SuperAdminAlert({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.background,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: background,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 17, color: color),

//           const SizedBox(width: 8),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                     color: color,
//                   ),
//                 ),

//                 const SizedBox(height: 3),

//                 Text(
//                   subtitle,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontSize: 9, color: color),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ================================================================
// // RECENT ACTIVITIES
// // ================================================================

// class _SuperAdminRecentActivities extends StatelessWidget {
//   const _SuperAdminRecentActivities();

//   @override
//   Widget build(BuildContext context) {
//     return _SuperAdminPanel(
//       padding: EdgeInsets.zero,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
//             child: Row(
//               children: [
//                 const Expanded(
//                   child: Text(
//                     'Recent login activities',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                       color: Color(0xFF172033),
//                     ),
//                   ),
//                 ),

//                 Text(
//                   'Last 24 hours',
//                   style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ),

//           const Divider(height: 1),

//           const _SuperAdminActivity(
//             icon: Icons.check_rounded,
//             background: Color(0xFFEAF8F1),
//             color: Color(0xFF2AA56D),
//             title: 'Ana Ferreira signed in from Lisbon, PT',
//             time: '14 minutes ago',
//           ),

//           const _SuperAdminActivity(
//             icon: Icons.circle,
//             background: Color(0xFFFFF4DF),
//             color: Color(0xFFD59A28),
//             title: 'Unrecognized device signed in to Delta Retail Group',
//             time: '52 minutes ago',
//           ),

//           const _SuperAdminActivity(
//             icon: Icons.check_rounded,
//             background: Color(0xFFEAF8F1),
//             color: Color(0xFF2AA56D),
//             title: 'Renu Kapoor (Super Admin) signed in',
//             time: '3 hours ago',
//           ),

//           const _SuperAdminActivity(
//             icon: Icons.close_rounded,
//             background: Color(0xFFFFE8EA),
//             color: Color(0xFFE34B55),
//             title: '5 failed attempts on j.mehta@acmecorp.com — locked',
//             time: 'Yesterday, 18:15',
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ================================================================
// // ACTIVITY
// // ================================================================

// class _SuperAdminActivity extends StatelessWidget {
//   final IconData icon;
//   final Color background;
//   final Color color;
//   final String title;
//   final String time;

//   const _SuperAdminActivity({
//     required this.icon,
//     required this.background,
//     required this.color,
//     required this.title,
//     required this.time,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       decoration: const BoxDecoration(
//         border: Border(bottom: BorderSide(color: Color(0xFFE7EBEF))),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 25,
//             height: 25,
//             decoration: BoxDecoration(
//               color: background,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(icon, size: 13, color: color),
//           ),

//           const SizedBox(width: 9),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF172033),
//                   ),
//                 ),

//                 const SizedBox(height: 3),

//                 Text(
//                   time,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 8.5,
//                     color: Color(0xFF8792A2),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ================================================================
// // COMMON PANEL
// // ================================================================

// class _SuperAdminPanel extends StatelessWidget {
//   final Widget child;
//   final EdgeInsetsGeometry padding;

//   const _SuperAdminPanel({
//     required this.child,
//     this.padding = const EdgeInsets.all(17),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: padding,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(11),
//         border: Border.all(color: const Color(0xFFDCE3E9)),
//       ),
//       child: child,
//     );
//   }
// }

// // ================================================================
// // PANEL TITLE
// // ================================================================

// class _SuperAdminPanelTitle extends StatelessWidget {
//   final String title;

//   const _SuperAdminPanelTitle({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 11,
//         letterSpacing: 0.6,
//         fontWeight: FontWeight.w700,
//         color: Color(0xFF68788B),
//       ),
//     );
//   }
// }

// // ================================================================
// // PANEL HEADING
// // ================================================================

// class _SuperAdminPanelHeading extends StatelessWidget {
//   final String title;

//   const _SuperAdminPanelHeading({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w800,
//         color: Color(0xFF172033),
//       ),
//     );
//   }
// }

// // ================================================================
// // SMALL BUTTON
// // ================================================================

// class _SuperAdminSmallButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;

//   const _SuperAdminSmallButton({required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(7),
//       child: Container(
//         width: 35,
//         height: 35,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(7),
//           border: Border.all(color: const Color(0xFFDCE3E9)),
//         ),
//         child: Icon(icon, size: 18, color: const Color(0xFF566474)),
//       ),
//     );
//   }
// }

// // ================================================================
// // MOBILE EXPORT
// // ================================================================

// class _SuperAdminMobileExportButton extends StatelessWidget {
//   const _SuperAdminMobileExportButton();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 40,
//       child: ElevatedButton.icon(
//         onPressed: () {},
//         icon: const Icon(Icons.download_outlined, size: 14),
//         label: const Text(
//           'Export',
//           style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF2437D9),
//           foregroundColor: Colors.white,
//           elevation: 0,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:typed_data';

import 'package:excel/excel.dart' as xl;
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pw;

import '../../providers/user_provider.dart';

class SuperAdminDashboardPage extends ConsumerWidget {
  const SuperAdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final userName = user.name.trim().isEmpty
        ? 'Super Admin'
        : user.name.trim();

    return LayoutBuilder(
      builder: (context, constraints) {
        return _SuperAdminDashboardBody(
          width: constraints.maxWidth,
          userName: userName,
        );
      },
    );
  }
}

// ================================================================
// SUPER ADMIN ALERTS + REPORT EXPORT
// ================================================================

const _superAdminAlerts = <_SuperAdminAlertData>[
  _SuperAdminAlertData(
    'Critical',
    '27 licenses expiring within 30 days',
    'Review renewals before the expiry date.',
    'Licensing',
    'Now',
  ),
  _SuperAdminAlertData(
    'Warning',
    '3 organizations awaiting activation approval',
    'New organizations are waiting for administrator review.',
    'Organizations',
    '12 min ago',
  ),
  _SuperAdminAlertData(
    'Warning',
    'Unusual login pattern detected',
    'Delta Retail Group — 3 logins from new locations.',
    'Security',
    '28 min ago',
  ),
  _SuperAdminAlertData(
    'Info',
    'Storage utilization reached 68%',
    'Storage is approaching the configured monitoring threshold.',
    'Infrastructure',
    '1 hour ago',
  ),
  _SuperAdminAlertData(
    'Info',
    'New tenant registration received',
    'A new organization has submitted its registration.',
    'Organizations',
    '2 hours ago',
  ),
];

class _SuperAdminAlertData {
  final String severity, title, description, category, time;
  const _SuperAdminAlertData(
    this.severity,
    this.title,
    this.description,
    this.category,
    this.time,
  );
}

void _openSuperAdminExport(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => const _SuperAdminExportPage()),
  );
}

void _showAllSuperAdminAlerts(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) {
      final screen = MediaQuery.sizeOf(dialogContext);
      final compact = screen.width < 600;
      return Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: compact ? 10 : 18,
          vertical: compact ? 12 : 24,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 620,
            maxHeight: screen.height * (compact ? 0.82 : 0.88),
          ),
          child: Padding(
            padding: EdgeInsets.all(compact ? 12 : 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'All security alerts',
                            style: TextStyle(
                              fontSize: compact ? 15 : 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF172033),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Review current platform alerts and their severity.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF7B8794),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Close',
                      onPressed: () => Navigator.pop(dialogContext),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _alertCountChip(
                      '${_superAdminAlerts.length} total',
                      const Color(0xFFEAF0FF),
                      const Color(0xFF2E50C8),
                    ),
                    _alertCountChip(
                      '${_superAdminAlerts.where((a) => a.severity == 'Critical').length} critical',
                      const Color(0xFFFFE8E8),
                      const Color(0xFFC73535),
                    ),
                    _alertCountChip(
                      '${_superAdminAlerts.where((a) => a.severity == 'Warning').length} warnings',
                      const Color(0xFFFFF2DA),
                      const Color(0xFFA86D19),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Divider(height: 1),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: _superAdminAlerts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, index) {
                      final alert = _superAdminAlerts[index];
                      final color = alert.severity == 'Critical'
                          ? const Color(0xFFC73535)
                          : alert.severity == 'Warning'
                          ? const Color(0xFFA86D19)
                          : const Color(0xFF2E67D8);
                      final bg = alert.severity == 'Critical'
                          ? const Color(0xFFFFEEEE)
                          : alert.severity == 'Warning'
                          ? const Color(0xFFFFF7E8)
                          : const Color(0xFFEAF1FF);
                      final compactAlert =
                          MediaQuery.sizeOf(dialogContext).width < 600;
                      return Container(
                        padding: EdgeInsets.all(compactAlert ? 9 : 13),
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              alert.severity == 'Critical'
                                  ? Icons.error_outline_rounded
                                  : alert.severity == 'Warning'
                                  ? Icons.warning_amber_rounded
                                  : Icons.info_outline_rounded,
                              color: color,
                              size: compactAlert ? 17 : 21,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    alert.title,
                                    style: TextStyle(
                                      fontSize: compactAlert ? 11 : 13,
                                      fontWeight: FontWeight.w700,
                                      color: color,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    alert.description,
                                    style: TextStyle(
                                      fontSize: compactAlert ? 10 : 12,
                                      color: color,
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    '${alert.category}  •  ${alert.time}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: color.withValues(alpha: .85),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              alert.severity.toUpperCase(),
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Close alerts'),
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

Widget _alertCountChip(String text, Color bg, Color fg) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
  decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
  child: Text(
    text,
    style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w700),
  ),
);

class _SuperAdminExportPage extends StatefulWidget {
  const _SuperAdminExportPage();
  @override
  State<_SuperAdminExportPage> createState() => _SuperAdminExportPageState();
}

class _SuperAdminExportPageState extends State<_SuperAdminExportPage> {
  String _format = 'PDF Document';
  String _interval = 'Last 30 Days';
  bool _includeCharts = false;
  bool _includeTables = false;
  bool _exporting = false;

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 700;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                mobile ? 10 : 22,
                mobile ? 6 : 12,
                mobile ? 10 : 22,
                mobile ? 7 : 12,
              ),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFDCE3E9))),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: mobile ? 21 : 27,
                    ),
                    style: IconButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFDCE3E9)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fixedSize: Size(mobile ? 34 : 42, mobile ? 34 : 42),
                    ),
                  ),
                  SizedBox(width: mobile ? 6 : 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Export Super Admin Dashboard Report',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: mobile ? 15 : 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF20243A),
                          ),
                        ),
                        SizedBox(height: mobile ? 2 : 3),
                        Text(
                          'Download a detailed summary of platform insights and performance.',
                          style: TextStyle(
                            fontSize: mobile ? 9 : 11,
                            height: 1.15,
                            color: Color(0xFF70798A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  mobile ? 10 : 24,
                  mobile ? 10 : 16,
                  mobile ? 10 : 24,
                  mobile ? 10 : 16,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'File Format',
                          style: TextStyle(
                            fontSize: mobile ? 13 : 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF20232B),
                          ),
                        ),
                        SizedBox(height: mobile ? 8 : 14),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final options = <(String, IconData)>[
                              ('PDF Document', Icons.picture_as_pdf_outlined),
                              ('CSV (Raw Data)', Icons.data_object_outlined),
                              ('Excel Spreadsheet', Icons.table_chart_outlined),
                            ];
                            final narrow = constraints.maxWidth < 520;
                            return Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: options
                                  .map(
                                    (option) => SizedBox(
                                      width: narrow
                                          ? constraints.maxWidth
                                          : (constraints.maxWidth - 20) / 3,
                                      child: InkWell(
                                        onTap: () =>
                                            setState(() => _format = option.$1),
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          height: mobile ? 76 : 116,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: _format == option.$1
                                                  ? const Color(0xFF2939FF)
                                                  : const Color(0xFFDCE3E9),
                                              width: _format == option.$1
                                                  ? 1.7
                                                  : 1.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                option.$2,
                                                size: mobile ? 24 : 36,
                                                color: const Color(0xFF707887),
                                              ),
                                              SizedBox(height: mobile ? 4 : 10),
                                              Text(
                                                option.$1,
                                                style: TextStyle(
                                                  fontSize: mobile ? 10 : 12,
                                                  color: Color(0xFF707887),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                        SizedBox(height: mobile ? 14 : 24),
                        const Text(
                          'Telemetry & Usage Interval',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF20232B),
                          ),
                        ),
                        SizedBox(height: mobile ? 7 : 13),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: ['Today', 'Last 7 Days', 'Last 30 Days']
                              .map(
                                (v) => ChoiceChip(
                                  label: Text(v),
                                  selected: _interval == v,
                                  onSelected: (_) =>
                                      setState(() => _interval = v),
                                  selectedColor: const Color(0xFF242B62),
                                  backgroundColor: const Color(0xFFF3F5F8),
                                  labelStyle: TextStyle(
                                    color: _interval == v
                                        ? Colors.white
                                        : const Color(0xFF172033),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  showCheckmark: false,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    side: BorderSide.none,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        SizedBox(height: mobile ? 12 : 22),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(mobile ? 10 : 18),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFDCE3E9)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Options',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  'Include Charts',
                                  style: TextStyle(
                                    fontSize: mobile ? 12 : 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: const Text(
                                  'Embed visual usage summaries in output',
                                  style: TextStyle(fontSize: 12),
                                ),
                                value: _includeCharts,
                                onChanged: (v) =>
                                    setState(() => _includeCharts = v),
                                activeTrackColor: const Color(0xFF2939E8),
                              ),
                              const Divider(height: 1),
                              SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  'Include Detailed Tables',
                                  style: TextStyle(
                                    fontSize: mobile ? 12 : 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: const Text(
                                  'Append alert and activity data rows',
                                  style: TextStyle(fontSize: 12),
                                ),
                                value: _includeTables,
                                onChanged: (v) =>
                                    setState(() => _includeTables = v),
                                activeTrackColor: const Color(0xFF2939E8),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'The export includes the dashboard KPIs, system status, resource utilization and security alerts. Detailed tables add alert and recent activity rows.',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF70798A),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                mobile ? 10 : 24,
                mobile ? 5 : 8,
                mobile ? 10 : 24,
                mobile ? 5 : 8,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFDCE3E9))),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _exporting
                              ? null
                              : () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(0, mobile ? 36 : 44),
                            side: const BorderSide(color: Color(0xFFDCE3E9)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: _exporting ? null : _downloadExport,
                          icon: _exporting
                              ? const SizedBox(
                                  width: 17,
                                  height: 17,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.download_rounded, size: 19),
                          label: Text(
                            _exporting
                                ? 'Preparing file...'
                                : 'Download Export',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(0, mobile ? 36 : 44),
                            backgroundColor: const Color(0xFF182CE5),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
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

  List<List<String>> _rows() {
    final rows = <List<String>>[
      ['Section', 'Metric', 'Value', 'Details'],
      ['Platform Overview', 'Total Users', '96,412', ''],
      ['Platform Overview', 'Active Users', '78,930', '4,215 online now'],
      ['Platform Overview', 'Organizations', '1,842', '+4.2% this month'],
      [
        'Platform Overview',
        'Licenses Active',
        '2,140',
        '27 expiring within 30 days',
      ],
      ['System Status', 'Server Status', 'Healthy', ''],
      ['System Status', 'Database', 'Connected', ''],
      ['System Status', 'API Gateway', 'Running', ''],
      ['System Status', 'Storage', '68% used', ''],
      ['Resource Utilization', 'CPU Usage', '42%', ''],
      ['Resource Utilization', 'Memory Usage', '57%', ''],
      ['Resource Utilization', 'Storage', '68%', ''],
    ];
    if (_includeCharts)
      rows.addAll([
        ['Usage Summary', 'CPU', '42%', 'Text-based chart: ████░░░░░░'],
        ['Usage Summary', 'Memory', '57%', 'Text-based chart: ██████░░░░'],
        ['Usage Summary', 'Storage', '68%', 'Text-based chart: ███████░░░'],
      ]);
    if (_includeTables) {
      for (final a in _superAdminAlerts) {
        rows.add([
          'Security Alert - ${a.severity}',
          a.title,
          a.time,
          '${a.category}: ${a.description}',
        ]);
      }
      rows.addAll([
        [
          'Recent Activity',
          'Ana Ferreira signed in from Lisbon, PT',
          '14 minutes ago',
          'Successful login',
        ],
        [
          'Recent Activity',
          'Unrecognized device signed in to Delta Retail Group',
          '52 minutes ago',
          'Review login',
        ],
        [
          'Recent Activity',
          'Renu Kapoor (Super Admin) signed in',
          '3 hours ago',
          'Successful login',
        ],
        [
          'Recent Activity',
          '5 failed attempts on j.mehta@acmecorp.com — locked',
          'Yesterday, 18:15',
          'Account locked',
        ],
      ]);
    }
    return rows;
  }

  Future<void> _downloadExport() async {
    setState(() => _exporting = true);
    try {
      final rows = _rows();
      final stamp = DateTime.now().toIso8601String().substring(0, 10);
      final baseName = 'onecloud_super_admin_dashboard_$stamp';
      late Uint8List bytes;
      late String extension;
      late MimeType mimeType;
      if (_format == 'CSV (Raw Data)') {
        final csv = rows
            .map(
              (row) => row
                  .map((cell) {
                    final escapedCell = cell.replaceAll('"', '""');
                    return '"$escapedCell"';
                  })
                  .join(','),
            )
            .join('\r\n');
        bytes = Uint8List.fromList([
          0xEF,
          0xBB,
          0xBF,
          ...utf8.encode(
            'Report Period,$_interval\r\nGenerated,$stamp\r\n\r\n$csv',
          ),
        ]);
        extension = 'csv';
        mimeType = MimeType.csv;
      } else if (_format == 'Excel Spreadsheet') {
        final workbook = xl.Excel.createExcel();
        // Rename the default active sheet so Excel opens directly on the
        // worksheet that contains the exported report data.
        const sheetName = 'Dashboard Report';
        workbook.rename('Sheet1', sheetName);
        final sheet = workbook[sheetName];
        sheet.appendRow([
          xl.TextCellValue('Report Period'),
          xl.TextCellValue(_interval),
        ]);
        sheet.appendRow([
          xl.TextCellValue('Generated'),
          xl.TextCellValue(stamp),
        ]);
        sheet.appendRow([xl.TextCellValue('')]);
        for (final row in rows) {
          sheet.appendRow(
            row.map<xl.CellValue>((cell) => xl.TextCellValue(cell)).toList(),
          );
        }
        final result = workbook.encode();
        if (result == null) throw Exception('Could not create Excel workbook.');
        bytes = Uint8List.fromList(result);
        extension = 'xlsx';
        mimeType = MimeType.microsoftExcel;
      } else {
        final doc = pw.Document();
        doc.addPage(
          pw.MultiPage(
            build: (ctx) => [
              pw.Text(
                'OneCloud — Super Admin Dashboard Report',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text('Reporting period: $_interval    Generated: $stamp'),
              pw.SizedBox(height: 16),
              pw.TableHelper.fromTextArray(
                data: rows
                    .map(
                      (row) => row
                          .map(
                            (cell) => cell
                                .replaceAll('—', '-')
                                .replaceAll('–', '-')
                                .replaceAll('█', '#')
                                .replaceAll('░', '-'),
                          )
                          .toList(),
                    )
                    .toList(),
                headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: const pdf.PdfColor(1, 1, 1),
                ),
                headerDecoration: const pw.BoxDecoration(
                  color: pdf.PdfColor(.12, .18, .55),
                ),
                cellStyle: const pw.TextStyle(fontSize: 8),
                cellPadding: const pw.EdgeInsets.all(5),
                border: pw.TableBorder.all(
                  color: const pdf.PdfColor(.82, .85, .9),
                ),
              ),
            ],
          ),
        );
        bytes = Uint8List.fromList(await doc.save());
        extension = 'pdf';
        mimeType = MimeType.pdf;
      }
      await FileSaver.instance.saveFile(
        name: baseName,
        bytes: bytes,
        fileExtension: extension,
        mimeType: mimeType,
      );
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Report downloaded as $baseName.$extension'),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not download report: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }
}

// ================================================================
// DASHBOARD BODY
// ================================================================

class _SuperAdminDashboardBody extends StatelessWidget {
  final double width;
  final String userName;

  const _SuperAdminDashboardBody({required this.width, required this.userName});

  bool get isMobile => width < 700;

  double get horizontalPadding {
    if (width < 360) return 10;
    if (width < 700) return 14;
    if (width < 1100) return 20;
    return 28;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          14,
          horizontalPadding,
          24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SuperAdminDashboardHeader(userName: userName, isMobile: isMobile),

            const SizedBox(height: 18),

            const _SuperAdminSectionTitle(title: 'PLATFORM OVERVIEW'),

            const SizedBox(height: 10),

            _SuperAdminPlatformOverview(width: width),

            const SizedBox(height: 18),

            const _SuperAdminSectionTitle(title: 'SYSTEM STATUS'),

            const SizedBox(height: 10),

            _SuperAdminSystemStatus(width: width),

            const SizedBox(height: 18),

            const _SuperAdminResourceUtilization(),

            const SizedBox(height: 18),

            const _SuperAdminSectionTitle(title: 'QUICK NAVIGATION'),

            const SizedBox(height: 10),

            _SuperAdminQuickNavigation(width: width),

            const SizedBox(height: 18),

            if (isMobile) ...[
              const _SuperAdminSecurityAlerts(),

              const SizedBox(height: 16),

              const _SuperAdminRecentActivities(),

              const SizedBox(height: 18),

              const _SuperAdminMobileExportButton(),
            ] else
              const _SuperAdminDesktopBottomSection(),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// HEADER
// ================================================================

class _SuperAdminDashboardHeader extends StatelessWidget {
  final String userName;
  final bool isMobile;

  const _SuperAdminDashboardHeader({
    required this.userName,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              isMobile ? 'Dashboard' : 'Super Admin Dashboard',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF172033),
              ),
            ),
          ],
        ),

        const SizedBox(height: 7),

        if (isMobile)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text(
                      'Super Admin Dashboard',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF172033),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _SuperAdminSmallButton(
                    icon: Icons.refresh_rounded,
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                'Welcome back, $userName',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11, color: Color(0xFF7B8794)),
              ),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Super Admin Dashboard',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF172033),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh_rounded, size: 15),
                label: const Text('Refresh', style: TextStyle(fontSize: 11)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF172033),
                  side: const BorderSide(color: Color(0xFFDCE2E8)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              ElevatedButton.icon(
                // onPressed: () => _openSuperAdminExport(context),
                onPressed: () {
                  debugPrint('EXPORT REPORT BUTTON CLICKED');
                  _openSuperAdminExport(context);
                },
                icon: const Icon(Icons.download_outlined, size: 15),
                label: const Text(
                  'Export report',
                  style: TextStyle(fontSize: 11),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2939E8),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
                ),
              ),
            ],
          ),

        if (!isMobile)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Welcome back, $userName',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: Color(0xFF7B8794)),
            ),
          ),
      ],
    );
  }
}

// ================================================================
// SECTION TITLE
// ================================================================

class _SuperAdminSectionTitle extends StatelessWidget {
  final String title;

  const _SuperAdminSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        letterSpacing: 0.6,
        fontWeight: FontWeight.w700,
        color: Color(0xFF68788B),
      ),
    );
  }
}

// ================================================================
// PLATFORM OVERVIEW
// ================================================================

class _SuperAdminPlatformOverview extends StatelessWidget {
  final double width;

  const _SuperAdminPlatformOverview({required this.width});

  @override
  Widget build(BuildContext context) {
    final cards = [
      const _SuperAdminKpiCard(
        title: 'TOTAL USERS',
        value: '96,412',
        subtitle: '↑ 1.8% this month',
        icon: Icons.people_outline_rounded,
        iconColor: Color(0xFF19A568),
        iconBackground: Color(0xFFE9F8F0),
      ),
      const _SuperAdminKpiCard(
        title: 'ACTIVE USERS',
        value: '78,930',
        subtitle: '● 4,215 online now',
        icon: Icons.check_circle_outline_rounded,
        iconColor: Color(0xFF336CF4),
        iconBackground: Color(0xFFEAF0FF),
      ),
      const _SuperAdminKpiCard(
        title: 'ORGANIZATIONS',
        value: '1,842',
        subtitle: '↑ 4.2% this month',
        icon: Icons.apartment_outlined,
        iconColor: Color(0xFFD58B1D),
        iconBackground: Color(0xFFFFF3DE),
      ),
      const _SuperAdminKpiCard(
        title: 'LICENSES ACTIVE',
        value: '2,140',
        subtitle: '27 expiring < 30 days',
        icon: Icons.description_outlined,
        iconColor: Colors.white,
        iconBackground: Colors.white,
        primary: true,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth;

        int columns;

        if (available < 520) {
          columns = 1;
        } else if (available < 900) {
          columns = 2;
        } else {
          columns = 4;
        }

        const gap = 14.0;

        final cardWidth = (available - ((columns - 1) * gap)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: cards.map((card) {
            return SizedBox(width: cardWidth, child: card);
          }).toList(),
        );
      },
    );
  }
}

// ================================================================
// KPI CARD
// ================================================================

class _SuperAdminKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final bool primary;

  const _SuperAdminKpiCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: primary
            ? const LinearGradient(
                colors: [Color(0xFF303FE4), Color(0xFF111847)],
              )
            : null,
        color: primary ? null : Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: primary ? null : Border.all(color: const Color(0xFFDCE3E9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 0.8,
                    color: primary
                        ? const Color(0xFFDCE3FF)
                        : const Color(0xFF728094),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 17,
                  color: primary ? const Color(0xFF18255F) : iconColor,
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: primary ? Colors.white : const Color(0xFF172033),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: primary ? Colors.white : const Color(0xFF21945F),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// SYSTEM STATUS
// ================================================================

class _SuperAdminSystemStatus extends StatelessWidget {
  final double width;

  const _SuperAdminSystemStatus({required this.width});

  @override
  Widget build(BuildContext context) {
    final statuses = [
      const _SuperAdminStatusCard(
        title: 'SERVER STATUS',
        value: 'Healthy',
        color: Color(0xFF29A66A),
      ),
      const _SuperAdminStatusCard(
        title: 'DATABASE',
        value: 'Connected',
        color: Color(0xFF29A66A),
      ),
      const _SuperAdminStatusCard(
        title: 'API GATEWAY',
        value: 'Running',
        color: Color(0xFF29A66A),
      ),
      const _SuperAdminStatusCard(
        title: 'STORAGE',
        value: '68% used',
        color: Color(0xFFD38A1B),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth;

        final columns = available < 520
            ? 1
            : available < 900
            ? 2
            : 4;

        const gap = 14.0;

        final cardWidth = (available - ((columns - 1) * gap)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: statuses.map((status) {
            return SizedBox(width: cardWidth, child: status);
          }).toList(),
        );
      },
    );
  }
}

// ================================================================
// STATUS CARD
// ================================================================

class _SuperAdminStatusCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _SuperAdminStatusCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDCE3E9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 8,
              letterSpacing: 0.7,
              color: Color(0xFF7B8794),
            ),
          ),

          const Spacer(),

          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ================================================================
// RESOURCE UTILIZATION
// ================================================================

class _SuperAdminResourceUtilization extends StatelessWidget {
  const _SuperAdminResourceUtilization();

  @override
  Widget build(BuildContext context) {
    return _SuperAdminPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SuperAdminPanelTitle(title: 'RESOURCE UTILIZATION'),

          const SizedBox(height: 16),

          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return const Column(
                  children: [
                    _SuperAdminResource(
                      title: 'CPU usage',
                      value: '42%',
                      progress: 0.42,
                    ),

                    SizedBox(height: 15),

                    _SuperAdminResource(
                      title: 'Memory usage',
                      value: '57%',
                      progress: 0.57,
                    ),

                    SizedBox(height: 15),

                    _SuperAdminResource(
                      title: 'Storage',
                      value: '68%',
                      progress: 0.68,
                      green: true,
                    ),
                  ],
                );
              }

              const gap = 28.0;

              final itemWidth = (constraints.maxWidth - (gap * 2)) / 3;

              return Row(
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: const _SuperAdminResource(
                      title: 'CPU usage',
                      value: '42%',
                      progress: 0.42,
                    ),
                  ),

                  const SizedBox(width: gap),

                  SizedBox(
                    width: itemWidth,
                    child: const _SuperAdminResource(
                      title: 'Memory usage',
                      value: '57%',
                      progress: 0.57,
                    ),
                  ),

                  const SizedBox(width: gap),

                  SizedBox(
                    width: itemWidth,
                    child: const _SuperAdminResource(
                      title: 'Storage',
                      value: '68%',
                      progress: 0.68,
                      green: true,
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
}

// ================================================================
// RESOURCE
// ================================================================

class _SuperAdminResource extends StatelessWidget {
  final String title;
  final String value;
  final double progress;
  final bool green;

  const _SuperAdminResource({
    required this.title,
    required this.value,
    required this.progress,
    this.green = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 11, color: Color(0xFF334155)),
              ),
            ),

            Text(
              value,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ],
        ),

        const SizedBox(height: 7),

        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            backgroundColor: const Color(0xFFEFF2F4),
            valueColor: AlwaysStoppedAnimation<Color>(
              green ? const Color(0xFF55BFA0) : const Color(0xFF285B7F),
            ),
          ),
        ),
      ],
    );
  }
}

// ================================================================
// QUICK NAVIGATION
// ================================================================

class _SuperAdminQuickNavigation extends StatelessWidget {
  final double width;

  const _SuperAdminQuickNavigation({required this.width});

  @override
  Widget build(BuildContext context) {
    final actions = [
      const _SuperAdminQuickCard(
        title: 'User Management',
        subtitle: 'Manage accounts & roles',
        icon: Icons.people_outline_rounded,
        green: true,
      ),
      const _SuperAdminQuickCard(
        title: 'Platform Settings',
        subtitle: 'Global configuration',
        icon: Icons.settings_outlined,
      ),
      const _SuperAdminQuickCard(
        title: 'License Management',
        subtitle: 'Renewals & seat usage',
        icon: Icons.description_outlined,
      ),
      const _SuperAdminQuickCard(
        title: 'Audit Logs',
        subtitle: 'Track admin actions',
        icon: Icons.article_outlined,
      ),
      const _SuperAdminQuickCard(
        title: 'Notifications',
        subtitle: 'Notification centre',
        icon: Icons.notifications_none_rounded,
        green: true,
      ),
      const _SuperAdminQuickCard(
        title: 'Backup & Recovery',
        subtitle: 'Snapshots & restore',
        icon: Icons.inventory_2_outlined,
        green: true,
      ),
      const _SuperAdminQuickCard(
        title: 'Reports',
        subtitle: 'Platform analytics',
        icon: Icons.show_chart_rounded,
        green: true,
      ),
      const _SuperAdminQuickCard(
        title: 'Security Center',
        subtitle: 'Threats & policies',
        icon: Icons.shield_outlined,
        green: true,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth;

        int columns;

        if (available < 360) {
          columns = 1;
        } else if (available < 900) {
          columns = 2;
        } else if (available < 1150) {
          columns = 3;
        } else {
          columns = 4;
        }

        const gap = 14.0;

        final cardWidth = (available - ((columns - 1) * gap)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: actions.map((card) {
            return SizedBox(width: cardWidth, child: card);
          }).toList(),
        );
      },
    );
  }
}

// ================================================================
// QUICK CARD
// ================================================================

class _SuperAdminQuickCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool green;

  const _SuperAdminQuickCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.green = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDCE3E9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: green ? const Color(0xFFEAF8F1) : const Color(0xFFEAF0FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 17,
              color: green ? const Color(0xFF24A574) : const Color(0xFF334BE5),
            ),
          ),

          const Spacer(),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 8.5, color: Color(0xFF8190A0)),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// DESKTOP BOTTOM SECTION
// ================================================================

class _SuperAdminDesktopBottomSection extends StatelessWidget {
  const _SuperAdminDesktopBottomSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 16.0;

        final leftWidth = (constraints.maxWidth * 0.57) - (gap / 2);

        final rightWidth = constraints.maxWidth - leftWidth - gap;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: leftWidth,
              child: const _SuperAdminSecurityAlerts(),
            ),

            const SizedBox(width: gap),

            SizedBox(
              width: rightWidth,
              child: const _SuperAdminRecentActivities(),
            ),
          ],
        );
      },
    );
  }
}

// ================================================================
// SECURITY ALERTS
// ================================================================

class _SuperAdminSecurityAlerts extends StatelessWidget {
  const _SuperAdminSecurityAlerts();

  @override
  Widget build(BuildContext context) {
    return _SuperAdminPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SuperAdminPanelHeading(title: 'Security alerts'),

          const SizedBox(height: 12),

          const _SuperAdminAlert(
            icon: Icons.warning_amber_rounded,
            title: '27 licenses expiring within 30 days',
            subtitle: 'Review renewals before Sep 22.',
            background: Color(0xFFFFF2DA),
            color: Color(0xFFA86D19),
          ),

          const SizedBox(height: 8),

          const _SuperAdminAlert(
            icon: Icons.info_outline_rounded,
            title: '3 organizations awaiting activation approval',
            subtitle: 'Submitted via self-signup, pending review.',
            background: Color(0xFFEAF1FF),
            color: Color(0xFF2E67D8),
          ),

          const SizedBox(height: 8),

          const _SuperAdminAlert(
            icon: Icons.lock_outline_rounded,
            title: 'Unusual login pattern detected',
            subtitle: 'Delta Retail Group – 3 logins from new locations.',
            background: Color(0xFFFFF2DA),
            color: Color(0xFFA86D19),
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                _showAllSuperAdminAlerts(context);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 42),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.standard,
              ),
              child: const Text(
                'View all alerts',
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// ALERT
// ================================================================

class _SuperAdminAlert extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color background;
  final Color color;

  const _SuperAdminAlert({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.background,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 17, color: color),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 9, color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// RECENT ACTIVITIES
// ================================================================

class _SuperAdminRecentActivities extends StatelessWidget {
  const _SuperAdminRecentActivities();

  @override
  Widget build(BuildContext context) {
    return _SuperAdminPanel(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Recent login activities',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF172033),
                    ),
                  ),
                ),

                Text(
                  'Last 24 hours',
                  style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          const _SuperAdminActivity(
            icon: Icons.check_rounded,
            background: Color(0xFFEAF8F1),
            color: Color(0xFF2AA56D),
            title: 'Ana Ferreira signed in from Lisbon, PT',
            time: '14 minutes ago',
          ),

          const _SuperAdminActivity(
            icon: Icons.circle,
            background: Color(0xFFFFF4DF),
            color: Color(0xFFD59A28),
            title: 'Unrecognized device signed in to Delta Retail Group',
            time: '52 minutes ago',
          ),

          const _SuperAdminActivity(
            icon: Icons.check_rounded,
            background: Color(0xFFEAF8F1),
            color: Color(0xFF2AA56D),
            title: 'Renu Kapoor (Super Admin) signed in',
            time: '3 hours ago',
          ),

          const _SuperAdminActivity(
            icon: Icons.close_rounded,
            background: Color(0xFFFFE8EA),
            color: Color(0xFFE34B55),
            title: '5 failed attempts on j.mehta@acmecorp.com — locked',
            time: 'Yesterday, 18:15',
          ),
        ],
      ),
    );
  }
}

// ================================================================
// ACTIVITY
// ================================================================

class _SuperAdminActivity extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color color;
  final String title;
  final String time;

  const _SuperAdminActivity({
    required this.icon,
    required this.background,
    required this.color,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE7EBEF))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 13, color: color),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  time,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 8.5,
                    color: Color(0xFF8792A2),
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

// ================================================================
// COMMON PANEL
// ================================================================

class _SuperAdminPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _SuperAdminPanel({
    required this.child,
    this.padding = const EdgeInsets.all(17),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFDCE3E9)),
      ),
      child: child,
    );
  }
}

// ================================================================
// PANEL TITLE
// ================================================================

class _SuperAdminPanelTitle extends StatelessWidget {
  final String title;

  const _SuperAdminPanelTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 11,
        letterSpacing: 0.6,
        fontWeight: FontWeight.w700,
        color: Color(0xFF68788B),
      ),
    );
  }
}

// ================================================================
// PANEL HEADING
// ================================================================

class _SuperAdminPanelHeading extends StatelessWidget {
  final String title;

  const _SuperAdminPanelHeading({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: Color(0xFF172033),
      ),
    );
  }
}

// ================================================================
// SMALL BUTTON
// ================================================================

class _SuperAdminSmallButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SuperAdminSmallButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: const Color(0xFFDCE3E9)),
        ),
        child: Icon(icon, size: 18, color: const Color(0xFF566474)),
      ),
    );
  }
}

// ================================================================
// MOBILE EXPORT
// ================================================================

class _SuperAdminMobileExportButton extends StatelessWidget {
  const _SuperAdminMobileExportButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton.icon(
        onPressed: () => _openSuperAdminExport(context),
        icon: const Icon(Icons.download_outlined, size: 14),
        label: const Text(
          'Export',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2437D9),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
      ),
    );
  }
}
