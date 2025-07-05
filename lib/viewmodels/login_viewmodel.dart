import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stack_buffer_test_task/core/colors.dart';
import '../core/snackbar_service.dart';

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> login(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/productList');
      }
    } on FirebaseAuthException catch (e) {
      SnackbarService.showSnackbar(
        title: "Error",
        message: e.message ?? 'Login failed',
        icon: Icons.error_outline,
      );
    } catch (e) {
      SnackbarService.showSnackbar(
         title: "Error",
        message: 'An error occurred',
        icon: Icons.error_outline,
      );
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn && context.mounted) {
      Navigator.of(context).pushReplacementNamed('/productList');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
