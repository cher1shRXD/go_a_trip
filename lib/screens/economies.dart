import 'package:flutter/material.dart';

class EconomiesScreen extends StatelessWidget {
  const EconomiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wallet, size: 100, color: Colors.purple[300]),
            const SizedBox(height: 16),
            const Text(
              'Economies Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
