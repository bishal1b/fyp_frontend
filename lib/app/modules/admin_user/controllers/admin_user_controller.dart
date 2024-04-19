import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental/app/models/adminUser.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';
import 'package:http/http.dart' as http;

class AdminUserController extends GetxController {
  AdminUserResponse? adminUserResponse;
  var formKey = GlobalKey<FormState>();
  var fullNameController = TextEditingController();
  var contactController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var lisImageController = TextEditingController();
  var selectedRole = 'user'.obs;
  final count = 0.obs;

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

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  void addUser() async {
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
        var url = Uri.http(ipAddress, 'rental/addUser');

        var request = http.MultipartRequest("POST", url);
        request.fields['token'] = Memory.getToken()!;
        request.fields['full_name'] = fullNameController.text;
        request.fields['contact'] = contactController.text;
        request.fields['address'] = addressController.text;
        request.fields['email'] = emailController.text;
        request.fields['password'] = passwordController.text;
        request.fields['role'] = selectedRole.value;

        request.files.add(
          http.MultipartFile.fromBytes(
            'liscence_image',
            imageBytes!,
            filename: image!.name,
          ),
        );

        var streamResponse = await request.send();
        var response = await http.Response.fromStream(streamResponse);
        print(response.body);
        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.back();
          Get.snackbar(
            'User Added',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          getUsers();
        } else {
          Get.snackbar(
            'Error',
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
      print(e);
      // Handle general errors
      Get.snackbar(
        'Error',
        'Failed to add user',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getUsers() async {
    try {
      var url = Uri.http(ipAddress, 'rental/getUser');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
      });
      var result = adminUserResponseFromJson(response.body);

      if (result.success!) {
        adminUserResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get users',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
