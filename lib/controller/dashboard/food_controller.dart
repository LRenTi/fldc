import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/theme/admin_theme.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/model/food_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

enum TimeUnit {
  year,
  month,
  week,
  day,
  hours,
}

enum RecentOrderRequest {
  year,
  month,
  week,
  day,
  hours,
}

enum OrderMap {
  year,
  month,
  week,
  day,
  hours,
}

class FoodController extends MyController {
  List<Food> food = [];

  late List<MapLatLng> polyline;
  late List<PolylineModel> polylines;
  MapShapeSource? dataSource;
  late MapZoomPanBehavior zoomPanBehavior;
  TimeUnit timeUnit = TimeUnit.year;
  RecentOrderRequest recentOrderRequest = RecentOrderRequest.year;
  OrderMap orderMap = OrderMap.year;
  List<SplineAreaData>? chartData;

  void onSelectedOrderRequest(TimeUnit time) {
    timeUnit = time;
    update();
  }

  void onRecentOrderRequest(RecentOrderRequest time) {
    recentOrderRequest = time;
    update();
  }

  void onSelectedOrderMap(OrderMap time) {
    orderMap = time;
    update();
  }

  @override
  void onInit() {
    Food.dummyList.then((value) {
      food = value;
      update();
    });

    chartData = <SplineAreaData>[
      SplineAreaData(2010, 3.0, 1.5, 1.0),
      SplineAreaData(2011, 4.0, 2.0, 1.2),
      SplineAreaData(2012, 5.5, 2.8, 1.4),
      SplineAreaData(2013, 4.5, 3.1, 1.6),
      SplineAreaData(2014, 6.0, 3.0, 1.9),
      SplineAreaData(2015, 7.0, 3.8, 2.4),
      SplineAreaData(2016, 6.5, 4.1, 2.7),
      SplineAreaData(2017, 8.0, 4.5, 3.3),
      SplineAreaData(2018, 7.5, 5.0, 3.8),
    ];

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

  List<CartesianSeries<SplineAreaData, double>> getSplineAreaSeries() {
    ContentTheme theme = AdminTheme.theme.contentTheme;
    final Color seriesColor1 = theme.primary;
    final Color seriesColor2 = theme.info;
    final Color seriesColor3 = theme.success;
    return <CartesianSeries<SplineAreaData, double>>[
      SplineAreaSeries<SplineAreaData, double>(
          dataSource: chartData,
          color: seriesColor1.withOpacity(0.6),
          borderColor: seriesColor1,
          name: 'Food',
          xValueMapper: (SplineAreaData sales, _) => sales.year,
          yValueMapper: (SplineAreaData sales, _) => sales.y1),
      SplineAreaSeries<SplineAreaData, double>(
          dataSource: chartData,
          borderColor: seriesColor2,
          color: seriesColor2.withOpacity(0.6),
          name: 'Drink',
          xValueMapper: (SplineAreaData sales, _) => sales.year,
          yValueMapper: (SplineAreaData sales, _) => sales.y2),
      SplineAreaSeries<SplineAreaData, double>(
          dataSource: chartData,
          borderColor: seriesColor3,
          color: seriesColor3.withOpacity(0.6),
          name: 'Other',
          xValueMapper: (SplineAreaData sales, _) => sales.year,
          yValueMapper: (SplineAreaData sales, _) => sales.y3)
    ];
  }

  List<RadialBarSeries<ChartSampleData, String>> getRadialBarSeries() {
    ContentTheme theme = AdminTheme.theme.contentTheme;
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'Food',
          y: 90,
          text: 'Food  ',
          xValue: null,
          pointColor: Colors.green),
      ChartSampleData(
          x: 'Drink',
          y: 60,
          text: 'Drink  ',
          xValue: null,
          pointColor: Colors.deepOrange),
      ChartSampleData(
        x: 'Other',
        y: 64,
        text: 'Other  ',
        xValue: null,
        pointColor: Colors.blue,
      ),
    ];
    final List<RadialBarSeries<ChartSampleData, String>> list =
        <RadialBarSeries<ChartSampleData, String>>[
      RadialBarSeries<ChartSampleData, String>(
          animationDuration: 0,
          maximumValue: 100,
          radius: '100%',
          gap: '16%',
          innerRadius: '50%',
          dataSource: chartData,
          cornerStyle: CornerStyle.bothCurve,
          trackColor: theme.background,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: MyTextStyle.bodyMedium(
                fontWeight: 600,
              )))
    ];
    return list;
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

class PolylineModel {
  PolylineModel(this.points);

  final List<MapLatLng> points;
}

class SplineAreaData {
  SplineAreaData(this.year, this.y1, this.y2, this.y3);

  final double year;
  final double y1;
  final double y2;
  final double y3;
}
