import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_boilerplate/app/base/base_custom_controller.dart';
import 'package:getx_boilerplate/data/model/response/register_response.dart';
import 'package:getx_boilerplate/data/repository/auth_repository/auth_repository.dart';
import 'package:getx_boilerplate/helper/custom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/request/login_request.dart';
import '../../data/model/request/register_request.dart';
import '../../data/model/response/login_response.dart';
import '../../routes/app_routes.dart';
import '../../shared/shared.dart';

class AuthController extends BaseCustomController {
  final AuthRepository authRepository =
      Get.find(tag: (AuthRepository).toString());

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  bool registerTermsChecked = false;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void register(BuildContext context) async {
    AppFocus.unfocus(context);
    if (registerFormKey.currentState!.validate()) {
      if (!registerTermsChecked) {
        CommonWidget.toast('Please check the terms first.');
        return;
      }

      final registerService = authRepository.register(
        RegisterRequest(
          email: registerEmailController.text,
          password: registerPasswordController.text,
        ),
      );
      callDataService(
        registerService,
        onSuccess: _handleRegisterResponse,
      );
    }
  }

  void _handleRegisterResponse(RegisterResponse? res) {
    final prefs = Get.find<SharedPreferences>();
    if (res?.token != null && res!.token!.isNotEmpty) {
      prefs.setString(StorageConstants.token, res.token ?? '');
      print('Go to Home screen>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    }
  }

  void login(BuildContext context) async {
    AppFocus.unfocus(context);
    if (loginFormKey.currentState!.validate()) {
      final loginService = authRepository.login(
        LoginRequest(
          email: loginEmailController.text,
          password: loginPasswordController.text,
        ),
      );
      callDataService(
        loginService,
        onSuccess: _handleLoginResponse,
      );
    }
  }

  void _handleLoginResponse(LoginResponse? res) {
    final prefs = Get.find<SharedPreferences>();
    if (res?.token != null && res!.token!.isNotEmpty) {
      prefs.setString(StorageConstants.token, res.token ?? '');
      goToNamed(AppRoutes.HOME);
    }
  }

  @override
  void onClose() {
    super.onClose();

    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();

    loginEmailController.dispose();
    loginPasswordController.dispose();
  }
}
