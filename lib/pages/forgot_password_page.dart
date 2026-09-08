import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../app_theme.dart';
import '../providers/user_provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool showPasswordFields = false;
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  String message = '';
  bool isSuccess = false;

  void checkEmail() {
    final email = emailController.text.trim();

    setState(() {
      message = '';
      isSuccess = false;
    });

    if (email.isEmpty) {
      setState(() {
        message = 'Please enter your email.';
      });
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      setState(() {
        message = 'Please enter a valid email address.';
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (!userProvider.emailExists(email)) {
      setState(() {
        message = 'No registered account found with this email.';
      });
      return;
    }

    setState(() {
      showPasswordFields = true;
      message = 'Email verified. Enter your new password.';
      isSuccess = true;
    });
  }

  void resetPassword() {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

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

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.resetPassword(emailController.text.trim(), password);

    setState(() {
      message = 'Password reset successful! You can now login.';
      isSuccess = true;
      passwordController.clear();
      confirmPasswordController.clear();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(
    String label,
    IconData icon, {
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppTheme.primaryBlue),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppTheme.lightBlue,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.lock_reset,
                      size: 60,
                      color: AppTheme.primaryBlue,
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Forgot Password?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      showPasswordFields
                          ? 'Create a new password for your account.'
                          : 'Enter your registered email address.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),

                    const SizedBox(height: 28),

                    TextField(
                      controller: emailController,
                      enabled: !showPasswordFields,
                      keyboardType: TextInputType.emailAddress,
                      decoration: inputDecoration(
                        'Email',
                        Icons.email_outlined,
                      ),
                    ),

                    if (!showPasswordFields) ...[
                      const SizedBox(height: 20),

                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: checkEmail,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Verify Email',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],

                    if (showPasswordFields) ...[
                      const SizedBox(height: 18),

                      TextField(
                        controller: passwordController,
                        obscureText: hidePassword,
                        decoration: inputDecoration(
                          'New Password',
                          Icons.lock_outline,
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
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller: confirmPasswordController,
                        obscureText: hideConfirmPassword,
                        onSubmitted: (_) => resetPassword(),
                        decoration: inputDecoration(
                          'Confirm New Password',
                          Icons.lock_outline,
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
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: resetPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Reset Password',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],

                    if (message.isNotEmpty) ...[
                      const SizedBox(height: 18),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSuccess ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],

                    const SizedBox(height: 15),

                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Back to Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
