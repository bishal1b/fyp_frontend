import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/modules/vehicle/controllers/vehicle_controller.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class VehicleDetailController extends GetxController {
  DateTimeRange? dateTimeRange;

  void makeBooking(String vehicleId) async {
    try {
      if (dateTimeRange == null) {
        Get.snackbar(
          'Error',
          'Please select a date and time',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      var url = Uri.http(ipAddress, 'rental/makeBooking.php');

      var response = await http.post(url, body: {
        'vehicle_id': vehicleId,
        'token': Memory.getToken(),
        'start_date': dateTimeRange!.start.toIso8601String(),
        'end_date': dateTimeRange!.end.toIso8601String(),
      });

      print(response.body);

      var result = jsonDecode(response.body);
      print(result);
      if (result['success']) {
        Get.find<VehicleController>()
            .makePayment(result['booking_id'], result['total']);
      } else {
        Get.snackbar(
          'Booking',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to make booking',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
