import 'package:flutter/material.dart';

class FlightData {
  final double? longitude;
  final double? latitude;
  final double? altitude;
  final double? speed;
  final double? heading;
  final String? username;
  final String? company;
  final String? status;
  final String? depicao;
  final String? arricao;
  final double? dist;
  final String? aircraft;
  final String? flight_number;
  final String? name;
  final String? call_sign;
  final String? company_id;
  final String? type_data;

  FlightData({
    this.longitude,
    this.latitude,
    this.altitude,
    this.speed,
    this.heading,
    this.username,
    this.company,
    this.status,
    this.depicao,
    this.arricao,
    this.dist,
    this.aircraft,
    this.flight_number,
    this.name,
    this.call_sign,
    this.company_id,
    this.type_data,
  });

  factory FlightData.fromJson(Map<String, dynamic> json) {
  if (json['type_data'] == 'real') {
    return FlightData(
      longitude: double.tryParse(json['longitude'] ?? '') ?? 0.0,
      latitude: double.tryParse(json['latitude'] ?? '') ?? 0.0,
      altitude: double.tryParse(json['altitude'] ?? '') ?? 0.0,
      speed: double.tryParse(json['speed'] ?? '') ?? 0.0,
      heading: double.tryParse(json['heading'] ?? '') ?? 0.0,
      username: json['username'] ?? '',
      status: json['status'] ?? '',
      depicao: json['depicao'] ?? '',
      arricao: json['arricao'] ?? '',
      dist: double.tryParse(json['dist'] ?? '') ?? 0.0,
      aircraft: json['aircraft'] ?? '',
      flight_number: json['flight_number'] ?? '',
      name: json['name'] ?? '',
      call_sign: json['call_sign'] ?? '',
      company_id: json['company_id'] ?? '',
      type_data: json['type_data'] ?? '',
    );
  } else if (json['type_data'] == 'ai') {
    return FlightData(
      longitude: double.tryParse(json['lon_step'] ?? '') ?? 0.0,
      latitude: double.tryParse(json['lat_step'] ?? '') ?? 0.0,
      username: json['crew_name'] ?? '',
      status: json['status'] ?? '',
      depicao: json['dep'] ?? '',
      arricao: json['des'] ?? '',
      name: json['name'] ?? '',
      call_sign: json['call_sign'] ?? '',
      company_id: json['id'] ?? '',
      type_data: json['type_data'] ?? '',
    );
  } else {
    return FlightData(
      longitude: 0.0,
      latitude: 0.0,
      altitude: 0.0,
      speed: 0.0,
      heading: 0.0,
      username: '',
      status: '',
      depicao: '',
      arricao: '',
      dist: 0.0,
      aircraft: '',
      flight_number: '',
      name: '',
      call_sign: '',
      company_id: '',
      type_data: '',
    );
  }
}


  @override
  String toString() {
    return 'FlightData(longitude: $longitude, latitude: $latitude, altitude: $altitude, speed: $speed, heading: $heading, username: $username, status: $status, depicao: $depicao, arricao: $arricao, dist: $dist, aircraft: $aircraft, flight_number: $flight_number, name: $name, call_sign: $call_sign, company_id: $company_id, type_data: $type_data)';
  }
}
