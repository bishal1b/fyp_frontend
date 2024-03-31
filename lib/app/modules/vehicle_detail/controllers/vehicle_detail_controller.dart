import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khalti_flutter/khalti_flutter.dart';
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
        makePayment(result['booking_id'], result['total']);
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

  void makePayment(int bookingId, int total) async {
    try {
      var config = PaymentConfig(
          amount: total,
          productIdentity: bookingId.toString(),
          productName: 'Booking: $bookingId');

      await KhaltiScope.of(Get.context!).pay(
          config: config,
          preferences: [
            PaymentPreference.khalti,
          ],
          onSuccess: (v) async {
            var url = Uri.http(ipAddress, 'rental/savePayment.php');

            var response = await http.post(url, body: {
              'booking_id': bookingId.toString(),
              'token': Memory.getToken(),
              'amount': total.toString(),
              'other_details': v.toString(),
            });

            var result = jsonDecode(response.body);
            if (result['success']) {
              Get.snackbar(
                'Success',
                result['message'],
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            } else {
              Get.snackbar(
                'Failed',
                result['message'],
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
          onFailure: (v) {
            Get.snackbar(
              'Failed',
              'Payment failed',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          },
          onCancel: () {
            Get.snackbar(
              'Cancelled',
              'Payment cancelled',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to make payment',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
