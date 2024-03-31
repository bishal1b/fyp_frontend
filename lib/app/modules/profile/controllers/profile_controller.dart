import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/models/user.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class ProfileController extends GetxController {
  UserResponse? userResponse;

  @override
  void onInit() {
    super.onInit();
    getMyProfile();
  }

  Future<void> getMyProfile() async {
    try {
      var url = Uri.http(ipAddress, 'rental/getMyProfile.php');

      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = userResponseFromJson(response.body);

      if (result.success!) {
        userResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get profile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
