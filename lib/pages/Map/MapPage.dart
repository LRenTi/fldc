import 'package:fldc/controller/Map.controller.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/model/routes_model.dart';
import 'package:fldc/services/CompanyRoute.service.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:fldc/view/layouts/left_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late MapControllerFLDC controller;

  late Future<CompanyRoutes> data;

  @override
  void initState() {
    controller = MapControllerFLDC();
    data =
        CompanyRouteService.getCompanyRoutes(100172); // Future initialisieren
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CompanyRoutes>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.routes.isEmpty) {
            return Center(child: Text('No routes available'));
          }
          var routes = snapshot.data!.routes;
          return FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(51.0, 10.0),
              initialZoom: 5.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              PolylineLayer(
                polylines: routes
                    .map((route) => Polyline(
                          points: [
                            LatLng(route.departure.latitude,
                                route.departure.longitude),
                            LatLng(route.destination.latitude,
                                route.destination.longitude),
                          ],
                          strokeWidth: 2.0,
                          color: const Color.fromARGB(255, 95, 95, 95),
                        ))
                    .toList(),
              ),
              MarkerLayer(
                markers: routes
                    .expand((route) => [
                          _buildAirportMarker(context, route.departure, route),
                          _buildAirportMarker(
                              context, route.destination, route),
                        ])
                    .toList(),
              ),
              LeftBar(
                isCondensed: true,
              )
            ],
          );
        },
      ),
    );
  }

  Marker _buildAirportMarker(
      BuildContext context, Airport airport, Routes route) {
    Color boxColor;
    if (route.verified && route.destination == airport) {
      boxColor = Colors.green;
    } else if (route.departure == airport) {
      boxColor = Colors.blue;
    } else {
      boxColor = Colors.red;
    }
    return Marker(
      width: 40.0,
      height: 20.0,
      point: LatLng(
        airport.latitude.isFinite ? airport.latitude : 0.0,
        airport.longitude.isFinite ? airport.longitude : 0.0,
      ),
      child: GestureDetector(
        onTap: () => _showRouteInfoModal(context, airport),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: boxColor,
          ),
          child: Center(
            child: Text(
              airport.icao,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _showRouteInfoModal(BuildContext context, Airport airport) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Airport: ${airport.name}',
                  style: const TextStyle(fontSize: 18)),
              Text('City: ${airport.city}'),
              Text('Country: ${airport.country}'),
              Text('Coordinates: ${airport.latitude}, ${airport.longitude}'),
            ],
          ),
        );
      },
    );
  }
}
