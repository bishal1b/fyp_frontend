import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/routes/app_pages.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class ChangePasswordController extends GetxController {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void onChangePassword() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        var url = Uri.http(ipAddress, 'rental/changePassword');

        var response = await http.post(url, body: {
          'old_password': oldPasswordController.text,
          'new_password': newPasswordController.text,
          'token': Memory.getToken(),
        });

        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.offNamed(Routes.PROFILE);
          Get.snackbar(
            'Change Password',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Change Password',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to change password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
