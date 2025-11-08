import 'package:ratabli/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ratabli/pages/auth/signin_page.dart';
import 'package:ratabli/pages/auth/signup_page.dart';
import 'package:ratabli/pages/home/home_page.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        // User is logged in
        if (snapshot.hasData) {
          return const HomePage();
        }
        // User is NOT logged in
        else {
          return const LoginPage();
        }
      },
    );
  }
}