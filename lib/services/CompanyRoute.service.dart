import 'dart:convert';

import 'package:fldc/model/routes_model.dart';
import 'package:fldc/services/api.service.dart';

class CompanyRouteService {
  static const defaultURL = 'https://lrenti.github.io/api/flylat/data/routes/';

  static get http => null;

  static Future<CompanyRoutes> getCompanyRoutes(companyId) async {
    var url = defaultURL + '${companyId.toString()}.json';
    var companyRoutes;

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
    return companyRoutes ?? CompanyRoutes(routes: [], name: 'TEST', id: 0, updateTimeStamp: DateTime.now());
  }
}
