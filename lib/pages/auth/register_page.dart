// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../app_theme.dart';
// import '../../providers/user_provider.dart';
// import '../../providers/registration_provider.dart';
// import '../../routes/routes.dart';
// import '../../widgets/auth_layout.dart';

// class RegisterPage extends ConsumerStatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   ConsumerState<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends ConsumerState<RegisterPage> {
//   final _formKey = GlobalKey<FormState>();

//   // ============================================================
//   // STEP
//   // ============================================================

//   // ============================================================
//   // ORGANIZATION
//   // ============================================================

//   final _organizationNameController = TextEditingController();
//   final _organizationCodeController = TextEditingController();
//   final _cityController = TextEditingController();

//   // ============================================================
//   // ADMIN
//   // ============================================================

//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _adminEmailController = TextEditingController();
//   final _mobileController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   // ============================================================
//   // TERMS
//   // ============================================================

//   // ============================================================
//   // STATE
//   // ============================================================

//   // ============================================================
//   // DISPOSE
//   // ============================================================

//   @override
//   void dispose() {
//     _organizationNameController.dispose();
//     _organizationCodeController.dispose();
//     _cityController.dispose();

//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _adminEmailController.dispose();
//     _mobileController.dispose();
//     _usernameController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();

//     super.dispose();
//   }

//   // ============================================================
//   // BUILD
//   // ============================================================

//   @override
//   Widget build(BuildContext context) {
//     return AuthLayout(
//       scrollable: true,
//       child: ref.watch(registrationProvider).registrationCompleted
//           ? _buildSuccessPage()
//           : _buildCurrentStep(),
//     );
//   }

//   Widget _buildCurrentStep() {
//     switch (ref.watch(registrationProvider).currentStep) {
//       case 1:
//         return _buildOrganizationStep();

//       case 2:
//         return _buildAdminStep();

//       case 3:
//         return _buildTermsStep();

//       default:
//         return _buildOrganizationStep();
//     }
//   }

//   // ============================================================
//   // COMMON HEADER
//   // ============================================================

//   Widget _buildHeader({
//     required int step,
//     required String section,
//     required String title,
//     required String description,
//     bool showBack = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (showBack) ...[
//           TextButton.icon(
//             onPressed: () {
//               ref.read(registrationProvider.notifier).previousStep();
//             },
//             style: TextButton.styleFrom(
//               padding: EdgeInsets.zero,
//               minimumSize: Size.zero,
//               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               foregroundColor: AppTheme.textMuted,
//             ),
//             icon: const Icon(Icons.chevron_left, size: 20),
//             label: Text(
//               'Back',
//               style: GoogleFonts.onest(color: AppTheme.textMuted, fontSize: 14),
//             ),
//           ),
//           const SizedBox(height: 26),
//         ],

//         _buildProgressIndicator(step),

//         const SizedBox(height: 38),

//         Text(
//           'STEP $step OF 3  ·  ${section.toUpperCase()}',
//           style: GoogleFonts.ibmPlexMono(
//             color: const Color(0xFF9AA8BD),
//             fontSize: 12,
//             letterSpacing: 2,
//           ),
//         ),

//         const SizedBox(height: 20),

//         Text(
//           title,
//           style: GoogleFonts.onest(
//             color: AppTheme.text,
//             fontSize: 38,
//             fontWeight: FontWeight.w600,
//             letterSpacing: -1.2,
//           ),
//         ),

//         const SizedBox(height: 12),

//         Text(
//           description,
//           style: GoogleFonts.onest(
//             color: AppTheme.textMuted,
//             fontSize: 16,
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }

//   // ============================================================
//   // PROGRESS
//   // ============================================================

//   Widget _buildProgressIndicator(int step) {
//     return Row(
//       children: List.generate(3, (index) {
//         final current = index + 1;

//         return Expanded(
//           child: Container(
//             height: 5,
//             margin: EdgeInsets.only(right: index == 2 ? 0 : 10),
//             decoration: BoxDecoration(
//               color: current <= step
//                   ? current == step
//                         ? AppTheme.ink
//                         : const Color(0xFF6D91F2)
//                   : const Color(0xFFE3E7ED),
//               borderRadius: BorderRadius.circular(5),
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   // ============================================================
//   // STEP 1
//   // ORGANIZATION DETAILS
//   // ============================================================

//   Widget _buildOrganizationStep() {
//     return ConstrainedBox(
//       constraints: const BoxConstraints(maxWidth: 900),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(
//               step: 1,
//               section: 'Organization Details',
//               title: 'Tell us about your organization',
//               description: "This creates your organization's workspace on One Enterprise.",
//             ),

//             const SizedBox(height: 42),

