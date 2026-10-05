// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // import '../../app_theme.dart';
// // import '../../providers/user_provider.dart';

// // class ProfilePage extends ConsumerWidget {
// //   const ProfilePage({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final user = ref.watch(userProvider);

// //     return SingleChildScrollView(
// //       padding: const EdgeInsets.all(24),
// //       child: Center(
// //         child: ConstrainedBox(
// //           constraints: const BoxConstraints(maxWidth: 700),
// //           child: Container(
// //             padding: const EdgeInsets.all(30),
// //             decoration: BoxDecoration(
// //               color: AppTheme.paper,
// //               borderRadius: BorderRadius.circular(16),
// //               border: Border.all(color: AppTheme.border),
// //             ),
// //             child: Column(
// //               children: [
// //                 // Profile Icon
// //                 CircleAvatar(
// //                   radius: 45,
// //                   backgroundColor: AppTheme.ink3,
// //                   child: Text(
// //                     user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
// //                     style: const TextStyle(
// //                       color: AppTheme.paper,
// //                       fontSize: 32,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 18),

// //                 // Name
// //                 Text(
// //                   user.name.isNotEmpty ? user.name : 'User',
// //                   style: const TextStyle(
// //                     color: AppTheme.text,
// //                     fontSize: 24,
// //                     fontWeight: FontWeight.w700,
// //                   ),
// //                 ),

// //                 const SizedBox(height: 5),

// //                 // Email
// //                 Text(
// //                   user.email.isNotEmpty ? user.email : 'No email available',
// //                   style: const TextStyle(
// //                     color: AppTheme.textMuted,
// //                     fontSize: 14,
// //                   ),
// //                 ),

// //                 const SizedBox(height: 28),

// //                 const Divider(color: AppTheme.border),

// //                 const SizedBox(height: 20),

// //                 _profileRow(Icons.person_outline, 'Name', user.name),

// //                 const SizedBox(height: 20),

// //                 _profileRow(Icons.email_outlined, 'Email', user.email),

// //                 const SizedBox(height: 20),

// //                 _profileRow(
// //                   Icons.verified_user_outlined,
// //                   'Account Status',
// //                   user.isLoggedIn ? 'Logged In' : 'Not Logged In',
// //                 ),

// //                 const SizedBox(height: 20),

// //                 _profileRow(
// //                   Icons.security_outlined,
// //                   'Authentication',
// //                   '2-Step Verification',
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _profileRow(IconData icon, String title, String value) {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Container(
// //           width: 42,
// //           height: 42,
// //           decoration: BoxDecoration(
// //             color: AppTheme.ink3.withValues(alpha: 0.10),
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //           child: Icon(icon, color: AppTheme.ink3, size: 21),
// //         ),

// //         const SizedBox(width: 15),

// //         Expanded(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 title,
// //                 style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
// //               ),

// //               const SizedBox(height: 4),

// //               Text(
// //                 value.isNotEmpty ? value : 'Not available',
// //                 style: const TextStyle(
// //                   fontSize: 15,
// //                   color: AppTheme.text,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../app_theme.dart';
// import '../../providers/user_provider.dart';
// import '../../providers/registration_provider.dart';

// class ProfilePage extends ConsumerWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(userProvider);
//     final registration = ref.watch(registrationProvider);

//     final fullName = user.name.isNotEmpty
//         ? user.name
//         : '${registration.firstName} ${registration.lastName}'.trim();

//     final email = user.email.isNotEmpty ? user.email : registration.adminEmail;

//     final initials = _getInitials(fullName);

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 900),
//           child: Column(
//             children: [
//               // ==========================================================
//               // PROFILE HEADER
//               // ==========================================================

//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(30),
//                 decoration: BoxDecoration(
//                   color: AppTheme.paper,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: AppTheme.border),
//                 ),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 45,
//                       backgroundColor: AppTheme.ink3,
//                       child: Text(
//                         initials,
//                         style: const TextStyle(
//                           color: AppTheme.paper,
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 18),

//                     Text(
//                       fullName.isNotEmpty ? fullName : 'User',
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: AppTheme.text,
//                         fontSize: 24,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),

