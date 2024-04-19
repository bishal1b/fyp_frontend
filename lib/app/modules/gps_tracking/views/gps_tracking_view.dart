import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../controllers/gps_tracking_controller.dart';

class GpsTrackingView extends GetView<GpsTrackingController> {
  GpsTrackingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Track Vehicles'),
          centerTitle: true,
        ),
        body: GetBuilder<GpsTrackingController>(
          builder: (controller) => Stack(
            children: [
              FlutterMap(
                mapController: controller.mapController,
                options: const MapOptions(
                  initialCenter: LatLng(28.2096, 83.9856),
                  initialZoom: 13,
                  interactionOptions: InteractionOptions(
                      flags: ~InteractiveFlag.doubleTapDragZoom),
                ),
                children: [
                  _openStreetMapTileLayer,
                  MarkerLayer(
                    markers: controller.markers,
                  )
                ],
              ),
              Positioned(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: controller.zoomOut,
                      icon: const Icon(
                        Icons.zoom_out_map,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                        onPressed: controller.fetchDevices,
                        icon: const Icon(Icons.refresh)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

TileLayer get _openStreetMapTileLayer => TileLayer(
      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );

Future<http.Response> loadTile(int zoom, int x, int y) async {
  const String tileUrl = "https://tile.openstreetmap.org/{z}/{x}/{y}.png";
  late http.Response response;

  try {
    response = await http.get(Uri.parse(tileUrl
        .replaceAll("{z}", "$zoom")
        .replaceAll("{x}", "$x")
        .replaceAll("{y}", "$y")));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw http.ClientException(
          "Failed to load tile. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error loading tile: $e");
    throw http.ClientException("Failed to load tile: $e");
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:http/http.dart' as http;

// import '../controllers/gps_tracking_controller.dart';

// class GpsTrackingView extends GetView<GpsTrackingController> {
//   GpsTrackingView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Track Vehicles'),
//           centerTitle: true,
//         ),
//         body: Stack(
//           children: [
//             FlutterMap(
//               mapController: controller.mapController,
//               options: const MapOptions(
//                 initialCenter: LatLng(28.2096, 83.9856),
//                 initialZoom: 13,
//                 interactionOptions: InteractionOptions(
//                     flags: ~InteractiveFlag.doubleTapDragZoom),
//               ),
//               children: [
//                 _openStreetMapTileLayer,
//                 MarkerLayer(
//                   markers: controller.markers,
//                 )
//               ],
//             ),
//             Positioned(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     onPressed: controller.zoomOut,
//                     icon: const Icon(
//                       Icons.zoom_out_map,
//                       color: Colors.black,
//                     ),
//                   ),
//                   IconButton(
//                       onPressed: controller.fetchDevices,
//                       icon: const Icon(Icons.refresh)),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// TileLayer get _openStreetMapTileLayer => TileLayer(
//       urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//       userAgentPackageName: 'dev.fleaflet.flutter_map.example',
//     );

// Future<http.Response> loadTile(int zoom, int x, int y) async {
//   const String tileUrl = "https://tile.openstreetmap.org/{z}/{x}/{y}.png";
//   late http.Response response;

//   try {
//     response = await http.get(Uri.parse(tileUrl
//         .replaceAll("{z}", "$zoom")
//         .replaceAll("{x}", "$x")
//         .replaceAll("{y}", "$y")));
//     if (response.statusCode == 200) {
//       return response;
//     } else {
//       throw http.ClientException(
//           "Failed to load tile. Status code: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("Error loading tile: $e");
//     throw http.ClientException("Failed to load tile: $e");
//   }
// }