//             _buildLabel('Organization Name', required: true),
//             const SizedBox(height: 8),
//             _buildTextField(
//               controller: _organizationNameController,
//               hint: 'ABC Technologies Pvt Ltd',
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty) {
//                   return 'Organization name is required.';
//                 }
//                 return null;
//               },
//               onChanged: (value) {
//                 ref
//                     .read(registrationProvider.notifier)
//                     .setOrganizationName(value);

//                 if (_organizationCodeController.text.isEmpty) {
//                   final code = _generateOrganizationCode(value);
//                   _organizationCodeController.text = code;
//                   ref
//                       .read(registrationProvider.notifier)
//                       .setOrganizationCode(code);
//                 }
//               },
//             ),

//             const SizedBox(height: 28),

//             _buildLabel('Organization Code', required: true),
//             const SizedBox(height: 8),
//             _buildTextField(
//               controller: _organizationCodeController,
//               onChanged: (value) {
//                 ref
//                     .read(registrationProvider.notifier)
//                     .setOrganizationCode(value);
//               },
//               hint: 'ABC-TECH',
//               textCapitalization: TextCapitalization.characters,
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty) {
//                   return 'Organization code is required.';
//                 }
//                 return null;
//               },
//             ),

//             const SizedBox(height: 8),

//             Wrap(
//               crossAxisAlignment: WrapCrossAlignment.center,
//               children: [
//                 Text(
//                   'Auto-generated from your organization name — ',
//                   style: GoogleFonts.onest(
//                     color: const Color(0xFF9AA8BD),
//                     fontSize: 13,
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     _organizationCodeController.selection = TextSelection(
//                       baseOffset: 0,
//                       extentOffset: _organizationCodeController.text.length,
//                     );
//                   },
//                   child: Text(
//                     'edit manually',
//                     style: GoogleFonts.onest(
//                       color: const Color(0xFF3E64D8),
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),

//             _buildLabel('Organization Type', required: true),
//             const SizedBox(height: 8),
//             _buildDropdown(
//               value: ref.watch(registrationProvider).organizationType,
//               items: const [
//                 'Enterprise',
//                 'Startup',
//                 'SME',
//                 'Government',
//                 'Non-Profit',
//               ],
//               onChanged: (value) {
//                 ref
//                     .read(registrationProvider.notifier)
//                     .setOrganizationType(value!);
//               },
//             ),

//             const SizedBox(height: 28),

//             _buildLabel('Industry', required: true),
//             const SizedBox(height: 8),
//             _buildDropdown(
//               value: ref.watch(registrationProvider).industry,
//               items: const [
//                 'Information Technology',
//                 'Finance',
//                 'Healthcare',
//                 'Manufacturing',
//                 'Retail',
//                 'Education',
//                 'Other',
//               ],
//               onChanged: (value) {
//                 ref.read(registrationProvider.notifier).setIndustry(value!);
//               },
//             ),

//             const SizedBox(height: 28),

//             _buildLabel('Company Size', required: true),
//             const SizedBox(height: 8),
//             _buildDropdown(
//               value: ref.watch(registrationProvider).companySize,
//               items: const [
//                 '1–50',
//                 '51–200',
//                 '201–500',
//                 '501–1000',
//                 '1001–5000',
//                 '5000+',
//               ],
//               onChanged: (value) {
//                 ref.read(registrationProvider.notifier).setCompanySize(value!);
//               },
//             ),

//             const SizedBox(height: 28),

//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildLabel('Country', required: true),
//                       const SizedBox(height: 8),
//                       _buildDropdown(
//                         value: ref.watch(registrationProvider).country,
//                         items: const [
//                           'India',
//                           'United States',
//                           'United Kingdom',
//                           'Australia',
//                           'Canada',
//                           'Singapore',
//                         ],
//                         onChanged: (value) {
//                           ref
//                               .read(registrationProvider.notifier)
//                               .setCountry(value!);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 24),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildLabel('State / Province', required: true),
//                       const SizedBox(height: 8),
//                       _buildDropdown(
//                         value: ref.watch(registrationProvider).state,
//                         items: const [
//                           'Andhra Pradesh',
//                           'Telangana',
//                           'Karnataka',
//                           'Tamil Nadu',
//                           'Maharashtra',
//                           'Kerala',
//                         ],
//                         onChanged: (value) {
//                           ref
//                               .read(registrationProvider.notifier)
//                               .setState(value!);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),

//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildLabel('City', required: true),
//                       const SizedBox(height: 8),
//                       _buildTextField(
//                         controller: _cityController,
//                         onChanged: (value) {
//                           ref
//                               .read(registrationProvider.notifier)
//                               .setCity(value);
//                         },
//                         hint: 'Hyderabad',
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'City is required.';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 24),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildLabel('Time Zone', required: true),
//                       const SizedBox(height: 8),
//                       _buildDropdown(
//                         value: ref.watch(registrationProvider).timeZone,
//                         items: const [
//                           'Asia/Kolkata (UTC +05:30)',
//                           'Asia/Dubai (UTC +04:00)',
//                           'Europe/London (UTC +00:00)',
//                           'America/New_York (UTC -05:00)',
//                         ],
//                         onChanged: (value) {
//                           ref
//                               .read(registrationProvider.notifier)
//                               .setTimeZone(value!);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),

//             _buildLabel('Organization Logo', required: false, optional: true),

//             const SizedBox(height: 8),

//             _buildLogoUpload(),

//             const SizedBox(height: 30),

//             _buildPrimaryButton(
//               label: 'Continue',
//               onPressed: _continueFromOrganization,
//             ),

//             _buildSignInFooter(),
//           ],
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // STEP 2
//   // ADMIN ACCOUNT
//   // ============================================================

//   Widget _buildAdminStep() {
//     final registration = ref.watch(registrationProvider);

//     return ConstrainedBox(
//       constraints: const BoxConstraints(maxWidth: 900),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(
//               step: 2,
//               section: 'Super Admin Account',
//               title: 'Create your admin account',
//               description:
//                   "This is the account you'll use to manage "
//                   "${registration.organizationName.trim()}.",
//               showBack: true,
//             ),

//             const SizedBox(height: 38),

//             _buildInfoBox(
//               icon: Icons.verified_user_outlined,
//               text:
//                   "This account will automatically be assigned the "
//                   "SUPER_ADMIN role, with full access to your "
//                   "organization's workspace.",
//             ),

//             const SizedBox(height: 38),

//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildLabel('First Name', required: true),
//                       const SizedBox(height: 8),
//                       _buildTextField(
//                         controller: _firstNameController,
//                         onChanged: (value) {
//                           ref
//                               .read(registrationProvider.notifier)
//                               .setFirstName(value);
//                         },
//                         hint: 'Ananya',
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'First name is required.';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 24),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildLabel('Last Name', required: true),
//                       const SizedBox(height: 8),
//                       _buildTextField(
//                         controller: _lastNameController,
//                         onChanged: (value) {
//                           ref
//                               .read(registrationProvider.notifier)
//                               .setLastName(value);
//                         },
//                         hint: 'Rao',
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'Last name is required.';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),

//             _buildLabel('Official Email', required: true),
//             const SizedBox(height: 8),
//             _buildTextField(
//               controller: _adminEmailController,
//               onChanged: (value) {
//                 ref.read(registrationProvider.notifier).setAdminEmail(value);
//               },
//               hint: 'ananya.rao@abctech.com',
//               keyboardType: TextInputType.emailAddress,
//               validator: _emailValidator,
//             ),

//             const SizedBox(height: 28),

