import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/routes/app_pages.dart';
import 'package:rental/utils/constant.dart';

class ForgetPasswordController extends GetxController {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  void onForgotPassword() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        isLoading.value = true;
        var url = Uri.http(ipAddress, 'rental/forgetPassword.php');

        var response =
            await http.post(url, body: {'email': emailController.text});

        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.toNamed(Routes.VERIFY_CODE, arguments: emailController.text);
          Get.snackbar(
            'Forgot Password',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Forgot Password',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send verification code',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
