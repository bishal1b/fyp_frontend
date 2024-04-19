import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/models/adminUser.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class UserDetailController extends GetxController {
  AdminUserResponse? adminUserResponse;

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void getUser() async {
    try {
      var url = Uri.http(ipAddress, 'rental/getUser');

      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = adminUserResponseFromJson(response.body);

      if (result.success!) {
        adminUserResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get users',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
