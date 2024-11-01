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
    icao: json['ICAO'] as String? ?? '', // Setze einen Standardwert, falls null
    name: json['name'] as String? ?? '', // Setze einen Standardwert
    latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0, // Setze einen Standardwert
    longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0, // Setze einen Standardwert
    city: json['municipality'] as String? ?? '', // Setze einen Standardwert
    country: json['iso_country'] as String? ?? '', // Setze einen Standardwert
    region: json['iso_region'] as String? ?? '', // Setze einen Standardwert
  );
}

  @override
  String toString() {
    return 'Airport{icao: $icao, name: $name, latitude: $latitude, longitude: $longitude, city: $city, country: $country, region: $region}';
  }
}


class AircraftRestriction {
  final String? name;
  final String icao;

  AircraftRestriction({this.name, required this.icao});

  factory AircraftRestriction.fromJson(Map<String, dynamic> json) {
    return AircraftRestriction(
      name: json['name'],
      icao: json['icao'],
    );
  }

}