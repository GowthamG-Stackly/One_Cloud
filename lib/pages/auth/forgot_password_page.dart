import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_theme.dart';
import '../../providers/user_provider.dart';
import '../../widgets/auth_layout.dart';

enum ForgotPasswordStep {
  enterEmail,
  emailSent,
  accountLocked,
  resetPassword,
  success,
}

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  // ============================================================
  // STATE
  // ============================================================

  ForgotPasswordStep currentStep = ForgotPasswordStep.enterEmail;

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  String message = '';
  bool isSuccess = false;

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: _buildCurrentStep(),
      ),
    );
  }

  // ============================================================
  // CURRENT STEP
  // ============================================================

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case ForgotPasswordStep.enterEmail:
        return _buildEnterEmail();

      case ForgotPasswordStep.emailSent:
        return _buildEmailSent();

      case ForgotPasswordStep.accountLocked:
        return _buildAccountLocked();

      case ForgotPasswordStep.resetPassword:
        return _buildResetPassword();

      case ForgotPasswordStep.success:
        return _buildSuccess();
    }
  }

  // ============================================================
  // STEP 1
  // FORGOT PASSWORD
  // ============================================================

  Widget _buildEnterEmail() {
    return _contentWrapper(
      key: const ValueKey('forgot-email'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackButton(),

          const SizedBox(height: 30),

          _buildEyebrow('PASSWORD RECOVERY'),

          const SizedBox(height: 18),

          Text(
            'Forgot your password?',
            style: GoogleFonts.onest(
              color: AppTheme.text,
              fontSize: 38,
              fontWeight: FontWeight.w600,
              height: 1.1,
              letterSpacing: -1.2,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Enter your work email and we’ll send you a '
            'link to reset it.',
            style: GoogleFonts.onest(
              color: AppTheme.textMuted,
              fontSize: 15,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 34),

          _buildFieldLabel('Work email'),

          const SizedBox(height: 8),

          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => sendResetLink(),
            decoration: _inputDecoration(hint: 'you@acmecorp.com'),
          ),

          if (message.isNotEmpty) ...[
            const SizedBox(height: 14),
            _buildMessageBox(),
          ],

          const SizedBox(height: 22),

          _buildPrimaryButton(
            label: 'Send reset link',
            onPressed: sendResetLink,
          ),

          const SizedBox(height: 90),

          _buildBottomSignIn(),
        ],
      ),
    );
  }

  // ============================================================
  // STEP 2
  // CHECK YOUR EMAIL
  // ============================================================

  Widget _buildEmailSent() {
    return _contentWrapper(
      key: const ValueKey('email-sent'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          _buildStatusIcon(
            icon: Icons.mail_outline_rounded,
            backgroundColor: const Color(0xFFE8F7EF),
            iconColor: const Color(0xFF2E9D5B),
          ),

          const SizedBox(height: 42),

          Text(
            'Check your email',
            textAlign: TextAlign.center,
            style: GoogleFonts.onest(
              color: AppTheme.text,
              fontSize: 38,
              fontWeight: FontWeight.w600,
              height: 1.1,
              letterSpacing: -1.2,
            ),
          ),

          const SizedBox(height: 16),

          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'We\'ve sent a password reset link to\n',
                  style: GoogleFonts.onest(
                    color: AppTheme.textMuted,
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
                TextSpan(
                  text: emailController.text.trim(),
                  style: GoogleFonts.onest(
                    color: AppTheme.textMuted,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.55,
                  ),
                ),
                TextSpan(
                  text: '. The link expires in 30 minutes.',
                  style: GoogleFonts.onest(
                    color: AppTheme.textMuted,
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 42),

          _buildSecondaryButton(label: 'Resend email', onPressed: resendEmail),

          const SizedBox(height: 10),

          _buildPrimaryButton(label: 'Continue', onPressed: openResetPassword),

          if (message.isNotEmpty) ...[
            const SizedBox(height: 14),
            _buildMessageBox(),
          ],

          const SizedBox(height: 100),

          _buildSupportText(),
        ],
      ),
    );
  }

  // ============================================================
  // STEP 3
  // ACCOUNT LOCKED
  // ============================================================

  Widget _buildAccountLocked() {
    return _contentWrapper(
      key: const ValueKey('account-locked'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          _buildStatusIcon(
            icon: Icons.lock_outline_rounded,
            backgroundColor: const Color(0xFFFCEAEA),
            iconColor: const Color(0xFFD74646),
          ),

          const SizedBox(height: 42),

          Text(
            'This account is locked',
            textAlign: TextAlign.center,
            style: GoogleFonts.onest(
              color: AppTheme.text,
              fontSize: 38,
              fontWeight: FontWeight.w600,
              height: 1.1,
              letterSpacing: -1.2,
            ),
          ),

          const SizedBox(height: 16),

          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Too many failed attempts. ',
                  style: GoogleFonts.onest(
                    color: AppTheme.textMuted,
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
                TextSpan(
                  text: emailController.text.trim(),
                  style: GoogleFonts.onest(
                    color: AppTheme.textMuted,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.55,
                  ),
                ),
                TextSpan(
                  text: ' is locked for 15 minutes.',
                  style: GoogleFonts.onest(
                    color: AppTheme.textMuted,
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 38),

          _buildLockWarning(),

          const SizedBox(height: 38),

          _buildPrimaryButton(
            label: 'Reset password',
            onPressed: openResetPassword,
          ),

          const SizedBox(height: 10),

          _buildSecondaryButton(
            label: 'Back to sign in',
            onPressed: backToLogin,
          ),

          const SizedBox(height: 100),

          _buildSecuritySupportText(),
        ],
      ),
    );
  }

  // ============================================================
  // STEP 4
  // CREATE NEW PASSWORD
  // ============================================================

  Widget _buildResetPassword() {
    return _contentWrapper(
      key: const ValueKey('reset-password'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackButton(),

          const SizedBox(height: 30),

          _buildEyebrow('PASSWORD RECOVERY'),

          const SizedBox(height: 18),

          Text(
            'Create a new password',
            style: GoogleFonts.onest(
              color: AppTheme.text,
              fontSize: 38,
              fontWeight: FontWeight.w600,
              height: 1.1,
              letterSpacing: -1.2,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Create a new secure password for your '
            'One Enterprise account.',
            style: GoogleFonts.onest(
              color: AppTheme.textMuted,
              fontSize: 15,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 32),

          _buildFieldLabel('New password'),

          const SizedBox(height: 8),

          TextField(
            controller: passwordController,
            obscureText: hidePassword,
            textInputAction: TextInputAction.next,
            decoration: _inputDecoration(
              hint: 'Enter your new password',
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

          const SizedBox(height: 20),

          _buildFieldLabel('Confirm password'),

          const SizedBox(height: 8),

          TextField(
            controller: confirmPasswordController,
            obscureText: hideConfirmPassword,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => resetPassword(),
            decoration: _inputDecoration(
              hint: 'Confirm your new password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hideConfirmPassword = !hideConfirmPassword;
                  });
                },
                icon: Icon(
                  hideConfirmPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppTheme.textMuted,
                  size: 21,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: AppTheme.info,
                size: 17,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Password must contain at least 6 characters.',
                  style: GoogleFonts.onest(
                    color: AppTheme.textMuted,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),

          if (message.isNotEmpty) ...[
            const SizedBox(height: 14),
            _buildMessageBox(),
          ],

          const SizedBox(height: 22),

          _buildPrimaryButton(
            label: 'Reset password',
            onPressed: resetPassword,
          ),

          const SizedBox(height: 70),

          _buildBottomSignIn(),
        ],
      ),
    );
  }

  // ============================================================
  // STEP 5
  // PASSWORD UPDATED
  // ============================================================

  Widget _buildSuccess() {
    return _contentWrapper(
      key: const ValueKey('password-success'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),

          _buildStatusIcon(
            icon: Icons.check_rounded,
            backgroundColor: const Color(0xFFE8F7EF),
            iconColor: const Color(0xFF2E9D5B),
          ),

          const SizedBox(height: 42),

          Text(
            'Password updated',
            textAlign: TextAlign.center,
            style: GoogleFonts.onest(
              color: AppTheme.text,
              fontSize: 38,
              fontWeight: FontWeight.w600,
              height: 1.1,
              letterSpacing: -1.2,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'Your password has been successfully reset.\n'
            'You can now sign in with your new password.',
            textAlign: TextAlign.center,
            style: GoogleFonts.onest(
              color: AppTheme.textMuted,
              fontSize: 15,
              height: 1.55,
            ),
          ),

          const SizedBox(height: 42),

          _buildPrimaryButton(label: 'Back to sign in', onPressed: backToLogin),

          const SizedBox(height: 110),

          Text(
            'Protected by One Enterprise security',
            textAlign: TextAlign.center,
            style: GoogleFonts.onest(color: AppTheme.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMMON CONTENT WRAPPER
  // ============================================================

  Widget _contentWrapper({required Key key, required Widget child}) {
    return Container(
      key: key,
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 520),
      child: child,
    );
  }

  // ============================================================
  // SEND RESET LINK
  // ============================================================

  void sendResetLink() {
    final String email = emailController.text.trim();

    setState(() {
      message = '';
      isSuccess = false;
    });

    if (email.isEmpty) {
      setState(() {
        message = 'Please enter your work email.';
      });
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      setState(() {
        message = 'Please enter a valid email address.';
      });
      return;
    }

    final bool exists = ref.read(userProvider.notifier).emailExists(email);

    if (!exists) {
      setState(() {
        message = 'No registered account found with this email.';
      });
      return;
    }

    setState(() {
      currentStep = ForgotPasswordStep.emailSent;
      message = '';
      isSuccess = true;
    });
  }

  // ============================================================
  // RESEND EMAIL
  // ============================================================

  void resendEmail() {
    setState(() {
      message = 'Reset email sent again.';
      isSuccess = true;
    });
  }

  // ============================================================
  // OPEN RESET PASSWORD
  // ============================================================

  void openResetPassword() {
    setState(() {
      currentStep = ForgotPasswordStep.resetPassword;
      message = '';
      isSuccess = false;
    });
  }

  // ============================================================
  // RESET PASSWORD
  // ============================================================

  void resetPassword() {
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    setState(() {
      message = '';
      isSuccess = false;
    });

    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        message = 'Please enter your new password.';
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        message = 'Password must be at least 6 characters.';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        message = 'Passwords do not match.';
      });
      return;
    }

    ref
        .read(userProvider.notifier)
        .resetPassword(emailController.text.trim(), password);

    passwordController.clear();
    confirmPasswordController.clear();

    setState(() {
      currentStep = ForgotPasswordStep.success;
      message = '';
      isSuccess = true;
    });
  }

  // ============================================================
  // BACK TO LOGIN
  // ============================================================

  void backToLogin() {
    context.pop();
  }

  // ============================================================
  // BACK BUTTON
  // ============================================================

  Widget _buildBackButton() {
    return TextButton.icon(
      onPressed: backToLogin,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: AppTheme.textMuted,
      ),
      icon: const Icon(Icons.arrow_back_rounded, size: 18),
      label: Text(
        'Back to sign in',
        style: GoogleFonts.onest(
          color: AppTheme.textMuted,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  // ============================================================
  // EYEBROW
  // ============================================================

  Widget _buildEyebrow(String text) {
    return Text(
      text,
      style: GoogleFonts.ibmPlexMono(
        color: AppTheme.textMuted,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.4,
      ),
    );
  }

  // ============================================================
  // STATUS ICON
  // ============================================================

  Widget _buildStatusIcon({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Icon(icon, color: iconColor, size: 48),
    );
  }

  // ============================================================
  // LOCK WARNING
  // ============================================================

  Widget _buildLockWarning() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3DD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.access_time_rounded,
            color: Color(0xFF986018),
            size: 29,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Try again in 15:00',
                  style: GoogleFonts.onest(
                    color: const Color(0xFF986018),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Or reset your password now.',
                  style: GoogleFonts.onest(
                    color: const Color(0xFF986018),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
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
  // INPUT
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

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),

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
        borderSide: const BorderSide(color: AppTheme.ink3, width: 1.5),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.danger),
      ),
    );
  }

  // ============================================================
  // PRIMARY BUTTON
  // ============================================================

  Widget _buildPrimaryButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.ink,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
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
  // SECONDARY BUTTON
  // ============================================================

  Widget _buildSecondaryButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppTheme.text,
          side: const BorderSide(color: AppTheme.border, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.onest(
            color: AppTheme.text,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  Widget _buildMessageBox() {
    final Color color = isSuccess ? AppTheme.success : AppTheme.danger;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isSuccess
                ? Icons.check_circle_outline_rounded
                : Icons.error_outline_rounded,
            color: color,
            size: 18,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.onest(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM SIGN IN
  // ============================================================

  Widget _buildBottomSignIn() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Remembered it? ',
              style: GoogleFonts.onest(color: AppTheme.textMuted, fontSize: 13),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: GestureDetector(
                onTap: backToLogin,
                child: Text(
                  'Sign in',
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
    );
  }

  // ============================================================
  // SUPPORT
  // ============================================================

  Widget _buildSupportText() {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "Didn't get it? Check spam, or ",
              style: GoogleFonts.onest(color: AppTheme.textMuted, fontSize: 13),
            ),
            TextSpan(
              text: 'contact support.',
              style: GoogleFonts.onest(
                color: AppTheme.ink3,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // ============================================================
  // SECURITY SUPPORT
  // ============================================================

  Widget _buildSecuritySupportText() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Recorded in the security audit log · ',
            style: GoogleFonts.onest(color: AppTheme.textMuted, fontSize: 13),
          ),
          TextSpan(
            text: 'Contact support',
            style: GoogleFonts.onest(
              color: AppTheme.ink3,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
