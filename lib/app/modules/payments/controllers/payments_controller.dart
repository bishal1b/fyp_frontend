import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/models/payments.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class PaymentsController extends GetxController {
  PaymentResponse? paymentsResponse;

  @override
  void onInit() {
    super.onInit();
    getPayments();
  }

  Future<void> getPayments() async {
    try {
      var url = Uri.http(ipAddress, 'rental/getPayment.php');

      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = paymentResponseFromJson(response.body);

      if (result.success!) {
        paymentsResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get payments',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
