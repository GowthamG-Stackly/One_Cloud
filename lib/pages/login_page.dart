import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'dart:math';

import '../routes/routes.dart';
import '../providers/user_provider.dart';
import '../app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  String errorMessage = '';

  bool showTwoStep = false;
  String verificationCode = '';

  final verificationController = TextEditingController();

  void generateVerificationCode() {
    final random = Random();
    final code = (100000 + random.nextInt(900000)).toString();

    setState(() {
      verificationCode = code;
      showTwoStep = true;
      errorMessage = '';
    });
  }

  // LOGIN
  // void login() {
  //   String email = emailController.text.trim();
  //   String password = passwordController.text;

  //   setState(() => errorMessage = '');

  //   if (email.isEmpty) {
  //     setState(() => errorMessage = 'Please enter your email');
  //     return;
  //   }

  //   if (!email.contains('@') || !email.contains('.')) {
  //     setState(() => errorMessage = 'Please enter a valid username');
  //     return;
  //   }

  //   if (password.isEmpty) {
  //     setState(() => errorMessage = 'Please enter your password');
  //     return;
  //   }

  //   if (password.length < 8) {
  //     setState(() => errorMessage = 'Password must be at least 8 characters');
  //     return;
  //   }

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const WelcomePage()),
  //   );
  // }

  // void login() {
  //   final email = emailController.text.trim();
  //   final password = passwordController.text.trim();

  //   setState(() {
  //     errorMessage = '';
  //   });

  //   if (email.isEmpty || password.isEmpty) {
  //     setState(() {
  //       errorMessage = 'Please enter email and password';
  //     });
  //     return;
  //   }

  //   final userProvider = Provider.of<UserProvider>(context, listen: false);

  //   if (userProvider.validateLogin(email, password)) {
  //     generateVerificationCode();
  //   } else {
  //     setState(() {
  //       errorMessage = 'Invalid email or password';
  //     });
  //   }
  // }

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      errorMessage = '';
    });

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Please enter email and password';
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Predefined test credentials
    const testEmail = 'user@gmail.com';
    const testPassword = '123456';

    final isPredefinedUser = email == testEmail && password == testPassword;

    final isRegisteredUser = userProvider.validateLogin(email, password);

    if (isPredefinedUser || isRegisteredUser) {
      generateVerificationCode();
    } else {
      setState(() {
        errorMessage = 'Invalid email or password';
      });
    }
  }

  void loginWithGoogle() {
    // Frontend-only Google login for POC

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Demo Google account
    const googleEmail = 'googleuser@gmail.com';

    userProvider.login(googleEmail);

    context.go(AppRoutes.dashboard);
  }

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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    verificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, AppTheme.lightBlue, AppTheme.primaryBlue],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1050),
              child: LayoutBuilder(
                builder: (context, size) {
                  // MOBILE
                  if (size.maxWidth < 650) {
                    return _mobileBox();
                  }

                  // DESKTOP / TABLET
                  return _mainBox();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // DESKTOP / TABLET MAIN BOX
  Widget _mainBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(child: _brandSection()),
            Expanded(child: _loginSection()),
          ],
        ),
      ),
    );
  }

  // MOBILE MAIN BOX
  Widget _mobileBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .15),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: [_mobileBrand(), _loginSection()]),
    );
  }

  // DESKTOP LEFT SIDE
  Widget _brandSection() {
    return Container(
      padding: const EdgeInsets.all(45),
      constraints: const BoxConstraints(minHeight: 520),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.darkNavy, AppTheme.primaryBlue],
        ),
      ),
      child: Stack(
        children: [
          Positioned(right: -30, top: 40, child: _shape(130)),

          Positioned(left: -40, bottom: 30, child: _shape(170)),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _logo(),

              const SizedBox(height: 25),

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome to\n',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'ONE CLOUD\n',
                      style: GoogleFonts.blackOpsOne(
                        color: AppTheme.primaryBlue,
                        fontSize: 30,
                        height: 1.2,
                      ),
                    ),
                    TextSpan(
                      text: 'Enterprise Platform',
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF7DD3FC),
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Smart inventory management made simple. '
                'Track your stock and manage your business '
                'operations from one place.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 30),

              _feature('Inventory Tracking'),
              _feature('Stock Movement Management'),
              _feature('Reports & Analytics'),
              _feature('Stock Alerts & Updates'),
            ],
          ),
        ],
      ),
    );
  }

  // MOBILE BRANDING
  Widget _mobileBrand() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.darkNavy, AppTheme.primaryBlue],
        ),
      ),
      child: Column(
        children: [
          _logo(),

          const SizedBox(height: 12),

          const Text(
            'GT-InStock',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Global Tracking InStock',
            style: TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }

  // LOGO

  Widget _logo() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withValues(alpha: 0.20),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/onecloud_logo.png',
        width: 280,
        fit: BoxFit.contain,
      ),
    );
  }

  // DECORATIVE SHAPE

  Widget _shape(double width) {
    return Transform.rotate(
      angle: -0.5,
      child: Container(
        width: width,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  // FEATURE

  Widget _feature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.white, size: 19),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }

  // LOGIN SECTION

  Widget _loginSection() {
    return Container(
      padding: const EdgeInsets.all(45),
      constraints: const BoxConstraints(minHeight: 520),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'USER LOGIN',
                style: TextStyle(
                  color: AppTheme.darkNavy,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),

              if (!showTwoStep) ...[
                const SizedBox(height: 35),

                TextField(
                  controller: emailController,
                  decoration: _input('Enter your email', Icons.person_outline),
                ),

                const SizedBox(height: 18),

                TextField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  onSubmitted: (_) => login(),
                  decoration: _input(
                    'Enter your password',
                    Icons.lock_outline,
                    IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(
                        hidePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                if (errorMessage.isNotEmpty)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Remember me',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),

                    TextButton(
                      onPressed: () {
                        context.push(AppRoutes.forgotPassword);
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppTheme.primaryBlue,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: 140,
                  height: 44,
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
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: OutlinedButton(
                    onPressed: loginWithGoogle,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.darkNavy,
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'G',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4285F4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    context.push(AppRoutes.register);
                  },
                  child: const Text(
                    "Don't have an account? Register",
                    style: TextStyle(color: AppTheme.primaryBlue, fontSize: 12),
                  ),
                ),
              ] else ...[
                const SizedBox(height: 35),

                const Icon(
                  Icons.verified_user_outlined,
                  size: 55,
                  color: AppTheme.primaryBlue,
                ),

                const SizedBox(height: 15),

                const Text(
                  '2-STEP VERIFICATION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.darkNavy,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Enter the verification code to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Verification Code: $verificationCode',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: verificationController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  decoration: _input('Enter 6-digit code', Icons.pin_outlined),
                ),

                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 140,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: verifyTwoStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'VERIFY',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () {
                    setState(() {
                      showTwoStep = false;
                      verificationCode = '';
                      verificationController.clear();
                      errorMessage = '';
                    });
                  },
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(color: AppTheme.primaryBlue, fontSize: 12),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // INPUT STYLE

  InputDecoration _input(String hint, IconData icon, [Widget? suffix]) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
      prefixIcon: Icon(icon, color: AppTheme.primaryBlue, size: 19),
      suffixIcon: suffix,
      filled: true,
      fillColor: AppTheme.lightBlue,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: AppTheme.primaryBlue, width: 1.5),
      ),
    );
  }
}
