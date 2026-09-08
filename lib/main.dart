import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/routes.dart';
import 'providers/user_provider.dart';
import 'app_theme.dart';

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Once Enterprise Cloud Platform',
      theme: AppTheme.theme,
      routerConfig: AppRoutes.router,
    );
  }
}
