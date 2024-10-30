import 'package:fldc/model/routes_model.dart';
import 'package:fldc/services/CompanyRoute.service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MapControllerFLDC extends GetxController{
  static MapControllerFLDC instance = Get.find();

  int companyId = 100172;

  var companyRoutes = CompanyRoutes(name: '', id: 0, updateTimeStamp: DateTime.now(), routes: []).obs;

  @override
  void onInit() {
    super.onInit();
    getCompanyRoutes(companyId);
  }

  void getCompanyRoutes(int id) async {
    var response = await CompanyRouteService.getCompanyRoutes(id);
    companyRoutes.value = response;
  }
}