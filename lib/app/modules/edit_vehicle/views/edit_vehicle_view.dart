import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/components/myButton.dart';
import 'package:rental/app/models/vehicle.dart';
import 'package:rental/app/modules/home/controllers/home_controller.dart';
import 'package:rental/app/modules/vehicle/controllers/vehicle_controller.dart';
import '../controllers/edit_vehicle_controller.dart';

class EditVehicleView extends GetView<EditVehicleController> {
  final Vehicle vehicle = Get.arguments;

  EditVehicleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditVehicleController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit Vehicle'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.key,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Vehicle Image',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  controller.imageBytes != null
                      ? Stack(
                          children: [
                            Image.memory(
                              controller.imageBytes!,
                              height: 200,
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                padding: EdgeInsets.all(0.0),
                                style: IconButton.styleFrom(
                                  padding: EdgeInsets.all(0.0),
                                ),
                                onPressed: controller.onImageDelete,
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2E9E95),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: controller.onImagePick,
                    child: Text('Pick Image',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ),
                  Visibility(
                    visible: controller.isImageError,
                    child: Text(
                      'Please select image',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your vehicle title';
                      }
                      return null;
                    },
                    controller: controller.titleController,
                    decoration: InputDecoration(
                      labelText: 'Vehicle Title',
                      hintText: 'Enter vehicle title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    minLines: 3,
                    maxLines: 5,
                    maxLength: 2500,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your vehicle description';
                      }
                      return null;
                    },
                    controller: controller.descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Vehicle Description',
                      hintText: 'Enter vehicle description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your vehicle per day price';
                      } else if (!value.isNum) {
                        return 'Please enter valid price';
                      }
                      return null;
                    },
                    controller: controller.priceController,
                    decoration: InputDecoration(
                      labelText: 'Per Day Price',
                      hintText: 'Enter per day price',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your vehicle plate number';
                      } else if (!value.isNum) {
                        return 'Please enter your plate number';
                      }
                      return null;
                    },
                    controller: controller.plate_numberController,
                    decoration: InputDecoration(
                      labelText: 'Plate Number',
                      hintText: 'Enter your vehicle plate number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your vehicle model';
                      }
                      return null;
                    },
                    controller: controller.modelController,
                    decoration: InputDecoration(
                      labelText: 'Model',
                      hintText: 'Enter vehicle model',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Select Vehicle Type',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select vehicle type';
                      }
                      return null;
                    },
                    value: controller.selectedCategoryId,
                    items: Get.find<VehicleController>()
                            .categoriesResponse
                            ?.categories
                            ?.map((e) => DropdownMenuItem(
                                  value: e.categoryId,
                                  child: Text(e.category ?? ''),
                                ))
                            .toList() ??
                        [],
                    onChanged: (v) {
                      controller.selectedCategoryId = v;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyButton(
                      text: 'Update Vehicle',
                      onPressed: () {
                        controller.onEditVehicle(vehicle.vehicleId!);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
