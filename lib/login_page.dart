import 'package:flutter/material.dart';

import 'welcome_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Variables
  bool hidePassword = true;
  String errorMessage = '';

  // Login function
  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text;

    // Clear previous error
    setState(() {
      errorMessage = '';
    });

    // Email validation
    if (email.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your email';
      });
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      setState(() {
        errorMessage = 'Please enter a valid email address';
      });
      return;
    }

    // Password validation
    if (password.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your password';
      });
      return;
    }

    if (password.length < 8) {
      setState(() {
        errorMessage = 'Password must be at least 8 characters';
      });
      return;
    }

    // Open Welcome Page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
  }

  // Forgot password
  void forgotPassword() {
    setState(() {
      // errorMessage = 'Password reset feature will be available soon';
    });
  }

  // Register
  void register() {
    setState(() {
      // errorMessage = 'Registration feature will be available soon';
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 400,

            padding: const EdgeInsets.all(35),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // GT LOGO
                Center(
                  child: Container(
                    width: 65,
                    height: 65,

                    decoration: BoxDecoration(
                      color: const Color(0xFF16A34A),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: const Center(
                      child: Text(
                        'GT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // APP NAME
                const Center(
                  child: Text(
                    'GT-InStock',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF15803D),
                    ),
                  ),
                ),

                const SizedBox(height: 3),

                const Center(
                  child: Text(
                    'Global Tracking InStock',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),

                const SizedBox(height: 25),

                // WELCOME TEXT
                const Text(
                  'Inventory Management System',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Sign in to access GT-InStock',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),

                const SizedBox(height: 18),

                // EMAIL
                const Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),

                const SizedBox(height: 6),

                TextField(
                  controller: emailController,

                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                    hintText: 'Enter your email',

                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Color(0xFF16A34A),
                    ),

                    contentPadding: const EdgeInsets.symmetric(vertical: 12),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),

                      borderSide: const BorderSide(
                        color: Color(0xFF16A34A),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // PASSWORD
                const Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),

                const SizedBox(height: 6),

                TextField(
                  controller: passwordController,

                  obscureText: hidePassword,

                  decoration: InputDecoration(
                    hintText: 'Enter your password',

                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Color(0xFF16A34A),
                    ),

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

                    contentPadding: const EdgeInsets.symmetric(vertical: 12),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),

                      borderSide: const BorderSide(
                        color: Color(0xFF16A34A),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                // ERROR MESSAGE
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),

                    child: Text(
                      errorMessage,

                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                // FORGOT PASSWORD
                Align(
                  alignment: Alignment.centerRight,

                  child: TextButton(
                    onPressed: forgotPassword,

                    child: const Text(
                      'Forgot Password?',

                      style: TextStyle(
                        color: Color(0xFF16A34A),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 46,

                  child: ElevatedButton(
                    onPressed: login,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16A34A),

                      foregroundColor: Colors.white,

                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    child: const Text(
                      'Login',

                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // REGISTER
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Text(
                        "Don't have an account?",

                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),

                      TextButton(
                        onPressed: register,

                        child: const Text(
                          'Register',

                          style: TextStyle(
                            color: Color(0xFF16A34A),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                // FOOTER
                const Center(
                  child: Text(
                    'Global Tracking InStock',

                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
