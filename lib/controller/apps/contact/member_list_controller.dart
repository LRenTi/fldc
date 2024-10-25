import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/model/contact_model.dart';

class MemberListController extends MyController {
  List<ContactModel> contact = [];

  @override
  void onInit() {
    ContactModel.dummyList.then((value) {
      contact = value;
      update();
    });
    super.onInit();
  }
}
