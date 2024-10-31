class Airline {
  String name;
  String id;

  Airline({required this.name, required this.id});

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );
  }

  @override
  String toString() {
    return 'Airline{name: $name, id: $id}';
  }
}