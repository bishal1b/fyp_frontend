import 'package:get/get.dart';

import '../controllers/edit_vehicle_controller.dart';

class EditVehicleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditVehicleController>(
      () => EditVehicleController(),
    );
  }
}
