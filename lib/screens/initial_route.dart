import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_a_trip/components/navigation.dart';
import 'package:go_a_trip/screens/login.dart';
import 'package:go_a_trip/services/auth/get_token.dart';

class InitialRoute extends StatelessWidget {
  const InitialRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: GetToken.getAccessToken(),
      builder: (context, snapshot) {
        log(snapshot.data.toString());
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const LoginScreen();
        }

        return const Navigation();
      },
    );
  }
}
