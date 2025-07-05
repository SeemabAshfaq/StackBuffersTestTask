import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel {
  Future<void> initializeApp(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    await Future.delayed(const Duration(seconds: 3));
    if (!context.mounted) return;
    if (isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('/navbar');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }
}
