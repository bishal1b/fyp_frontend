import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/routes/app_pages.dart';
import 'package:rental/utils/constant.dart';

class VerifyCodeController extends GetxController {
  var otpController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void onVerifyCode() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        var url = Uri.http(ipAddress, 'rental/resetPassword');

        var response = await http.post(url, body: {
          'code': otpController.text,
          'new_password': newPasswordController.text,
          'email': Get.arguments,
        });

        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.offAllNamed(Routes.LOGIN);
          Get.snackbar(
            'Reset Password',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Reset Password',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to reset password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
