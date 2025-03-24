import 'package:flutter/material.dart';
import 'package:e_globalpen_app/presentation/splash/splash_screen.dart';
import 'package:e_globalpen_app/presentation/home/home_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => SplashScreen(),
};
