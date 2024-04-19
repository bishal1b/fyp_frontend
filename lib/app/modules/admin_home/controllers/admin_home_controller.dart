import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/models/stats.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

import 'package:http/http.dart' as http;

class AdminHomeController extends GetxController {
  StatsResponse? statsResponse;
  var selectedDate = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getStats();
  }

  Future<void> getStats({DateTime? date}) async {
    try {
      var url = Uri.http(ipAddress, 'rental/getStats');
      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'month': date != null ? date.month.toString() : 'null',
        'year': date != null ? date.year.toString() : 'null',
      });
      print(response.body);
      print(response.body);
      var result = statsResponseFromJson(response.body);

      if (result.success!) {
        statsResponse = result;
        update();
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to get stats',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
