import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_a_trip/screens/search.dart';
import 'package:go_a_trip/screens/profile.dart';
import 'package:go_a_trip/screens/write.dart';
import 'package:go_a_trip/screens/home.dart';
import 'package:go_a_trip/screens/all_board.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigateController());

    return Scaffold(
      bottomNavigationBar: Padding(
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
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.list_alt_outlined, size: 24),
                    selectedIcon: Icon(Icons.list_alt, size: 28),
                    label: '전체 글',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.add_box_outlined, size: 24),
                    selectedIcon: Icon(Icons.add_box, size: 28),
                    label: '글 쓰기',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined, size: 24),
                    selectedIcon: Icon(Icons.home, size: 28),
                    label: '홈',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.search_outlined, size: 24),
                    selectedIcon: Icon(Icons.search, size: 28),
                    label: '검색',
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
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigateController extends GetxController {
  final Rx<int> selectedIndex = 2.obs;

  final screens = [
    const AllBoardScreen(),
    const WriteScreen(),
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];
}
