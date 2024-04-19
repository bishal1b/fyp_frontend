import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/models/bookings.dart';
import 'package:rental/app/modules/vehicle/controllers/vehicle_controller.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class BookingsController extends GetxController {
  BookingsResponse? bookingsResponse;
  var selectedRating = 0.0;

  @override
  void onInit() {
    super.onInit();

    getBookings();
  }

  Future<void> getBookings() async {
    try {
      var url = Uri.http(ipAddress, 'rental/getBookings.php');

      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = bookingsResponseFromJson(response.body);

      if (result.success!) {
        bookingsResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get bookings',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void giveRating(String vehicleId) async {
    try {
      var url = Uri.http(ipAddress, 'rental/giveRating.php');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'vehicle_id': vehicleId,
        'rating': selectedRating.toString()
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.snackbar(
          'Rating',
          result['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.find<VehicleController>().getVehicles();
        update();
      } else {
        Get.snackbar(
          'Error',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to give rating',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void cancelBooking(String bookingId) async {
    try {
      var url = Uri.http(ipAddress, 'rental/cancelBookings.php');

      var response = await http.post(url,
          body: {'token': Memory.getToken(), 'booking_id': bookingId});
      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.snackbar(
          'Cancel Booking',
          result['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        getBookings();
        Get.close(1);
        update();
      } else {
        Get.snackbar(
          'Error',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to cancel booking',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
