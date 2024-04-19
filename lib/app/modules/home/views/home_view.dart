import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/modules/vehicle/controllers/vehicle_controller.dart';
import 'package:rental/app/routes/app_pages.dart';
import 'package:rental/utils/constant.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(VehicleController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2E9E95),
        title: const Text('Sajhilo Bike Rental'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getCategories();
          await controller.getVehicles();
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: GetBuilder<VehicleController>(
            builder: (controller) {
              if (controller.categoriesResponse == null ||
                  controller.vehicleResponseTopRatings == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              print(controller.vehicleResponseTopRatings?.vehicles?.length);

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 40,
                      child: ListView.builder(
                        itemCount:
                            controller.categoriesResponse?.categories?.length ??
                                0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var category =
                              controller.categoriesResponse?.categories?[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.VEHICLE_BY_CATEGORY,
                                  arguments: category);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Color(0xFF2E9E95),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  category?.category ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Top Highest Ratings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemCount: controller
                              .vehicleResponseTopRatings?.vehicles?.length ??
                          0,
                      itemBuilder: (BuildContext context, int index) {
                        var vehicle = controller
                            .vehicleResponseTopRatings?.vehicles?[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.VEHICLE_DETAIL,
                                arguments: vehicle);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: Image.network(
                                      getImageUrl(vehicle?.imageUrl ?? ''),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        vehicle?.title ?? '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF2E9E95),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                vehicle?.category ?? '',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 20,
                                              ),
                                              Text(
                                                '${vehicle?.rating ?? 'N/A'}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        'Rs: ${vehicle?.perDayPrice ?? 'N/A'} per day',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
