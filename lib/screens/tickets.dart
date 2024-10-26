import 'package:flutter/material.dart';
import 'package:go_a_trip/components/header.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      const Header(title: 'Tickets'),
      Container(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.airplane_ticket, size: 100, color: Colors.lime[300]),
              const SizedBox(height: 16),
              const Text(
                'Tickets Screen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
