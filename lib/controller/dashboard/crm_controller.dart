import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/model/contact_lead_modal.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CRMController extends MyController {
  List<ContactLeadModal> contactLead = [];
  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;
  TooltipBehavior? tooltipBehavior;

  void onSelectData(index) {
    selectedDataSetIndex = index;
    update();
  }

  @override
  void onInit() {
    ContactLeadModal.dummyList.then((value) {
      contactLead = value.sublist(0, 6);
      update();
    });
    tooltipBehavior = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        header: '',
        format: 'point.y marks in point.x');

    super.onInit();
  }

  List<_ChartData> generateChartData() {
    Random random = Random();
    return List.generate(
        10,
        (index) => _ChartData(
            (2005 + index).toDouble(),
            (100 + random.nextInt(100)).toDouble(),
            (110 + random.nextInt(110).toDouble())));
  }

  List dealsOverView = [
    {
      "name": "Alexandra Ogden",
      "email": "alexandra@gmail.com",
      "amount": "890432",
      "probability": "38%",
      "status": "Qualified",
    },
    {
      "name": "Jake	Howard",
      "email": "kakehoward@gmail.com",
      "amount": "798243",
      "probability": "69%",
      "status": "Review",
    },
    {
      "name": "Ian Ferguson",
      "email": "ianferguson@gmail.com",
      "amount": "678345",
      "probability": "39%",
      "status": "Close Won",
    },
    {
      "name": "Nicholas	Pullman",
      "email": "nicholaspullman@gmail.com",
      "amount": "789345",
      "probability": "98%",
      "status": "Closed Lost",
    },
    {
      "name": "Charles Clarion",
      "email": "charlesclarion@gmail.com",
      "amount": "789345",
      "probability": "58%",
      "status": "Review",
    },
  ];

  List<ColumnSeries<ChartSampleData, String>> getTracker() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
          dataSource: trackerChart(),
          isTrackVisible: true,
          trackColor: Color.fromRGBO(198, 201, 207, 1),
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          color: Colors.teal,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'User Activity',
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.top,
              textStyle: MyTextStyle.bodyMedium()))
    ];
  }

  List<ChartSampleData> trackerChart() {
    Random random = Random();
    return List.generate(
        7,
        (index) => ChartSampleData(
            x: "Subject ${index + 1}", y: (50 + random.nextInt(40))));
  }

  List<LineSeries<_ChartData, num>> getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          dataSource: generateChartData(),
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          name: 'Germany',
          markerSettings: MarkerSettings(isVisible: true)),
      LineSeries<_ChartData, num>(
          dataSource: generateChartData(),
          name: 'England',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: MarkerSettings(isVisible: true))
    ];
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        title: 'Pending',
        color: Colors.red,
        values: [
          300,
          50,
          250,
        ],
      ),
      RawDataSet(
        title: 'Loss',
        color: Colors.cyan,
        values: [
          250,
          100,
          200,
        ],
      ),
      RawDataSet(
        title: 'Won',
        color: Colors.blue,
        values: [
          200,
          150,
          50,
        ],
      )
    ];
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.2)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }
}

class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });

  final String title;
  final Color color;
  final List<double> values;
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);

  final double x;
  final double y;
  final double y2;
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
