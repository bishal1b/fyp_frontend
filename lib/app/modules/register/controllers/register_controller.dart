import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rental/utils/constant.dart';

class RegisterController extends GetxController {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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

  void register() async {
    try {
      if (image == null) {
        isImageError = true;
        update();
        return;
      } else {
        isImageError = false;
        update();
      }

      if (formKey.currentState!.validate() && image != null) {
        var url = Uri.http(ipAddress, 'rental/auth/register.php');

        var request = http.MultipartRequest("POST", url);

        request.fields['full_name'] = nameController.text;
        request.fields['contact'] = phoneController.text;
        request.fields['address'] = addressController.text;
        request.fields['email'] = emailController.text;
        request.fields['password'] = passwordController.text;

        request.files.add(
          http.MultipartFile.fromBytes(
            'liscence_image',
            imageBytes!,
            filename: image!.name,
          ),
        );

        var streamResponse = await request.send();
        var response = await http.Response.fromStream(streamResponse);

        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.back();
          Get.snackbar(
            'Registration',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed('/login');
        } else {
          Get.snackbar(
            'Registration',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        // Handle form validation errors
        Get.snackbar(
          'Validation Error',
          'Please fill in all required fields',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Handle general errors
      Get.snackbar(
        'Error',
        'Failed to register user',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
