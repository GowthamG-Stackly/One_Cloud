// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class NotificationPage extends StatefulWidget {
//   const NotificationPage({super.key});

//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage> {
//   static const Color primary = Color(0xFF3738F5);
//   static const Color textDark = Color(0xFF20243A);
//   static const Color textMuted = Color(0xFF70799C);
//   static const Color border = Color(0xFFE1E5EF);

//   int selectedTab = 0;

//   final List<_NotificationData> items = [
//     _NotificationData(
//       title: 'Acme Corp enterprise license expires in 5 days',
//       description:
//           'Review account usage and renewal terms before automatic suspension.',
//       time: '10m ago',
//       icon: Icons.warning_rounded,
//       iconColor: const Color(0xFF292D42),
//       background: const Color(0xFFFFF8E8),
//       outline: const Color(0xFFFFD777),
//     ),
//     _NotificationData(
//       title: 'NovaTech Solutions completed onboarding and SSO setup',
//       description: 'Primary tenant provisioned with 240 employee seats.',
//       time: '1h ago',
//       icon: Icons.check_rounded,
//       iconColor: const Color(0xFF20243A),
//       background: const Color(0xFFEAFBF2),
//       outline: const Color(0xFF9DE5BE),
//     ),
//     _NotificationData(
//       title: 'Admin login from unrecognized IP (194.26.29.11)',
//       description:
//           'Delta Retail Group — Frankfurt, DE. Geo-fence alert triggered.',
//       time: '3h ago',
//       icon: Icons.lock_outline_rounded,
//       iconColor: const Color(0xFF9B8A46),
//       background: const Color(0xFFFFEFEF),
//       outline: const Color(0xFFFFB2B2),
//     ),
//     _NotificationData(
//       title: '5 consecutive failed MFA attempts',
//       description: 'User j.mehta@acmecorp.com temporarily locked.',
//       time: '5h ago',
//       icon: Icons.block_rounded,
//       iconColor: const Color(0xFFD92D20),
//       background: const Color(0xFFFFF3E9),
//       outline: const Color(0xFFFFC28E),
//     ),
//     _NotificationData(
//       title: 'Monthly enterprise report is ready',
//       description: 'Your October platform usage report is available.',
//       time: '6h ago',
//       icon: Icons.assessment_outlined,
//       iconColor: primary,
//       background: const Color(0xFFEEF1FF),
//       outline: const Color(0xFFC8D0FF),
//       isRead: true,
//     ),
//     _NotificationData(
//       title: 'Database backup completed successfully',
//       description: 'All scheduled backups completed successfully.',
//       time: '8h ago',
//       icon: Icons.cloud_done_outlined,
//       iconColor: const Color(0xFF16865A),
//       background: const Color(0xFFEAFBF2),
//       outline: const Color(0xFF9DE5BE),
//       isRead: true,
//     ),
//     _NotificationData(
//       title: 'New team member added',
//       description: 'A new employee was added to your organization.',
//       time: '10h ago',
//       icon: Icons.person_add_alt_1_outlined,
//       iconColor: primary,
//       background: const Color(0xFFEEF1FF),
//       outline: const Color(0xFFC8D0FF),
//       isRead: true,
//     ),
//     _NotificationData(
//       title: 'Security policy updated',
//       description: 'Enterprise security settings were updated.',
//       time: '12h ago',
//       icon: Icons.security_outlined,
//       iconColor: const Color(0xFF16865A),
//       background: const Color(0xFFEAFBF2),
//       outline: const Color(0xFF9DE5BE),
//       isRead: true,
//     ),
//     _NotificationData(
//       title: 'Subscription usage reached 75%',
//       description: 'Review current usage and subscription limits.',
//       time: '1d ago',
//       icon: Icons.data_usage_outlined,
//       iconColor: primary,
//       background: const Color(0xFFEEF1FF),
//       outline: const Color(0xFFC8D0FF),
//       isRead: true,
//     ),
//     _NotificationData(
//       title: 'Workflow execution completed',
//       description: 'Your scheduled workflow ran successfully.',
//       time: '1d ago',
//       icon: Icons.account_tree_outlined,
//       iconColor: const Color(0xFF16865A),
//       background: const Color(0xFFEAFBF2),
//       outline: const Color(0xFF9DE5BE),
//       isRead: true,
//     ),
//     _NotificationData(
//       title: 'New integration connected',
//       description: 'A third-party integration was connected.',
//       time: '2d ago',
//       icon: Icons.hub_outlined,
//       iconColor: primary,
//       background: const Color(0xFFEEF1FF),
//       outline: const Color(0xFFC8D0FF),
//       isRead: true,
//     ),
//     _NotificationData(
//       title: 'Platform maintenance scheduled',
//       description: 'Scheduled maintenance information is available.',
//       time: '2d ago',
//       icon: Icons.schedule_outlined,
//       iconColor: const Color(0xFF9B8A46),
//       background: const Color(0xFFFFF8E8),
//       outline: const Color(0xFFFFD777),
//       isRead: true,
//     ),
//   ];