//                     const SizedBox(height: 5),

//                     Text(
//                       email.isNotEmpty ? email : 'No email available',
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: AppTheme.textMuted,
//                         fontSize: 14,
//                       ),
//                     ),

//                     if (registration.organizationName.isNotEmpty) ...[
//                       const SizedBox(height: 12),

//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 14,
//                           vertical: 7,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppTheme.ink3.withValues(alpha: 0.08),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           registration.organizationName,
//                           style: const TextStyle(
//                             color: AppTheme.ink3,
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // ==========================================================
//               // ADMIN ACCOUNT
//               // ==========================================================
//               _sectionCard(
//                 title: 'Admin Account',
//                 icon: Icons.person_outline,
//                 children: [
//                   _profileRow(
//                     Icons.person_outline,
//                     'First Name',
//                     registration.firstName,
//                   ),

//                   _profileRow(
//                     Icons.person_outline,
//                     'Last Name',
//                     registration.lastName,
//                   ),

//                   _profileRow(
//                     Icons.email_outlined,
//                     'Official Email',
//                     registration.adminEmail,
//                   ),

//                   _profileRow(
//                     Icons.phone_outlined,
//                     'Mobile Number',
//                     registration.mobileNumber,
//                   ),

//                   _profileRow(
//                     Icons.alternate_email,
//                     'Username',
//                     registration.username,
//                   ),

//                   _profileRow(
//                     Icons.admin_panel_settings_outlined,
//                     'Role',
//                     'SUPER_ADMIN',
//                   ),

//                   _profileRow(
//                     Icons.verified_user_outlined,
//                     'Account Status',
//                     user.isLoggedIn ? 'Logged In' : 'Not Logged In',
//                   ),

//                   _profileRow(
//                     Icons.security_outlined,
//                     'Authentication',
//                     '2-Step Verification',
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               // ==========================================================
//               // ORGANIZATION DETAILS
//               // ==========================================================
//               _sectionCard(
//                 title: 'Organization Details',
//                 icon: Icons.business_outlined,
//                 children: [
//                   _profileRow(
//                     Icons.business_outlined,
//                     'Organization Name',
//                     registration.organizationName,
//                   ),

//                   _profileRow(
//                     Icons.tag_outlined,
//                     'Organization Code',
//                     registration.organizationCode,
//                   ),

//                   _profileRow(
//                     Icons.account_tree_outlined,
//                     'Organization Type',
//                     registration.organizationType,
//                   ),

//                   _profileRow(
//                     Icons.work_outline,
//                     'Industry',
//                     registration.industry,
//                   ),

//                   _profileRow(
//                     Icons.groups_outlined,
//                     'Company Size',
//                     registration.companySize,
//                   ),

//                   _profileRow(
//                     Icons.public_outlined,
//                     'Country',
//                     registration.country,
//                   ),

//                   _profileRow(
//                     Icons.location_city_outlined,
//                     'State / Province',
//                     registration.state,
//                   ),

//                   _profileRow(
//                     Icons.location_on_outlined,
//                     'City',
//                     registration.city,
//                   ),

//                   _profileRow(
//                     Icons.schedule_outlined,
//                     'Time Zone',
//                     registration.timeZone,
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               // ==========================================================
//               // ACCOUNT PREFERENCES
//               // ==========================================================
//               _sectionCard(
//                 title: 'Account Preferences',
//                 icon: Icons.tune_outlined,
//                 children: [
//                   _profileRow(
//                     Icons.description_outlined,
//                     'Terms of Service',
//                     registration.termsAccepted ? 'Accepted' : 'Not Accepted',
//                   ),

//                   _profileRow(
//                     Icons.verified_outlined,
//                     'Admin Authorization',
//                     registration.authorizationAccepted
//                         ? 'Confirmed'
//                         : 'Not Confirmed',
//                   ),

//                   _profileRow(
//                     Icons.policy_outlined,
//                     'Data Processing',
//                     registration.dataProcessingAccepted
//                         ? 'Accepted'
//                         : 'Not Accepted',
//                   ),

