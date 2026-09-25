import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app_theme.dart';
import '../../providers/user_provider.dart';
import '../../routes/routes.dart';
import '../../widgets/auth_layout.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // ============================================================
  // CONTROLLERS
  // ============================================================

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final verificationController = TextEditingController();

  // ============================================================
  // STATE
  // ============================================================

  bool hidePassword = true;
  bool showTwoStep = false;

  String errorMessage = '';
  String verificationCode = '';

  // ============================================================
  // GENERATE VERIFICATION CODE
  // ============================================================

  void generateVerificationCode() {
    final random = Random();

    final code = (100000 + random.nextInt(900000)).toString();

    setState(() {
      verificationCode = code;
      showTwoStep = true;
      errorMessage = '';
    });
  }

  // ============================================================
  // LOGIN
  // ============================================================

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      errorMessage = '';
    });

    // Empty validation
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Please enter email and password';
      });

      return;
    }

    // ==========================================================
    // PREDEFINED TEST ACCOUNT
    // ==========================================================

    const testEmail = 'user@gmail.com';
    const testPassword = '123456';

    final isPredefinedUser = email == testEmail && password == testPassword;

    // ==========================================================
    // REGISTERED USER
    // ==========================================================

    final isRegisteredUser = ref
        .read(userProvider.notifier)
        .validateLogin(email, password);

    // ==========================================================
    // SUCCESS
    // ==========================================================

    if (isPredefinedUser || isRegisteredUser) {
      generateVerificationCode();
    } else {
      setState(() {
        errorMessage = 'Invalid email or password';
      });
    }
  }

  // ============================================================
  // GOOGLE LOGIN
  // ============================================================

  void loginWithGoogle() {
    // Frontend-only Google login for POC

    const googleEmail = 'googleuser@gmail.com';

    ref.read(userProvider.notifier).login(googleEmail);

    context.go(AppRoutes.dashboard);
  }

  // ============================================================
  // VERIFY TWO STEP
  // ============================================================

  void verifyTwoStep() {
    final enteredCode = verificationController.text.trim();

    setState(() {
      errorMessage = '';
    });

    if (enteredCode.isEmpty) {
      setState(() {
        errorMessage = 'Please enter the verification code';
      });

      return;
    }

    if (enteredCode != verificationCode) {
      setState(() {
        errorMessage = 'Invalid verification code';
      });

      return;
    }

    ref.read(userProvider.notifier).login(emailController.text.trim());

    context.go(AppRoutes.dashboard);
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    verificationController.dispose();

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: showTwoStep ? _buildTwoStepLogin() : _buildLoginForm(),
    );
  }

  // ============================================================
  // LOGIN FORM
  // ============================================================

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================================
            // STEP
            // ======================================================

            Text(
              'STEP 1 OF 2  ·  IDENTITY',
              style: GoogleFonts.ibmPlexMono(
                color: AppTheme.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 18),

            // ======================================================
            // TITLE
            // ======================================================
            Text(
              'Sign in',
              style: GoogleFonts.onest(
                color: AppTheme.text,
                fontSize: 38,
                fontWeight: FontWeight.w600,
                height: 1.1,
                letterSpacing: -1.2,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Enter your work email and password to continue.',
              style: GoogleFonts.onest(
                color: AppTheme.textMuted,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 38),

            // ======================================================
            // EMAIL
            // ======================================================
            _buildFieldLabel('Work email'),

            const SizedBox(height: 8),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: _inputDecoration(hint: 'you@company.com'),
            ),

            const SizedBox(height: 22),

            // ======================================================
            // PASSWORD
            // ======================================================
            _buildFieldLabel('Password'),

            const SizedBox(height: 8),

            TextField(
              controller: passwordController,
              obscureText: hidePassword,
              onSubmitted: (_) => login(),
              decoration: _inputDecoration(
                hint: 'Enter your password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppTheme.textMuted,
                    size: 21,
                  ),
                ),
              ),
            ),

            // ======================================================
            // ERROR
            // ======================================================
            if (errorMessage.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildErrorMessage(),
            ],

            const SizedBox(height: 16),

            // ======================================================
            // REMEMBER / FORGOT PASSWORD
            // ======================================================
            Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: false,
                    activeColor: AppTheme.ink,
                    side: const BorderSide(color: AppTheme.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onChanged: (_) {},
                  ),
                ),

                const SizedBox(width: 9),

                Expanded(
                  child: Text(
                    'Remember this device for 30 days',
                    style: GoogleFonts.onest(
                      color: AppTheme.textMuted,
                      fontSize: 13,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    context.push(AppRoutes.forgotPassword);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forgot password?',
                    style: GoogleFonts.onest(
                      color: AppTheme.ink3,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // ======================================================
            // SIGN IN BUTTON
            // ======================================================
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.ink,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Sign in',
                  style: GoogleFonts.onest(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ======================================================
            // DIVIDER
            // ======================================================
            Row(
              children: [
                const Expanded(child: Divider(color: AppTheme.border)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'or continue with',
                    style: GoogleFonts.onest(
                      color: AppTheme.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ),

                const Expanded(child: Divider(color: AppTheme.border)),
              ],
            ),

            const SizedBox(height: 18),

            // ======================================================
            // GOOGLE
            // ======================================================
            _buildSocialButton(
              icon: 'G',
              label: 'Google',
              onPressed: loginWithGoogle,
              iconColor: const Color(0xFF4285F4),
            ),

            const SizedBox(height: 12),

            // ======================================================
            // MICROSOFT
            // ======================================================
            _buildMicrosoftButton(),

            const SizedBox(height: 12),

            // ======================================================
            // COMPANY SSO
            // ======================================================
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () {
                  // SSO integration can be connected later.
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.text,
                  backgroundColor: AppTheme.paper,
                  side: const BorderSide(color: AppTheme.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.people_outline,
                      size: 21,
                      color: AppTheme.text,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Company SSO (SAML)',
                      style: GoogleFonts.onest(
                        color: AppTheme.text,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ======================================================
            // REGISTER
            // ======================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 22),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppTheme.border)),
              ),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'New to One Enterprise? ',
                        style: GoogleFonts.onest(
                          color: AppTheme.textMuted,
                          fontSize: 13,
                        ),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            context.push(AppRoutes.register);
                          },
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.onest(
                              color: AppTheme.ink3,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
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

  // ============================================================
  // TWO STEP VERIFICATION
  // ============================================================

  Widget _buildTwoStepLogin() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================================
            // BACK
            // ======================================================

            TextButton.icon(
              onPressed: () {
                setState(() {
                  showTwoStep = false;
                  verificationCode = '';
                  verificationController.clear();
                  errorMessage = '';
                });
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                foregroundColor: AppTheme.textMuted,
              ),
              icon: const Icon(Icons.arrow_back, size: 18),
              label: Text('Back', style: GoogleFonts.onest(fontSize: 14)),
            ),

            const SizedBox(height: 28),

            // ======================================================
            // STEP
            // ======================================================
            Text(
              'STEP 2 OF 2  ·  VERIFICATION',
              style: GoogleFonts.ibmPlexMono(
                color: AppTheme.textMuted,
                fontSize: 12,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 18),

            // ======================================================
            // TITLE
            // ======================================================
            Text(
              'Verify your identity',
              style: GoogleFonts.onest(
                color: AppTheme.text,
                fontSize: 34,
                fontWeight: FontWeight.w600,
                letterSpacing: -1,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Enter the verification code to complete sign in.',
              style: GoogleFonts.onest(
                color: AppTheme.textMuted,
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            // ======================================================
            // ACCOUNT
            // ======================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.paperDim,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.amberAI, AppTheme.tealData],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 21,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          emailController.text.trim(),
                          style: GoogleFonts.onest(
                            color: AppTheme.text,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Verification required to continue',
                          style: GoogleFonts.onest(
                            color: AppTheme.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            // ======================================================
            // VERIFICATION CODE
            // ======================================================
            _buildFieldLabel('Verification code'),

            const SizedBox(height: 8),

            TextField(
              controller: verificationController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: GoogleFonts.ibmPlexMono(
                color: AppTheme.text,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 5,
              ),
              decoration: _inputDecoration(hint: 'Enter 6-digit code')
                  .copyWith(counterText: ''),
              onSubmitted: (_) => verifyTwoStep(),
            ),

            // ======================================================
            // POC CODE
            // ======================================================
            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.paperDim,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.border),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppTheme.info,
                    size: 18,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      'POC verification code: $verificationCode',
                      style: GoogleFonts.ibmPlexMono(
                        color: AppTheme.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ======================================================
            // ERROR
            // ======================================================
            if (errorMessage.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildErrorMessage(),
            ],

            const SizedBox(height: 22),

            // ======================================================
            // VERIFY BUTTON
            // ======================================================
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: verifyTwoStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.ink,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Verify and sign in',
                  style: GoogleFonts.onest(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ======================================================
            // SECURITY NOTE
            // ======================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppTheme.border)),
              ),
              child: Text(
                'Your account is protected by One Enterprise '
                'identity and access policies.',
                textAlign: TextAlign.center,
                style: GoogleFonts.onest(
                  color: AppTheme.textMuted,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FIELD LABEL
  // ============================================================

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.onest(
        color: AppTheme.text,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration _inputDecoration({required String hint, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,

      hintStyle: GoogleFonts.onest(
        color: AppTheme.textMuted.withValues(alpha: 0.65),
        fontSize: 14,
      ),

      suffixIcon: suffixIcon,

      filled: true,

      fillColor: AppTheme.paper,

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.border),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.border),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.ink3, width: 1.5),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.danger),
      ),
    );
  }

  // ============================================================
  // ERROR MESSAGE
  // ============================================================

  Widget _buildErrorMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.danger.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.danger.withValues(alpha: 0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: AppTheme.danger, size: 18),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              errorMessage,
              style: GoogleFonts.onest(
                color: AppTheme.danger,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // GOOGLE BUTTON
  // ============================================================

  Widget _buildSocialButton({
    required String icon,
    required String label,
    required VoidCallback onPressed,
    required Color iconColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.text,
          backgroundColor: AppTheme.paper,
          side: const BorderSide(color: AppTheme.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: GoogleFonts.onest(
                color: iconColor,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(width: 10),

            Text(
              label,
              style: GoogleFonts.onest(
                color: AppTheme.text,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MICROSOFT BUTTON
  // ============================================================

  Widget _buildMicrosoftButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: () {
          // Microsoft authentication can be connected later.
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.text,
          backgroundColor: AppTheme.paper,
          side: const BorderSide(color: AppTheme.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: GridView.count(
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                children: const [
                  ColoredBox(color: Color(0xFFF25022)),
                  ColoredBox(color: Color(0xFF7FBA00)),
                  ColoredBox(color: Color(0xFF00A4EF)),
                  ColoredBox(color: Color(0xFFFFB900)),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Text(
              'Microsoft',
              style: GoogleFonts.onest(
                color: AppTheme.text,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