//   int get unreadCount => items.where((item) => !item.isRead).length;

//   List<_NotificationData> get visibleItems {
//     if (selectedTab == 1) {
//       return items.where((item) => !item.isRead).toList();
//     }
//     return items;
//   }

//   void _markAllRead() {
//     setState(() {
//       for (final item in items) {
//         item.isRead = true;
//       }
//     });
//   }

//   void _openNotification(_NotificationData item) {
//     setState(() {
//       item.isRead = true;
//     });
//   }

//   void _goBack() {
//     if (context.canPop()) {
//       context.pop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final isMobile = constraints.maxWidth < 600;

//         return Container(
//           color: Colors.white,
//           child: Column(
//             children: [
//               _buildHeader(isMobile),
//               _buildFilters(isMobile),
//               Expanded(
//                 child: visibleItems.isEmpty
//                     ? _buildEmptyState(isMobile)
//                     : _buildList(isMobile),
//               ),
//               _buildFooter(isMobile),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildHeader(bool isMobile) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(
//         horizontal: isMobile ? 16 : 28,
//         vertical: 18,
//       ),
//       decoration: const BoxDecoration(
//         border: Border(bottom: BorderSide(color: border)),
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: isMobile ? 48 : 64,
//             height: isMobile ? 48 : 64,
//             child: OutlinedButton(
//               onPressed: _goBack,
//               style: OutlinedButton.styleFrom(
//                 padding: EdgeInsets.zero,
//                 foregroundColor: Colors.black,
//                 side: const BorderSide(color: border, width: 1.5),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(17),
//                 ),
//               ),
//               child: const Icon(Icons.arrow_back_rounded, size: 29),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Wrap(
//               crossAxisAlignment: WrapCrossAlignment.center,
//               spacing: 10,
//               runSpacing: 4,
//               children: [
//                 Text(
//                   'Notifications',
//                   style: TextStyle(
//                     color: textDark,
//                     fontSize: isMobile ? 23 : 32,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: -0.6,
//                   ),
//                 ),
//                 if (unreadCount > 0)
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFE7E9FF),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: Text(
//                       '$unreadCount unread',
//                       style: const TextStyle(
//                         color: primary,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilters(bool isMobile) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(
//         horizontal: isMobile ? 16 : 36,
//         vertical: isMobile ? 16 : 24,
//       ),
//       decoration: const BoxDecoration(
//         border: Border(bottom: BorderSide(color: border)),
//       ),
//       child: isMobile
//           ? Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _tabButton(
//                         label: 'All (${items.length})',
//                         selected: selectedTab == 0,
//                         onTap: () => setState(() => selectedTab = 0),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: _tabButton(
//                         label: 'Unread ($unreadCount)',
//                         selected: selectedTab == 1,
//                         onTap: () => setState(() => selectedTab = 1),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: _markAllButton(),
//                 ),
//               ],
//             )
//           : Row(
//               children: [
//                 _tabButton(
//                   label: 'All (${items.length})',
//                   selected: selectedTab == 0,
//                   onTap: () => setState(() => selectedTab = 0),
//                 ),
//                 const SizedBox(width: 20),
//                 _tabButton(
//                   label: 'Unread ($unreadCount)',
//                   selected: selectedTab == 1,
//                   onTap: () => setState(() => selectedTab = 1),
//                 ),
//                 const Spacer(),
//                 _markAllButton(),
//               ],
//             ),
//     );
//   }

//   Widget _tabButton({
//     required String label,
//     required bool selected,
//     required VoidCallback onTap,
//   }) {
//     return Material(
//       color: selected ? primary : Colors.transparent,
//       borderRadius: BorderRadius.circular(13),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(13),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
//           alignment: Alignment.center,
//           child: Text(
//             label,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               color: selected ? Colors.white : textMuted,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _markAllButton() {
//     return TextButton(
//       onPressed: unreadCount == 0 ? null : _markAllRead,
//       style: TextButton.styleFrom(
//         foregroundColor: primary,
//         disabledForegroundColor: textMuted,
//         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//       ),
//       child: const Text(
//         'Mark all as read',
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//       ),
//     );
//   }

//   Widget _buildList(bool isMobile) {
//     return ListView.separated(
//       padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 36),
//       itemCount: visibleItems.length,
//       separatorBuilder: (_, __) =>
//           const Divider(height: 1, thickness: 1, color: border),
//       itemBuilder: (context, index) {
//         final item = visibleItems[index];

//         return InkWell(
//           onTap: () => _openNotification(item),
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: isMobile ? 20 : 25),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: isMobile ? 50 : 76,
//                   height: isMobile ? 50 : 76,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: item.background,
//                     border: Border.all(color: item.outline, width: 1.5),
//                   ),
//                   child: Icon(
//                     item.icon,
//                     color: item.iconColor,
//                     size: isMobile ? 24 : 31,
//                   ),
//                 ),
//                 SizedBox(width: isMobile ? 13 : 24),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         item.title,
//                         style: TextStyle(
//                           color: textDark,
//                           fontSize: isMobile ? 16 : 22,
//                           height: 1.35,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         item.description,
//                         style: TextStyle(
//                           color: textMuted,
//                           fontSize: isMobile ? 14 : 18,
//                           height: 1.5,
//                         ),
//                       ),
//                       const SizedBox(height: 13),
//                       Text(
//                         item.time,
//                         style: TextStyle(
//                           color: textMuted,
//                           fontSize: isMobile ? 13 : 17,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (!item.isRead) ...[
//                   const SizedBox(width: 8),
//                   Container(
//                     margin: const EdgeInsets.only(top: 9),
//                     width: 12,
//                     height: 12,
//                     decoration: const BoxDecoration(
//                       color: primary,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildEmptyState(bool isMobile) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(minHeight: constraints.maxHeight),
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       width: isMobile ? 165 : 250,
//                       height: isMobile ? 165 : 250,
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           Container(
//                             width: isMobile ? 135 : 205,
//                             height: isMobile ? 135 : 205,
//                             decoration: const BoxDecoration(
//                               color: Color(0xFFEDF3FF),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.notifications_rounded,
//                               size: isMobile ? 65 : 96,
//                               color: const Color(0xFF4166F5),
//                             ),
//                           ),
//                           Positioned(
//                             right: 0,
//                             bottom: 5,
//                             child: Container(
//                               width: 48,
//                               height: 48,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: const Color(0xFFCAD5E5),
//                                   width: 2,
//                                 ),
//                               ),
//                               child: const Icon(
//                                 Icons.do_not_disturb_alt_outlined,
//                                 color: Color(0xFF647792),
//                                 size: 27,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 22),
//                     Text(
//                       'No Notifications',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: textDark,
//                         fontSize: isMobile ? 23 : 28,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(height: 14),
//                     ConstrainedBox(
//                       constraints: const BoxConstraints(maxWidth: 550),
//                       child: Text(
//                         "You're all caught up! When there are new "
//                         "alerts or updates, they'll show up here.",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: textMuted,
//                           fontSize: isMobile ? 15 : 18,
//                           height: 1.5,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildFooter(bool isMobile) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(
//         horizontal: 12,
//         vertical: isMobile ? 18 : 24,
//       ),
//       decoration: const BoxDecoration(
//         border: Border(top: BorderSide(color: border)),
//       ),
//       child: Center(
//         child: TextButton(
//           onPressed: () => setState(() => selectedTab = 0),
//           style: TextButton.styleFrom(
//             foregroundColor: primary,
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//           ),
//           child: Wrap(
//             alignment: WrapAlignment.center,
//             crossAxisAlignment: WrapCrossAlignment.center,
//             spacing: 7,
//             children: [
//               Text(
//                 'View all notifications',
//                 style: TextStyle(
//                   fontSize: isMobile ? 16 : 19,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const Icon(Icons.arrow_forward_rounded, size: 21),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _NotificationData {
//   final String title;
//   final String description;
//   final String time;
//   final IconData icon;
//   final Color iconColor;
//   final Color background;
//   final Color outline;
//   bool isRead;

//   _NotificationData({
//     required this.title,
//     required this.description,
//     required this.time,
//     required this.icon,
//     required this.iconColor,
//     required this.background,
//     required this.outline,
//     this.isRead = false,
//   });
// }

import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  static const Color primaryBlue = Color(0xFF159FE3);
  static const Color darkNavy = Color(0xFF102A56);
  static const Color pageBackground = Color(0xFFF5F8FC);
  static const Color borderColor = Color(0xFFE4EAF2);
  static const Color mutedColor = Color(0xFF718096);

  String selectedFilter = 'All';

  final List<_NotificationItem> notifications = [
    _NotificationItem(
      title: 'New employee onboarded',
      description: 'A new employee has been added to the HRMS module.',
      time: '5 minutes ago',
      category: 'HRMS',
      icon: Icons.person_add_alt_1_rounded,
      color: Color(0xFF159FE3),
      isRead: false,
    ),
    _NotificationItem(
      title: 'Low stock alert',
      description: 'Some inventory items have reached their minimum level.',
      time: '20 minutes ago',
      category: 'Inventory',
      icon: Icons.inventory_2_outlined,
      color: Color(0xFFE8A33D),
      isRead: false,
    ),
    _NotificationItem(
      title: 'Workflow completed',
      description: 'The purchase approval workflow has been completed.',
      time: '1 hour ago',
      category: 'Workflow',
      icon: Icons.task_alt_rounded,
      color: Color(0xFF16A085),
      isRead: true,
    ),
    _NotificationItem(
      title: 'Security verification',
      description: 'A new sign-in was detected on your account.',
      time: '2 hours ago',
      category: 'Security',
      icon: Icons.shield_outlined,
      color: Color(0xFF7C5CDE),
      isRead: false,
    ),
    _NotificationItem(
      title: 'Monthly report available',
      description: 'Your latest enterprise report is ready to view.',
      time: '4 hours ago',
      category: 'Reports',
      icon: Icons.analytics_outlined,
      color: Color(0xFF16A085),
      isRead: true,
    ),
    _NotificationItem(
      title: 'Subscription updated',
      description: 'Your enterprise subscription details were updated.',
      time: 'Yesterday',
      category: 'Platform',
      icon: Icons.workspace_premium_outlined,
      color: Color(0xFFE8A33D),
      isRead: true,
    ),
    _NotificationItem(
      title: 'New message received',
      description: 'You have received a new message from your team.',
      time: 'Yesterday',
      category: 'Messages',
      icon: Icons.mail_outline_rounded,
      color: Color(0xFF159FE3),
      isRead: false,
    ),
    _NotificationItem(
      title: 'System maintenance completed',
      description: 'The scheduled system maintenance is complete.',
      time: '2 days ago',
      category: 'System',
      icon: Icons.settings_suggest_outlined,
      color: Color(0xFF7C5CDE),
      isRead: true,
    ),
  ];

  int get unreadCount => notifications.where((item) => !item.isRead).length;

  List<_NotificationItem> get filteredNotifications {
    switch (selectedFilter) {
      case 'Unread':
        return notifications.where((item) => !item.isRead).toList();
      case 'Read':
        return notifications.where((item) => item.isRead).toList();
      default:
        return notifications;
    }
  }

  void _markAllAsRead() {
    setState(() {
      for (final item in notifications) {
        item.isRead = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toggleRead(_NotificationItem item) {
    setState(() {
      item.isRead = !item.isRead;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final isMobile = width < 600;
            final isTablet = width >= 600 && width < 1000;

            final horizontalPadding = isMobile
                ? 10.0
                : isTablet
                ? 20.0
                : 28.0;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: isMobile ? 5 : 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(isMobile),
                      SizedBox(height: isMobile ? 7 : 9),
                      _buildSummary(isMobile, isTablet),
                      SizedBox(height: isMobile ? 7 : 9),
                      _buildFilterBar(isMobile),
                      const SizedBox(height: 7),
                      Expanded(
                        child: _buildNotificationList(
                          isMobile: isMobile,
                          isTablet: isTablet,
                        ),
                      ),
                      SizedBox(height: isMobile ? 2 : 5),
                      _buildFooter(isMobile),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Compact page header.
  Widget _buildHeader(bool isMobile) {
    return Row(
      children: [
        SizedBox(
          width: isMobile ? 32 : 36,
          height: isMobile ? 32 : 36,
          child: Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
              side: const BorderSide(color: borderColor),
            ),
            child: IconButton(
              tooltip: 'Go back',
              padding: EdgeInsets.zero,
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                size: isMobile ? 17 : 19,
                color: darkNavy,
              ),
            ),
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Notifications',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: darkNavy,
                  fontSize: isMobile ? 17 : 21,
                  height: 1.15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isMobile
                    ? 'Your latest updates'
                    : 'Stay updated with your enterprise activity',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: mutedColor,
                  fontSize: isMobile ? 10 : 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        if (unreadCount > 0)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 7 : 9,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE7F4FD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$unreadCount unread',
              style: const TextStyle(
                color: primaryBlue,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }

  // Compact summary cards.
  Widget _buildSummary(bool isMobile, bool isTablet) {
    final cards = [
      _SummaryData(
        title: 'Total',
        value: '${notifications.length}',
        icon: Icons.notifications_none_rounded,
        color: primaryBlue,
      ),
      _SummaryData(
        title: 'Unread',
        value: '$unreadCount',
        icon: Icons.mark_email_unread_outlined,
        color: const Color(0xFFE8A33D),
      ),
      _SummaryData(
        title: 'Read',
        value: '${notifications.length - unreadCount}',
        icon: Icons.drafts_outlined,
        color: const Color(0xFF16A085),
      ),
    ];

    return Row(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          Expanded(
            child: _buildSummaryCard(cards[i], compact: isMobile || isTablet),
          ),
          if (i != cards.length - 1) SizedBox(width: isMobile ? 6 : 10),
        ],
      ],
    );
  }

  Widget _buildSummaryCard(_SummaryData data, {required bool compact}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 7 : 11,
        vertical: compact ? 7 : 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Container(
            width: compact ? 27 : 32,
            height: compact ? 27 : 32,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(data.icon, color: data.color, size: compact ? 15 : 18),
          ),
          SizedBox(width: compact ? 6 : 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: compact ? 9 : 11,
                    color: mutedColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data.value,
                  style: TextStyle(
                    fontSize: compact ? 15 : 18,
                    height: 1.1,
                    color: darkNavy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Compact filter bar.
  Widget _buildFilterBar(bool isMobile) {
    const filters = ['All', 'Unread', 'Read'];

    return Container(
      padding: EdgeInsets.all(isMobile ? 3 : 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          for (final filter in filters)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _buildFilterButton(filter, isMobile),
              ),
            ),
          if (!isMobile) ...[
            const SizedBox(width: 6),
            TextButton.icon(
              onPressed: unreadCount == 0 ? null : _markAllAsRead,
              icon: const Icon(Icons.done_all_rounded, size: 14),
              label: const Text('Mark all read'),
              style: TextButton.styleFrom(
                foregroundColor: primaryBlue,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: const Size(0, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterButton(String filter, bool isMobile) {
    final selected = selectedFilter == filter;

    return InkWell(
      borderRadius: BorderRadius.circular(7),
      onTap: () {
        setState(() {
          selectedFilter = filter;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 6 : 7,
          horizontal: 4,
        ),
        decoration: BoxDecoration(
          color: selected ? darkNavy : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: Text(
            filter,
            style: TextStyle(
              color: selected ? Colors.white : mutedColor,
              fontSize: isMobile ? 10 : 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // The list gets all remaining vertical space.
  Widget _buildNotificationList({
    required bool isMobile,
    required bool isTablet,
  }) {
    final items = filteredNotifications;

    if (items.isEmpty) {
      return _buildEmptyState(isMobile);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 10 : 14,
              vertical: 8,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Recent activity',
                    style: TextStyle(
                      color: darkNavy,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  '${items.length} items',
                  style: const TextStyle(color: mutedColor, fontSize: 10),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: borderColor),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 8 : 14,
                vertical: 2,
              ),
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                indent: 3,
                endIndent: 3,
                color: borderColor,
              ),
              itemBuilder: (context, index) {
                return _buildNotificationTile(
                  items[index],
                  isMobile: isMobile,
                  isTablet: isTablet,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile(
    _NotificationItem item, {
    required bool isMobile,
    required bool isTablet,
  }) {
    final compact = isMobile || isTablet;

    return InkWell(
      onTap: () => _toggleRead(item),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 8 : 10,
          horizontal: 2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: compact ? 32 : 38,
              height: compact ? 32 : 38,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(
                item.icon,
                color: item.color,
                size: compact ? 16 : 19,
              ),
            ),
            SizedBox(width: isMobile ? 8 : 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: darkNavy,
                            fontSize: compact ? 11 : 13,
                            height: 1.25,
                            fontWeight: item.isRead
                                ? FontWeight.w500
                                : FontWeight.w700,
                          ),
                        ),
                      ),
                      if (!item.isRead) ...[
                        const SizedBox(width: 5),
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 4),
                          decoration: const BoxDecoration(
                            color: primaryBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: mutedColor,
                      height: 1.25,
                      fontSize: compact ? 10 : 11,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    spacing: 7,
                    runSpacing: 3,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        item.time,
                        style: TextStyle(
                          color: mutedColor,
                          fontSize: compact ? 9 : 10,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F4F8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.category,
                          style: const TextStyle(
                            color: Color(0xFF53657D),
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 2),
            SizedBox(
              width: 28,
              height: 28,
              child: PopupMenuButton<String>(
                tooltip: 'Notification options',
                padding: EdgeInsets.zero,
                iconSize: 17,
                icon: const Icon(Icons.more_horiz_rounded, color: mutedColor),
                onSelected: (value) {
                  if (value == 'toggle') {
                    _toggleRead(item);
                  } else if (value == 'delete') {
                    setState(() {
                      notifications.remove(item);
                    });
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'toggle',
                    child: Text(
                      item.isRead ? 'Mark as unread' : 'Mark as read',
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete notification'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 28),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: isMobile ? 52 : 64,
              height: isMobile ? 52 : 64,
              decoration: const BoxDecoration(
                color: Color(0xFFEAF7FD),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: isMobile ? 25 : 30,
                color: primaryBlue,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              selectedFilter == 'Unread'
                  ? 'You are all caught up!'
                  : selectedFilter == 'Read'
                  ? 'No read notifications'
                  : 'No notifications yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 15 : 17,
                color: darkNavy,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Your notifications will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: mutedColor),
            ),
          ],
        ),
      ),
    );
  }

  // Compact footer.
  Widget _buildFooter(bool isMobile) {
    return Row(
      children: [
        const Icon(Icons.verified_user_outlined, size: 13, color: mutedColor),
        const SizedBox(width: 5),
        const Expanded(
          child: Text(
            'Your latest updates',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: mutedColor, fontSize: 9),
          ),
        ),
        if (isMobile)
          TextButton(
            onPressed: unreadCount == 0 ? null : _markAllAsRead,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              minimumSize: const Size(0, 26),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: primaryBlue,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

class _NotificationItem {
  _NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.category,
    required this.icon,
    required this.color,
    required this.isRead,
  });

  final String title;
  final String description;
  final String time;
  final String category;
  final IconData icon;
  final Color color;
  bool isRead;
}

class _SummaryData {
  const _SummaryData({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
}
