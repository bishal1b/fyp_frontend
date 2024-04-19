import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rental/app/components/mybutton.dart';

import '../controllers/verify_code_controller.dart';

class VerifyCodeView extends GetView<VerifyCodeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Verify Code'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      'Enter enter otp code and new password!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset(
                    "assets/images/forgetPassword.png",
                    height: 200,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your otp';
                      } else if (value.length != 6) {
                        return 'Please enter a valid 6 digit otp';
                      }
                      return null;
                    },
                    controller: controller.otpController,
                    decoration: InputDecoration(
                      labelText: 'OTP',
                      hintText: 'Enter your otp code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters long";
                      } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}|:"<>?/\\~-]).{6,}$')
                          .hasMatch(value)) {
                        return "Password must contain at least one A-Z, a-z, 0-9 and special character";
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: controller.newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      hintText: 'Enter your new password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field Required";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters long";
                      } else if (controller.confirmPasswordController.text !=
                          controller.confirmPasswordController.text) {
                        return "Password Doesn't match";
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: controller.confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Enter your confirm password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyButton(
                      text: 'Change Password',
                      onPressed: controller.onVerifyCode),
                ],
              ),
            ),
          ),
        ));
  }
}
