import 'package:fldc/helpers/services/auth_service.dart';
import 'package:fldc/helpers/widgets/my_form_validator.dart';
import 'package:fldc/helpers/widgets/my_validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  MyFormValidator basicValidator = MyFormValidator();
  bool obscureText = false;

  @override
  void onInit() {
    super.onInit();
    basicValidator.addField(
      'email',
      required: true,
      label: "Email",
      validators: [MyEmailValidator()],
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'first_name',
      required: true,
      label: 'First Name',
      validators: [MyNameValidator(max: 10)],
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'last_name',
      required: true,
      label: 'Last Name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'password',
      required: true,
      validators: [MyLengthValidator(min: 6, max: 10)],
      controller: TextEditingController(),
    );
  }

  void showPasswordToggle() {
    obscureText = !obscureText;
    update();
  }

  Future<void> onLogin() async {
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
      Get.toNamed(
        nextUrl,
      );
      update();
    }
  }

  void gotoLogin() {
    Get.toNamed('/auth/login');
  }
}
