class Aircelerates {
  final String? route;
  final String? name;
  final String? departure;
  final String? destination;

  Aircelerates({
    this.route,
    this.name,
    this.departure,
    this.destination,
  });

  factory Aircelerates.fromJson(Map<String, dynamic> json) {
    return Aircelerates(
      route: json['Route'] ?? '',
      name: json['Name'] ?? '',
      departure: json['Departure'] ?? '',
      destination: json['Destination'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Route: $route, Name: $name, Departure: $departure, destination: $destination';
  }
}
