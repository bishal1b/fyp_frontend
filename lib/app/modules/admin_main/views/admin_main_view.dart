import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_main_controller.dart';

class AdminMainView extends GetView<AdminMainController> {
  const AdminMainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.screens[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: TextStyle(color: Colors.black),
            unselectedLabelStyle: TextStyle(color: Colors.black),
            showUnselectedLabels: true,
            selectedItemColor: Color(0xFF2E9E95),
            unselectedItemColor: Colors.blueGrey,
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.currentIndex.value = index;
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  label: 'Bookings'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bike_scooter,
                  ),
                  label: 'My Vehicles'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_box,
                  ),
                  label: 'Profile'),
            ]),
      ),
    );
  }
}
