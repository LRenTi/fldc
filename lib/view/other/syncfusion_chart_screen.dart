import 'package:fldc/controller/other/syncfusion_chart_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SyncFusionChartScreen extends StatefulWidget {
  const SyncFusionChartScreen({super.key});

  @override
  State<SyncFusionChartScreen> createState() => _SyncFusionChartScreenState();
}

class _SyncFusionChartScreenState extends State<SyncFusionChartScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late SyncfusionChartController controller;

  @override
  void initState() {
    controller = SyncfusionChartController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Other", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Other'),
                        MyBreadcrumbItem(name: 'Syncfusion Chart', active: true)
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(sizes: 'lg-6', child: _buildDefaultLineChart()),
                    MyFlexItem(
                        sizes: 'lg-6', child: _buildCustomizedColumnChart()),
                    MyFlexItem(sizes: 'lg-6', child: _buildDashedSplineChart()),
                    MyFlexItem(sizes: 'lg-6', child: _buildAreaZoneChart()),
                    MyFlexItem(sizes: 'lg-6', child: _buildDefaultBarChart()),
                    MyFlexItem(
                        sizes: 'lg-6',
                        child: _buildMultipleSeriesBubbleChart()),
                    MyFlexItem(
                        sizes: 'lg-6', child: _buildShapesScatterChart()),
                    MyFlexItem(
                        sizes: 'lg-6', child: _buildDashedStepLineChart()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDashedStepLineChart() {
    return MyCard(
      borderRadiusAll: 8,
      paddingAll: 23,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(text: 'CO2 - Intensity analysis'),
        primaryXAxis: NumericAxis(
          interval: 1,
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(text: 'Year'),
        ),
        primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          minimum: 360,
          maximum: 600,
          interval: 30,
          majorTickLines: MajorTickLines(size: 0),
          title: AxisTitle(text: 'Intensity (g/kWh)'),
        ),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: controller.getDashedStepLineSeries(),
      ),
    );
  }

  Widget _buildShapesScatterChart() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(text: 'Inflation Analysis'),
        primaryXAxis: NumericAxis(
          minimum: 1945,
          maximum: 2005,
          title: AxisTitle(text: 'Year'),
          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
          majorGridLines: MajorGridLines(width: 0),
        ),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        primaryYAxis: NumericAxis(
            title: AxisTitle(text: 'Inflation Rate(%)'),
            labelFormat: '{value}%',
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(size: 0)),
        tooltipBehavior: controller.scatterTooltipBehavior,
        series: controller.getScatterShapesSeries(),
      ),
    );
  }

  Widget _buildDefaultLineChart() {
    return MyCard(
      borderRadiusAll: 8,
      paddingAll: 23,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(text: 'Inflation - Consumer price'),
        legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
            position: LegendPosition.bottom),
        primaryXAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            interval: 2,
            majorGridLines: MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}%',
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(color: Colors.transparent)),
        series: controller.getDefaultLineSeries(),
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }

  Widget _buildCustomizedColumnChart() {
    return MyCard(
      borderRadiusAll: 8,
      paddingAll: 23,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      child: SfCartesianChart(
        title: ChartTitle(text: 'PC vendor shipments - 2015 Q1'),
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}M',
            title: AxisTitle(text: 'Shipments in million'),
            majorGridLines: MajorGridLines(width: 0),
            majorTickLines: MajorTickLines(size: 0)),
        series: <CartesianSeries<ChartSampleData, String>>[
          ColumnSeries<ChartSampleData, String>(
            onCreateRenderer: (ChartSeries<ChartSampleData, String> series) {
              return _CustomColumnSeriesRenderer(ThemeData.light());
            },
            dataLabelSettings: DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.middle),
            dataSource: <ChartSampleData>[
              ChartSampleData(
                  x: 'HP Inc',
                  y: 12.54,
                  pointColor: Color.fromARGB(53, 92, 125, 1)),
              ChartSampleData(
                  x: 'Lenovo',
                  y: 13.46,
                  pointColor: Color.fromARGB(192, 108, 132, 1)),
              ChartSampleData(
                  x: 'Dell',
                  y: 9.18,
                  pointColor: Color.fromARGB(246, 114, 128, 1)),
              ChartSampleData(
                  x: 'Apple',
                  y: 4.56,
                  pointColor: Color.fromARGB(248, 177, 149, 1)),
              ChartSampleData(
                  x: 'Asus',
                  y: 5.29,
                  pointColor: Color.fromARGB(116, 180, 155, 1)),
            ],
            width: 0.8,
            xValueMapper: (ChartSampleData sales, _) => sales.x as String,
            yValueMapper: (ChartSampleData sales, _) => sales.y,
            pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
          )
        ],
        tooltipBehavior: controller.tooltipBehavior,
      ),
    );
  }

  Widget _buildDashedSplineChart() {
    return MyCard(
      borderRadiusAll: 8,
      paddingAll: 23,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(text: 'Total investment (% of GDP)'),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        primaryXAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          interval: 1,
        ),
        primaryYAxis: NumericAxis(
          minimum: 16,
          maximum: 28,
          interval: 4,
          labelFormat: '{value}%',
          axisLine: AxisLine(width: 0),
        ),
        series: controller.getDashedSplineSeries(),
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }

  Widget _buildAreaZoneChart() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double containerSize = kIsWeb
        ? 80
        : orientation == Orientation.portrait
            ? 80
            : 45;
    final double fontSize = 14 / MediaQuery.of(context).textScaler.scale(1);
    final double size = 13 / MediaQuery.of(context).textScaler.scale(1);
    return MyCard(
      borderRadiusAll: 8,
      paddingAll: 23,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        legend: Legend(position: LegendPosition.bottom),
        title: ChartTitle(text: 'Average monthly temperature of US - 2020'),
        primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}°F',
            minimum: 0,
            maximum: 90,
            interval: 30,
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(size: 0)),
        series: controller.getAreaZoneSeries(),
        tooltipBehavior: controller.areaTooltipBehavior,
        annotations: <CartesianChartAnnotation>[
          CartesianChartAnnotation(
              widget: SizedBox(
                  height: containerSize,
                  width: containerSize,
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Icon(
                          Icons.circle,
                          color: Color.fromRGBO(116, 182, 194, 1),
                          size: size,
                        ),
                        Text(
                          ' Winter',
                          style: TextStyle(fontSize: fontSize),
                        ),
                      ]),
                      Row(children: <Widget>[
                        Icon(Icons.circle,
                            color: Color.fromRGBO(75, 189, 138, 1), size: size),
                        Text(
                          ' Spring',
                          style: TextStyle(fontSize: fontSize),
                        )
                      ]),
                      Row(children: <Widget>[
                        Icon(Icons.circle,
                            color: Color.fromRGBO(255, 186, 83, 1), size: size),
                        Text(
                          ' Summer',
                          style: TextStyle(fontSize: fontSize),
                        )
                      ]),
                      Row(children: <Widget>[
                        Icon(Icons.circle,
                            color: Color.fromRGBO(194, 110, 21, 1), size: size),
                        Text(
                          ' Autumn',
                          style: TextStyle(fontSize: fontSize),
                        )
                      ]),
                    ],
                  )),
              coordinateUnit: CoordinateUnit.percentage,
              x: kIsWeb ? '95%' : '85%',
              y: kIsWeb ? '21%' : '14%')
        ],
      ),
    );
  }

  Widget _buildDefaultBarChart() {
    return MyCard(
      borderRadiusAll: 8,
      paddingAll: 23,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(text: 'Tourism - Number of arrivals'),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
            majorGridLines: const MajorGridLines(width: 0),
            numberFormat: NumberFormat.compact()),
        series: controller.getDefaultBarSeries(),
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }

  Widget _buildMultipleSeriesBubbleChart() {
    return MyCard(
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      borderRadiusAll: 8,
      paddingAll: 23,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(text: 'World countries details'),
        primaryXAxis: NumericAxis(
            majorGridLines: MajorGridLines(width: 0),
            title: AxisTitle(text: 'Literacy rate'),
            minimum: 60,
            maximum: 100),
        primaryYAxis: NumericAxis(
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(width: 0),
            title: AxisTitle(text: 'GDP growth rate')),
        series: controller.getMultipleBubbleSeries(),
        legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
            position: LegendPosition.bottom),
        tooltipBehavior: controller.bubbleTooltipBehavior,
      ),
    );
  }
}

