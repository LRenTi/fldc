import 'dart:math';

import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/model/visitor_by_channels_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsController extends MyController {
  String selectedTimeDesign = "Year";
  String selectActivity = "Year";
  List<VisitorByChannelsModel> visitorByChannel = [];

  void onSelectedTimeDesign(String time) {
    selectedTimeDesign = time;
    update();
  }

  void onSelectedActivity(String time) {
    selectActivity = time;
    update();
  }

  void removeData(index) {
    visitorByChannel.removeAt(index);
    update();
  }

  @override
  void onInit() {
    VisitorByChannelsModel.dummyList.then((value) {
      visitorByChannel = value;
      update();
    });
    super.onInit();
  }

  List<ChartData> generateChartData() {
    Random random = Random();
    return List.generate(
        10,
        (index) =>
            ChartData((2012 + index), (20 + random.nextInt(20)).toDouble()));
  }

  final List<ChartSampleData> audienceOverviewChart = [
    ChartSampleData(x: 2018, y: 50, yValue: 38),
    ChartSampleData(x: 2019, y: 10, yValue: 28),
    ChartSampleData(x: 2020, y: 32, yValue: 50),
    ChartSampleData(x: 2020, y: 44, yValue: 40),
    ChartSampleData(x: 2020, y: 40, yValue: 60),
    ChartSampleData(x: 2020, y: 50, yValue: 38),
    ChartSampleData(x: 2021, y: 10, yValue: 28),
    ChartSampleData(x: 2022, y: 20, yValue: 16),
    ChartSampleData(x: 2023, y: 30, yValue: 50)
  ];
  final TooltipBehavior audienceOverview = TooltipBehavior(
      enable: true,
      format: 'point.x : point.y',
      tooltipPosition: TooltipPosition.pointer);

  final List<ChartSampleData> columnChart = <ChartSampleData>[
    ChartSampleData(x: 2010, y: 32, yValue: 50),
    ChartSampleData(x: 2011, y: 44, yValue: 40),
    ChartSampleData(x: 2012, y: 40, yValue: 60),
    ChartSampleData(x: 2013, y: 50, yValue: 38),
    ChartSampleData(x: 2014, y: 10, yValue: 28),
    ChartSampleData(x: 2015, y: 20, yValue: 16),
    ChartSampleData(x: 2016, y: 30, yValue: 50),
  ];

  final TooltipBehavior columnChartToolTip = TooltipBehavior(
      enable: true,
      format: 'point.x : point.y',
      tooltipPosition: TooltipPosition.pointer);

  final TooltipBehavior timeByLocation = TooltipBehavior(
      enable: true,
      format: 'point.x : point.y',
      tooltipPosition: TooltipPosition.pointer);
}

class CircularChartData {
  CircularChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}

class ChartData {
  ChartData(this.x, this.y);

  final int x;
  final double? y;
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
