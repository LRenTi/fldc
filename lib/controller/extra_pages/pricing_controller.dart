import 'package:fldc/controller/my_controller.dart';

class PricingController extends MyController {
  bool isMonth = false;

  void onSelectMonth() {
    isMonth = !isMonth;
    update();
  }
}
