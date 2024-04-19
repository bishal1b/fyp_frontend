import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:rental/app/data/tile_loader.dart';

class GpsTrackingController extends GetxController {
  final MapController mapController = MapController();
  final RentalDevicesRemoteSource rentalDevicesRemoteSource =
      RentalDevicesRemoteSource();
  final List<Marker> markers = <Marker>[].obs;
  late Timer timer;

  @override
  void onInit() {
    fetchDevices();
    startAutoUpdate();
    super.onInit();
  }

  void startAutoUpdate() {
    const Duration updateInterval = Duration(seconds: 40);
    timer = Timer.periodic(updateInterval, (Timer t) {
      fetchDevices();
      update();
    });
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  void fetchDevices() {
    rentalDevicesRemoteSource.getDevices().then(
      (deviceModel) {
        if (deviceModel != null && deviceModel.isNotEmpty) {
          markers.assignAll(
            deviceModel.map(
              (location) {
                // Determine marker color based on vehicle activity
                Color markerColor =
                    location.active == 'true' ? Colors.green : Colors.red;

                return Marker(
                  width: 100,
                  height: 60,
                  point: LatLng(
                    double.parse(location.lat),
                    double.parse(location.lng),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: Get.context!,
                        builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Vehicle Info',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Table(
                                children: [
                                  TableRow(children: [
                                    const TableCell(child: Text('Name')),
                                    TableCell(child: Text(location.name)),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(child: Text('Active')),
                                    TableCell(child: Text(location.active)),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(child: Text('Altitude')),
                                    TableCell(child: Text(location.altitude)),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(child: Text('Longitude')),
                                    TableCell(child: Text(location.lng)),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(child: Text('Latitude')),
                                    TableCell(child: Text(location.lat)),
                                  ]),
                                ],
                              )
                            ],
                          ),
                          actions: [
                            SizedBox(
                              height: 48,
                              width: double.maxFinite,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.black,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)))),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Close')),
                            )
                          ],
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Text(location.name)),
                        Container(
                          decoration: BoxDecoration(
                            color: markerColor,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              Icons.directions_bike,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          );
        } else {
          print('Values not available');
        }
      },
    );
  }

  void zoomOut() {
    double currentZoom = mapController.camera.zoom;
    mapController.move(mapController.camera.center, currentZoom - 1);
  }
}
