import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rental/app/components/mybutton.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
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
                      'Enter old password and new password!',
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
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your old password';
                      }
                      return null;
                    },
                    controller: controller.oldPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Old Password',
                      hintText: 'Enter your old password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PasswordTextField(
                    controller: controller.newPasswordController,
                    label: 'New Password',
                    hint: 'Enter your new password',
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
                      onPressed: controller.onChangePassword),
                ],
              ),
            ),
          ),
        ));
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;

  const PasswordTextField({super.key, this.controller, this.label, this.hint});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      obscureText: !isVisible,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          child: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
        ),
        labelText: widget.label ?? 'Password',
        hintText: widget.hint ?? 'Enter your password',
        border: OutlineInputBorder(),
      ),
    );
  }
}
