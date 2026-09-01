import 'package:flutter/material.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/core/theme/app_theme.dart';
import 'package:lactarehub/presentation/navigation/app_navigation.dart';

void main() {
  ServiceLocator.setUp();
  runApp(const LactareApp());
}

class LactareApp extends StatelessWidget {
  const LactareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lactare',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppNavigation.generateRoutes,
    );
  }
}
