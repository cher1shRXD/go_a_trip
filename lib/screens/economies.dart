import 'package:flutter/material.dart';
import 'package:go_a_trip/components/header.dart';

class EconomiesScreen extends StatelessWidget {
  const EconomiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      const Header(title: 'Economies'),
      Container(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wallet, size: 100, color: Colors.lime[300]),
              const SizedBox(height: 16),
              const Text(
                'Economies Screen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
