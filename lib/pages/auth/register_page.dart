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

  // ============================================================
  // REGISTER CARD
  // ============================================================

  Widget _buildRegisterCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 500;

        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 450),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 30,
            vertical: isMobile ? 10 : 30,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isMobile ? 14 : 20),
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
          child: _buildRegisterForm(isMobile),
        );
      },
    );
  }

  // ============================================================
  // REGISTER FORM
  // ============================================================

  Widget _buildRegisterForm(bool isMobile) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ------------------------------------------------------
          // TITLE
          // ------------------------------------------------------

          Text(
            'Create Account',
            style: GoogleFonts.roboto(
              color: AppTheme.darkNavy,
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(height: isMobile ? 3 : 7),

          Text(
            'Create your OneCloud account to get started.',
            style: GoogleFonts.roboto(
              color: AppTheme.darkNavy.withValues(alpha: 0.55),
              fontSize: isMobile ? 10 : 12,
              height: 1.25,
            ),
          ),

          SizedBox(height: isMobile ? 10 : 25),

          // ------------------------------------------------------
          // FULL NAME
          // ------------------------------------------------------
          _buildLabel('Full Name', isMobile),

          SizedBox(height: isMobile ? 4 : 7),

          _buildTextField(
            controller: _nameController,
            hintText: 'Enter your full name',
            icon: Icons.person_outline,
            textInputAction: TextInputAction.next,
            isMobile: isMobile,
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

          SizedBox(height: isMobile ? 8 : 17),

          // ------------------------------------------------------
          // EMAIL
          // ------------------------------------------------------
          _buildLabel('Email Address', isMobile),

          SizedBox(height: isMobile ? 4 : 7),

          _buildTextField(
            controller: _emailController,
            hintText: 'Enter your email address',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            isMobile: isMobile,
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

          SizedBox(height: isMobile ? 8 : 17),

          // ------------------------------------------------------
          // PASSWORD
          // ------------------------------------------------------
          _buildLabel('Password', isMobile),

          SizedBox(height: isMobile ? 4 : 7),

          _buildTextField(
            controller: _passwordController,
            hintText: 'Create a password',
            icon: Icons.lock_outline,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
            isMobile: isMobile,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppTheme.darkNavy.withValues(alpha: 0.45),
                size: isMobile ? 17 : 19,
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

          SizedBox(height: isMobile ? 8 : 17),

          // ------------------------------------------------------
          // CONFIRM PASSWORD
          // ------------------------------------------------------
          _buildLabel('Confirm Password', isMobile),

          SizedBox(height: isMobile ? 4 : 7),

          _buildTextField(
            controller: _confirmPasswordController,
            hintText: 'Confirm your password',
            icon: Icons.lock_outline,
            obscureText: _obscureConfirmPassword,
            textInputAction: TextInputAction.done,
            isMobile: isMobile,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppTheme.darkNavy.withValues(alpha: 0.45),
                size: isMobile ? 17 : 19,
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

          SizedBox(height: isMobile ? 7 : 14),

          // ------------------------------------------------------
          // TERMS
          // ------------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: AppTheme.primaryBlue,
                size: isMobile ? 14 : 16,
              ),

              SizedBox(width: isMobile ? 5 : 7),

              Expanded(
                child: Text(
                  'By creating an account, you agree to the '
                  'OneCloud platform terms and conditions.',
                  style: GoogleFonts.roboto(
                    color: AppTheme.darkNavy.withValues(alpha: 0.55),
                    fontSize: isMobile ? 8 : 9.5,
                    height: isMobile ? 1.2 : 1.4,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 10 : 22),

          // ------------------------------------------------------
          // REGISTER BUTTON
          // ------------------------------------------------------
          SizedBox(
            width: double.infinity,
            height: isMobile ? 42 : 50,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppTheme.primaryBlue.withValues(
                  alpha: 0.50,
                ),
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
                ),
              ),
              child: _isLoading
                  ? SizedBox(
                      width: isMobile ? 18 : 21,
                      height: isMobile ? 18 : 21,
                      child: const CircularProgressIndicator(
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
                            fontSize: isMobile ? 11 : 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(width: isMobile ? 5 : 8),

                        Icon(
                          Icons.arrow_forward_rounded,
                          size: isMobile ? 15 : 18,
                        ),
                      ],
                    ),
            ),
          ),

          SizedBox(height: isMobile ? 8 : 20),

          // ------------------------------------------------------
          // LOGIN LINK
          // ------------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Already have an account?',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    color: AppTheme.darkNavy.withValues(alpha: 0.55),
                    fontSize: isMobile ? 9 : 11,
                  ),
                ),
              ),

              SizedBox(width: isMobile ? 3 : 5),

              TextButton(
                onPressed: () {
                  context.go(AppRoutes.login);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 3 : 4,
                    vertical: 1,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Sign In',
                  style: GoogleFonts.roboto(
                    color: AppTheme.primaryBlue,
                    fontSize: isMobile ? 9 : 11,
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

  Widget _buildLabel(String text, bool isMobile) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        color: AppTheme.darkNavy,
        fontSize: isMobile ? 9 : 11,
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
    required bool isMobile,
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
        fontSize: isMobile ? 10 : 12,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
          color: AppTheme.darkNavy.withValues(alpha: 0.35),
          fontSize: isMobile ? 9 : 11,
        ),

        prefixIcon: Icon(
          icon,
          color: AppTheme.darkNavy.withValues(alpha: 0.45),
          size: isMobile ? 16 : 19,
        ),

        prefixIconConstraints: BoxConstraints(
          minWidth: isMobile ? 38 : 48,
          minHeight: isMobile ? 38 : 48,
        ),

        suffixIcon: suffixIcon,

        filled: true,
        fillColor: Colors.white,

        contentPadding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 14,
          vertical: isMobile ? 9 : 14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
          borderSide: BorderSide(
            color: AppTheme.darkNavy.withValues(alpha: 0.08),
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
          borderSide: BorderSide(
            color: AppTheme.darkNavy.withValues(alpha: 0.08),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
          borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 1.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
          borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.60)),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
          borderSide: BorderSide(
            color: Colors.red.withValues(alpha: 0.70),
            width: 1.5,
          ),
        ),

        errorStyle: GoogleFonts.roboto(
          fontSize: isMobile ? 7.5 : 9,
          fontWeight: FontWeight.w500,
          height: 1.0,
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

    context.go(AppRoutes.login);
  }
}
