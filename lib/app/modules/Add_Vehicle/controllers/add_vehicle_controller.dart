import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class AddVehicleController extends GetxController {
  var titleController = TextEditingController();
  var plateNumberController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var modelController = TextEditingController();
  var key = GlobalKey<FormState>();

  bool isImageError = false;

  XFile? image;
  Uint8List? imageBytes;

  String? selectedCategoryId;

  void onImageDelete() {
    image = null;
    imageBytes = null;
    update();
  }

  void onImagePick() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageBytes = await image!.readAsBytes();
      update();
    }
  }

  void onAddVehicle() async {
    try {
      if (image == null) {
        isImageError = true;
        update();
      } else {
        isImageError = false;
        update();
      }
      if (key.currentState!.validate() && image != null) {
        var url = Uri.http(ipAddress, 'rental/addVehicle.php');

        var request = http.MultipartRequest("POST", url);

        request.fields['title'] = titleController.text;
        request.fields['plate_number'] = plateNumberController.text;
        request.fields['description'] = descriptionController.text;
        request.fields['per_day_price'] = priceController.text;
        request.fields['model'] = modelController.text;
        request.fields['category_id'] = selectedCategoryId!;
        request.fields['token'] = Memory.getToken()!;

        request.files.add(
          http.MultipartFile.fromBytes('image', imageBytes!,
              filename: image!.name),
        );

        var streamResponse = await request.send();
        var response = await http.Response.fromStream(streamResponse);

        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.back();
          Get.snackbar(
            'Add Vehicle',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Add Vehicle',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Add Vehicle',
        'Failed to add vehicle',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
