import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_theme.dart';
import '../../providers/user_provider.dart';
import '../../providers/registration_provider.dart';
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

  final TextEditingController workspaceController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());

  // ============================================================
  // STATE
  // ============================================================

  int currentStep = 1;

  bool hidePassword = true;
  bool rememberDevice = false;
  bool isRedirecting = false;

  String errorMessage = '';

  // ============================================================
  // STEP 1
  // WORKSPACE + EMAIL
  // ============================================================

  void continueToPassword() {
    final workspace = workspaceController.text.trim();
    final email = emailController.text.trim();

    setState(() {
      errorMessage = '';
    });

    // Workspace cannot be empty.
    if (workspace.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your workspace';
      });
      return;
    }

    // Email cannot be empty.
    if (email.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your work email';
      });
      return;
    }

    // Basic email format check.
    if (!email.contains('@')) {
      setState(() {
        errorMessage = 'Please enter a valid email address';
      });
      return;
    }

    // Get registered organization details.
    final registration = ref.read(registrationProvider);

    // Workspace must match the registered organization name.
    final workspaceValid =
        workspace.toLowerCase() ==
        registration.organizationName.trim().toLowerCase();

    if (!workspaceValid) {
      setState(() {
        errorMessage = 'Workspace does not match the registered organization';
      });
      return;
    }

    // Check whether email exists in Riverpod.
    final emailExists = ref.read(userProvider.notifier).emailExists(email);

    if (!emailExists) {
      setState(() {
        errorMessage = 'This work email is not registered';
      });
      return;
    }

    // Workspace + email are valid → move to password.
    setState(() {
      currentStep = 2;
    });
  }

  // ============================================================
  // STEP 2
  // EMAIL + PASSWORD VALIDATION
  // ============================================================

  void signIn() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      errorMessage = '';
    });

    if (password.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your password';
      });
      return;
    }

    // Validate email + password through Riverpod.
    final isValid = ref
        .read(userProvider.notifier)
        .validateLogin(email, password);

    if (isValid) {
      clearOtp();

      setState(() {
        currentStep = 3;
      });
    } else {
      setState(() {
        errorMessage = 'Invalid email or password';
      });
    }
  }

  // ============================================================
  // STEP 3
  // OTP
  // ============================================================

  void verifyOtp() {
    final enteredCode = otpControllers
        .map((controller) => controller.text.trim())
        .join();

    setState(() {
      errorMessage = '';
    });

    // Accept any 6-digit OTP
    if (enteredCode.length != 6) {
      setState(() {
        errorMessage = 'Please enter the 6-digit verification code';
      });
      return;
    }

    // FIRST show the "You're in" screen.
    setState(() {
      isRedirecting = true;
    });

    // Keep the success screen visible for 3 seconds.
    Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      ref.read(userProvider.notifier).login(emailController.text.trim());

      context.go(AppRoutes.dashboard);
    });
  }

  // ============================================================
  // GOOGLE LOGIN
  // ============================================================

  void loginWithGoogle() {
    ref.read(userProvider.notifier).login('googleuser@gmail.com');

    context.go(AppRoutes.dashboard);
  }

  // ============================================================
  // BACK
  // ============================================================

  void goBack() {
    setState(() {
      errorMessage = '';

      if (currentStep == 3) {
        clearOtp();
        currentStep = 2;
      } else if (currentStep == 2) {
        passwordController.clear();
        currentStep = 1;
      }
    });
  }

  // ============================================================
  // CLEAR OTP
  // ============================================================

  void clearOtp() {
    for (final controller in otpControllers) {
      controller.clear();
    }

    FocusScope.of(context).unfocus();
  }

  // ============================================================
  // OTP INPUT
  // ============================================================

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < otpFocusNodes.length - 1) {
      otpFocusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }

    setState(() {});
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    workspaceController.dispose();
    emailController.dispose();
    passwordController.dispose();

    for (final controller in otpControllers) {
      controller.dispose();
    }

    for (final node in otpFocusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      scrollable: true,
      child: isRedirecting
          ? _buildSuccessPage()
          : AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _buildCurrentStep(),
            ),
    );
  }

  // ============================================================
  // CURRENT STEP
  // ============================================================

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 1:
        return _buildIdentifyPage();

      case 2:
        return _buildPasswordPage();

      case 3:
        return _buildVerificationPage();

      default:
        return _buildIdentifyPage();
    }
  }

  // ============================================================
  // STEP 1
  // IDENTIFY
  // ============================================================

  Widget _buildIdentifyPage() {
    return Column(
      key: const ValueKey('identify'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _stepText('STEP 1 OF 3  ·  IDENTIFY'),

        const SizedBox(height: 18),

        _title('Sign in'),

        const SizedBox(height: 10),

        _description('Enter your workspace and work email to continue.'),

        const SizedBox(height: 40),

        _label('Workspace'),

        const SizedBox(height: 8),

        _workspaceField(),

        const SizedBox(height: 8),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Don't know your workspace? ",
                style: _normalText(),
              ),
              TextSpan(text: 'Find it here', style: _linkText()),
            ],
          ),
        ),

        const SizedBox(height: 28),

        _label('Work email'),

        const SizedBox(height: 8),

        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecoration('you@acmecorp.com'),
        ),

        if (errorMessage.isNotEmpty) ...[const SizedBox(height: 12), _error()],

        const SizedBox(height: 22),

        _primaryButton('Continue', continueToPassword),

        const SizedBox(height: 32),

        _orDivider(),

        const SizedBox(height: 18),

        _socialButton('Google', _googleIcon(), loginWithGoogle),

        const SizedBox(height: 12),

        _socialButton('Microsoft', _microsoftIcon(), () {}),

        const SizedBox(height: 12),

        _socialButton(
          'Company SSO (SAML)',
          const Icon(Icons.people_outline, size: 21, color: AppTheme.text),
          () {},
        ),

        const SizedBox(height: 30),

        _registerSection(),
      ],
    );
  }

  // ============================================================
  // STEP 2
  // PASSWORD
  // ============================================================

  Widget _buildPasswordPage() {
    return Column(
      key: const ValueKey('password'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _backButton(),

        const SizedBox(height: 28),

        _stepText('STEP 2 OF 3  ·  PASSWORD'),

        const SizedBox(height: 18),

        _title('Enter your password'),

        const SizedBox(height: 10),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Signing in to ', style: _normalText()),
              TextSpan(
                text: workspaceController.text.trim(),
                style: _boldText(),
              ),
              TextSpan(text: '.', style: _normalText()),
            ],
          ),
        ),

        const SizedBox(height: 38),

        _accountCard(),

        const SizedBox(height: 28),

        _label('Password'),

        const SizedBox(height: 8),

        TextField(
          controller: passwordController,
          obscureText: hidePassword,
          onSubmitted: (_) => signIn(),
          decoration: _inputDecoration(
            'Enter your password',
            suffix: IconButton(
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
              ),
            ),
          ),
        ),

        if (errorMessage.isNotEmpty) ...[const SizedBox(height: 12), _error()],

        const SizedBox(height: 18),

        Row(
          children: [
            Checkbox(
              value: rememberDevice,
              activeColor: AppTheme.ink3,
              onChanged: (value) {
                setState(() {
                  rememberDevice = value ?? false;
                });
              },
            ),
            Expanded(
              child: Text(
                'Remember this device for 30 days',
                style: _normalText(),
              ),
            ),
            TextButton(
              onPressed: () {
                context.push(AppRoutes.forgotPassword);
              },
              child: Text('Forgot password?', style: _linkText()),
            ),
          ],
        ),

        const SizedBox(height: 22),

        _primaryButton('Sign in', signIn),

        const SizedBox(height: 34),

        _securityNote(),
      ],
    );
  }

  // ============================================================
  // ACCOUNT CARD
  // ============================================================

  Widget _accountCard() {
    return Container(
      width: double.infinity,
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F8),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF82D1B6), Color(0xFF377FA3)],
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  emailController.text.trim(),
                  overflow: TextOverflow.ellipsis,
                  style: _boldText(),
                ),
                const SizedBox(height: 3),
                Text('Not you? Use a different account', style: _normalText()),
              ],
            ),
          ),

          TextButton(
            onPressed: () {
              setState(() {
                currentStep = 1;
                passwordController.clear();
                errorMessage = '';
              });
            },
            child: Text('Switch', style: _linkText()),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STEP 3
  // OTP
  // ============================================================

  Widget _buildVerificationPage() {
    return Column(
      key: const ValueKey('verification'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _backButton(),

        const SizedBox(height: 28),

        _stepText('STEP 3 OF 3  ·  VERIFY'),

        const SizedBox(height: 18),

        _title('Two-factor verification'),

        const SizedBox(height: 10),

        _description('Enter the 6-digit code from your authenticator app.'),

        const SizedBox(height: 36),

        _otpBoxes(),

        const SizedBox(height: 12),

        Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Code expires in 04:57 · ',
                  style: _normalText(),
                ),
                TextSpan(text: 'Resend code', style: _linkText()),
                TextSpan(text: ' · ', style: _normalText()),
                TextSpan(text: 'Use a backup code', style: _linkText()),
              ],
            ),
          ),
        ),

        if (errorMessage.isNotEmpty) ...[const SizedBox(height: 12), _error()],

        const SizedBox(height: 26),

        _primaryButton('Verify and sign in', verifyOtp),

        const SizedBox(height: 34),

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
                  TextSpan(text: 'Having trouble? ', style: _normalText()),
                  TextSpan(text: 'Contact support', style: _linkText()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // OTP BOXES
  // ============================================================

  Widget _otpBoxes() {
    return Center(
      child: Row(
        children: List.generate(6, (index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: index == 5 ? 0 : 8),
              child: SizedBox(
                height: 64,
                child: TextField(
                  controller: otpControllers[index],
                  focusNode: otpFocusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF182535),
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFDCE3E8),
                        width: 1.3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFF2B78A5),
                        width: 1.8,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty && index < 5) {
                      FocusScope.of(context)
                          .requestFocus(otpFocusNodes[index + 1]);
                    }

                    if (value.isEmpty && index > 0) {
                      FocusScope.of(context)
                          .requestFocus(otpFocusNodes[index - 1]);
                    }
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ============================================================
  // SUCCESS PAGE
  // ============================================================

  Widget _buildSuccessPage() {
    return SizedBox(
      key: const ValueKey('success'),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE6F7EE),
            ),
            child: const Icon(Icons.check, color: Color(0xFF27A05D), size: 40),
          ),

          const SizedBox(height: 32),

          Text(
            "You're in",
            style: GoogleFonts.onest(
              color: AppTheme.text,
              fontSize: 34,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          Text('Redirecting to your dashboard...', style: _normalText()),
        ],
      ),
    );
  }

  // ============================================================
  // WORKSPACE FIELD
  // ============================================================

  Widget _workspaceField() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: workspaceController,
              decoration: InputDecoration(
                hintText: 'acmecorp',
                hintStyle: GoogleFonts.onest(color: Colors.grey, fontSize: 15),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              style: GoogleFonts.onest(color: AppTheme.text, fontSize: 15),
            ),
          ),

          Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: const BoxDecoration(
              color: Color(0xFFF4F5F7),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '.oneenterprise.io',
              style: GoogleFonts.ibmPlexMono(
                color: AppTheme.textMuted,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BACK BUTTON
  // ============================================================

  Widget _backButton() {
    return TextButton.icon(
      onPressed: goBack,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: const Icon(Icons.chevron_left, size: 20, color: AppTheme.textMuted),
      label: Text('Back', style: _normalText()),
    );
  }

  // ============================================================
  // COMMON UI
  // ============================================================

  Widget _stepText(String text) {
    return Text(
      text,
      style: GoogleFonts.ibmPlexMono(
        color: AppTheme.textMuted,
        fontSize: 12,
        letterSpacing: 1.4,
      ),
    );
  }

  Widget _title(String text) {
    return Text(
      text,
      style: GoogleFonts.onest(
        color: AppTheme.text,
        fontSize: 36,
        fontWeight: FontWeight.w600,
        height: 1.1,
        letterSpacing: -1.2,
      ),
    );
  }

  Widget _description(String text) {
    return Text(
      text,
      style: GoogleFonts.onest(
        color: AppTheme.textMuted,
        fontSize: 15,
        height: 1.5,
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.onest(
        color: AppTheme.text,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  TextStyle _normalText() {
    return GoogleFonts.onest(color: AppTheme.textMuted, fontSize: 13);
  }

  TextStyle _boldText() {
    return GoogleFonts.onest(
      color: AppTheme.text,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle _linkText() {
    return GoogleFonts.onest(
      color: AppTheme.ink3,
      fontSize: 13,
      fontWeight: FontWeight.w600,
    );
  }

  InputDecoration _inputDecoration(String hint, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.onest(
        color: AppTheme.textMuted.withValues(alpha: 0.65),
        fontSize: 15,
      ),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: AppTheme.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: AppTheme.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: AppTheme.ink3, width: 1.5),
      ),
    );
  }

  // ============================================================
  // PRIMARY BUTTON
  // ============================================================

  Widget _primaryButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.ink,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.onest(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ============================================================
  // OR DIVIDER
  // ============================================================

  Widget _orDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppTheme.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text('or continue with', style: _normalText()),
        ),
        const Expanded(child: Divider(color: AppTheme.border)),
      ],
    );
  }

  // ============================================================
  // SOCIAL BUTTON
  // ============================================================

  Widget _socialButton(String text, Widget icon, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: AppTheme.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              text,
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
  // GOOGLE ICON
  // ============================================================

  Widget _googleIcon() {
    return Text(
      'G',
      style: GoogleFonts.onest(
        color: const Color(0xFF4285F4),
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // ============================================================
  // MICROSOFT ICON
  // ============================================================

  Widget _microsoftIcon() {
    return SizedBox(
      width: 18,
      height: 18,
      child: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: const [
          ColoredBox(color: Color(0xFFF25022)),
          ColoredBox(color: Color(0xFF7FBA00)),
          ColoredBox(color: Color(0xFF00A4EF)),
          ColoredBox(color: Color(0xFFFFB900)),
        ],
      ),
    );
  }

  // ============================================================
  // REGISTER
  // ============================================================

  Widget _registerSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 22),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.border)),
      ),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text('New to One Enterprise? ', style: _normalText()),
            GestureDetector(
              onTap: () {
                ref.read(registrationProvider.notifier).reset();
                context.push(AppRoutes.register);
              },
              child: Text('Create an account', style: _linkText()),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECURITY NOTE
  // ============================================================

  Widget _securityNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 22),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.border)),
      ),
      child: Center(
        child: Text(
          'Protected by enterprise password policy · '
          '5 attempts before\nlockout',
          textAlign: TextAlign.center,
          style: _normalText(),
        ),
      ),
    );
  }

  // ============================================================
  // ERROR
  // ============================================================

  Widget _error() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.danger.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.danger.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppTheme.danger, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              errorMessage,
              style: GoogleFonts.onest(color: AppTheme.danger, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
