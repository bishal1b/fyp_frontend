import 'package:get/get.dart';

import '../controllers/vehicle_by_category_controller.dart';

class VehicleByCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleByCategoryController>(
      () => VehicleByCategoryController(),
    );
  }
}
