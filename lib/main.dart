import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:e_globalpen_app/presentation/splash/splash_screen.dart';

import 'presentation/auth/sign_in_screen.dart';
import 'presentation/home/home_screen.dart';
import 'presentation/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings'); // Open a box for storing onboarding state
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-GlobalPen',
      theme: ThemeData(primaryColor: Color(0xFF790679)),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/signin': (context) => SignInScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
