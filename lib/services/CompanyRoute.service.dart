import 'dart:convert';

import 'package:fldc/model/routes_model.dart';
import 'package:fldc/services/api.service.dart';

class CompanyRouteService {
  static const defaultURL = 'https://lrenti.github.io/api/flylat/data/routes/';

  static Future<CompanyRoutes> getCompanyRoutes(String companyId) async {
    var url = defaultURL + '${companyId}.json';
    CompanyRoutes companyRoutes = CompanyRoutes(name: '', id: 0, updateTimeStamp: DateTime.now(), routes: []);

    await ApiService.send(
      CrudRequest.getMethod,
      url,
      onSuccess: (response) {
        companyRoutes = CompanyRoutes.fromJson(response as Map<String, dynamic>);
      },
      onError: (statusCode, message) {
        print('Error: $statusCode, $message');
      },
    );
    return companyRoutes;
  }
}
