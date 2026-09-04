import 'package:flutter/material.dart';

import 'login_page.dart';

void main() {
  runApp(const GTInStockApp());
}

class GTInStockApp extends StatelessWidget {
  const GTInStockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GT-InStock',

      theme: ThemeData(
        primaryColor: const Color(0xFF16A34A),
        scaffoldBackgroundColor: const Color(0xFFF3F8F4),
        fontFamily: 'Arial',
      ),

      home: const LoginPage(),
    );
  }
}
