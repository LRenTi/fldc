import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/services/auth_service.dart';
import 'package:fldc/helpers/widgets/my_form_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends MyController {
  MyFormValidator basicV = MyFormValidator();
  TextEditingController passwordController =
      TextEditingController(text: "password");
  TextEditingController confirmPasswordController =
      TextEditingController(text: "password123");
  String password = '';
  String confirmPassword1 = '';

  bool showPassword = false;

  bool confirmPassword = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void onLogin() async {
    if (basicV.validateForm()) {
      if (password == confirmPassword1) {
        Get.offNamed('/dashboard/analytics');
      } else {
        var errors = await AuthService.loginUser(basicV.getData());
        if (errors != null) {
          basicV.addErrors(errors);
          basicV.validateForm();
          basicV.clearErrors();
        }
      }
      Get.offNamed('/dashboard/analytics');
    }
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onResetPassword() {
    confirmPassword = !confirmPassword;
    update();
  }
}
