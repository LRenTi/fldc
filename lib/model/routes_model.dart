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
      distance: json['distance'] as String,
      flown: json['flown'] as int,
      verified: json['verified'] == "1",  // String "1"/"0" in bool umwandeln
      departure: Airport.fromJson(json['departure']),
      destination: Airport.fromJson(json['destination']),
    );
  }
}

class Airport {
  String icao;
  String name;
  double latitude;  // Typ auf double geändert für exakte Werte
  double longitude;
  String city;
  String country;
  String region;

  Airport({
    required this.icao,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.country,
    required this.region,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      icao: json['ICAO'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      city: json['municipality'] as String,
      country: json['iso_country'] as String,
      region: json['iso_region'] as String,
    );
  }
}
