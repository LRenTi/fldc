import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/services/auth_service.dart';
import 'package:fldc/helpers/widgets/my_form_validator.dart';
import 'package:fldc/helpers/widgets/my_validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  @override
  void onInit() {
    super.onInit();
    basicValidator.addField(
      'email',
      required: true,
      label: "Email",
      validators: [MyEmailValidator()],
      controller: TextEditingController(text: "user@demo.com"),
    );
  }

  Future<void> onResetPassword() async {
    if (basicValidator.validateForm()) {
      update();
      var errors = await AuthService.loginUser(basicValidator.getData());
      if (errors != null) {
        basicValidator.validateForm();
        basicValidator.clearErrors();
      }
      Get.toNamed('/auth_2/reset_password');
      update();
    }
  }

  void backToLogin() {
    Get.offNamed('/auth_2/login');
  }
}