class _CustomColumnSeriesRenderer<T, D> extends ColumnSeriesRenderer<T, D> {
  _CustomColumnSeriesRenderer(this.themeData);

  final ThemeData themeData;

  @override
  ColumnSegment<T, D> createSegment() {
    return _ColumnCustomPainter(themeData);
  }
}

class _ColumnCustomPainter<T, D> extends ColumnSegment<T, D> {
  _ColumnCustomPainter(this.themeData);

  final ThemeData themeData;

  List<Color> colorList = <Color>[
    Color.fromRGBO(53, 92, 125, 1),
    Color.fromRGBO(192, 108, 132, 1),
    Color.fromRGBO(246, 114, 128, 1),
    Color.fromRGBO(248, 177, 149, 1),
    Color.fromRGBO(116, 180, 155, 1)
  ];
  List<Color> colorListM3Light = [
    Color.fromRGBO(6, 174, 224, 1),
    Color.fromRGBO(99, 85, 199, 1),
    Color.fromRGBO(49, 90, 116, 1),
    Color.fromRGBO(255, 180, 0, 1),
    Color.fromRGBO(150, 60, 112, 1)
  ];
  List<Color> colorListM3Dark = [
    Color.fromRGBO(255, 245, 0, 1),
    Color.fromRGBO(51, 182, 119, 1),
    Color.fromRGBO(218, 150, 70, 1),
    Color.fromRGBO(201, 88, 142, 1),
    Color.fromRGBO(77, 170, 255, 1),
  ];

