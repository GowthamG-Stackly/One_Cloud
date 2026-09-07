import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';
import 'dashboard_page.dart';
import 'user_provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const green = Color(0xFF16A34A);
  static const darkGreen = Color(0xFF087443);
  static const lightGreen = Color(0xFFE8F7EC);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAF6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, size) {
            final mobile = size.maxWidth < 700;

            return SingleChildScrollView(
              child: Column(
                children: [
                  _header(context, mobile),
                  _hero(context, mobile, userProvider),
                  _features(mobile),
                  _stats(mobile),
                  const SizedBox(height: 25),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _header(BuildContext context, bool mobile) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: mobile ? 18 : 45, vertical: 14),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [darkGreen, green]),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'GT',
              style: TextStyle(
                color: green,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GT-InStock',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Global Tracking InStock',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          if (!mobile)
            const Row(
              children: [
                Text('Home', style: TextStyle(color: Colors.white)),
                SizedBox(width: 28),
                Text('About', style: TextStyle(color: Colors.white70)),
                SizedBox(width: 28),
                Text('Features', style: TextStyle(color: Colors.white70)),
                SizedBox(width: 28),
              ],
            ),
          TextButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            },
            icon: const Icon(Icons.dashboard, color: Colors.white),
            label: mobile
                ? const SizedBox()
                : const Text(
                    'Dashboard',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
          IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
          ),
        ],
      ),
    );
  }

  Widget _hero(BuildContext context, bool mobile, UserProvider userProvider) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        mobile ? 20 : 55,
        mobile ? 35 : 55,
        mobile ? 20 : 55,
        35,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFE8F7EC), Colors.white]),
      ),
      child: Column(
        children: [
          const Icon(Icons.inventory_2_rounded, size: 55, color: green),
          const SizedBox(height: 15),
          Text(
            'Welcome to GT-InStock',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: mobile ? 30 : 44,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Smart Inventory Management for a Better Tomorrow',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: mobile ? 16 : 21,
              fontWeight: FontWeight.w600,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Manage inventory, track stock movements, monitor availability '
            'and make informed decisions — all in one place.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
          ),
          const SizedBox(height: 28),

          Container(
            constraints: const BoxConstraints(maxWidth: 720),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .07),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              runSpacing: 15,
              children: [
                const Icon(Icons.account_circle, size: 55, color: green),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GT-InStock User',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      userProvider.email.isEmpty
                          ? 'No email available'
                          : userProvider.email,
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const Text(
                      'Inventory Management User',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: lightGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '●  Active User',
                    style: TextStyle(
                      color: darkGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          SizedBox(
            width: mobile ? double.infinity : 320,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardPage(),
                  ),
                );
              },
              icon: const Icon(Icons.dashboard),
              label: const Text(
                'Go to Dashboard  →',
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _features(bool mobile) {
    final features = [
      [
        Icons.inventory_2,
        'Inventory Management',
        'Organize and manage your products efficiently.',
      ],
      [
        Icons.swap_horiz,
        'Stock Movement',
        'Track incoming and outgoing stock easily.',
      ],
      [
        Icons.bar_chart,
        'Reports & Analytics',
        'Get insights and make better inventory decisions.',
      ],
      [
        Icons.notifications_active,
        'Stock Alerts',
        'Stay informed about low-stock availability.',
      ],
    ];

    return Padding(
      padding: EdgeInsets.all(mobile ? 18 : 40),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: features.map((item) {
          return Container(
            width: mobile ? double.infinity : 255,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: green.withValues(alpha: .12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .04),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(item[0] as IconData, color: green, size: 32),
                const SizedBox(height: 12),
                Text(
                  item[1] as String,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  item[2] as String,
                  style: const TextStyle(color: Colors.black54, height: 1.4),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _stats(bool mobile) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mobile ? 18 : 40),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 35,
        runSpacing: 18,
        children: const [
          _Stat(Icons.inventory, '1,248+', 'Products Tracked'),
          _Stat(Icons.people, '50+', 'Active Users'),
          _Stat(Icons.verified, '99%', 'System Uptime'),
          _Stat(Icons.trending_up, 'Better', 'Inventory Control'),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).logout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String title;

  const _Stat(this.icon, this.value, this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFF16A34A), size: 30),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF087443),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ],
    );
  }
}
