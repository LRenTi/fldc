import 'package:fldc/controller/dashboard/food_controller.dart';
import 'package:fldc/controller/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

enum RevenueOverView {
  year,
  month,
  week,
  day,
  hours,
}

class RealEstateController extends MyController {
  RevenueOverView revenueOverView = RevenueOverView.year;
  MapShapeSource? dataSource;
  late List<PolylineModel> polylines;
  late List<MapLatLng> polyline;
  late MapZoomPanBehavior zoomPanBehavior;

  @override
  void onInit() {
    polyline = <MapLatLng>[
      MapLatLng(13.0827, 80.2707),
      MapLatLng(13.1746, 79.6117),
      MapLatLng(13.6373, 79.5037),
      MapLatLng(14.4673, 78.8242),
      MapLatLng(14.9091, 78.0092),
      MapLatLng(16.2160, 77.3566),
      MapLatLng(17.1557, 76.8697),
      MapLatLng(18.0975, 75.4249),
      MapLatLng(18.5204, 73.8567),
      MapLatLng(19.0760, 72.8777),
    ];
    polylines = <PolylineModel>[
      PolylineModel(polyline),
    ];
    dataSource = MapShapeSource.asset(
      'assets/data/world_map.json',
      shapeDataField: 'name',
    );
    zoomPanBehavior = MapZoomPanBehavior(
      zoomLevel: 2,
      focalLatLng: MapLatLng(19.3173, 76.7139),
    );
    super.onInit();
  }

  final List<ChartSampleData> chartData = [
    ChartSampleData(x: 'Jan', y: 16, yValue: 1200),
    ChartSampleData(x: 'Feb', y: 26, yValue: 2200),
    ChartSampleData(x: 'Mar', y: 24, yValue: 1800),
    ChartSampleData(x: 'Apr', y: 28, yValue: 800),
    ChartSampleData(x: 'May', y: 30, yValue: 2500),
    ChartSampleData(x: 'Jun', y: 20, yValue: 1500),
    ChartSampleData(x: 'Jul', y: 40, yValue: 3500),
    ChartSampleData(x: 'Aug', y: 26, yValue: 2200),
    ChartSampleData(x: 'Sep', y: 50, yValue: 4500),
    ChartSampleData(x: 'Oct', y: 70, yValue: 5500),
    ChartSampleData(x: 'Nov', y: 55, yValue: 3000),
    ChartSampleData(x: 'Dec', y: 45, yValue: 3500),
  ];

  List recentTransaction = [
    {
      'date': '17 March 2023',
      'name': 'Mr. Rockey',
      'price': '1200',
      'type': 'Rent',
      'status': 'Paid',
    },
    {
      'date': '21 March 2023',
      'name': 'Ms. Taylor',
      'price': '500',
      'type': 'Sell',
      'status': 'Pending',
    },
    {
      'date': '30 March 2023',
      'name': 'Mr. Smith',
      'price': '1500',
      'type': 'Rent',
      'status': 'Paid',
    },
    {
      'date': '5 April 2023',
      'name': 'Mrs. Johnson',
      'price': '300',
      'type': 'Sell',
      'status': 'Paid',
    }
  ];

  final TooltipBehavior chart = TooltipBehavior(
    enable: true,
    format: 'point.x : point.yValue1 : point.yValue2',
  );

  void onSelectRevenueOverViewTime(RevenueOverView time) {
    revenueOverView = time;
    update();
  }
}

class ChartSampleData {
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  final dynamic x;
  final num? y;
  final dynamic xValue;
  final num? yValue;
  final num? secondSeriesYValue;
  final num? thirdSeriesYValue;
  final Color? pointColor;
  final num? size;
  final String? text;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  final num? volume;
}
