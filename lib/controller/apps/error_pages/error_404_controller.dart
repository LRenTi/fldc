import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/view/dashboard/analytics_screen.dart';
import 'package:get/get.dart';

class Error404Controller extends MyController {
  void goToDashboardScreen() {
    Get.off(AnalyticsScreen());
  }
}
