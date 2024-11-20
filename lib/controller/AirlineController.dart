import 'package:fldc/model/airline_model.dart';
import 'package:fldc/model/routes_model.dart';
import 'package:fldc/services/api.service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class Airlinecontroller extends GetxController {
  RxList<Airline> airlines = <Airline>[].obs;
  RxList<RouteFL> routes = <RouteFL>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAirlines();
  }

  void getAirlines() {
    ApiService.send(
      CrudRequest.getMethod,
      'https://lrenti.github.io/api/flylat/data/airlines.json',
      onSuccess: (response) {
        airlines.value =
            (response as List).map((e) => Airline.fromJson(e)).toList();
      },
      onError: (statusCode, message) {
        print('Error: $statusCode, $message');
      },
    );
  }

  void getRouteByAirlineId(int id) async{
    await ApiService.send(
      CrudRequest.getMethod,
      'https://flylat.net/company/get_routes.php?id=${id}',
      cors: true,
      onSuccess: (response) {
        print('Received routes: $response'); // Debug-Ausgabe
        routes.value =
            (response as List).map((e) => RouteFL.fromJson(e)).toList();
        print('Routes length: ${routes.length}'); // Prüfe die Länge
      },
      onError: (statusCode, message) {
        print('Error: $statusCode, $message');
      },
    );
    update();
  }
}
