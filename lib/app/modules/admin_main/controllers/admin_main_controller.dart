import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/modules/admin_category/views/admin_category_view.dart';
import 'package:rental/app/modules/admin_home/views/admin_home_view.dart';
import 'package:rental/app/modules/admin_user/views/admin_user_view.dart';
import 'package:rental/app/modules/bookings/views/bookings_view.dart';
import 'package:rental/app/modules/profile/views/profile_view.dart';

class AdminMainController extends GetxController {
  var currentIndex = 0.obs;
  List<Widget> screens = [
    AdminHomeView(),
    AdminCategoryView(),
    BookingsView(),
    AdminUserView(),
    ProfileView()
  ];
}
