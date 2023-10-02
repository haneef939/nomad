import 'package:flutter/material.dart';
import 'package:nomad/views/splash/splash.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/splash":
        return MaterialPageRoute(builder: (_) => Splash());
      default:
        return null;
    }
  }
}
