import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_theme.dart';
import '../../providers/user_provider.dart';
import '../../widgets/auth_layout.dart';

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

  bool showPasswordFields = false;

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  String message = '';
  bool isSuccess = false;

  // ============================================================
  // VERIFY EMAIL
  // ============================================================

  void checkEmail() {
    final String email = emailController.text.trim();

    setState(() {
      message = '';
      isSuccess = false;
    });

    // Empty email
    if (email.isEmpty) {
      setState(() {
        message = 'Please enter your work email.';
      });

      return;
    }

    // Email validation
    if (!email.contains('@') || !email.contains('.')) {
      setState(() {
        message = 'Please enter a valid email address.';
      });

      return;
    }

    // Check registered email
    final bool exists = ref.read(userProvider.notifier).emailExists(email);

    if (!exists) {
      setState(() {
        message = 'No registered account found with this email.';
      });

      return;
    }

    // Email verified
    setState(() {
      showPasswordFields = true;
      message = 'Email verified. Enter your new password.';
      isSuccess = true;
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

    // Empty fields
    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        message = 'Please enter your new password.';
      });

      return;
    }

    // Password length
    if (password.length < 6) {
      setState(() {
        message = 'Password must be at least 6 characters.';
      });

      return;
    }

    // Password match
    if (password != confirmPassword) {
      setState(() {
        message = 'Passwords do not match.';
      });

      return;
    }

    // Reset password
    ref
        .read(userProvider.notifier)
        .resetPassword(emailController.text.trim(), password);

    setState(() {
      message = 'Password reset successful. You can now sign in.';
      isSuccess = true;

      passwordController.clear();
      confirmPasswordController.clear();
    });
  }

  // ============================================================
  // BACK TO LOGIN
  // ============================================================

  void backToLogin() {
    context.pop();
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return AuthLayout(child: _buildForgotPasswordContent());
  }

  // ============================================================
  // RIGHT SIDE CONTENT
  // ============================================================

  Widget _buildForgotPasswordContent() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================================
            // BACK TO SIGN IN
            // ======================================================

            TextButton.icon(
              onPressed: backToLogin,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: AppTheme.textMuted,
              ),
              icon: const Icon(Icons.arrow_back, size: 17),
              label: Text(
                'Back to sign in',
                style: GoogleFonts.onest(
                  color: AppTheme.textMuted,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ======================================================
            // LABEL
            // ======================================================
            Text(
              'PASSWORD RECOVERY',
              style: GoogleFonts.ibmPlexMono(
                color: AppTheme.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.4,
              ),
            ),

            const SizedBox(height: 18),

            // ======================================================
            // TITLE
            // ======================================================
            Text(
              showPasswordFields
                  ? 'Create a new password'
                  : 'Forgot your password?',
              style: GoogleFonts.onest(
                color: AppTheme.text,
                fontSize: 38,
                fontWeight: FontWeight.w600,
                height: 1.1,
                letterSpacing: -1.2,
              ),
            ),

            const SizedBox(height: 10),

            // ======================================================
            // DESCRIPTION
            // ======================================================
            Text(
              showPasswordFields
                  ? 'Create a new secure password for your '
                        'One Enterprise account.'
                  : 'Enter your work email and we’ll verify '
                        'your account so you can reset your password.',
              style: GoogleFonts.onest(
                color: AppTheme.textMuted,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 36),

            // ======================================================
            // WORK EMAIL
            // ======================================================
            _buildFieldLabel('Work email'),

            const SizedBox(height: 8),

            TextField(
              controller: emailController,
              enabled: !showPasswordFields,
              keyboardType: TextInputType.emailAddress,
              textInputAction: showPasswordFields
                  ? TextInputAction.none
                  : TextInputAction.done,
              decoration: _inputDecoration(hint: 'you@company.com'),
              onSubmitted: (_) {
                if (!showPasswordFields) {
                  checkEmail();
                }
              },
            ),

            // ======================================================
            // VERIFY EMAIL
            // ======================================================
            if (!showPasswordFields) ...[
              const SizedBox(height: 22),

              _buildPrimaryButton(
                label: 'Continue',
                icon: Icons.arrow_forward,
                onPressed: checkEmail,
              ),
            ],

            // ======================================================
            // PASSWORD FIELDS
            // ======================================================
            if (showPasswordFields) ...[
              const SizedBox(height: 22),

              // ----------------------------------------------------
              // NEW PASSWORD
              // ----------------------------------------------------
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

              // ----------------------------------------------------
              // CONFIRM PASSWORD
              // ----------------------------------------------------
              _buildFieldLabel('Confirm password'),

              const SizedBox(height: 8),

              TextField(
                controller: confirmPasswordController,
                obscureText: hideConfirmPassword,
                textInputAction: TextInputAction.done,
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
                onSubmitted: (_) => resetPassword(),
              ),

              const SizedBox(height: 14),

              // ----------------------------------------------------
              // PASSWORD REQUIREMENT
              // ----------------------------------------------------
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
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

              const SizedBox(height: 22),

              // ----------------------------------------------------
              // RESET BUTTON
              // ----------------------------------------------------
              _buildPrimaryButton(
                label: 'Reset password',
                icon: Icons.check,
                onPressed: resetPassword,
              ),
            ],

            // ======================================================
            // MESSAGE
            // ======================================================
            if (message.isNotEmpty) ...[
              const SizedBox(height: 18),
              _buildMessageBox(),
            ],

            const SizedBox(height: 30),

            // ======================================================
            // DIVIDER
            // ======================================================
            const Divider(color: AppTheme.border, height: 1),

            const SizedBox(height: 24),

            // ======================================================
            // BOTTOM LOGIN LINK
            // ======================================================
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Remembered your password? ',
                      style: GoogleFonts.onest(
                        color: AppTheme.textMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
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
            ),

            const SizedBox(height: 20),

            // ======================================================
            // SECURITY TEXT
            // ======================================================
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.verified_user_outlined,
                    color: AppTheme.textMuted,
                    size: 14,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    'Protected by One Enterprise security',
                    style: GoogleFonts.onest(
                      color: AppTheme.textMuted,
                      fontSize: 11,
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

      disabledBorder: OutlineInputBorder(
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
  // PRIMARY BUTTON
  // ============================================================

  Widget _buildPrimaryButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
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
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.onest(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(width: 8),

            Icon(icon, size: 18),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE BOX
  // ============================================================

  Widget _buildMessageBox() {
    final Color color = isSuccess ? AppTheme.success : AppTheme.danger;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isSuccess ? Icons.check_circle_outline : Icons.error_outline,
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
}
