import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/widgets/my_text_utils.dart';
import 'package:fldc/model/contact_lead_modal.dart';

class TimeLineController extends MyController {
  List<ContactLeadModal> timeline = [];
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));

  @override
  void onInit() {
    ContactLeadModal.dummyList.then((value) {
      timeline = value.sublist(0, 6);
      update();
    });
    super.onInit();
  }
}
