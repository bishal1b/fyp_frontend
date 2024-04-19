import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rental/app/components/vehicleCard.dart';
import 'package:rental/app/modules/vehicle/controllers/vehicle_controller.dart';
import 'package:rental/app/routes/app_pages.dart';

import '../controllers/my_vehicles_controller.dart';

class MyVehiclesView extends GetView<MyVehiclesController> {
  const MyVehiclesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(VehicleController());
    return Scaffold(
      appBar: AppBar(
        title: Text('My Vehicles'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getVehicles();
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: GetBuilder<VehicleController>(
            builder: (controller) {
              if (controller.vehicleResponse == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                shrinkWrap: true, // Add this line
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.vehicleResponse?.vehicles?.length ?? 0,
                itemBuilder: (context, index) => VehicleCard(
                  vehicle: controller.vehicleResponse!.vehicles![index],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2E9E95),
        onPressed: () {
          Get.toNamed(Routes.ADD_VEHICLE);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
