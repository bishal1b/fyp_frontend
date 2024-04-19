import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/modules/login/controllers/login_controller.dart';
import 'package:rental/app/routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 240, 235),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset('assets/images/logo.png'),
                Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: "Email",
                      labelText: "Email",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field Required";
                      } else if (!GetUtils.isEmail(value)) {
                        return "please enter valid email";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 10,
                ),
                PasswordTextField(
                  controller: controller.passwordController,
                  label: 'New Password',
                  hint: 'Enter your new password',
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.FORGET_PASSWORD);
                      },
                      child: Text("Forgot password?",
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF2E9E95))),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E9E95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  ),
                  onPressed: controller.login,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.offAllNamed(Routes.REGISTER);
                        },
                        child: Text(
                          "Sign up",
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFF2E9E95)),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
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
          return "Field Required";
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