//             _buildLabel('Mobile Number', required: true),
//             const SizedBox(height: 8),
//             _buildTextField(
//               controller: _mobileController,
//               onChanged: (value) {
//                 ref.read(registrationProvider.notifier).setMobileNumber(value);
//               },
//               hint: '+91 98765 43210',
//               keyboardType: TextInputType.phone,
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty) {
//                   return 'Mobile number is required.';
//                 }
//                 return null;
//               },
//             ),

//             const SizedBox(height: 28),

//             _buildLabel('Username', required: true),
//             const SizedBox(height: 8),
//             _buildTextField(
//               controller: _usernameController,
//               onChanged: (value) {
//                 ref.read(registrationProvider.notifier).setUsername(value);
//               },
//               hint: 'ananya.rao',
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty) {
//                   return 'Username is required.';
//                 }
//                 return null;
//               },
//             ),

//             const SizedBox(height: 28),

//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildLabel('Password', required: true),
//                       const SizedBox(height: 8),
//                       _buildTextField(
//                         controller: _passwordController,
//                         onChanged: (value) {
//                           ref
//                               .read(registrationProvider.notifier)
//                               .setPassword(value);
//                         },
//                         hint: 'Create a password',
//                         obscureText: _obscurePassword,
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _obscurePassword = !_obscurePassword;
//                             });
//                           },
//                           icon: Icon(
//                             _obscurePassword
//                                 ? Icons.visibility_outlined
//                                 : Icons.visibility_off_outlined,
//                             color: AppTheme.textMuted,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Password is required.';
//                           }

//                           if (value.length < 8) {
//                             return 'Minimum 8 characters.';
//                           }

//                           if (!RegExp(r'[0-9]').hasMatch(value)) {
//                             return 'Include at least one number.';
//                           }

//                           if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
//                               .hasMatch(value)) {
//                             return 'Include at least one symbol.';
//                           }

//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 24),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildLabel('Confirm Password', required: true),
//                       const SizedBox(height: 8),
//                       _buildTextField(
//                         controller: _confirmPasswordController,
//                         onChanged: (value) {
//                           ref
//                               .read(registrationProvider.notifier)
//                               .setConfirmPassword(value);
//                         },
//                         hint: 'Re-enter password',
//                         obscureText: _obscureConfirmPassword,
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _obscureConfirmPassword =
//                                   !_obscureConfirmPassword;
//                             });
//                           },
//                           icon: Icon(
//                             _obscureConfirmPassword
//                                 ? Icons.visibility_outlined
//                                 : Icons.visibility_off_outlined,
//                             color: AppTheme.textMuted,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please confirm your password.';
//                           }

//                           if (value != _passwordController.text) {
//                             return 'Passwords do not match.';
//                           }

//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 8),

//             Text(
//               'Minimum 8 characters, with at least one number and one symbol.',
//               style: GoogleFonts.onest(
//                 color: const Color(0xFF9AA8BD),
//                 fontSize: 13,
//               ),
//             ),

//             const SizedBox(height: 32),

//             _buildPrimaryButton(
//               label: 'Continue',
//               onPressed: _continueFromAdmin,
//             ),

//             _buildSignInFooter(),
//           ],
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // STEP 3
//   // TERMS
//   // ============================================================

//   Widget _buildTermsStep() {
//     return ConstrainedBox(
//       constraints: const BoxConstraints(maxWidth: 900),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildHeader(
//             step: 3,
//             section: 'Terms & Authorization',
//             title: 'Review and confirm',
//             description:
//                 "One last step before we create "
//                 "${_organizationNameController.text.trim()}'s workspace.",
//             showBack: true,
//           ),

//           const SizedBox(height: 40),

//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(28),
//             decoration: BoxDecoration(
//               color: const Color(0xFFFAFBFD),
//               border: Border.all(color: AppTheme.border),
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: Column(
//               children: [
//                 _buildCheckboxRow(
//                   value: ref.watch(registrationProvider).termsAccepted,
//                   onChanged: (value) {
//                     ref
//                         .read(registrationProvider.notifier)
//                         .setTermsAccepted(value ?? false);
//                   },
//                   text: RichText(
//                     text: TextSpan(
//                       style: _termsStyle(),
//                       children: [
//                         const TextSpan(text: 'I have read and agree to the '),
//                         _linkSpan('Terms of Service'),
//                         const TextSpan(text: ' and '),
//                         _linkSpan('Privacy Policy'),
//                         const TextSpan(text: '.'),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 22),

//                 _buildCheckboxRow(
//                   value: ref.watch(registrationProvider).authorizationAccepted,
//                   onChanged: (value) {
//                     ref
//                         .read(registrationProvider.notifier)
//                         .setAuthorizationAccepted(value ?? false);
//                   },
//                   text: RichText(
//                     text: TextSpan(
//                       style: _termsStyle(),
//                       children: [
//                         const TextSpan(
//                           text: 'I confirm that I am authorized to register ',
//                         ),
//                         TextSpan(
//                           text: ref
//                               .watch(registrationProvider)
//                               .organizationName
//                               .trim(),
//                           style: _termsStyle(fontWeight: FontWeight.w700),
//                         ),
//                         const TextSpan(
//                           text:
//                               ' on One Enterprise, and I accept '
//                               'responsibility as its Super Administrator.',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 22),

//                 _buildCheckboxRow(
//                   value: ref.watch(registrationProvider).dataProcessingAccepted,
//                   onChanged: (value) {
//                     ref
//                         .read(registrationProvider.notifier)
//                         .setDataProcessingAccepted(value ?? false);
//                   },
//                   text: RichText(
//                     text: TextSpan(
//                       style: _termsStyle(),
//                       children: [
//                         const TextSpan(text: 'I agree to the '),
//                         _linkSpan('Data Processing Agreement'),
//                         const TextSpan(
//                           text:
//                               ' governing how organization data '
//                               'is stored and processed.',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 22),

//                 _buildCheckboxRow(
//                   value: ref.watch(registrationProvider).productUpdates,
//                   onChanged: (value) {
//                     ref
//                         .read(registrationProvider.notifier)
//                         .setProductUpdates(value ?? false);
//                   },
//                   text: RichText(
//                     text: TextSpan(
//                       style: _termsStyle(),
//                       children: const [
//                         TextSpan(
//                           text:
//                               'Send me product updates and security '
//                               'notices by email',
//                         ),
//                         TextSpan(
//                           text: '   OPTIONAL',
//                           style: TextStyle(
//                             fontSize: 11,
//                             letterSpacing: 1,
//                             color: Color(0xFF9AA8BD),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 18),

//           if (!_allRequiredTermsAccepted)
//             Text(
//               'Please accept all required terms before creating your account.',
//               style: GoogleFonts.onest(color: AppTheme.danger, fontSize: 12),
//             ),

//           const SizedBox(height: 18),

//           _buildPrimaryButton(
//             label: 'Create account',
//             onPressed: _createAccount,
//           ),

//           _buildSignInFooter(),
//         ],
//       ),
//     );
//   }

//   // ============================================================
//   // SUCCESS
//   // ============================================================

//   Widget _buildSuccessPage() {
//     final registration = ref.watch(registrationProvider);
//     final organizationCode = registration.organizationCode.trim().toLowerCase();

//     return Center(
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 720),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 94,
//               height: 94,
//               decoration: const BoxDecoration(
//                 color: Color(0xFFE7F7EE),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.check,
//                 color: Color(0xFF2CA566),
//                 size: 48,
//               ),
//             ),

//             const SizedBox(height: 38),

//             Text(
//               'Welcome to One Enterprise',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.onest(
//                 color: AppTheme.text,
//                 fontSize: 38,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: -1.2,
//               ),
//             ),

//             const SizedBox(height: 14),

//             Text.rich(
//               TextSpan(
//                 style: GoogleFonts.onest(
//                   color: AppTheme.textMuted,
//                   fontSize: 17,
//                   height: 1.5,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: '${registration.organizationName.trim()} ',
//                     style: const TextStyle(fontWeight: FontWeight.w700),
//                   ),
//                   const TextSpan(
//                     text:
//                         'is ready. Your Super Admin account has been '
//                         'created — verify your email to activate full access.',
//                   ),
//                 ],
//               ),
//               textAlign: TextAlign.center,
//             ),

//             const SizedBox(height: 48),

//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEEF3FF),
//                 border: Border.all(color: const Color(0xFFD3DEFF)),
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 52,
//                     height: 52,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.mail_outline,
//                       color: Color(0xFF3E64D8),
//                       size: 27,
//                     ),
//                   ),

//                   const SizedBox(width: 18),

//                   Expanded(
//                     child: Text.rich(
//                       TextSpan(
//                         style: GoogleFonts.onest(
//                           color: const Color(0xFF405274),
//                           fontSize: 15,
//                           height: 1.5,
//                         ),
//                         children: [
//                           const TextSpan(
//                             text:
//                                 "We've sent a verification link to your "
//                                 "official email. Your workspace: ",
//                           ),
//                           TextSpan(
//                             text: '$organizationCode.oneenterprise.io',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontFamily: 'monospace',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 34),

//             _buildPrimaryButton(
//               label: 'Go to sign in',
//               onPressed: () {
//                 context.go(AppRoutes.login);
//               },
//             ),

//             const SizedBox(height: 28),

//             const Divider(color: AppTheme.border),

//             const SizedBox(height: 28),

//             RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: "Didn't get the email? ",
//                     style: GoogleFonts.onest(
//                       color: AppTheme.textMuted,
//                       fontSize: 14,
//                     ),
//                   ),
//                   WidgetSpan(
//                     alignment: PlaceholderAlignment.middle,
//                     child: GestureDetector(
//                       onTap: _resendVerification,
//                       child: Text(
//                         'Resend verification',
//                         style: GoogleFonts.onest(
//                           color: const Color(0xFF3E64D8),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // CHECKBOX
//   // ============================================================

//   Widget _buildCheckboxRow({
//     required bool value,
//     required ValueChanged<bool?> onChanged,
//     required Widget text,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Checkbox(
//           value: value,
//           onChanged: onChanged,
//           activeColor: AppTheme.ink,
//           side: const BorderSide(color: Color(0xFF7C7C7C)),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Padding(padding: const EdgeInsets.only(top: 8), child: text),
//         ),
//       ],
//     );
//   }

//   // ============================================================
//   // INFO BOX
//   // ============================================================

//   Widget _buildInfoBox({required IconData icon, required String text}) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: const Color(0xFFEEF3FF),
//         border: Border.all(color: const Color(0xFFD2DEFF)),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 52,
//             height: 52,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(icon, color: const Color(0xFF3E64D8), size: 26),
//           ),
//           const SizedBox(width: 18),
//           Expanded(
//             child: Text(
//               text,
//               style: GoogleFonts.onest(
//                 color: const Color(0xFF405274),
//                 fontSize: 15,
//                 height: 1.45,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ============================================================
//   // LOGO UPLOAD
//   // ============================================================

//   Widget _buildLogoUpload() {
//     return Container(
//       width: double.infinity,
//       height: 135,
//       decoration: BoxDecoration(
//         color: const Color(0xFFFBFCFE),
//         border: Border.all(color: AppTheme.border, style: BorderStyle.solid),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(14),
//         onTap: () {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Logo upload can be connected here.')),
//           );
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.upload_outlined,
//               color: Color(0xFF9AA8BD),
//               size: 30,
//             ),
//             const SizedBox(height: 10),
//             RichText(
//               text: TextSpan(
//                 style: GoogleFonts.onest(
//                   fontSize: 14,
//                   color: const Color(0xFF9AA8BD),
//                 ),
//                 children: [
//                   TextSpan(
//                     text: 'Upload logo',
//                     style: GoogleFonts.onest(
//                       color: const Color(0xFF3E64D8),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const TextSpan(
//                     text: ' or drag and drop — PNG, JPG up to 5MB',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // INPUT
//   // ============================================================

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hint,
//     String? Function(String?)? validator,
//     TextInputType? keyboardType,
//     TextInputAction? textInputAction,
//     bool obscureText = false,
//     TextCapitalization textCapitalization = TextCapitalization.none,
//     Widget? suffixIcon,
//     ValueChanged<String>? onChanged,
//   }) {
//     return TextFormField(
//       controller: controller,
//       validator: validator,
//       keyboardType: keyboardType,
//       textInputAction: textInputAction,
//       obscureText: obscureText,
//       textCapitalization: textCapitalization,
//       onChanged: onChanged,
//       style: GoogleFonts.onest(color: AppTheme.text, fontSize: 15),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: GoogleFonts.onest(
//           color: const Color(0xFFA8B4C7),
//           fontSize: 15,
//         ),
//         suffixIcon: suffixIcon,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 18,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppTheme.border),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppTheme.border),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppTheme.ink, width: 1.5),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppTheme.danger),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppTheme.danger, width: 1.5),
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // LABEL
//   // ============================================================

//   Widget _buildLabel(
//     String label, {
//     required bool required,
//     bool optional = false,
//   }) {
//     return Row(
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.onest(
//             color: AppTheme.text,
//             fontSize: 15,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         if (required)
//           Text(
//             ' *',
//             style: GoogleFonts.onest(
//               color: const Color(0xFFD94141),
//               fontSize: 15,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         if (optional) ...[
//           const SizedBox(width: 8),
//           Text(
//             'OPTIONAL',
//             style: GoogleFonts.ibmPlexMono(
//               color: const Color(0xFF9AA8BD),
//               fontSize: 10,
//               letterSpacing: 1,
//             ),
//           ),
//         ],
//       ],
//     );
//   }

//   // ============================================================
//   // DROPDOWN
//   // ============================================================

//   Widget _buildDropdown({
//     required String value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       isExpanded: true,
//       icon: const Icon(
//         Icons.keyboard_arrow_down_rounded,
//         color: Color(0xFF91A0B5),
//       ),
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 18,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppTheme.border),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppTheme.border),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppTheme.ink, width: 1.5),
//         ),
//       ),
//       style: GoogleFonts.onest(color: AppTheme.text, fontSize: 15),
//       items: items
//           .map(
//             (item) => DropdownMenuItem<String>(value: item, child: Text(item)),
//           )
//           .toList(),
//     );
//   }

