import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../app_theme.dart';
import '../providers/user_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  String errorMessage = '';

  void register() {
    setState(() {
      errorMessage = '';
    });

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields.';
      });
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      setState(() {
        errorMessage = 'Please enter a valid email address.';
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        errorMessage = 'Password must be at least 6 characters.';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        errorMessage = 'Passwords do not match.';
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.register(name, email, password);

    setState(() {
      errorMessage = 'Registration successful! You can now login.';
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppTheme.primaryBlue, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.person_add_alt_1,
                        size: 55,
                        color: AppTheme.primaryBlue,
                      ),

                      const SizedBox(height: 15),

                      Text(
                        'Register',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryBlue,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Create your GT-InStock account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 30),

                      TextField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        decoration: inputDecoration(
                          label: 'Full Name',
                          icon: Icons.person_outline,
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: inputDecoration(
                          label: 'Email',
                          icon: Icons.email_outlined,
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller: passwordController,
                        obscureText: hidePassword,
                        textInputAction: TextInputAction.next,
                        decoration: inputDecoration(
                          label: 'Password',
                          icon: Icons.lock_outline,
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
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => register(),
                        decoration: inputDecoration(
                          label: 'Confirm Password',
                          icon: Icons.lock_outline,
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

                      if (errorMessage.isNotEmpty) ...[
                        const SizedBox(height: 18),
                        Text(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                errorMessage.startsWith(
                                  'Registration successful',
                                )
                                ? Colors.green
                                : Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],

                      const SizedBox(height: 25),

                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: AppTheme.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
