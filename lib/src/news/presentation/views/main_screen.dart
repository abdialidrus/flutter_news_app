import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/presentation/views/headlines/headlines_screen.dart';
import 'package:flutter_news_app/src/news/presentation/views/home_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 70,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            setState(() {
              controller.selectedIndex.value = index;
            });
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Iconsax.global), label: 'Headlines'),
            NavigationDestination(icon: Icon(Iconsax.bookmark), label: 'Saved'),
          ],
        ),
      ),
      body: controller.screens[controller.selectedIndex.value],
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HeadlinesScreen(),
    Container(color: Colors.orange),
  ];
}
