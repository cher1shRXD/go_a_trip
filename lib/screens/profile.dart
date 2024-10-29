import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_a_trip/components/header.dart';
import 'package:go_a_trip/screens/login.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const tokenStore = FlutterSecureStorage();

    void clearToken() async {
      await tokenStore.delete(key: 'accessToken');
      await tokenStore.delete(key: 'refreshToken');
    }

    return SafeArea(
        child: Column(children: [
      const Header(title: '프로필'),
      Container(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 100, color: Colors.lime[300]),
              const SizedBox(height: 16),
              const Text(
                'Profile Screen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                    onPressed: () {
                      clearToken();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text('로그아웃')),
              )
            ],
          ),
        ),
      ),
    ]));
  }
}
