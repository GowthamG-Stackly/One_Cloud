import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'welcome_page.dart';
import 'user_provider.dart';

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

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Please enter email and password';
      });
      return;
    }

    if (email == 'admin@gmail.com' && password == '123456') {
      Provider.of<UserProvider>(context, listen: false).login(email);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    } else {
      setState(() {
        errorMessage = 'Invalid email or password';
      });
    }
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8FBE9F), Color(0xFFB8D8C1), Color(0xFF78AD8B)],
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

  // ============================================================
  // DESKTOP / TABLET MAIN BOX
  // ============================================================

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

  // ============================================================
  // MOBILE MAIN BOX
  // ============================================================

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

  // ============================================================
  // DESKTOP LEFT SIDE
  // ============================================================

  Widget _brandSection() {
    return Container(
      padding: const EdgeInsets.all(45),
      constraints: const BoxConstraints(minHeight: 520),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF166534), Color(0xFF22A05A)],
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

              const Text(
                'Welcome to\nGT-InStock',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
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

  // ============================================================
  // MOBILE BRANDING
  // ============================================================

  Widget _mobileBrand() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF166534), Color(0xFF22A05A)],
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

  // ============================================================
  // LOGO
  // ============================================================

  Widget _logo() {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Text(
          'GT',
          style: TextStyle(
            color: Color(0xFF15803D),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DECORATIVE SHAPE
  // ============================================================

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

  // ============================================================
  // FEATURE
  // ============================================================

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

  // ============================================================
  // LOGIN SECTION
  // ============================================================

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
                  color: Color(0xFF15803D),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),

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
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color(0xFF16A34A), fontSize: 11),
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
                    backgroundColor: const Color(0xFF16A34A),
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

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {},
                child: const Text(
                  "Don't have an account? Register",
                  style: TextStyle(color: Color(0xFF16A34A), fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // INPUT STYLE
  // ============================================================

  InputDecoration _input(String hint, IconData icon, [Widget? suffix]) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
      prefixIcon: Icon(icon, color: const Color(0xFF16A34A), size: 19),
      suffixIcon: suffix,
      filled: true,
      fillColor: const Color(0xFFF5F9F6),
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
        borderSide: const BorderSide(color: Color(0xFF16A34A), width: 1.5),
      ),
    );
  }
}
