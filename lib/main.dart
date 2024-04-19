import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:rental/utils/memory.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Memory.init();
  var token = Memory.getToken();
  var role = Memory.getRole();

  runApp(
    KhaltiScope(
      publicKey: "test_public_key_31df2a99c7ea4c0bbd908f079a292dd3",
      builder: (context, navigator) => GetMaterialApp(
        navigatorKey: navigator,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ne', 'NP'),
        ],
        localizationsDelegates: const [
          KhaltiLocalizations.delegate,
          MonthYearPickerLocalizations.delegate
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 234, 240, 235),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF2E9E95),
          ),
          useMaterial3: false,
        ),
        defaultTransition: Transition.cupertino,
        title: "Application",
        initialRoute: token == null
            ? Routes.LOGIN
            : role == 'admin'
                ? Routes.ADMIN_MAIN
                : Routes.MAIN,
        getPages: AppPages.routes,
      ),
    ),
  );
}