  @override
  Paint getFillPaint() {
    final Paint customerFillPaint = Paint();
    colorList = themeData.useMaterial3
        ? (themeData.brightness == Brightness.light
            ? colorListM3Light
            : colorListM3Dark)
        : colorList;
    customerFillPaint.isAntiAlias = false;
    customerFillPaint.color = colorList[currentSegmentIndex];
    customerFillPaint.style = PaintingStyle.fill;
    return customerFillPaint;
  }

  @override
  Paint getStrokePaint() {
    final Paint customerStrokePaint = Paint();
    customerStrokePaint.isAntiAlias = false;
    customerStrokePaint.color = Colors.transparent;
    customerStrokePaint.style = PaintingStyle.stroke;
    return customerStrokePaint;
  }

  @override
  void onPaint(Canvas canvas) {
    if (segmentRect != null) {
      double x, y;
      x = segmentRect!.center.dx;
      y = segmentRect!.top;
      double width = 0;
      double height = 20;
      width = segmentRect!.width;
      final Paint paint = Paint();
      paint.color = getFillPaint().color;
      paint.style = PaintingStyle.fill;
      final Path path = Path();
      final double factor = segmentRect!.height * (1 - animationFactor);
      path.moveTo(x - width / 2, y + factor + height);
      path.lineTo(x, (segmentRect!.top + factor + height) - height);
      path.lineTo(x + width / 2, y + factor + height);
      path.lineTo(x + width / 2, segmentRect!.bottom + factor);
      path.lineTo(x - width / 2, segmentRect!.bottom + factor);
      path.close();
      canvas.drawPath(path, paint);
    }
  }
}
