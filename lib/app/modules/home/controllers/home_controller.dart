import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/models/category.dart';
import 'package:rental/app/models/vehicle.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class HomeController extends GetxController {
  CategoriesResponse? categoriesResponse;
  VehicleResponse? vehicleResponse;

  VehicleResponse? vehicleResponseTopRatings;

  int count = 0;

  void increment() {
    count++;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getCategories();
    getVehicles();
    // getTopRatings();
  }

  Future<void> getCategories() async {
    try {
      var url = Uri.http(ipAddress, 'rental/getCategory.php');

      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = categoriesResponseFromJson(response.body);

      if (result.success!) {
        categoriesResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get categories',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getVehicles() async {
    try {
      var url = Uri.http(ipAddress, 'rental/getVehicles.php');

      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = vehicleResponseFromJson(response.body);

      if (result.success!) {
        vehicleResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get categories',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
