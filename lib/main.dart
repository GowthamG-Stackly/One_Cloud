import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';
import 'user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: const GTInStockApp(),
    ),
  );
}

class GTInStockApp extends StatelessWidget {
  const GTInStockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GT-InStock',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
