import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../app_theme.dart';
import '../../providers/user_provider.dart';
import '../../routes/routes.dart';
import '../../widgets/auth_layout.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(reverse: true, child: _buildRegisterCard());
  }

  Widget _buildRegisterCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 500;

        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 450),
          padding: EdgeInsets.all(isSmallScreen ? 20 : 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isSmallScreen ? 14 : 20),
            border: Border.all(
              color: AppTheme.darkNavy.withValues(alpha: 0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.darkNavy.withValues(alpha: 0.08),
                blurRadius: 25,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: _buildRegisterForm(),
        );
      },
    );
  }

  // ============================================================
  // REGISTER FORM
  // ============================================================

  Widget _buildRegisterForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------------------------------------------
          // TITLE
          // ------------------------------------------------------

          Text(
            'Create Account',
            style: GoogleFonts.roboto(
              color: AppTheme.darkNavy,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            'Create your OneCloud account to get started.',
            style: GoogleFonts.roboto(
              color: AppTheme.darkNavy.withValues(alpha: 0.55),
              fontSize: 12,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 25),

          // ------------------------------------------------------
          // FULL NAME
          // ------------------------------------------------------
          _buildLabel('Full Name'),

          const SizedBox(height: 7),

          _buildTextField(
            controller: _nameController,
            hintText: 'Enter your full name',
            icon: Icons.person_outline,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }

              if (value.trim().length < 2) {
                return 'Name must contain at least 2 characters';
              }

              return null;
            },
          ),

          const SizedBox(height: 17),

          // ------------------------------------------------------
          // EMAIL
          // ------------------------------------------------------
          _buildLabel('Email Address'),

          const SizedBox(height: 7),

          _buildTextField(
            controller: _emailController,
            hintText: 'Enter your email address',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }

              final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

              if (!emailRegex.hasMatch(value.trim())) {
                return 'Please enter a valid email address';
              }

              return null;
            },
          ),

          const SizedBox(height: 17),

          // ------------------------------------------------------
          // PASSWORD
          // ------------------------------------------------------
          _buildLabel('Password'),

          const SizedBox(height: 7),

          _buildTextField(
            controller: _passwordController,
            hintText: 'Create a password',
            icon: Icons.lock_outline,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
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
                color: AppTheme.darkNavy.withValues(alpha: 0.45),
                size: 19,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }

              if (value.length < 6) {
                return 'Password must contain at least 6 characters';
              }

              return null;
            },
          ),

          const SizedBox(height: 17),

          // ------------------------------------------------------
          // CONFIRM PASSWORD
          // ------------------------------------------------------
          _buildLabel('Confirm Password'),

          const SizedBox(height: 7),

          _buildTextField(
            controller: _confirmPasswordController,
            hintText: 'Confirm your password',
            icon: Icons.lock_outline,
            obscureText: _obscureConfirmPassword,
            textInputAction: TextInputAction.done,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppTheme.darkNavy.withValues(alpha: 0.45),
                size: 19,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }

              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }

              return null;
            },
            onFieldSubmitted: (_) {
              _register();
            },
          ),

          const SizedBox(height: 14),

          // ------------------------------------------------------
          // TERMS
          // ------------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: AppTheme.primaryBlue,
                size: 16,
              ),

              const SizedBox(width: 7),

              Expanded(
                child: Text(
                  'By creating an account, you agree to the '
                  'OneCloud platform terms and conditions.',
                  style: GoogleFonts.roboto(
                    color: AppTheme.darkNavy.withValues(alpha: 0.55),
                    fontSize: 9.5,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // ------------------------------------------------------
          // REGISTER BUTTON
          // ------------------------------------------------------
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppTheme.primaryBlue.withValues(
                  alpha: 0.50,
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 21,
                      height: 21,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create Account',
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, size: 18),
                      ],
                    ),
            ),
          ),

          const SizedBox(height: 20),

          // ------------------------------------------------------
          // LOGIN LINK
          // ------------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: GoogleFonts.roboto(
                  color: AppTheme.darkNavy.withValues(alpha: 0.55),
                  fontSize: 11,
                ),
              ),

              const SizedBox(width: 5),

              TextButton(
                onPressed: () {
                  context.go(AppRoutes.login);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Sign In',
                  style: GoogleFonts.roboto(
                    color: AppTheme.primaryBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LABEL
  // ============================================================

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        color: AppTheme.darkNavy,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function(String)? onFieldSubmitted,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      style: GoogleFonts.roboto(
        color: AppTheme.darkNavy,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
          color: AppTheme.darkNavy.withValues(alpha: 0.35),
          fontSize: 11,
        ),
        prefixIcon: Icon(
          icon,
          color: AppTheme.darkNavy.withValues(alpha: 0.45),
          size: 19,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppTheme.darkNavy.withValues(alpha: 0.08),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppTheme.darkNavy.withValues(alpha: 0.08),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.60)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red.withValues(alpha: 0.70),
            width: 1.5,
          ),
        ),
        errorStyle: GoogleFonts.roboto(
          fontSize: 9,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ============================================================
  // REGISTER
  // ============================================================

  void _register() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Your UserProvider.register() is synchronous.
    userProvider.register(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Account created successfully',
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 12),
        ),
        backgroundColor: AppTheme.primaryBlue,
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Go to Login after registration.
    context.go(AppRoutes.login);
  }
}
