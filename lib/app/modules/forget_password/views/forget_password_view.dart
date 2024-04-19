import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rental/app/components/mybutton.dart';

import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 234, 240, 235),
        appBar: AppBar(
          title: Text('Forgot Password'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      'Enter your email and we will send you a verification code',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                        return 'Please enter your email';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Obx(
                    () => MyButton(
                      isLoading: controller.isLoading.value,
                      text: 'Send',
                      onPressed: controller.onForgotPassword,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
