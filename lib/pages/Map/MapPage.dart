import 'dart:convert';
import 'dart:io';

import 'package:fldc/controller/AirlineController.dart';
import 'package:fldc/helpers/theme/theme_customizer.dart';
import 'package:fldc/helpers/widgets/my_responsive.dart';
import 'package:fldc/helpers/widgets/my_screen_media.dart';
import 'package:fldc/helpers/widgets/responsive.dart';
import 'package:fldc/model/aircelerates_model.dart';
import 'package:fldc/model/airline_model.dart';
import 'package:fldc/model/airport_model.dart';
import 'package:fldc/model/flightdata_model.dart';
import 'package:fldc/services/api.service.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:fldc/view/ui/toast_message_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late List<FlightData> flights = [];
  late List<Aircelerates> aircelerates = [];
  late MapPageController controller;
  late Future<CompanyRoutes> data;
  Airline? selectedOption;
  final Airlinecontroller airlineController = Get.find();
  late List<Airline> dropdownOptions = [];

  @override
  void initState() {
    super.initState();
    controller = MapPageController.instance;
    dropdownOptions = airlineController.airlines;
    selectedOption = dropdownOptions.firstWhere(
        (airline) => airline.id == '100172',
        orElse: () => dropdownOptions.first);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.getCompanyRoutes(selectedOption!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    MyScreenMediaType screenType =
        MyScreenMedia.getTypeFromWidth(MediaQuery.of(context).size.width);
    return Scaffold(
      drawer: LeftBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(
                color: contentTheme.primary, size: 40),
          );
        }

        final snapshotData = controller.companyRoutes.value;

        // if (snapshotData.routes.isEmpty) {
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     clipBehavior: Clip.antiAliasWithSaveLayer,
        //     elevation: 0,
        //     shape: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(8),
        //         borderSide: BorderSide.none),
        //     width: 300,
        //     behavior: SnackBarBehavior.floating,
        //     duration: Duration(milliseconds: 1200),
        //     content: MyText.labelLarge("Something went wrong",
        //         fontWeight: 600, color: contentTheme.onPrimary),
        //     backgroundColor: contentTheme.primary,
        //   ));
        // }

        var routes = snapshotData.routes;
        final Set<String> airportICOs = {};

        return Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(51.0, 10.0),
                initialZoom: 3.0,
                interactionOptions: InteractionOptions(
                    flags: InteractiveFlag.pinchZoom |
                        InteractiveFlag.doubleTapDragZoom |
                        InteractiveFlag.doubleTapZoom |
                        InteractiveFlag.drag |
                        InteractiveFlag.scrollWheelZoom |
                        InteractiveFlag.pinchMove |
                        InteractiveFlag.pinchZoom |
                        InteractiveFlag.flingAnimation),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c', 'd'],
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
                          context, route.departure, snapshotData));
                    }
                    if (airportICOs.add(route.destination.icao)) {
                      markers.add(_buildAirportMarker(
                          context, route.destination, snapshotData));
                    }
                    return markers;
                  }).toList(),
                ),
              ],
            ),
            if (!screenType.isMobile && !screenType.isTablet)
              LeftBar(
                isCondensed: true,
              ),
            mapNavigator(screenType),
          ],
        );
      }),
    );
  }

  Widget mapNavigator(MyScreenMediaType screenType) {
    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        child: Row(
          children: [
            if (screenType.isMobile || screenType.isTablet)
              Builder(
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: theme.dialogBackgroundColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  );
                },
              ),
            if (screenType.isMobile || screenType.isTablet) MySpacing.width(10) else MySpacing.width(58),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: theme.dialogBackgroundColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                dropdownColor: theme.dialogBackgroundColor,
                value: selectedOption?.id,
                items: dropdownOptions
                    .map<DropdownMenuItem<String>>((Airline option) {
                  return DropdownMenuItem<String>(
                    value: option.id,
                    child: Text(option.name),
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      selectedOption = dropdownOptions
                          .firstWhere((airline) => airline.id == value);
                      controller.getCompanyRoutes(value);
                    });
                  }
                },
              ),
            ),
          ],
        ),
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
        return Obx(
          () {
            flights = controller.flights;
            aircelerates = controller.aircelerates;
            bool _isHoveringA380 = false;

            bool hasA380restriction = controller.a380restriction.any((element) {
              return element.icao == airport.icao;
            });

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
                      Row(
                        children: [
                          Padding(
                            padding: MySpacing.all(16),
                            child: MyText.labelLarge(
                                '${airport.name}  -  ${airport.city}, ${airport.country}',
                                fontWeight: 600),
                          ),
                        ],
                      ),
                      Divider(height: 0, thickness: 1),
                      Row(
                        children: [
                          if (!hasA380restriction)
                            Padding(
                              padding: MySpacing.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Restrictions:",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  MouseRegion(
                                    onEnter: (_) =>
                                        setState(() => _isHoveringA380 = true),
                                    onExit: (_) =>
                                        setState(() => _isHoveringA380 = false),
                                    child: Container(
                                      margin: MySpacing.top(2),
                                      padding: MySpacing.all(2),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.red),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        "A380",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  if (_isHoveringA380)
                                    Positioned(
                                      top: -30,
                                      child: Material(
                                        elevation: 4,
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          color: Colors.white,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            "Hier ist ein Hover-Text!",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      Divider(height: 0, thickness: 1),
                      Padding(
                        padding:
                            MySpacing.symmetric(horizontal: 16, vertical: 8),
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
                              flight.company_id == selectedOption!.id &&
                              ((flight.depicao == route.departure.icao &&
                                      flight.arricao ==
                                          route.destination.icao) ||
                                  (flight.depicao == route.destination.icao &&
                                      flight.arricao == route.departure.icao)));

                          bool hasAircelerates = false;
                          if (selectedOption!.id == '100172') {
                            hasAircelerates = aircelerates.any((flight) =>
                                (flight.departure == route.departure.icao &&
                                    flight.destination ==
                                        route.destination.icao) ||
                                (flight.departure == route.destination.icao &&
                                    flight.destination ==
                                        route.departure.icao));
                          }

                          bool activeFlight = flights.any((flight) =>
                              flight.type_data == "real" &&
                              flight.company_id == selectedOption!.id &&
                              ((flight.depicao == route.departure.icao &&
                                      flight.arricao ==
                                          route.destination.icao) ||
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
                                    color: activeFlight
                                        ? Color(0xFF57B8F0)
                                        : route.verified
                                            ? Colors.green
                                            : Colors.red,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: hasMatchingFlightData
                                      ? Icon(
                                          Icons.flight,
                                          size: 10,
                                          color: Colors.white,
                                        )
                                      : hasAircelerates
                                          ? Icon(
                                              Icons.flight,
                                              size: 10,
                                              color: Color.fromARGB(
                                                  255, 255, 187, 110),
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
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF57B8F0),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    Text(
                                      " Active Flight",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.flight,
                                      size: 10,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      " Active AI-Flight",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                                if (selectedOption!.id == '100172')
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.flight,
                                        size: 10,
                                        color:
                                            Color.fromARGB(255, 255, 187, 110),
                                      ),
                                      Text(
                                        " Planned AI-Flights",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
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
      },
    );
  }
}