//   // ============================================================
//   // PRIMARY BUTTON
//   // ============================================================

//   Widget _buildPrimaryButton({
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       height: 58,
//       child: ElevatedButton(
//         onPressed: ref.watch(registrationProvider).isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppTheme.ink,
//           foregroundColor: Colors.white,
//           disabledBackgroundColor: AppTheme.ink.withValues(alpha: 0.55),
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: ref.watch(registrationProvider).isLoading
//             ? const SizedBox(
//                 width: 22,
//                 height: 22,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   color: Colors.white,
//                 ),
//               )
//             : Text(
//                 label,
//                 style: GoogleFonts.onest(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//       ),
//     );
//   }

//   // ============================================================
//   // FOOTER
//   // ============================================================

//   Widget _buildSignInFooter() {
//     return Column(
//       children: [
//         const SizedBox(height: 40),
//         const Divider(color: AppTheme.border),
//         const SizedBox(height: 28),
//         Center(
//           child: RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: 'Already have an organization? ',
//                   style: GoogleFonts.onest(
//                     color: AppTheme.textMuted,
//                     fontSize: 14,
//                   ),
//                 ),
//                 WidgetSpan(
//                   alignment: PlaceholderAlignment.middle,
//                   child: GestureDetector(
//                     onTap: () {
//                       context.go(AppRoutes.login);
//                     },
//                     child: Text(
//                       'Sign in',
//                       style: GoogleFonts.onest(
//                         color: const Color(0xFF3E64D8),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // ============================================================
//   // VALIDATION / ACTIONS
//   // ============================================================

