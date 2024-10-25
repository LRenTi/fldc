import 'package:fldc/controller/my_controller.dart';
import 'package:flutter/material.dart';

class ProfileController extends MyController {
  late TextEditingController nameTE,
      lastNameTE,
      emailTE,
      addressTE,
      cityTE,
      stateTE,
      passwordTE;

  @override
  void onInit() {
    nameTE = TextEditingController();
    lastNameTE = TextEditingController();
    emailTE = TextEditingController();
    addressTE = TextEditingController();
    cityTE = TextEditingController();
    stateTE = TextEditingController();
    passwordTE = TextEditingController();
    super.onInit();
  }
}
