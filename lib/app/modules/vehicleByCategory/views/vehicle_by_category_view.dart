import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rental/app/components/vehicleCard.dart';
import 'package:rental/app/models/category.dart';
import 'package:rental/app/models/vehicle.dart';
import 'package:rental/app/modules/vehicle/controllers/vehicle_controller.dart';

import '../controllers/vehicle_by_category_controller.dart';

class VehicleByCategoryView extends GetView<VehicleByCategoryController> {
  @override
  Widget build(BuildContext context) {
    Category category = Get.arguments;
    List<Vehicle> vehicles = [];
    vehicles = Get.find<VehicleController>()
            .vehicleResponse
            ?.vehicles
            ?.where((element) => element.categoryId == category.categoryId)
            .toList() ??
        [];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 240, 235),
      appBar: AppBar(
        title: Text(category.category ?? ""),
        centerTitle: true,
      ),
      body: vehicles.isEmpty
          ? Center(
              child: Text(
              "No Vehicles found for ${category.category}!",
              style: TextStyle(fontSize: 20),
            ))
          : ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                return VehicleCard(vehicle: vehicles[index]);
              },
            ),
    );
  }
}
