import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/services/auth_service.dart';
import 'package:fldc/helpers/widgets/my_form_validator.dart';
import 'package:fldc/helpers/widgets/my_validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  bool isShowPassword = false;

  @override
  void onInit() {
    super.onInit();
    basicValidator.addField(
      'email',
      required: true,
      label: "Email",
      validators: [MyEmailValidator()],
      controller: TextEditingController(text: 'user@demo.com'),
    );
    basicValidator.addField(
      'first_name',
      required: true,
      label: 'First Name',
      controller: TextEditingController(text: 'Chloe'),
    );
    basicValidator.addField(
      'last_name',
      required: true,
      label: 'Last Name',
      controller: TextEditingController(text: 'Fiona'),
    );
    basicValidator.addField(
      'password',
      required: true,
      validators: [MyLengthValidator(min: 6, max: 10)],
      controller: TextEditingController(text: 'password'),
    );
  }

  void onShowPasswordToggle() {
    isShowPassword = !isShowPassword;
    update();
  }

  Future<void> onSignUp() async {
    if (basicValidator.validateForm()) {
      update();
      var errors = await AuthService.loginUser(basicValidator.getData());
      if (errors != null) {
        basicValidator.addErrors(errors);
        basicValidator.validateForm();
        basicValidator.clearErrors();
      }
      String nextUrl =
          Uri.parse(ModalRoute.of(Get.context!)?.settings.name ?? "")
                  .queryParameters['next'] ??
              "/dashboard/analytics";
      Get.offNamed(nextUrl);
      update();
    }
  }

  void gotoLogin() {
    Get.toNamed('/auth_2/login');
  }
}
