import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/components/mybutton.dart';
import 'package:rental/app/models/vehicle.dart';
import 'package:rental/utils/constant.dart';

import '../controllers/vehicle_detail_controller.dart';

class VehicleDetailView extends GetView<VehicleDetailController> {
  final Vehicle vehicle = Get.arguments;

  VehicleDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF2E9E95),
        title: Text(
          vehicle.title ?? '',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                getImageUrl(vehicle.imageUrl ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        vehicle.title ?? '',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          Text(
                            '${vehicle.rating ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E9E95),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.motorcycle, color: Colors.white, size: 20),
                        SizedBox(width: 4),
                        Text(
                          vehicle.category ?? '',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12),
                  Row(
                    children: [
                      SizedBox(width: 4),
                      Text(
                        'Per day price (in Rs): ${vehicle.perDayPrice ?? ''}',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF2E9E95)),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(width: 4),
                      Text(
                        'Model: ${vehicle.noOfSeats ?? ''}',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF2E9E95)),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    vehicle.description ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  // Rating Widget
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: MyButton(
          text: 'Book Now',
          onPressed: () async {
            controller.dateTimeRange = await showDateRangePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 30)),
            );
            controller.makeBooking(vehicle.vehicleId ?? '');
          },
        ),
      ),
    );
  }
}
