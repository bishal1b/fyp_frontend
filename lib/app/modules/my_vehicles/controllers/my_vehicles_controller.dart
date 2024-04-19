import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/models/vehicle.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class MyVehiclesController extends GetxController {
  VehicleResponse? vehicleResponse;

  @override
  void onInit() {
    super.onInit();
    getVehicles();
  }

  Future<void> getVehicles() async {
    try {
      var url = Uri.http(ipAddress, 'rental/getMyVehicle');

      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = vehicleResponseFromJson(response.body);

      if (result.success!) {
        vehicleResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get vehicles',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
