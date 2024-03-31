import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rental/app/components/vehicleCard.dart';
import 'package:rental/app/models/vehicle.dart';

import '../controllers/vehicle_controller.dart';

class VehicleView extends GetView<VehicleController> {
  const VehicleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(VehicleController());

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 240, 235),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E9E95),
        title: Text('Search Vehicle'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchView(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
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
          child: GetBuilder<VehicleController>(builder: (controller) {
            if (controller.categoriesResponse == null ||
                controller.vehicleResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: Get.height * 0.9,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Recommended Vehicles',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          controller.vehicleResponse?.vehicles?.length ?? 0,
                      itemBuilder: (context, index) {
                        return VehicleCard(
                          vehicle: controller.vehicleResponse!.vehicles![index],
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var allVehicles = Get.find<VehicleController>().vehicleResponse?.vehicles;
    List<Vehicle> filteredVehicles = [];

    var formattedQuery = query.toLowerCase().trim();

    filteredVehicles = formattedQuery.isEmpty
        ? []
        : allVehicles
                ?.where((element) =>
                    (element.title?.toLowerCase().contains(formattedQuery) ??
                        false) ||
                    (element.description
                            ?.toLowerCase()
                            .contains(formattedQuery) ??
                        false) ||
                    (element.perDayPrice
                            ?.toLowerCase()
                            .contains(formattedQuery) ??
                        false) ||
                    (element.category?.toLowerCase().contains(formattedQuery) ??
                        false))
                .toList() ??
            [];

    if (formattedQuery.isEmpty) {
      return Center(
        child: Text(
          'Start typing to search !',
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    if (filteredVehicles.isEmpty) {
      return Center(
        child: Text(
          'No results found for "$formattedQuery"',
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredVehicles.length,
      itemBuilder: (context, index) {
        return VehicleCard(
          vehicle: filteredVehicles[index],
        );
      },
    );
  }
}
