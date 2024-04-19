import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override


  
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 234, 240, 235),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome User!",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Image.asset("assets/images/logo.png"),
                  SizedBox(
                    height: 5,
                  ),
                  CircularProgressIndicator.adaptive()
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
