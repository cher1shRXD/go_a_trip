import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_a_trip/components/header.dart';
import 'package:go_a_trip/components/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NavigateController controller = Get.find<NavigateController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Header(title: 'Go a Trip'),
            GestureDetector(
              onTap: () => {controller.selectedIndex.value = 3},
              child: Container(
                width: double.infinity,
                height: 40,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: Colors.grey[200]!,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '무엇이 궁금하신가요?',
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey[500],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
