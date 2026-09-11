import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import '../../providers/user_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  String message = '';
  bool isSuccess = false;

  void register() {
    setState(() {
      message = '';
      isSuccess = false;
    });

    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        message = 'Please fill in all fields.';
      });
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      setState(() {
        message = 'Please enter a valid email address.';
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

    final UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    userProvider.register(name, email, password);

    setState(() {
      message = 'Registration successful! You can now login.';
      isSuccess = true;
    });
  }

  void backToLogin() {
    context.pop();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkNavy,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.white,
              AppTheme.lightBlue,
              AppTheme.primaryBlue,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1050),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth < 650) {
                      return _mobileLayout();
                    }
                    return _desktopLayout();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _desktopLayout() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: _brandSection()),
            Expanded(child: _registerSection()),
          ],
        ),
      ),
    );
  }

  Widget _mobileLayout() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[_mobileBrand(), _registerSection()],
      ),
    );
  }

  Widget _brandSection() {
    return Container(
      padding: const EdgeInsets.all(42),
      constraints: const BoxConstraints(minHeight: 610),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[AppTheme.darkNavy, AppTheme.primaryBlue],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(right: -35, top: 40, child: _shape(130)),
          Positioned(left: -45, bottom: 30, child: _shape(170)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _logo(),
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Create your\n',
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
              Text(
                'Create your organization account and bring '
                'users, business services, workflows and data '
                'together in one secure enterprise platform.',
                style: GoogleFonts.roboto(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 28),
              _feature('Unified Enterprise Services'),
              _feature('Users, Tenants & Access Control'),
              _feature('Reports & Business Intelligence'),
              _feature('Workflow & Platform Automation'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mobileBrand() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[AppTheme.darkNavy, AppTheme.primaryBlue],
        ),
      ),
      child: Column(
        children: <Widget>[
          _logo(),
          const SizedBox(height: 12),
          Text(
            'ONE CLOUD',
            style: GoogleFonts.blackOpsOne(color: Colors.white, fontSize: 25),
          ),
          const SizedBox(height: 3),
          Text(
            'Enterprise Platform',
            style: GoogleFonts.roboto(
              color: const Color(0xFF7DD3FC),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _logo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.primaryBlue.withValues(alpha: 0.20),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/onecloud_logo.png',
        width: 230,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _shape(double width) {
    return Transform.rotate(
      angle: -0.5,
      child: Container(
        width: width,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _feature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: <Widget>[
          const Icon(Icons.check_circle_outline, color: Colors.white, size: 19),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerSection() {
    return Container(
      color: const Color(0xFFF8FAFC),
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 34),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 390),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'CREATE ACCOUNT',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: AppTheme.darkNavy,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Start using OneCloud Enterprise Platform',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.blueGrey.shade500,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 22),
              _fieldLabel('FULL NAME'),
              const SizedBox(height: 7),
              TextField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: _input(
                  'Enter your full name',
                  Icons.person_outline_rounded,
                ),
              ),
              const SizedBox(height: 13),
              _fieldLabel('EMAIL ADDRESS'),
              const SizedBox(height: 7),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: _input(
                  'Enter your business email',
                  Icons.email_outlined,
                ),
              ),
              const SizedBox(height: 13),
              _fieldLabel('PASSWORD'),
              const SizedBox(height: 7),
              TextField(
                controller: passwordController,
                obscureText: hidePassword,
                textInputAction: TextInputAction.next,
                decoration: _input(
                  'Create a password',
                  Icons.lock_outline_rounded,
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
                      color: Colors.blueGrey.shade400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              _fieldLabel('CONFIRM PASSWORD'),
              const SizedBox(height: 7),
              TextField(
                controller: confirmPasswordController,
                obscureText: hideConfirmPassword,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => register(),
                decoration: _input(
                  'Confirm your password',
                  Icons.lock_outline_rounded,
                  IconButton(
                    onPressed: () {
                      setState(() {
                        hideConfirmPassword = !hideConfirmPassword;
                      });
                    },
                    icon: Icon(
                      hideConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.blueGrey.shade400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _securityNote(),
              if (message.isNotEmpty) ...<Widget>[
                const SizedBox(height: 12),
                _messageBox(),
              ],
              const SizedBox(height: 15),
              SizedBox(
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: register,
                  icon: const Icon(Icons.person_add_alt_1_rounded, size: 17),
                  label: Text(
                    'CREATE ACCOUNT',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              TextButton(
                onPressed: backToLogin,
                child: Text(
                  'Already have an account? Login',
                  style: GoogleFonts.roboto(
                    color: AppTheme.primaryBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.verified_user_outlined,
                    size: 13,
                    color: Colors.blueGrey.shade400,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'OneCloud Enterprise Security',
                    style: GoogleFonts.roboto(
                      color: Colors.blueGrey.shade400,
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        color: AppTheme.darkNavy,
        fontSize: 9,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.9,
      ),
    );
  }

  InputDecoration _input(String hint, IconData icon, [Widget? suffixIcon]) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.roboto(
        color: Colors.blueGrey.shade400,
        fontSize: 11,
      ),
      prefixIcon: Icon(icon, color: AppTheme.primaryBlue, size: 19),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFFE1E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFFE1E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: AppTheme.primaryBlue, width: 1.4),
      ),
    );
  }

  Widget _securityNote() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(
        color: AppTheme.lightBlue.withValues(alpha: 0.50),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: AppTheme.primaryBlue.withValues(alpha: 0.10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.security_outlined,
            color: AppTheme.primaryBlue,
            size: 17,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Create a secure account to access OneCloud '
              'enterprise services.',
              style: GoogleFonts.roboto(
                color: AppTheme.darkNavy,
                fontSize: 10,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageBox() {
    final Color color = isSuccess ? Colors.green.shade700 : Colors.red.shade700;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            isSuccess ? Icons.check_circle_outline : Icons.error_outline,
            size: 17,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.roboto(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
