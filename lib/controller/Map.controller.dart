import 'package:fldc/model/aircelerates_model.dart';
import 'package:fldc/model/flightdata_model.dart';
import 'package:fldc/model/routes_model.dart';
import 'package:fldc/services/CompanyRoute.service.dart';
import 'package:fldc/services/api.service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MapPageController extends GetxController {
  static MapPageController instance = Get.find();

  String companyId = '100172';
  var isLoading = false.obs;

  var companyRoutes = CompanyRoutes(
      name: '', id: 0, updateTimeStamp: DateTime.now(), routes: []).obs;
  var flights = <FlightData>[].obs;
  var aircelerates = <Aircelerates>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCompanyRoutes(companyId);
    fetchFlightData();
    fetchAIRcelerates();
  }

  void getCompanyRoutes(String id) async {
    isLoading.value = true;
    var response = await CompanyRouteService.getCompanyRoutes(id);
    companyRoutes.value = response;
    isLoading.value = false;
  }

  void fetchFlightData() {
    ApiService.send(
      CrudRequest.getMethod,
      "https://flylat.net/flylat_connect/map/mapper_all/getDataAi.php",
      cors: true,
      onSuccess: (response) {
        flights.value = (response as List)
            .map(
                (flight) => FlightData.fromJson(flight as Map<String, dynamic>))
            .toList();
      },
      onError: (statusCode, message) {
        print('Error: $statusCode, $message');
      },
    );
  }

  void fetchAIRcelerates() {
    ApiService.send(
      CrudRequest.getMethod,
      "https://lrenti.github.io/api/flylat/auto/airoutes.json",
      onSuccess: (response) {
        aircelerates.value = (response as List)
            .map((flight) =>
                Aircelerates.fromJson(flight as Map<String, dynamic>))
            .toList();
      },
      onError: (statusCode, message) {
        print('Error: $statusCode, $message');
      },
    );
  }
}