//   void _continueFromOrganization() {
//     FocusScope.of(context).unfocus();

//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     ref.read(registrationProvider.notifier).nextStep();
//   }

//   void _continueFromAdmin() {
//     FocusScope.of(context).unfocus();

//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     ref.read(registrationProvider.notifier).nextStep();
//   }

//   bool get _allRequiredTermsAccepted {
//     final registration = ref.read(registrationProvider);
//     return registration.termsAccepted &&
//         registration.authorizationAccepted &&
//         registration.dataProcessingAccepted;
//   }

//   Future<void> _createAccount() async {
//     FocusScope.of(context).unfocus();

//     if (!_allRequiredTermsAccepted) {
//       setState(() {});
//       return;
//     }

//     ref.read(registrationProvider.notifier).setLoading(true);

//     try {
//       final registration = ref.read(registrationProvider);
//       final firstName = registration.firstName.trim();
//       final lastName = registration.lastName.trim();
//       final fullName = '$firstName $lastName';

//       final email = registration.adminEmail.trim();
//       final password = registration.password;

//       // ========================================================
//       // RIVERPOD REGISTRATION
//       // ========================================================

//       ref.read(userProvider.notifier).register(fullName, email, password);

//       // Give the UI a moment to complete the operation.
//       await Future.delayed(const Duration(milliseconds: 500));

//       if (!mounted) return;

//       ref.read(registrationProvider.notifier).setLoading(false);
//       ref.read(registrationProvider.notifier).setRegistrationCompleted(true);
//     } catch (e) {
//       if (!mounted) return;

//       ref.read(registrationProvider.notifier).setLoading(false);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Unable to create account. Please try again.',
//             style: GoogleFonts.onest(color: Colors.white),
//           ),
//           backgroundColor: AppTheme.danger,
//         ),
//       );
//     }
//   }

//   void _resendVerification() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Verification email has been resent.')),
//     );
//   }

//   // ============================================================
//   // HELPERS
//   // ============================================================

//   String _generateOrganizationCode(String name) {
//     final words = name
//         .trim()
//         .toUpperCase()
//         .split(RegExp(r'\s+'))
//         .where((e) => e.isNotEmpty)
//         .toList();

//     if (words.isEmpty) {
//       return '';
//     }

//     if (words.length == 1) {
//       return words.first.length > 8 ? words.first.substring(0, 8) : words.first;
//     }

//     return '${words.first.substring(0, words.first.length >= 3 ? 3 : words.first.length)}-${words[1].substring(0, words[1].length >= 4 ? 4 : words[1].length)}';
//   }

//   String? _emailValidator(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Email is required.';
//     }

//     final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

//     if (!emailRegex.hasMatch(value.trim())) {
//       return 'Please enter a valid email address.';
//     }

//     return null;
//   }

//   TextStyle _termsStyle({FontWeight fontWeight = FontWeight.w400}) {
//     return GoogleFonts.onest(
//       color: const Color(0xFF52627A),
//       fontSize: 15,
//       height: 1.5,
//       fontWeight: fontWeight,
//     );
//   }

