import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/model/product_order_modal.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EcommerceController extends MyController {
  List<ProductOrderModal> order = [];
  List<String>? axis;
  String? selectedAxisType;
  String? selectedAxis;
  double? crossAt;
  TooltipBehavior? tooltipBehavior;
  double initialRating = 3.5;

  @override
  void onInit() {
    ProductOrderModal.dummyList.then((value) {
      order = value.sublist(0, 5);
      update();
    });

    selectedAxisType = '-2 (modified)';
    selectedAxis = '-2 (modified)';
    crossAt = -2;
    axis = <String>['-2 (modified)', '100 (default)'].toList();
    tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.onInit();
  }

  List<CartesianSeries<ChartSampleData, String>> getSeries() {
    return <CartesianSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
          dataSource: <ChartSampleData>[
            ChartSampleData(
                x: 'Iceland',
                y: 1200,
                pointColor: const Color.fromRGBO(107, 189, 98, 1)),
            ChartSampleData(
                x: 'Algeria',
                y: 1000,
                pointColor: const Color.fromRGBO(107, 189, 98, 1)),
            ChartSampleData(
                x: 'Singapore',
                y: 1150,
                pointColor: const Color.fromRGBO(107, 189, 98, 1)),
            ChartSampleData(
                x: 'Malaysia',
                y: 130,
                pointColor: const Color.fromRGBO(199, 86, 86, 1)),
            ChartSampleData(
                x: 'Moldova',
                y: 1050,
                pointColor: const Color.fromRGBO(107, 189, 98, 1)),
            ChartSampleData(
                x: 'American Samoa',
                y: 100,
                pointColor: const Color.fromRGBO(199, 86, 86, 1)),
            ChartSampleData(
                x: 'Latvia',
                y: 180,
                pointColor: const Color.fromRGBO(199, 86, 86, 1))
          ],
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true, labelAlignment: ChartDataLabelAlignment.middle)),
    ];
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