//                   _profileRow(
//                     Icons.notifications_outlined,
//                     'Product Updates',
//                     registration.productUpdates ? 'Enabled' : 'Disabled',
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // SECTION CARD
//   // ============================================================

//   Widget _sectionCard({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(30),
//       decoration: BoxDecoration(
//         color: AppTheme.paper,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppTheme.border),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 42,
//                 height: 42,
//                 decoration: BoxDecoration(
//                   color: AppTheme.ink3.withValues(alpha: 0.10),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(icon, color: AppTheme.ink3, size: 21),
//               ),

//               const SizedBox(width: 14),

//               Text(
//                 title,
//                 style: const TextStyle(
//                   color: AppTheme.text,
//                   fontSize: 19,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 22),

//           const Divider(color: AppTheme.border),

//           const SizedBox(height: 6),

//           ...children.map(
//             (child) =>
//                 Padding(padding: const EdgeInsets.only(top: 18), child: child),
//           ),
//         ],
//       ),
//     );
//   }

//   // ============================================================
//   // PROFILE ROW
//   // ============================================================

//   Widget _profileRow(IconData icon, String title, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 42,
//           height: 42,
//           decoration: BoxDecoration(
//             color: AppTheme.ink3.withValues(alpha: 0.10),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, color: AppTheme.ink3, size: 21),
//         ),

//         const SizedBox(width: 15),

//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
//               ),

//               const SizedBox(height: 4),

//               Text(
//                 value.isNotEmpty ? value : 'Not available',
//                 style: const TextStyle(
//                   fontSize: 15,
//                   color: AppTheme.text,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ============================================================
//   // INITIALS
//   // ============================================================

//   String _getInitials(String name) {
//     final trimmed = name.trim();

//     if (trimmed.isEmpty) {
//       return 'U';
//     }

//     final parts = trimmed
//         .split(RegExp(r'\s+'))
//         .where((part) => part.isNotEmpty)
//         .toList();

//     if (parts.length == 1) {
//       return parts.first[0].toUpperCase();
//     }

