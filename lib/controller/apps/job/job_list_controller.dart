import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/widgets/my_text_utils.dart';
import 'package:fldc/model/job_modal.dart';
import 'package:get/get.dart';

class JobListController extends MyController {
  List<JobModal> job = [];
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));

  @override
  void onInit() {
    JobModal.dummyList.then((value) {
      job = value;
      update();
    });
    super.onInit();
  }

  void goToDetailScreen() {
    Get.toNamed('/app/job_detail');
  }
}
