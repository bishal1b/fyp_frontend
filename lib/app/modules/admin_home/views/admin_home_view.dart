import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rental/app/modules/vehicle/controllers/vehicle_controller.dart';
import 'package:rental/app/routes/app_pages.dart';
import 'package:rental/utils/memory.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(VehicleController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminHomeView'),
        centerTitle: true,
      ),
      body: Center(
          child: TextButton(
              onPressed: () {
                Memory.clear();
                Get.offAllNamed(Routes.LOGIN);
              },
              child: Text("Logout"))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2E9E95),
        onPressed: () {
          Get.toNamed(Routes.ADD_VEHICLE);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
