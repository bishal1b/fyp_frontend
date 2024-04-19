import 'package:get/get.dart';
import 'package:rental/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  void initState() {
    splashToLogin();
  }

  splashToLogin() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed(Routes.LOGIN);
    });
  }
}
