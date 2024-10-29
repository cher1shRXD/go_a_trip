import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_a_trip/screens/economies.dart';
import 'package:go_a_trip/screens/profile.dart';
import 'package:go_a_trip/screens/tickets.dart';
import 'package:go_a_trip/screens/home.dart';
import 'package:go_a_trip/screens/airport.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigateController());

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
            left: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
            right: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Obx(
              () => ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                child: NavigationBar(
                  backgroundColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  height: 64,
                  elevation: 0,
                  selectedIndex: controller.selectedIndex.value,
                  onDestinationSelected: (index) =>
                      controller.selectedIndex.value = index,
                  labelBehavior:
                      NavigationDestinationLabelBehavior.onlyShowSelected,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.local_airport_outlined, size: 24),
                      selectedIcon: Icon(Icons.local_airport, size: 28),
                      label: '공항',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.airplane_ticket_outlined, size: 24),
                      selectedIcon: Icon(Icons.airplane_ticket, size: 28),
                      label: '항공권',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined, size: 24),
                      selectedIcon: Icon(Icons.home, size: 28),
                      label: '홈',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.wallet_outlined, size: 24),
                      selectedIcon: Icon(Icons.wallet, size: 28),
                      label: '결제',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline, size: 24),
                      selectedIcon: Icon(Icons.person, size: 28),
                      label: '프로필',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigateController extends GetxController {
  final Rx<int> selectedIndex = 2.obs;

  final screens = [
    const AirportScreen(),
    const TicketsScreen(),
    const HomeScreen(),
    const EconomiesScreen(),
    const ProfileScreen(),
  ];
}
