import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/modules/bookings/views/bookings_view.dart';
import 'package:rental/app/modules/home/views/home_view.dart';
import 'package:rental/app/modules/profile/views/profile_view.dart';
import 'package:rental/app/modules/vehicle/views/vehicle_view.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  List<Widget> screens = [
    HomeView(),
    VehicleView(),
    BookingsView(),
    ProfileView()
  ];
}
