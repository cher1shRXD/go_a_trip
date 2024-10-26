import 'package:flutter/material.dart';
import 'package:go_a_trip/components/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      const Header(title: 'Go a Trip'),
      Container(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home, size: 100, color: Colors.lime[300]),
              const SizedBox(height: 16),
              const Text(
                'Home Screen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
