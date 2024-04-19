import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rental/app/models/vehicle.dart';
import 'package:rental/app/routes/app_pages.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class EditVehicleController extends GetxController {
  final Vehicle vehicle = Get.arguments;

  var formkey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var plate_numberController = TextEditingController();
  var modelController = TextEditingController();
  var key = GlobalKey<FormState>();

  bool isImageError = false;

  XFile? image;
  Uint8List? imageBytes;

  String? selectedCategoryId;

  @override
  void onInit() {
    super.onInit();
    titleController.text = vehicle.title!;
    descriptionController.text = vehicle.description!;
    priceController.text = vehicle.perDayPrice!;
    plate_numberController.text = vehicle.plateNumber!;
    modelController.text = vehicle.model!;
    selectedCategoryId = vehicle.categoryId;
    

    
  }

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

  void onEditVehicle(String vehicleId) async {
    try {
      if (image == null) {
        isImageError = true;
        update();
      } else {
        isImageError = false;
        update();
      }
      if (key.currentState!.validate() && image != null) {
        var url = Uri.http(ipAddress, 'rental/editVehicle');

        var request = http.MultipartRequest("POST", url);

        request.fields['vehicle_id'] = vehicleId;
        request.fields['title'] = titleController.text;
        request.fields['description'] = descriptionController.text;
        request.fields['per_day_price'] = priceController.text;
        request.fields['plate_number'] = plate_numberController.text;
        request.fields['model'] = modelController.text;
        request.fields['category_id'] = selectedCategoryId!;
        request.fields['token'] = Memory.getToken()!;

        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            imageBytes!,
            filename: image!.name,
          ),
        );

        var streamResponse = await request.send();
        var response = await http.Response.fromStream(streamResponse);

        var result = jsonDecode(response.body);

        if (result['success']) {
          update();
          Get.offNamed(Routes.MY_VEHICLES);
          update();
          

    
          Get.snackbar(
            'Edit Vehicle',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          update();


        } else {
          Get.snackbar(
            'Edit Vehicle',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Edit Vehicle',
        'Failed to edit vehicle',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}