import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/modules/vehicle/controllers/vehicle_controller.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class AdminCategoryController extends GetxController {
  var categoryTitle = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void addCategory() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        var url = Uri.http(ipAddress, 'rental/addCategory.php');

        var response = await http.post(url, body: {
          'token': Memory.getToken(),
          'category': categoryTitle.text,
        });

        print(response.body);
        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.find<VehicleController>().getCategories();
          Get.back();
          categoryTitle.clear();
          Get.snackbar(
            'Add Category',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Add Category',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to add category',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void updateCategoryStatus(String categoryId, bool toDelete) async {
    try {
      var url = Uri.http(ipAddress, 'rental/updateCategoryStatus.php');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'category_id': categoryId,
        'is_delete': toDelete ? '1' : '0',
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.find<VehicleController>().getCategories();
        Get.back();
        categoryTitle.clear();
        Get.snackbar(
          'Update Category',
          result['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Update Category',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to add category',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
