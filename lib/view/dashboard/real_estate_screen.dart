import 'package:fldc/controller/dashboard/real_estate_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_list_extension.dart';
import 'package:fldc/helpers/widgets/my_progress_bar.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/images.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class RealEstateScreen extends StatefulWidget {
  const RealEstateScreen({super.key});

  @override
  State<RealEstateScreen> createState() => _RealEstateScreenState();
}

class _RealEstateScreenState extends State<RealEstateScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late RealEstateController controller;

  @override
  void initState() {
    controller = Get.put(RealEstateController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'real_estate_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Dashboard",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Real Estate'),
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
                    MyFlexItem(
                        sizes: 'lg-3 md-6 sm-6',
                        child: realEstateStatistics(
                            "Properties for sale",
                            LucideIcons.wallet,
                            "238",
                            .4,
                            LucideIcons.trending_up,
                            "-20%")),
                    MyFlexItem(
                        sizes: 'lg-3 md-6 sm-6',
                        child: realEstateStatistics(
                            "Properties for Rent",
                            LucideIcons.shapes,
                            "174",
                            .7,
                            LucideIcons.trending_down,
                            "-10%")),
                    MyFlexItem(
                        sizes: 'lg-3 md-6 sm-6',
                        child: realEstateStatistics(
                            "Total Customer",
                            LucideIcons.users,
                            "1480",
                            .8,
                            LucideIcons.trending_up,
                            "-39%")),
                    MyFlexItem(
                        sizes: 'lg-3 md-6 sm-6',
                        child: realEstateStatistics(
                            "Total City",
                            LucideIcons.building_2,
                            "60",
                            .5,
                            LucideIcons.trending_down,
                            "-14%")),
                    MyFlexItem(sizes: 'lg-8.5 md-6', child: revenueOverView()),
                    MyFlexItem(sizes: 'lg-3.5 md-6', child: newProperties()),
                    MyFlexItem(sizes: 'lg-5 md-6', child: areaMap()),
                    MyFlexItem(sizes: 'lg-7 md-6', child: recentTransaction()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget revenueOverView() {
    return MyContainer(
      borderRadiusAll: 12,
      paddingAll: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.nBottom(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: MyText.titleMedium("Revenue Overview",
                        fontWeight: 600, overflow: TextOverflow.ellipsis)),
                PopupMenuButton<RevenueOverView>(
                  onSelected: controller.onSelectRevenueOverViewTime,
                  itemBuilder: (BuildContext context) {
                    return RevenueOverView.values.map((unit) {
                      return PopupMenuItem<RevenueOverView>(
                        value: unit,
                        height: 32,
                        child: MyText.bodySmall(
                            unit.toString().split('.').last.capitalize!,
                            color: theme.colorScheme.onSurface,
                            fontWeight: 600),
                      );
                    }).toList();
                  },
                  color: theme.cardTheme.color,
                  child: MyContainer.bordered(
                    padding: MySpacing.xy(8, 4),
                    borderRadiusAll: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyText.bodyMedium(
                            controller.revenueOverView
                                .toString()
                                .split('.')
                                .last
                                .capitalize!,
                            color: theme.colorScheme.onSurface,
                            fontWeight: 600),
                        MySpacing.width(4),
                        Icon(LucideIcons.chevron_down,
                            size: 22, color: theme.colorScheme.onSurface),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 376,
            child: Padding(
              padding: MySpacing.all(16),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: controller.chart,
                axes: <ChartAxis>[
                  NumericAxis(
                      numberFormat: NumberFormat.compact(),
                      majorGridLines: const MajorGridLines(width: 0),
                      opposedPosition: true,
                      name: 'yAxis1',
                      interval: 1000,
                      minimum: 0,
                      maximum: 7000)
                ],
                series: [
                  ColumnSeries<ChartSampleData, String>(
                      animationDuration: 2000,
                      width: 0.5,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4)),
                      color: contentTheme.primary,
                      dataSource: controller.chartData,
                      xValueMapper: (ChartSampleData data, _) => data.x,
                      yValueMapper: (ChartSampleData data, _) => data.y,
                      name: 'Unit Sold'),
                  LineSeries<ChartSampleData, String>(
                      animationDuration: 4500,
                      animationDelay: 2000,
                      dataSource: controller.chartData,
                      xValueMapper: (ChartSampleData data, _) => data.x,
                      yValueMapper: (ChartSampleData data, _) => data.yValue,
                      yAxisName: 'yAxis1',
                      markerSettings: const MarkerSettings(isVisible: true),
                      name: 'Total Transaction')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget realEstateStatistics(
      String title,
      IconData icon,
      String propertiesCount,
      double progressBar,
      IconData percentageIcon,
      String propertiesPercentage) {
    return MyContainer(
      borderRadiusAll: 12,
      paddingAll: 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: MyText.titleMedium(title,
                      fontWeight: 600, overflow: TextOverflow.ellipsis)),
              MyContainer(
                paddingAll: 12,
                borderRadiusAll: 8,
                color: contentTheme.primary.withOpacity(.2),
                child: Icon(icon, size: 20, color: contentTheme.primary),
              )
            ],
          ),
          MyText.titleLarge(propertiesCount, fontSize: 36, fontWeight: 700),
          MySpacing.height(12),
          MyProgressBar(
              width: 400,
              progress: progressBar,
              height: 8,
              radius: 8,
              activeColor: colorScheme.primary),
          MySpacing.height(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(percentageIcon,
                      size: 18,
                      color: percentageIcon == LucideIcons.trending_up
                          ? contentTheme.success
                          : contentTheme.danger),
                  MySpacing.width(8),
                  MyText.titleMedium(propertiesPercentage,
                      fontWeight: 600,
                      color: percentageIcon == LucideIcons.trending_up
                          ? contentTheme.success
                          : contentTheme.danger),
                ],
              ),
              Expanded(
                  child: MyText.titleMedium("less than last week",
                      fontWeight: 600, overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      ),
    );
  }

  Widget newProperties() {
    Widget newPropertiesWidget(String image, String title, String detail) {
      return Row(
        children: [
          MyContainer(
            height: 70,
            width: 100,
            paddingAll: 0,
            clipBehavior: Clip.antiAlias,
            borderRadiusAll: 8,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(12),
          Expanded(
            child: SizedBox(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodyMedium(title,
                      fontWeight: 600, overflow: TextOverflow.ellipsis),
                  MyText.bodyMedium(detail,
                      fontWeight: 600, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          )
        ],
      );
    }

    return MyContainer(
      borderRadiusAll: 12,
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: MyText.titleMedium("New Properties",
                      fontWeight: 600, overflow: TextOverflow.ellipsis)),
              MyText.bodyMedium("All Properties", fontWeight: 600)
            ],
          ),
          MySpacing.height(24),
          newPropertiesWidget(
              Images.landscape[0], "\$23,600", "3434 Green Rd."),
          MySpacing.height(20),
          newPropertiesWidget(
              Images.landscape[1], "\$45,300", "2344 E. Pecan St."),
          MySpacing.height(20),
          newPropertiesWidget(
              Images.landscape[2], "\$40,000", "3421 People Dr."),
          MySpacing.height(20),
          newPropertiesWidget(Images.landscape[3], "\$36,770", "4343 Red Rd."),
        ],
      ),
    );
  }

  Widget areaMap() {
    return MyContainer(
      paddingAll: 24,
      borderRadiusAll: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Area Map", fontWeight: 600),
          MySpacing.height(24),
          SizedBox(height: 380, child: map()),
        ],
      ),
    );
  }

  Widget map() {
    if (controller.dataSource == null) {
      return MyContainer();
    }

    return SfMaps(
      layers: [
        MapShapeLayer(
          source: controller.dataSource!,
          sublayers: [
            MapPolylineLayer(
              polylines: List<MapPolyline>.generate(
                controller.polylines.length,
                (int index) {
                  return MapPolyline(
                      points: controller.polylines[index].points,
                      color: Colors.transparent,
                      onTap: () {});
                },
              ).toSet(),
            ),
          ],
          zoomPanBehavior: controller.zoomPanBehavior,
        ),
      ],
    );
  }

  Widget recentTransaction() {
    return MyContainer(
      borderRadiusAll: 12,
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Recent Transaction", fontWeight: 600),
          MySpacing.height(24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: MyContainer.none(
              borderRadiusAll: 4,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: DataTable(
                  sortAscending: true,
                  onSelectAll: (_) => {},
                  headingRowColor: WidgetStatePropertyAll(
                      contentTheme.primary.withAlpha(40)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  dataRowMaxHeight: 80,
                  showBottomBorder: false,
                  columns: [
                    DataColumn(
                        label:
                            MyText.labelLarge('', color: contentTheme.primary)),
                    DataColumn(
                        label: MyText.labelLarge('Date',
                            color: contentTheme.primary)),
                    DataColumn(
                        label: MyText.labelLarge('Name',
                            color: contentTheme.primary)),
                    DataColumn(
                        label: MyText.labelLarge('Price',
                            color: contentTheme.primary)),
                    DataColumn(
                        label: MyText.labelLarge('Type',
                            color: contentTheme.primary)),
                    DataColumn(
                        label: MyText.labelLarge('Status',
                            color: contentTheme.primary)),
                  ],
                  rows: controller.recentTransaction
                      .mapIndexed((index, data) => DataRow(cells: [
                            DataCell(MyContainer(
                              height: 60,
                              width: 90,
                              borderRadiusAll: 8,
                              paddingAll: 0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.asset(
                                  Images.avatars[index % Images.avatars.length],
                                  fit: BoxFit.cover),
                            )),
                            DataCell(SizedBox(
                                width: 130,
                                child: MyText.bodyMedium('${data['date']}'))),
                            DataCell(SizedBox(
                                width: 100,
                                child: MyText.bodyMedium('${data['name']}'))),
                            DataCell(SizedBox(
                                width: 80,
                                child:
                                    MyText.bodyMedium('\$${data['price']}'))),
                            DataCell(SizedBox(
                                width: 80,
                                child: MyText.bodyMedium('${data['type']}'))),
                            DataCell(SizedBox(
                                width: 80,
                                child: MyText.bodyMedium('${data['status']}'))),
                          ]))
                      .toList()),
            ),
          )
        ],
      ),
    );
  }
}
