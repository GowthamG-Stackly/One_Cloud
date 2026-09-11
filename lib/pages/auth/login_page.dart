import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../app_theme.dart';
import '../../providers/user_provider.dart';
import '../../routes/routes.dart';
import '../../widgets/auth_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // ==========================================================
    // PREDEFINED TEST ACCOUNT
    // ==========================================================

    const testEmail = 'user@gmail.com';

    const testPassword = '123456';

    final isPredefinedUser = email == testEmail && password == testPassword;

    // ==========================================================
    // REGISTERED USER
    // ==========================================================

    final isRegisteredUser = userProvider.validateLogin(email, password);

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

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    const googleEmail = 'googleuser@gmail.com';

    userProvider.login(googleEmail);

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

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.login(emailController.text.trim());

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
      child: showTwoStep ? _buildTwoStepCard() : _buildLoginCard(),
    );
  }

  // ============================================================
  // LOGIN CARD
  // ============================================================

  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------------------------------------------
          // TITLE
          // ------------------------------------------------------

          Center(
            child: Column(
              children: [
                Text(
                  'USER LOGIN',
                  style: GoogleFonts.roboto(
                    color: AppTheme.darkNavy,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Sign in to your OneCloud account',
                  style: GoogleFonts.roboto(
                    color: AppTheme.primaryBlue,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ------------------------------------------------------
          // EMAIL
          // ------------------------------------------------------
          Text(
            'Email / Username',
            style: GoogleFonts.roboto(
              color: AppTheme.darkNavy,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 7),

          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration(
              'Enter your email',
              Icons.person_outline,
            ),
          ),

          const SizedBox(height: 17),

          // ------------------------------------------------------
          // PASSWORD
          // ------------------------------------------------------
          Text(
            'Password',
            style: GoogleFonts.roboto(
              color: AppTheme.darkNavy,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 7),

          TextField(
            controller: passwordController,
            obscureText: hidePassword,
            onSubmitted: (_) => login(),
            decoration: _inputDecoration(
              'Enter your password',
              Icons.lock_outline,
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
                  color: AppTheme.primaryBlue,
                  size: 18,
                ),
              ),
            ),
          ),

          // ------------------------------------------------------
          // ERROR
          // ------------------------------------------------------
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                errorMessage,
                style: GoogleFonts.roboto(color: Colors.red, fontSize: 10),
              ),
            ),

          const SizedBox(height: 5),

          // ------------------------------------------------------
          // REMEMBER + FORGOT
          // ------------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: false,
                      activeColor: AppTheme.primaryBlue,
                      onChanged: (_) {},
                    ),
                  ),

                  const SizedBox(width: 5),

                  Text(
                    'Remember me',
                    style: GoogleFonts.roboto(
                      color: AppTheme.darkNavy,
                      fontSize: 10,
                    ),
                  ),
                ],
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
                  'Forgot Password?',
                  style: GoogleFonts.roboto(
                    color: AppTheme.primaryBlue,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ------------------------------------------------------
          // LOGIN BUTTON
          // ------------------------------------------------------
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'LOGIN',
                style: GoogleFonts.roboto(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // ------------------------------------------------------
          // OR
          // ------------------------------------------------------
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppTheme.darkNavy.withValues(alpha: 0.12),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'OR',
                  style: GoogleFonts.roboto(
                    color: AppTheme.darkNavy.withValues(alpha: 0.45),
                    fontSize: 9,
                  ),
                ),
              ),

              Expanded(
                child: Divider(
                  color: AppTheme.darkNavy.withValues(alpha: 0.12),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // ------------------------------------------------------
          // GOOGLE
          // ------------------------------------------------------
          SizedBox(
            width: double.infinity,
            height: 43,
            child: OutlinedButton(
              onPressed: loginWithGoogle,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.darkNavy,
                side: BorderSide(
                  color: AppTheme.darkNavy.withValues(alpha: 0.12),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'G',
                    style: GoogleFonts.roboto(
                      color: AppTheme.primaryBlue,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(width: 9),

                  Text(
                    'Continue with Google',
                    style: GoogleFonts.roboto(
                      color: AppTheme.darkNavy,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ------------------------------------------------------
          // REGISTER
          // ------------------------------------------------------
          Center(
            child: TextButton(
              onPressed: () {
                context.push(AppRoutes.register);
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                      style: GoogleFonts.roboto(
                        color: AppTheme.darkNavy,
                        fontSize: 10,
                      ),
                    ),
                    TextSpan(
                      text: 'Register',
                      style: GoogleFonts.roboto(
                        color: AppTheme.primaryBlue,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TWO STEP CARD
  // ============================================================

  Widget _buildTwoStepCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: AppTheme.lightBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_user_outlined,
              color: AppTheme.primaryBlue,
              size: 32,
            ),
          ),

          const SizedBox(height: 17),

          Text(
            '2-Step Verification',
            style: GoogleFonts.roboto(
              color: AppTheme.darkNavy,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            'Enter the verification code to continue.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: AppTheme.darkNavy.withValues(alpha: 0.55),
              fontSize: 10,
            ),
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: AppTheme.lightBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              verificationCode,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: AppTheme.primaryBlue,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: 4,
              ),
            ),
          ),

          const SizedBox(height: 18),

          TextField(
            controller: verificationController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            textAlign: TextAlign.center,
            decoration: _inputDecoration(
              'Enter 6-digit code',
              Icons.pin_outlined,
            ),
          ),

          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                errorMessage,
                style: GoogleFonts.roboto(color: Colors.red, fontSize: 10),
              ),
            ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: verifyTwoStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('VERIFY'),
            ),
          ),

          const SizedBox(height: 8),

          TextButton(
            onPressed: () {
              setState(() {
                showTwoStep = false;
                verificationCode = '';
                verificationController.clear();
                errorMessage = '';
              });
            },
            child: Text(
              'Back to Login',
              style: GoogleFonts.roboto(
                color: AppTheme.primaryBlue,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration _inputDecoration(
    String hint,
    IconData icon, {
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,

      hintStyle: GoogleFonts.roboto(
        color: AppTheme.darkNavy.withValues(alpha: 0.38),
        fontSize: 10,
      ),

      prefixIcon: Icon(icon, color: AppTheme.primaryBlue, size: 18),

      suffixIcon: suffix,

      filled: true,

      fillColor: AppTheme.lightBlue,

      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(
          color: AppTheme.primaryBlue.withValues(alpha: 0.08),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 1.4),
      ),
    );
  }
}
