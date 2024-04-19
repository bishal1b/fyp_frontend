import 'package:get/get.dart';

import '../controllers/gps_tracking_controller.dart';

class GpsTrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GpsTrackingController>(
      () => GpsTrackingController(),
    );
  }
}
