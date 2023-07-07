import 'package:get/get.dart';

import '../modules/auth_check_phone_number/bindings/auth_check_phone_number_binding.dart';
import '../modules/auth_check_phone_number/views/auth_check_phone_number_view.dart';
import '../modules/auth_create_password/bindings/auth_create_password_binding.dart';
import '../modules/auth_create_password/views/auth_create_password_view.dart';
import '../modules/auth_login/bindings/auth_login_binding.dart';
import '../modules/auth_login/views/auth_login_view.dart';
import '../modules/auth_otp/bindings/auth_otp_binding.dart';
import '../modules/auth_otp/views/auth_otp_view.dart';
import '../modules/auth_register/bindings/auth_register_binding.dart';
import '../modules/auth_register/views/auth_register_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/main_menu/bindings/main_menu_binding.dart';
import '../modules/main_menu/views/main_menu_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_MENU,
      page: () => const MainMenuView(),
      binding: MainMenuBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_LOGIN,
      page: () => const AuthLoginView(),
      binding: AuthLoginBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_CREATE_PASSWORD,
      page: () => const AuthCreatePasswordView(),
      binding: AuthCreatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_REGISTER,
      page: () => const AuthRegisterView(),
      binding: AuthRegisterBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_CHECK_PHONE_NUMBER,
      page: () => const AuthCheckPhoneNumberView(),
      binding: AuthCheckPhoneNumberBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_OTP,
      page: () => const AuthOtpView(),
      binding: AuthOtpBinding(),
    ),
  ];
}
