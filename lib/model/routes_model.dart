import 'package:fldc/model/airport_model.dart';

class CompanyRoutes {
  String name;
  int id;
  DateTime updateTimeStamp;
  List<Routes> routes;

  CompanyRoutes({
    required this.name,
    required this.id,
    required this.updateTimeStamp,
    required this.routes,
  });

  factory CompanyRoutes.fromJson(Map<String, dynamic> json) {
    return CompanyRoutes(
      name: json['name'] as String,
      id: int.parse(json['id']), 
      updateTimeStamp: DateTime.fromMillisecondsSinceEpoch((json['updateTimestamp'] * 1000).toInt()),
      routes: (json['routes'] as List)
          .map((routeJson) => Routes.fromJson(routeJson))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'CompanyRoutes{name: $name, id: $id, updateTimeStamp: $updateTimeStamp, routes: $routes}';
  }
}

class Routes {
  int id;
  int profit;
  String distance;
  int flown;
  bool verified;
  Airport departure;
  Airport destination;

  Routes({
    required this.id,
    required this.profit,
    required this.distance,
    required this.flown,
    required this.verified,
    required this.departure,
    required this.destination,
  });

factory Routes.fromJson(Map<String, dynamic> json) {
  return Routes(
    id: json['route_id'] as int,
    profit: json['profit'] as int,
    distance: json['distance'] as String? ?? '', // Setze einen Standardwert
    flown: json['flown'] as int,
    verified: json['verified'] == "1",
    departure: Airport.fromJson(json['departure'] ?? {}), // Wenn null, leeres Map
    destination: Airport.fromJson(json['destination'] ?? {}), // Wenn null, leeres Map
  );
}


  @override
  String toString() {
    return 'Routes{id: $id, profit: $profit, distance: $distance, flown: $flown, verified: $verified, departure: $departure, destination: $destination}';
  }
}