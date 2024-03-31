import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/models/user.dart';
import 'package:rental/app/modules/profile/controllers/profile_controller.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class EditProfileController extends GetxController {
  final User user = Get.arguments;
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var contactController = TextEditingController();
  var addressController = TextEditingController();

  String? imageUrl;

  XFile? imageFile;
  Uint8List? imageBytes;

  @override
  void onInit() {
    super.onInit();
    nameController.text = user.fullName ?? '';
    emailController.text = user.email ?? '';
    addressController.text = user.address ?? '';
    contactController.text = user.contact ?? '';
    imageUrl = user.imageUrl;
  }

  void onImagePick() async {
    final ImagePicker picker = ImagePicker();
    imageFile = await picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      imageBytes = await imageFile!.readAsBytes();
      update();
    }
  }

  void onUpdateProfile() async {
    try {
      if (formKey.currentState!.validate()) {
        var url = Uri.http(ipAddress, 'rental/updateProfile.php');

        var request = http.MultipartRequest("POST", url);

        request.fields['full_name'] = nameController.text;
        request.fields['contact'] = contactController.text;
        request.fields['address'] = addressController.text;

        request.fields['token'] = Memory.getToken()!;

        if (imageBytes != null) {
          request.files.add(
            http.MultipartFile.fromBytes('image', imageBytes!,
                filename: imageFile!.name),
          );
        }

        var streamResponse = await request.send();
        var response = await http.Response.fromStream(streamResponse);

        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.back();
          Get.find<ProfileController>().getMyProfile();
          Get.snackbar(
            'Update Profile',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Update Profile',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Update Profile',
        'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
