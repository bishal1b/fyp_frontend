import 'package:get/get.dart';

import '../controllers/my_vehicles_controller.dart';

class MyVehiclesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyVehiclesController>(
      () => MyVehiclesController(),
    );
  }
}
