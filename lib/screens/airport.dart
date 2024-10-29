import 'package:flutter/material.dart';
import 'package:go_a_trip/components/header.dart';

class AirportScreen extends StatelessWidget {
  const AirportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Header(title: '공항'),
          Container(
            color: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_airport, size: 100, color: Colors.lime[300]),
                  const SizedBox(height: 16),
                  const Text(
                    'Airport Screen',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ]
      )
    );
  }
}
