import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/models/vehicle.dart';
import 'package:rental/app/routes/app_pages.dart';
import 'package:rental/utils/constant.dart';
import 'package:rental/utils/memory.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.VEHICLE_DETAIL, arguments: vehicle);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
            )
          ],
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image on the left
            Hero(
              tag: vehicle.vehicleId ?? '',
              child: Image.network(
                getImageUrl(
                  vehicle.imageUrl ?? '',
                ),
                height: 100,
                width: Get.width * 0.4,
                fit: BoxFit.fill, // Adjust the fit property
              ),
            ),

            const SizedBox(
              width: 10,
            ),
            // Details on the right
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle.title ?? '',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF2E9E95),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          vehicle.category ?? '',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                      Text(
                        vehicle.rating ?? '',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Model:  ${vehicle.model ?? ''}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Rs. ${vehicle.perDayPrice ?? ''} per day",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: Memory.getRole() == 'admin',
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.EDIT_VEHICLE,
                                arguments: vehicle);
                          },
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF2E9E95),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed(Routes.EDIT_VEHICLE,
                                    arguments: vehicle);
                              },
                              child: Text('Edit',
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
