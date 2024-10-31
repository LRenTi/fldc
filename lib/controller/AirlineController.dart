import 'package:fldc/model/airline_model.dart';
import 'package:fldc/services/api.service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class Airlinecontroller extends GetxController {
  RxList<Airline> airlines = <Airline>[].obs;

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
}
