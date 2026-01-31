import 'package:flutter/material.dart';
import 'package:studio_page_case/features/splash/presentation/splash_screen.dart';
import 'package:studio_page_case/features/studio/presentation/pages/studio_page.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String studio = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case studio:
        return MaterialPageRoute(builder: (_) => const StudioPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route not found: ${settings.name}')),
          ),
        );
    }
  }
}
