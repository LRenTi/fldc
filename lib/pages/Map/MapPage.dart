import 'package:fldc/model/aircelerates_model.dart';
import 'package:fldc/model/flightdata_model.dart';
import 'package:fldc/services/api.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:fldc/controller/Map.controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/model/routes_model.dart';
import 'package:fldc/services/CompanyRoute.service.dart';
import 'package:fldc/view/layouts/left_bar.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late List<FlightData> flights;
  late List<Aircelerates> aircelerates;

  @override
  void initState() {
    super.initState();
    controller = MapControllerFLDC();
    data = CompanyRouteService.getCompanyRoutes(100172);
    _fetchFlightData();
    _fetchAIRcelerates();
  }

  void _fetchFlightData() {
    ApiService.send(
      CrudRequest.getMethod,
      "https://flylat.net/flylat_connect/map/mapper_all/getDataAi.php",
      cors: true,
      onSuccess: (response) {
        setState(() {
          flights = (response as List)
              .map((flight) =>
                  FlightData.fromJson(flight as Map<String, dynamic>))
              .toList();
        });
      },
      onError: (statusCode, message) {
        print('Error: $statusCode, $message');
      },
    );
  }

  void _fetchAIRcelerates() {
    ApiService.send(
      CrudRequest.getMethod,
      "https://lrenti.github.io/api/flylat/auto/airoutes.json",
      onSuccess: (response) {
        aircelerates = (response as List)
            .map((flight) =>
                Aircelerates.fromJson(flight as Map<String, dynamic>))
            .toList();
      },
      onError: (statusCode, message) {
        print('Error: $statusCode, $message');
      },
    );
  }

  late MapControllerFLDC controller;
  late Future<CompanyRoutes> data;
  String selectedOption = '100172';

  final List<String> dropdownOptions = [
    '100172',
    '100269'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Error: ${snapshot.error}\nDetails: ${snapshot.stackTrace}'));
          } else if (snapshot.data == null || snapshot.data!.routes.isEmpty) {
            return Center(child: Text('No routes available'));
          }

          var routes = snapshot.data!.routes;
          final Set<String> airportICOs = {};

          return Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(51.0, 10.0),
                  initialZoom: 4.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                    markers: routes.expand((route) {
                      List<Marker> markers = [];
                      if (airportICOs.add(route.departure.icao)) {
                        markers.add(_buildAirportMarker(
                            context, route.departure, snapshot.data!));
                      }
                      if (airportICOs.add(route.destination.icao)) {
                        markers.add(_buildAirportMarker(
                            context, route.destination, snapshot.data!));
                      }
                      return markers;
                    }).toList(),
                  ),
                  LeftBar(
                    isCondensed: true,
                  ),
                ],
              ),
              Positioned(
                top: 20,
                left: MediaQuery.of(context).size.width / 2 - 100,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: selectedOption,
                    items: dropdownOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue!;
                        data = CompanyRouteService.getCompanyRoutes(
                            selectedOption);
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Marker _buildAirportMarker(
      BuildContext context, Airport airport, CompanyRoutes data) {
    return Marker(
      width: 40.0,
      height: 20.0,
      point: LatLng(
        airport.latitude.isFinite ? airport.latitude : 0.0,
        airport.longitude.isFinite ? airport.longitude : 0.0,
      ),
      child: GestureDetector(
        onTap: () => _showRouteInfoModal(context, airport, data),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppTheme.primaryColor,
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

  void _showRouteInfoModal(
      BuildContext context, Airport airport, CompanyRoutes data) {
    final List<Routes> routesList = [];
    for (var route in data.routes) {
      if (route.departure.icao == airport.icao ||
          route.destination.icao == airport.icao) {
        routesList.add(route);
      }
    }
    routesList.sort((a, b) {
      int comparison = a.departure.icao.compareTo(b.departure.icao);
      if (comparison == 0) {
        return a.destination.icao.compareTo(b.destination.icao);
      }
      return comparison;
    });

    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          child: SizedBox(
            width: 600,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: MySpacing.all(16),
                    child:
                        MyText.labelLarge('${airport.name}', fontWeight: 600),
                  ),
                  Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: MyText.bodySmall(
                        '${airport.city}, ${airport.country}',
                        fontWeight: 600),
                  ),
                  Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.symmetric(horizontal: 16, vertical: 8),
                    child: Text("Routes", style: TextStyle(fontSize: 16)),
                  ),
                  Column(
                    children: routesList.map((route) {
                      var port;
                      if (route.departure.icao == airport.icao) {
                        port = route.destination;
                      } else if (route.destination.icao == airport.icao) {
                        port = route.departure;
                      }
                      bool hasMatchingFlightData = flights.any((flight) =>
                          flight.type_data == "ai" &&
                          flight.company_id == selectedOption &&
                          ((flight.depicao == route.departure.icao &&
                                  flight.arricao == route.destination.icao) ||
                              (flight.depicao == route.destination.icao &&
                                  flight.arricao == route.departure.icao)));

                      bool hasAircelerates = false;
                      if (selectedOption == '100172') {
                        hasAircelerates = aircelerates.any((flight) =>
                            (flight.departure == route.departure.icao &&
                                flight.destination == route.destination.icao) ||
                            (flight.departure == route.destination.icao &&
                                flight.destination == route.departure.icao));
                      }

                      bool activeFlight = flights.any((flight) =>
                          flight.type_data == "real" &&
                          flight.company_id == selectedOption &&
                          ((flight.depicao == route.departure.icao &&
                                  flight.arricao == route.destination.icao) ||
                              (flight.depicao == route.destination.icao &&
                                  flight.arricao == route.departure.icao)));

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color:
                                    route.verified ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: activeFlight
                                  ? Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF57B8F0),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    )
                                  : hasMatchingFlightData
                                      ? Icon(
                                          Icons.flight,
                                          size: 10,
                                          color: Colors.white,
                                        )
                                      : hasAircelerates
                                          ? Icon(
                                              Icons.flight,
                                              size: 10,
                                              color: Color.fromARGB(255, 255, 187, 110),
                                            )
                                          : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Row(
                                children: [
                                  Text(
                                    '${port.icao}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ' - ${port.name}',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(padding: MySpacing.all(5)),
                  Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                Text(
                                  " Verified",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                Text(
                                  " Not Verified",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            )
                          ],
                        ),
                        MyButton(
                          onPressed: () => Get.back(),
                          elevation: 0,
                          borderRadiusAll: 8,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: AppTheme.primaryColor,
                          child: MyText.labelMedium(
                            "Close",
                            fontWeight: 600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
