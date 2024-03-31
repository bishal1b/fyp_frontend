import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:rental/app/routes/app_pages.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class LoginController extends GetxController {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void login() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        var url = Uri.http(ipAddress, 'rental/auth/login.php');
        var response = await http.post(url, body: {
          'email': emailController.text,
          'password': passwordController.text,
        });
        var result = jsonDecode(response.body);

        if (result['success']) {
          Memory.saveToken(result['token']);
          Memory.saveRole(result['role']);

          if (result['role'] == 'admin') {
            Get.offNamed(Routes.ADMIN_MAIN);
          } else {
            Get.offAllNamed(Routes.MAIN);
          }
          Get.snackbar('Login', result['message'],
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar(
            "Login",
            'Login unsuccessful',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to login',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
