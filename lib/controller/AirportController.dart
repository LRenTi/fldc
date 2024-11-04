import 'package:fldc/controller/AirlineController.dart';
import 'package:fldc/model/airport_model.dart';
import 'package:fldc/services/api.service.dart';
import 'package:get/get.dart';

class Airportcontroller extends GetxController {
  var airports = <Airport>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAirports();
  }

  void getAirports() {
    ApiService.send(
      CrudRequest.getMethod,
      'https://lrenti.github.io/api/flylat/data/airports.json',
      onSuccess: (response) {
        airports.value =
            (response as List).map((e) => Airport.fromJson(e)).toList();
      },
      onError: (statusCode, message) {
        print('Error: $statusCode, $message');
      },
    );
  }
}