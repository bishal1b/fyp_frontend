import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:rental/app/models/category.dart';
import 'package:rental/app/models/vehicle.dart';
import 'package:rental/utils/constant.dart';

import 'package:http/http.dart' as http;
import 'package:rental/utils/memory.dart';

class VehicleController extends GetxController {
  CategoriesResponse? categoriesResponse;
  VehicleResponse? vehicleResponse;
  VehicleResponse? vehicleResponseTopRatings;

  var selectedFilter = "All";

  int count = 0;

  void increment() {
    count++;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getCategories();
    getVehicles();
    getTopRatings();
  }

  Future<void> getTopRatings() async {
    try {
      var url = Uri.http(ipAddress, 'rental/topRatings');

      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = vehicleResponseFromJson(response.body);

      if (result.success!) {
        vehicleResponseTopRatings = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get top ratings',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getCategories() async {
    try {
      var url = Uri.http(ipAddress, 'rental/getCategory.php');

      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = categoriesResponseFromJson(response.body);

      if (result.success!) {
        categoriesResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get categories',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getVehicles() async {
    try {
      var url = Uri.http(ipAddress, 'rental/getVehicles.php');

      var response = await http.post(
        url,
        body: {
          'token': Memory.getToken(),
          'priceLowToHigh':
              selectedFilter == "priceLowToHigh" ? 'true' : 'false',
          'priceHighToLow':
              selectedFilter == "priceHighToLow" ? 'true' : 'false',
          'ratingHighToLow':
              selectedFilter == "ratingHighToLow" ? 'true' : 'false',
        },
      );
      var result = vehicleResponseFromJson(response.body);

      if (result.success!) {
        vehicleResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get vehicles',
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
