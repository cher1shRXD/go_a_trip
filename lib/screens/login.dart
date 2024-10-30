import 'package:flutter/material.dart';
import 'package:go_a_trip/components/header.dart';
import 'package:go_a_trip/components/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(title: '로그인'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: LoginForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
