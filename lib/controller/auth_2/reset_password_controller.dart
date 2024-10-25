import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/services/auth_service.dart';
import 'package:fldc/helpers/widgets/my_form_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  TextEditingController passwordController =
      TextEditingController(text: "password");
  TextEditingController confirmPasswordController =
      TextEditingController(text: "password123");
  String password = '';
  String confirmPassword = '';

  bool isShowPassword = false;

  bool isConfirmPassword = false;

  void onResetPassword() async {
    if (basicValidator.validateForm()) {
      if (password == confirmPassword) {
        Get.offNamed('/dashboard/analytics');
      } else {
        var errors = await AuthService.loginUser(basicValidator.getData());
        if (errors != null) {
          basicValidator.addErrors(errors);
          basicValidator.validateForm();
          basicValidator.clearErrors();
        }
      }
      Get.offNamed('/dashboard/analytics');
    }
  }

  void onShowPasswordToggle() {
    isShowPassword = !isShowPassword;
    update();
  }

  void onShowConfirmPassword() {
    isConfirmPassword = !isConfirmPassword;
    update();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