//     return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_theme.dart';
import '../../providers/user_provider.dart';
import '../../providers/registration_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final registration = ref.watch(registrationProvider);

    final fullName = user.name.isNotEmpty
        ? user.name
        : '${registration.firstName} ${registration.lastName}'.trim();

    final email = user.email.isNotEmpty ? user.email : registration.adminEmail;

    final initials = _getInitials(fullName);

    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 24,
        vertical: isMobile ? 16 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              // ==========================================================
              // PROFILE HEADER
              // ==========================================================

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isMobile ? 20 : 30),
                decoration: BoxDecoration(
                  color: AppTheme.paper,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: isMobile ? 38 : 45,
                      backgroundColor: AppTheme.ink3,
                      child: Text(
                        initials,
                        style: TextStyle(
                          color: AppTheme.paper,
                          fontSize: isMobile ? 26 : 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: isMobile ? 14 : 18),

                    Text(
                      fullName.isNotEmpty ? fullName : 'User',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        color: AppTheme.text,
                        fontSize: isMobile ? 21 : 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Email is allowed to wrap on small screens.
                    Text(
                      email.isNotEmpty ? email : 'No email available',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: isMobile ? 13 : 14,
                      ),
                    ),

                    if (registration.organizationName.isNotEmpty) ...[
                      const SizedBox(height: 12),

                      Container(
                        constraints: BoxConstraints(
                          maxWidth: isMobile ? screenWidth - 80 : 500,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.ink3.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          registration.organizationName,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: const TextStyle(
                            color: AppTheme.ink3,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================================
              // ADMIN ACCOUNT
              // ==========================================================
              _sectionCard(
                title: 'Admin Account',
                icon: Icons.person_outline,
                isMobile: isMobile,
                children: [
                  _profileRow(
                    Icons.person_outline,
                    'First Name',
                    registration.firstName,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.person_outline,
                    'Last Name',
                    registration.lastName,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.email_outlined,
                    'Official Email',
                    registration.adminEmail,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.phone_outlined,
                    'Mobile Number',
                    registration.mobileNumber,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.alternate_email,
                    'Username',
                    registration.username,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.admin_panel_settings_outlined,
                    'Role',
                    'SUPER_ADMIN',
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.verified_user_outlined,
                    'Account Status',
                    user.isLoggedIn ? 'Logged In' : 'Not Logged In',
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.security_outlined,
                    'Authentication',
                    '2-Step Verification',
                    isMobile: isMobile,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ==========================================================
              // ORGANIZATION DETAILS
              // ==========================================================
              _sectionCard(
                title: 'Organization Details',
                icon: Icons.business_outlined,
                isMobile: isMobile,
                children: [
                  _profileRow(
                    Icons.business_outlined,
                    'Organization Name',
                    registration.organizationName,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.tag_outlined,
                    'Organization Code',
                    registration.organizationCode,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.account_tree_outlined,
                    'Organization Type',
                    registration.organizationType,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.work_outline,
                    'Industry',
                    registration.industry,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.groups_outlined,
                    'Company Size',
                    registration.companySize,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.public_outlined,
                    'Country',
                    registration.country,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.location_city_outlined,
                    'State / Province',
                    registration.state,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.location_on_outlined,
                    'City',
                    registration.city,
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.schedule_outlined,
                    'Time Zone',
                    registration.timeZone,
                    isMobile: isMobile,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ==========================================================
              // ACCOUNT PREFERENCES
              // ==========================================================
              _sectionCard(
                title: 'Account Preferences',
                icon: Icons.tune_outlined,
                isMobile: isMobile,
                children: [
                  _profileRow(
                    Icons.description_outlined,
                    'Terms of Service',
                    registration.termsAccepted ? 'Accepted' : 'Not Accepted',
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.verified_outlined,
                    'Admin Authorization',
                    registration.authorizationAccepted
                        ? 'Confirmed'
                        : 'Not Confirmed',
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.policy_outlined,
                    'Data Processing',
                    registration.dataProcessingAccepted
                        ? 'Accepted'
                        : 'Not Accepted',
                    isMobile: isMobile,
                  ),

                  _profileRow(
                    Icons.notifications_outlined,
                    'Product Updates',
                    registration.productUpdates ? 'Enabled' : 'Disabled',
                    isMobile: isMobile,
                  ),
                ],
              ),

              // Extra bottom spacing for mobile.
              SizedBox(height: isMobile ? 20 : 30),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION CARD
  // ============================================================

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
    required bool isMobile,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 18 : 30),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: isMobile ? 38 : 42,
                height: isMobile ? 38 : 42,
                decoration: BoxDecoration(
                  color: AppTheme.ink3.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.ink3,
                  size: isMobile ? 20 : 21,
                ),
              ),

              SizedBox(width: isMobile ? 11 : 14),

              Expanded(
                child: Text(
                  title,
                  softWrap: true,
                  style: TextStyle(
                    color: AppTheme.text,
                    fontSize: isMobile ? 17 : 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 16 : 22),

          const Divider(color: AppTheme.border, height: 1),

          SizedBox(height: isMobile ? 2 : 6),

          // Section rows
          ...children.map(
            (child) => Padding(
              padding: EdgeInsets.only(top: isMobile ? 16 : 18),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROFILE ROW
  // ============================================================

  Widget _profileRow(
    IconData icon,
    String title,
    String value, {
    required bool isMobile,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon
        Container(
          width: isMobile ? 38 : 42,
          height: isMobile ? 38 : 42,
          decoration: BoxDecoration(
            color: AppTheme.ink3.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.ink3, size: isMobile ? 19 : 21),
        ),

        SizedBox(width: isMobile ? 11 : 15),

        // Text area
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                softWrap: true,
                style: TextStyle(
                  fontSize: isMobile ? 11.5 : 12,
                  color: AppTheme.textMuted,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value.isNotEmpty ? value : 'Not available',
                softWrap: true,
                maxLines: null,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  color: AppTheme.text,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // INITIALS
  // ============================================================

  String _getInitials(String name) {
    final trimmed = name.trim();

    if (trimmed.isEmpty) {
      return 'U';
    }

    final parts = trimmed
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
