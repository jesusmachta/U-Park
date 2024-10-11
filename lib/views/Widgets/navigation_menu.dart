import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primera_app/controllers/navigation_controller.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
              height: 80,
              elevation: 10,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: const [
                NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Iconsax.chart_2), label: 'Estadisticas'),
                NavigationDestination(
                    icon: Icon(Iconsax.messages_3), label: 'Comentarios'),
              ])),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}
