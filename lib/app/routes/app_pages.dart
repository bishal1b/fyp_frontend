import 'package:get/get.dart';

import '../modules/Add_Vehicle/bindings/add_vehicle_binding.dart';
import '../modules/Add_Vehicle/views/add_vehicle_view.dart';
import '../modules/admin_category/bindings/admin_category_binding.dart';
import '../modules/admin_category/views/admin_category_view.dart';
import '../modules/admin_home/bindings/admin_home_binding.dart';
import '../modules/admin_home/views/admin_home_view.dart';
import '../modules/admin_main/bindings/admin_main_binding.dart';
import '../modules/admin_main/views/admin_main_view.dart';
import '../modules/admin_user/bindings/admin_user_binding.dart';
import '../modules/admin_user/views/admin_user_view.dart';
import '../modules/booking_detail/bindings/booking_detail_binding.dart';
import '../modules/booking_detail/views/booking_detail_view.dart';
import '../modules/bookings/bindings/bookings_binding.dart';
import '../modules/bookings/views/bookings_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/editProfile/bindings/edit_profile_binding.dart';
import '../modules/editProfile/views/edit_profile_view.dart';
import '../modules/edit_vehicle/bindings/edit_vehicle_binding.dart';
import '../modules/edit_vehicle/views/edit_vehicle_view.dart';
import '../modules/forget_password/bindings/forget_password_binding.dart';
import '../modules/forget_password/views/forget_password_view.dart';
import '../modules/gps_tracking/bindings/gps_tracking_binding.dart';
import '../modules/gps_tracking/views/gps_tracking_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/my_vehicles/bindings/my_vehicles_binding.dart';
import '../modules/my_vehicles/views/my_vehicles_view.dart';
import '../modules/payment_detail/bindings/payment_detail_binding.dart';
import '../modules/payment_detail/views/payment_detail_view.dart';
import '../modules/payments/bindings/payments_binding.dart';
import '../modules/payments/views/payments_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/user_detail/bindings/user_detail_binding.dart';
import '../modules/user_detail/views/user_detail_view.dart';
import '../modules/vehicle/bindings/vehicle_binding.dart';
import '../modules/vehicle/views/vehicle_view.dart';
import '../modules/vehicleByCategory/bindings/vehicle_by_category_binding.dart';
import '../modules/vehicleByCategory/views/vehicle_by_category_view.dart';
import '../modules/vehicle_detail/bindings/vehicle_detail_binding.dart';
import '../modules/vehicle_detail/views/vehicle_detail_view.dart';
import '../modules/verify_code/bindings/verify_code_binding.dart';
import '../modules/verify_code/views/verify_code_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => const AdminHomeView(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_MAIN,
      page: () => const AdminMainView(),
      binding: AdminMainBinding(),
    ),
    GetPage(
      name: _Paths.BOOKINGS,
      page: () => const BookingsView(),
      binding: BookingsBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENTS,
      page: () => const PaymentsView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CATEGORY,
      page: () => const AdminCategoryView(),
      binding: AdminCategoryBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_USER,
      page: () => const AdminUserView(),
      binding: AdminUserBinding(),
    ),
    GetPage(
      name: _Paths.ADD_VEHICLE,
      page: () => const AddVehicleView(),
      binding: AddVehicleBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE_DETAIL,
      page: () => VehicleDetailView(),
      binding: VehicleDetailBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE,
      page: () => const VehicleView(),
      binding: VehicleBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE_BY_CATEGORY,
      page: () => VehicleByCategoryView(),
      binding: VehicleByCategoryBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
      children: [],
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_CODE,
      page: () => VerifyCodeView(),
      binding: VerifyCodeBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.MY_VEHICLES,
      page: () => MyVehiclesView(),
      binding: MyVehiclesBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_DETAIL,
      page: () => BookingDetailView(),
      binding: BookingDetailBinding(),
    ),
    GetPage(
      name: _Paths.USER_DETAIL,
      page: () => UserDetailView(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_DETAIL,
      page: () => PaymentDetailView(),
      binding: PaymentDetailBinding(),
    ),
    GetPage(
      name: _Paths.GPS_TRACKING,
      page: () => GpsTrackingView(),
      binding: GpsTrackingBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_VEHICLE,
      page: () => EditVehicleView(),
      binding: EditVehicleBinding(),
    ),
  ];
}