//   TextSpan _linkSpan(String text) {
//     return TextSpan(
//       text: text,
//       style: GoogleFonts.onest(
//         color: const Color(0xFF3E64D8),
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_theme.dart';
import '../../providers/user_provider.dart';
import '../../providers/registration_provider.dart';
import '../../routes/routes.dart';
import '../../widgets/auth_layout.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // ============================================================
  // ORGANIZATION
  // ============================================================

  final _organizationNameController = TextEditingController();
  final _organizationCodeController = TextEditingController();
  final _cityController = TextEditingController();

  // ============================================================
  // ADMIN
  // ============================================================

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _adminEmailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // ============================================================
  // DISPOSE
  // ============================================================
  @override
  void initState() {
    super.initState();

    // Start every new registration with a fresh registration state.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(registrationProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _organizationNameController.dispose();
    _organizationCodeController.dispose();
    _cityController.dispose();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _adminEmailController.dispose();
    _mobileController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final registration = ref.watch(registrationProvider);

    return AuthLayout(
      scrollable: true,
      child: registration.registrationCompleted
          ? _buildSuccessPage()
          : _buildCurrentStep(registration.currentStep),
    );
  }

  Widget _buildCurrentStep(int currentStep) {
    switch (currentStep) {
      case 1:
        return _buildOrganizationStep();

      case 2:
        return _buildAdminStep();

      case 3:
        return _buildTermsStep();

      default:
        return _buildOrganizationStep();
    }
  }

  // ============================================================
  // COMMON HEADER
  // ============================================================

  Widget _buildHeader({
    required int step,
    required String section,
    required String title,
    required String description,
    bool showBack = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showBack) ...[
          TextButton.icon(
            onPressed: () {
              ref.read(registrationProvider.notifier).previousStep();
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: AppTheme.textMuted,
            ),
            icon: const Icon(Icons.chevron_left, size: 20),
            label: Text(
              'Back',
              style: GoogleFonts.onest(color: AppTheme.textMuted, fontSize: 14),
            ),
          ),
          const SizedBox(height: 26),
        ],

        _buildProgressIndicator(step),

        const SizedBox(height: 38),

        Text(
          'STEP $step OF 3  ·  ${section.toUpperCase()}',
          style: GoogleFonts.ibmPlexMono(
            color: const Color(0xFF9AA8BD),
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          title,
          style: GoogleFonts.onest(
            color: AppTheme.text,
            fontSize: 38,
            fontWeight: FontWeight.w600,
            letterSpacing: -1.2,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          description,
          style: GoogleFonts.onest(
            color: AppTheme.textMuted,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PROGRESS
  // ============================================================

  Widget _buildProgressIndicator(int step) {
    return Row(
      children: List.generate(3, (index) {
        final current = index + 1;

        return Expanded(
          child: Container(
            height: 5,
            margin: EdgeInsets.only(right: index == 2 ? 0 : 10),
            decoration: BoxDecoration(
              color: current <= step
                  ? current == step
                        ? AppTheme.ink
                        : const Color(0xFF6D91F2)
                  : const Color(0xFFE3E7ED),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      }),
    );
  }

  // ============================================================
  // STEP 1
  // ORGANIZATION DETAILS
  // ============================================================

  Widget _buildOrganizationStep() {
    final registration = ref.watch(registrationProvider);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(
              step: 1,
              section: 'Organization Details',
              title: 'Tell us about your organization',
              description: "This creates your organization's workspace on One Enterprise.",
            ),

            const SizedBox(height: 42),

            // Organization Name
            _buildLabel('Organization Name', required: true),

            const SizedBox(height: 8),

            _buildTextField(
              controller: _organizationNameController,
              hint: 'ABC Technologies Pvt Ltd',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Organization name is required.';
                }

                return null;
              },
              onChanged: (value) {
                ref
                    .read(registrationProvider.notifier)
                    .setOrganizationName(value);

                if (_organizationCodeController.text.isEmpty) {
                  final code = _generateOrganizationCode(value);

                  _organizationCodeController.text = code;

                  ref
                      .read(registrationProvider.notifier)
                      .setOrganizationCode(code);
                }
              },
            ),

            const SizedBox(height: 28),

            // Organization Code
            _buildLabel('Organization Code', required: true),

            const SizedBox(height: 8),

            _buildTextField(
              controller: _organizationCodeController,
              hint: 'ABC-TECH',
              textCapitalization: TextCapitalization.characters,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Organization code is required.';
                }

                return null;
              },
              onChanged: (value) {
                ref
                    .read(registrationProvider.notifier)
                    .setOrganizationCode(value);
              },
            ),

            const SizedBox(height: 8),

            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Auto-generated from your organization name — ',
                  style: GoogleFonts.onest(
                    color: const Color(0xFF9AA8BD),
                    fontSize: 13,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _organizationCodeController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _organizationCodeController.text.length,
                    );
                  },
                  child: Text(
                    'edit manually',
                    style: GoogleFonts.onest(
                      color: const Color(0xFF3E64D8),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Organization Type
            _buildLabel('Organization Type', required: true),

            const SizedBox(height: 8),

            _buildDropdown(
              value: registration.organizationType,
              items: const [
                'Enterprise',
                'Startup',
                'SME',
                'Government',
                'Non-Profit',
              ],
              onChanged: (value) {
                if (value == null) return;

                ref
                    .read(registrationProvider.notifier)
                    .setOrganizationType(value);
              },
            ),

            const SizedBox(height: 28),

            // Industry
            _buildLabel('Industry', required: true),

            const SizedBox(height: 8),

            _buildDropdown(
              value: registration.industry,
              items: const [
                'Information Technology',
                'Finance',
                'Healthcare',
                'Manufacturing',
                'Retail',
                'Education',
                'Other',
              ],
              onChanged: (value) {
                if (value == null) return;

                ref.read(registrationProvider.notifier).setIndustry(value);
              },
            ),

            const SizedBox(height: 28),

            // Company Size
            _buildLabel('Company Size', required: true),

            const SizedBox(height: 8),

            _buildDropdown(
              value: registration.companySize,
              items: const [
                '1–50',
                '51–200',
                '201–500',
                '501–1000',
                '1001–5000',
                '5000+',
              ],
              onChanged: (value) {
                if (value == null) return;

                ref.read(registrationProvider.notifier).setCompanySize(value);
              },
            ),

            const SizedBox(height: 28),

            // Country + State
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Country', required: true),

                      const SizedBox(height: 8),

                      _buildDropdown(
                        value: registration.country,
                        items: const [
                          'India',
                          'United States',
                          'United Kingdom',
                          'Australia',
                          'Canada',
                          'Singapore',
                        ],
                        onChanged: (value) {
                          if (value == null) return;

                          ref
                              .read(registrationProvider.notifier)
                              .setCountry(value);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 24),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('State / Province', required: true),

                      const SizedBox(height: 8),

                      _buildDropdown(
                        value: registration.state,
                        items: const [
                          'Andhra Pradesh',
                          'Telangana',
                          'Karnataka',
                          'Tamil Nadu',
                          'Maharashtra',
                          'Kerala',
                        ],
                        onChanged: (value) {
                          if (value == null) return;

                          ref
                              .read(registrationProvider.notifier)
                              .setState(value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // City + Time Zone
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('City', required: true),

                      const SizedBox(height: 8),

                      _buildTextField(
                        controller: _cityController,
                        hint: 'Hyderabad',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'City is required.';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          ref
                              .read(registrationProvider.notifier)
                              .setCity(value);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 24),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Time Zone', required: true),

                      const SizedBox(height: 8),

                      _buildDropdown(
                        value: registration.timeZone,
                        items: const [
                          'Asia/Kolkata (UTC +05:30)',
                          'Asia/Dubai (UTC +04:00)',
                          'Europe/London (UTC +00:00)',
                          'America/New_York (UTC -05:00)',
                        ],
                        onChanged: (value) {
                          if (value == null) return;

                          ref
                              .read(registrationProvider.notifier)
                              .setTimeZone(value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            _buildLabel('Organization Logo', required: false, optional: true),

            const SizedBox(height: 8),

            _buildLogoUpload(),

            const SizedBox(height: 30),

            _buildPrimaryButton(
              label: 'Continue',
              onPressed: _continueFromOrganization,
            ),

            _buildSignInFooter(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // STEP 2
  // ADMIN ACCOUNT
  // ============================================================

  Widget _buildAdminStep() {
    final registration = ref.watch(registrationProvider);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(
              step: 2,
              section: 'Super Admin Account',
              title: 'Create your admin account',
              description:
                  "This is the account you'll use to manage "
                  "${registration.organizationName.trim()}.",
              showBack: true,
            ),

            const SizedBox(height: 38),

            _buildInfoBox(
              icon: Icons.verified_user_outlined,
              text:
                  "This account will automatically be assigned the "
                  "SUPER_ADMIN role, with full access to your "
                  "organization's workspace.",
            ),

            const SizedBox(height: 38),

            // First + Last Name
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('First Name', required: true),

                      const SizedBox(height: 8),

                      _buildTextField(
                        controller: _firstNameController,
                        hint: 'Ananya',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'First name is required.';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          ref
                              .read(registrationProvider.notifier)
                              .setFirstName(value);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 24),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Last Name', required: true),

                      const SizedBox(height: 8),

                      _buildTextField(
                        controller: _lastNameController,
                        hint: 'Rao',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Last name is required.';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          ref
                              .read(registrationProvider.notifier)
                              .setLastName(value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Email
            _buildLabel('Official Email', required: true),

            const SizedBox(height: 8),

            _buildTextField(
              controller: _adminEmailController,
              hint: 'ananya.rao@abctech.com',
              keyboardType: TextInputType.emailAddress,
              validator: _emailValidator,
              onChanged: (value) {
                ref.read(registrationProvider.notifier).setAdminEmail(value);
              },
            ),

            const SizedBox(height: 28),

            // Mobile
            _buildLabel('Mobile Number', required: true),

            const SizedBox(height: 8),

            _buildTextField(
              controller: _mobileController,
              hint: '+91 98765 43210',
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Mobile number is required.';
                }

                return null;
              },
              onChanged: (value) {
                ref.read(registrationProvider.notifier).setMobileNumber(value);
              },
            ),

            const SizedBox(height: 28),

            // Username
            _buildLabel('Username', required: true),

            const SizedBox(height: 8),

            _buildTextField(
              controller: _usernameController,
              hint: 'ananya.rao',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Username is required.';
                }

                return null;
              },
              onChanged: (value) {
                ref.read(registrationProvider.notifier).setUsername(value);
              },
            ),

            const SizedBox(height: 28),

            // Password + Confirm Password
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Password', required: true),

                      const SizedBox(height: 8),

                      _buildTextField(
                        controller: _passwordController,
                        hint: 'Create a password',
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppTheme.textMuted,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required.';
                          }

                          if (value.length < 8) {
                            return 'Minimum 8 characters.';
                          }

                          if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return 'Include at least one number.';
                          }

                          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                              .hasMatch(value)) {
                            return 'Include at least one symbol.';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          ref
                              .read(registrationProvider.notifier)
                              .setPassword(value);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 24),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Confirm Password', required: true),

                      const SizedBox(height: 8),

                      _buildTextField(
                        controller: _confirmPasswordController,
                        hint: 'Re-enter password',
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppTheme.textMuted,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password.';
                          }

                          if (value != _passwordController.text) {
                            return 'Passwords do not match.';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          ref
                              .read(registrationProvider.notifier)
                              .setConfirmPassword(value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              'Minimum 8 characters, with at least one number and one symbol.',
              style: GoogleFonts.onest(
                color: const Color(0xFF9AA8BD),
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 32),

            _buildPrimaryButton(
              label: 'Continue',
              onPressed: _continueFromAdmin,
            ),

            _buildSignInFooter(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // STEP 3
  // TERMS
  // ============================================================

  Widget _buildTermsStep() {
    final registration = ref.watch(registrationProvider);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            step: 3,
            section: 'Terms & Authorization',
            title: 'Review and confirm',
            description:
                "One last step before we create "
                "${registration.organizationName.trim()}'s workspace.",
            showBack: true,
          ),

          const SizedBox(height: 40),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFBFD),
              border: Border.all(color: AppTheme.border),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                // Terms
                _buildCheckboxRow(
                  value: registration.termsAccepted,
                  onChanged: (value) {
                    ref
                        .read(registrationProvider.notifier)
                        .setTermsAccepted(value ?? false);
                  },
                  text: RichText(
                    text: TextSpan(
                      style: _termsStyle(),
                      children: [
                        const TextSpan(text: 'I have read and agree to the '),
                        _linkSpan('Terms of Service'),
                        const TextSpan(text: ' and '),
                        _linkSpan('Privacy Policy'),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // Authorization
                _buildCheckboxRow(
                  value: registration.authorizationAccepted,
                  onChanged: (value) {
                    ref
                        .read(registrationProvider.notifier)
                        .setAuthorizationAccepted(value ?? false);
                  },
                  text: RichText(
                    text: TextSpan(
                      style: _termsStyle(),
                      children: [
                        const TextSpan(
                          text: 'I confirm that I am authorized to register ',
                        ),
                        TextSpan(
                          text: registration.organizationName.trim(),
                          style: _termsStyle(fontWeight: FontWeight.w700),
                        ),
                        const TextSpan(
                          text:
                              ' on One Enterprise, and I accept '
                              'responsibility as its Super Administrator.',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // Data Processing
                _buildCheckboxRow(
                  value: registration.dataProcessingAccepted,
                  onChanged: (value) {
                    ref
                        .read(registrationProvider.notifier)
                        .setDataProcessingAccepted(value ?? false);
                  },
                  text: RichText(
                    text: TextSpan(
                      style: _termsStyle(),
                      children: [
                        const TextSpan(text: 'I agree to the '),
                        _linkSpan('Data Processing Agreement'),
                        const TextSpan(
                          text:
                              ' governing how organization data '
                              'is stored and processed.',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // Product Updates
                _buildCheckboxRow(
                  value: registration.productUpdates,
                  onChanged: (value) {
                    ref
                        .read(registrationProvider.notifier)
                        .setProductUpdates(value ?? false);
                  },
                  text: RichText(
                    text: TextSpan(
                      style: _termsStyle(),
                      children: const [
                        TextSpan(
                          text:
                              'Send me product updates and security '
                              'notices by email',
                        ),
                        TextSpan(
                          text: '   OPTIONAL',
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 1,
                            color: Color(0xFF9AA8BD),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          if (!_allRequiredTermsAccepted)
            Text(
              'Please accept all required terms before creating your account.',
              style: GoogleFonts.onest(color: AppTheme.danger, fontSize: 12),
            ),

          const SizedBox(height: 18),

          _buildPrimaryButton(
            label: 'Create account',
            onPressed: _createAccount,
          ),

          _buildSignInFooter(),
        ],
      ),
    );
  }

  // ============================================================
  // SUCCESS
  // ============================================================

  Widget _buildSuccessPage() {
    final registration = ref.watch(registrationProvider);

    final organizationCode = registration.organizationCode.trim().toLowerCase();

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 94,
              height: 94,
              decoration: const BoxDecoration(
                color: Color(0xFFE7F7EE),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Color(0xFF2CA566),
                size: 48,
              ),
            ),

            const SizedBox(height: 38),

            Text(
              'Welcome to One Enterprise',
              textAlign: TextAlign.center,
              style: GoogleFonts.onest(
                color: AppTheme.text,
                fontSize: 38,
                fontWeight: FontWeight.w600,
                letterSpacing: -1.2,
              ),
            ),

            const SizedBox(height: 14),

            Text.rich(
              TextSpan(
                style: GoogleFonts.onest(
                  color: AppTheme.textMuted,
                  fontSize: 17,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: '${registration.organizationName.trim()} ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const TextSpan(
                    text:
                        'is ready. Your Super Admin account has been '
                        'created — verify your email to activate full access.',
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 48),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF3FF),
                border: Border.all(color: const Color(0xFFD3DEFF)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.mail_outline,
                      color: Color(0xFF3E64D8),
                      size: 27,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: GoogleFonts.onest(
                          color: const Color(0xFF405274),
                          fontSize: 15,
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                            text:
                                "We've sent a verification link to your "
                                "official email. Your workspace: ",
                          ),
                          TextSpan(
                            text: '$organizationCode.oneenterprise.io',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 34),

            _buildPrimaryButton(
              label: 'Go to sign in',
              onPressed: () {
                context.go(AppRoutes.login);
              },
            ),

            const SizedBox(height: 28),

            const Divider(color: AppTheme.border),

            const SizedBox(height: 28),

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Didn't get the email? ",
                    style: GoogleFonts.onest(
                      color: AppTheme.textMuted,
                      fontSize: 14,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: _resendVerification,
                      child: Text(
                        'Resend verification',
                        style: GoogleFonts.onest(
                          color: const Color(0xFF3E64D8),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CHECKBOX
  // ============================================================

  Widget _buildCheckboxRow({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required Widget text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.ink,
          side: const BorderSide(color: Color(0xFF7C7C7C)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Padding(padding: const EdgeInsets.only(top: 8), child: text),
        ),
      ],
    );
  }

  // ============================================================
  // INFO BOX
  // ============================================================

  Widget _buildInfoBox({required IconData icon, required String text}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF3FF),
        border: Border.all(color: const Color(0xFFD2DEFF)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF3E64D8), size: 26),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Text(
              text,
              style: GoogleFonts.onest(
                color: const Color(0xFF405274),
                fontSize: 15,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOGO UPLOAD
  // ============================================================

  Widget _buildLogoUpload() {
    return Container(
      width: double.infinity,
      height: 135,
      decoration: BoxDecoration(
        color: const Color(0xFFFBFCFE),
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logo upload can be connected here.')),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.upload_outlined,
              color: Color(0xFF9AA8BD),
              size: 30,
            ),

            const SizedBox(height: 10),

            RichText(
              text: TextSpan(
                style: GoogleFonts.onest(
                  fontSize: 14,
                  color: const Color(0xFF9AA8BD),
                ),
                children: [
                  TextSpan(
                    text: 'Upload logo',
                    style: GoogleFonts.onest(
                      color: const Color(0xFF3E64D8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(
                    text: ' or drag and drop — PNG, JPG up to 5MB',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // INPUT
  // ============================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool obscureText = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    Widget? suffixIcon,
    ValueChanged<String>? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      style: GoogleFonts.onest(color: AppTheme.text, fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.onest(
          color: const Color(0xFFA8B4C7),
          fontSize: 15,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.ink, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.danger, width: 1.5),
        ),
      ),
    );
  }

  // ============================================================
  // LABEL
  // ============================================================

  Widget _buildLabel(
    String label, {
    required bool required,
    bool optional = false,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.onest(
            color: AppTheme.text,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),

        if (required)
          Text(
            ' *',
            style: GoogleFonts.onest(
              color: const Color(0xFFD94141),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

        if (optional) ...[
          const SizedBox(width: 8),
          Text(
            'OPTIONAL',
            style: GoogleFonts.ibmPlexMono(
              color: const Color(0xFF9AA8BD),
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
        ],
      ],
    );
  }

  // ============================================================
  // DROPDOWN
  // ============================================================

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Color(0xFF91A0B5),
      ),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.ink, width: 1.5),
        ),
      ),
      style: GoogleFonts.onest(color: AppTheme.text, fontSize: 15),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(value: item, child: Text(item)),
          )
          .toList(),
    );
  }

  // ============================================================
  // PRIMARY BUTTON
  // ============================================================

  Widget _buildPrimaryButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    final isLoading = ref.watch(registrationProvider).isLoading;

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.ink,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppTheme.ink.withValues(alpha: 0.55),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: GoogleFonts.onest(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _buildSignInFooter() {
    return Column(
      children: [
        const SizedBox(height: 40),

        const Divider(color: AppTheme.border),

        const SizedBox(height: 28),

        Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Already have an organization? ',
                  style: GoogleFonts.onest(
                    color: AppTheme.textMuted,
                    fontSize: 14,
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: GestureDetector(
                    onTap: () {
                      context.go(AppRoutes.login);
                    },
                    child: Text(
                      'Sign in',
                      style: GoogleFonts.onest(
                        color: const Color(0xFF3E64D8),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
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
  // VALIDATION / ACTIONS
  // ============================================================

  void _continueFromOrganization() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref.read(registrationProvider.notifier).nextStep();
  }

  void _continueFromAdmin() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref.read(registrationProvider.notifier).nextStep();
  }

  bool get _allRequiredTermsAccepted {
    final registration = ref.read(registrationProvider);

    return registration.termsAccepted &&
        registration.authorizationAccepted &&
        registration.dataProcessingAccepted;
  }

  Future<void> _createAccount() async {
    FocusScope.of(context).unfocus();

    if (!_allRequiredTermsAccepted) {
      return;
    }

    ref.read(registrationProvider.notifier).setLoading(true);

    try {
      final registration = ref.read(registrationProvider);

      final firstName = registration.firstName.trim();

      final lastName = registration.lastName.trim();

      final fullName = '$firstName $lastName'.trim();

      final email = registration.adminEmail.trim();

      final password = registration.password;

      // ========================================================
      // RIVERPOD USER REGISTRATION
      // ========================================================

      ref.read(userProvider.notifier).register(fullName, email, password);

      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      ref.read(registrationProvider.notifier).setLoading(false);

      ref.read(registrationProvider.notifier).setRegistrationCompleted(true);
    } catch (e) {
      if (!mounted) return;

      ref.read(registrationProvider.notifier).setLoading(false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to create account. Please try again.',
            style: GoogleFonts.onest(color: Colors.white),
          ),
          backgroundColor: AppTheme.danger,
        ),
      );
    }
  }

  void _resendVerification() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verification email has been resent.')),
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================

  String _generateOrganizationCode(String name) {
    final words = name
        .trim()
        .toUpperCase()
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .toList();

    if (words.isEmpty) {
      return '';
    }

    if (words.length == 1) {
      return words.first.length > 8 ? words.first.substring(0, 8) : words.first;
    }

    final first = words.first;

    final second = words[1];

    final firstPart = first.substring(0, first.length >= 3 ? 3 : first.length);

    final secondPart = second.substring(
      0,
      second.length >= 4 ? 4 : second.length,
    );

    return '$firstPart-$secondPart';
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }

    return null;
  }

  TextStyle _termsStyle({FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.onest(
      color: const Color(0xFF52627A),
      fontSize: 15,
      height: 1.5,
      fontWeight: fontWeight,
    );
  }

  TextSpan _linkSpan(String text) {
    return TextSpan(
      text: text,
      style: GoogleFonts.onest(
        color: const Color(0xFF3E64D8),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
