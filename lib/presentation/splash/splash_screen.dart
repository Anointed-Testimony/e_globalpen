import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hive/hive.dart';
import '../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(Duration(seconds: 3)); // Simulate loading

    var box = await Hive.openBox('appData'); // Ensure box is opened
    bool hasSeenOnboarding = box.get('hasSeenOnboarding', defaultValue: false);

    print('DEBUG: hasSeenOnboarding = $hasSeenOnboarding'); // Debugging

    if (mounted) { // Ensure widget is still in the tree before navigating
      Navigator.pushReplacementNamed(
          context, hasSeenOnboarding ? '/home' : '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash_bg.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: AppTheme.primaryColor.withOpacity(0.9),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(seconds: 2),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Global Pen Reads',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
