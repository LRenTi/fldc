import 'package:fldc/controller/dashboard/analytics_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/utils/utils.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
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
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late AnalyticsController controller = Get.put(AnalyticsController());

  @override
  void initState() {
    // controller = AnalyticsController();
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
                    MyText.titleMedium(
                      "Dashboard",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Analytics'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(children: [
                  MyFlexItem(
                      sizes: 'lg-3 md-6',
                      child: buildOverView(
                          LucideIcons.users,
                          contentTheme.primary,
                          "Visitor",
                          "3432",
                          LucideIcons.trending_up,
                          contentTheme.success,
                          '12%')),
                  MyFlexItem(
                      sizes: 'lg-3 md-6',
                      child: buildOverView(
                          LucideIcons.user,
                          Colors.purpleAccent,
                          "Unique Visitor",
                          "3432",
                          LucideIcons.trending_down,
                          contentTheme.danger,
                          '8%')),
                  MyFlexItem(
                      sizes: 'lg-3 md-6',
                      child: buildOverView(
                          LucideIcons.chart_bar,
                          Colors.blue,
                          "Avg. Visit Duration",
                          "0:02:12s",
                          LucideIcons.trending_up,
                          contentTheme.success,
                          '20%')),
                  MyFlexItem(
                      sizes: 'lg-3 md-6',
                      child: buildOverView(
                          LucideIcons.glasses,
                          Colors.brown,
                          "Pages per visit",
                          "0:02:12s",
                          LucideIcons.trending_up,
                          contentTheme.success,
                          '8%')),
                  MyFlexItem(
                      sizes: 'lg-6 md-6', child: buildActivityOnThePage()),
                  MyFlexItem(sizes: 'lg-3 md-6', child: buildTrafficSources()),
                  MyFlexItem(
                      sizes: 'lg-3 md-6', child: buildResponseTimeByLocation()),
                  MyFlexItem(sizes: 'lg-3 md-6', child: buildMostActiveUser()),
                  MyFlexItem(sizes: 'lg-3', child: buildVisitorsByCountry()),
                  MyFlexItem(sizes: 'lg-6', child: buildAudienceOverview()),
                  MyFlexItem(child: buildVisitorByChannel()),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildVisitorByChannel() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Visitors By Channel", fontWeight: 600),
          MySpacing.height(12),
          if (controller.visitorByChannel.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  sortAscending: true,
                  columnSpacing: 60,
                  onSelectAll: (_) => {},
                  headingRowColor: WidgetStatePropertyAll(
                      contentTheme.primary.withAlpha(40)),
                  dataRowMaxHeight: 60,
                  showBottomBorder: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  border: TableBorder.all(
                      borderRadius: BorderRadius.circular(8),
                      style: BorderStyle.solid,
                      width: .4,
                      color: Colors.grey),
                  columns: [
                    DataColumn(
                        label: MyText.labelLarge(
                      'S.No',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Channel',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Session',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Bounce Rate',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Session Duration',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Target Reached',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Page Per Session',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Action',
                      color: contentTheme.primary,
                    )),
                  ],
                  rows: controller.visitorByChannel
                      .mapIndexed((index, data) => DataRow(cells: [
                            DataCell(MyText.bodyMedium('${data.id}')),
                            DataCell(SizedBox(
                              width: 250,
                              child: MyText.labelLarge(
                                data.channel,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )),
                            DataCell(SizedBox(
                                width: 100,
                                child: MyText.bodySmall('${data.session}',
                                    fontWeight: 600))),
                            DataCell(SizedBox(
                              width: 100,
                              child: MyText.bodySmall('${data.bounceRate}%',
                                  fontWeight: 600),
                            )),
                            DataCell(SizedBox(
                              width: 250,
                              child: MyText.bodySmall(
                                  '${Utils.getDateTimeStringFromDateTime(data.sessionDuration)}',
                                  fontWeight: 600),
                            )),
                            DataCell(
                              MyContainer(
                                borderRadiusAll: 4,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                padding: MySpacing.xy(8, 8),
                                color: contentTheme.primary.withAlpha(32),
                                child: MyText.bodySmall(
                                  '${data.targetReached}',
                                  fontWeight: 600,
                                  color: contentTheme.primary,
                                ),
                              ),
                            ),
                            DataCell(SizedBox(
                                width: 100,
                                child: MyText.bodyMedium(
                                    '${data.pagePerSession}'))),
                            DataCell(SizedBox(
                              width: 130,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyContainer(
                                    onTap: () => {},
                                    padding: MySpacing.xy(8, 8),
                                    color: contentTheme.primary.withAlpha(36),
                                    child: Icon(
                                      LucideIcons.pencil,
                                      size: 14,
                                      color: contentTheme.primary,
                                    ),
                                  ),
                                  MyContainer(
                                    onTap: () => {},
                                    padding: MySpacing.xy(8, 8),
                                    color: contentTheme.success.withAlpha(36),
                                    child: Icon(
                                      LucideIcons.pencil,
                                      size: 14,
                                      color: contentTheme.success,
                                    ),
                                  ),
                                  MyContainer(
                                    onTap: () => controller.removeData(index),
                                    padding: MySpacing.xy(8, 8),
                                    color: contentTheme.danger.withAlpha(36),
                                    child: Icon(
                                      LucideIcons.trash_2,
                                      size: 14,
                                      color: contentTheme.danger,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ]))
                      .toList()),
            ),
        ],
      ),
    );
  }

  Widget buildVisitorsByCountry() {
    Widget buildData(String image, name, count) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 41,
            width: 41,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          MySpacing.width(12),
          Expanded(
            child: MyText.bodyMedium(name,
                fontWeight: 600, overflow: TextOverflow.ellipsis),
          ),
          MyContainer(
            borderRadiusAll: 8,
            padding: MySpacing.xy(8, 8),
            color: Colors.brown.withAlpha(36),
            child: MyText.bodySmall(
              numberFormatter(count),
              fontWeight: 600,
              color: Colors.brown,
            ),
          )
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Visitor by country's", fontWeight: 600),
          MySpacing.height(12),
          buildData(
              'assets/images/dummy/united_states.png', "United State", "41560"),
          MySpacing.height(12),
          buildData('assets/images/dummy/argentina.png', "Argentina", "18400"),
          MySpacing.height(12),
          buildData('assets/images/dummy/germany.png', "Germany", "9000"),
          MySpacing.height(12),
          buildData('assets/images/dummy/mexico.png', "Mexico", "15325"),
          MySpacing.height(12),
          buildData('assets/images/dummy/russia.png', "Russia", "12222"),
          MySpacing.height(12),
          buildData('assets/images/dummy/canada.png', "Canada", "2040"),
          MySpacing.height(12),
          buildData('assets/images/dummy/malaysia.png', "Malaysia", "7658"),
        ],
      ),
    );
  }

  Widget buildAudienceOverview() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Audience Overview", fontWeight: 600),
          MySpacing.height(12),
          SizedBox(
              height: 358,
              child: SfCartesianChart(
                  tooltipBehavior: controller.audienceOverview,
                  series: <CartesianSeries>[
                    BarSeries<ChartSampleData, dynamic>(
                        color: Colors.blue,
                        borderRadius:
                            BorderRadius.horizontal(right: Radius.circular(8)),
                        dataSource: controller.audienceOverviewChart,
                        xValueMapper: (ChartSampleData data, _) => data.x,
                        yValueMapper: (ChartSampleData data, _) => data.y,
                        width: 0.6,
                        spacing: 0.3),
                    BarSeries<ChartSampleData, dynamic>(
                        borderRadius:
                            BorderRadius.horizontal(right: Radius.circular(8)),
                        dataSource: controller.audienceOverviewChart,
                        color: Colors.teal,
                        xValueMapper: (ChartSampleData data, _) => data.x,
                        yValueMapper: (ChartSampleData data, _) => data.yValue,
                        width: 0.6,
                        spacing: 0.3)
                  ]))
        ],
      ),
    );
  }

  Widget buildTrafficSources() {
    Widget buildData(String browser, session, double process) {
      return Row(
        children: [
          Expanded(
              child: MyText.bodyMedium(browser,
                  fontWeight: 600, overflow: TextOverflow.ellipsis)),
          Expanded(
            child: Row(
              children: [
                if (session >= 5000)
                  Icon(
                    LucideIcons.trending_up,
                    size: 20,
                    color: contentTheme.success,
                  ),
                if (session < 5000)
                  Icon(
                    LucideIcons.trending_down,
                    size: 20,
                    color: contentTheme.danger,
                  ),
                MySpacing.width(8),
                Expanded(
                  child: MyText.bodyMedium("$session",
                      fontWeight: 600, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Expanded(
            child: MyProgressBar(
              progress: process,
              height: 4,
              radius: 4,
              inactiveColor: theme.dividerColor,
              activeColor: contentTheme.primary,
            ),
          ),
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 0,
      child: SizedBox(
        height: 392,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: MySpacing.only(left: 23, top: 19),
              child: MyText.titleMedium("Traffic Sources", fontWeight: 600),
            ),
            Divider(height: 30),
            Padding(
              padding: MySpacing.only(left: 23),
              child: Row(children: [
                Expanded(child: MyText.bodyMedium("Browser", fontWeight: 600)),
                Expanded(child: MyText.bodyMedium("Sessions", fontWeight: 600)),
                Expanded(child: MyText.bodyMedium("Traffic", fontWeight: 600)),
              ]),
            ),
            Divider(height: 30),
            Padding(
              padding: MySpacing.x(23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildData("Chrome", 9000, .26),
                  MySpacing.height(20),
                  buildData("Safari", 6000, .19),
                  MySpacing.height(20),
                  buildData("Opera", 3200, .1),
                  MySpacing.height(20),
                  buildData("Firefox", 5500, .24),
                  MySpacing.height(20),
                  buildData("Edge", 2000, .2),
                  MySpacing.height(20),
                  buildData("Brave", 1000, .1),
                  MySpacing.height(20),
                  buildData("Mozilla", 5340, .24),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMostActiveUser() {
    Widget buildData(String image, name, emailID) {
      return MyContainer.bordered(
        borderRadiusAll: 8,
        child: Row(
          children: [
            MyContainer.rounded(
              paddingAll: 0,
              height: 46,
              width: 46,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            MySpacing.width(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodyLarge(name, fontWeight: 600),
                  MySpacing.height(4),
                  MyText.bodyMedium(
                    emailID,
                    fontWeight: 700,
                    xMuted: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return MyCard(
        shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
        borderRadiusAll: 8,
        padding: MySpacing.only(left: 23, top: 20, bottom: 20, right: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.titleMedium("Most Active user", fontWeight: 600),
            MySpacing.height(20),
            SizedBox(
              height: 356,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildData(Images.avatars[1], "Johan", "johan@gmail.com"),
                    MySpacing.height(12),
                    buildData(Images.avatars[2], "Alexandra",
                        "alexandra12@gmail.com"),
                    MySpacing.height(12),
                    buildData(
                        Images.avatars[3], "Lillian", "lillian@gmail.com"),
                    MySpacing.height(12),
                    buildData(
                        Images.avatars[4], "Stephanie", "stephanie@gmail.com"),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildActivityOnThePage() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      padding: MySpacing.only(left: 23, right: 23, bottom: 4, top: 23),
      child: SizedBox(
        height: 347,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MyText.titleMedium("Activity on the pages",
                      fontWeight: 600, overflow: TextOverflow.ellipsis),
                ),
                PopupMenuButton(
                  onSelected: controller.onSelectedActivity,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  itemBuilder: (BuildContext context) {
                    return [
                      "Year",
                      "Month",
                      "Week",
                      "Day",
                      "Hours",
                    ].map((behavior) {
                      return PopupMenuItem(
                        value: behavior,
                        height: 32,
                        child: MyText.bodySmall(
                          behavior.toString(),
                          color: theme.colorScheme.onSurface,
                          fontWeight: 600,
                        ),
                      );
                    }).toList();
                  },
                  color: theme.cardTheme.color,
                  child: MyContainer.bordered(
                    padding: MySpacing.xy(8, 4),
                    borderRadiusAll: 8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyText.bodySmall(
                          controller.selectActivity.toString(),
                          fontWeight: 600,
                          color: theme.colorScheme.onSurface,
                        ),
                        MySpacing.width(4),
                        Icon(
                          LucideIcons.chevron_down,
                          size: 20,
                          color: theme.colorScheme.onSurface,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            MySpacing.height(12),
            SizedBox(
              height: 305,
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                primaryXAxis:
                    CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
                tooltipBehavior: controller.columnChartToolTip,
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                series: [
                  ColumnSeries<ChartSampleData, int>(
                      opacity: 0.9,
                      width: 0.6,
                      color: contentTheme.title,
                      dataSource: controller.columnChart,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8)),
                      xValueMapper: (ChartSampleData data, _) => data.x,
                      yValueMapper: (ChartSampleData data, _) => data.y,
                      dataLabelSettings: DataLabelSettings(isVisible: true)),
                  ColumnSeries<ChartSampleData, int>(
                    color: contentTheme.success,
                    dataSource: controller.columnChart,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8)),
                    xValueMapper: (ChartSampleData data, _) => data.x,
                    yValueMapper: (ChartSampleData data, _) => data.yValue,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPopUpMenu() {
    return PopupMenuButton(
      offset: Offset(0, 20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
            padding: MySpacing.xy(16, 8),
            height: 10,
            child: MyText.bodySmall("Refresh Report", fontWeight: 600)),
        PopupMenuItem(
            padding: MySpacing.xy(16, 8),
            height: 10,
            child: MyText.bodySmall("Export to CSV", fontWeight: 600)),
        PopupMenuItem(
            padding: MySpacing.xy(16, 8),
            height: 10,
            child: MyText.bodySmall("Export to PDF", fontWeight: 600)),
        PopupMenuItem(
            padding: MySpacing.xy(16, 8),
            height: 10,
            child: MyText.bodySmall("Share Report", fontWeight: 600)),
      ],
      child: Icon(
        LucideIcons.ellipsis_vertical,
        size: 20,
      ),
    );
  }

  Widget buildOverView(IconData icon, Color color, String title, subTitle,
      IconData tradIcon, Color tradColor, String per) {
    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyContainer(
                  height: 44,
                  width: 44,
                  borderRadiusAll: 8,
                  paddingAll: 0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: color.withAlpha(36),
                  child: Icon(icon, color: color),
                ),
                MySpacing.height(12),
                MyText.bodyMedium(title, muted: true, fontWeight: 700),
                MySpacing.height(12),
                MyText.bodyLarge(subTitle, fontWeight: 600, muted: true),
                MySpacing.height(12),
                Row(
                  children: [
                    Icon(tradIcon, color: tradColor, size: 20),
                    MySpacing.width(4),
                    MyText.bodyMedium(per, fontWeight: 600),
                    MySpacing.width(4),
                    Expanded(
                      child: MyText.bodyMedium("from previous month",
                          fontWeight: 600, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                )
              ],
            ),
          ),
          buildPopUpMenu()
        ],
      ),
    );
  }

  Widget buildResponseTimeByLocation() {
    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      child: SizedBox(
        height: 345,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MyText.titleMedium("Response time by location",
                      fontWeight: 600, overflow: TextOverflow.ellipsis),
                ),
                PopupMenuButton(
                  onSelected: controller.onSelectedTimeDesign,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  itemBuilder: (BuildContext context) {
                    return [
                      "Year",
                      "Month",
                      "Week",
                      "Day",
                      "Hours",
                    ].map((behavior) {
                      return PopupMenuItem(
                        value: behavior,
                        height: 32,
                        child: MyText.bodySmall(
                          behavior.toString(),
                          color: theme.colorScheme.onSurface,
                          fontWeight: 600,
                        ),
                      );
                    }).toList();
                  },
                  color: theme.cardTheme.color,
                  child: MyContainer.bordered(
                    padding: MySpacing.xy(8, 4),
                    borderRadiusAll: 8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyText.bodySmall(
                          controller.selectedTimeDesign.toString(),
                          fontWeight: 600,
                          color: theme.colorScheme.onSurface,
                        ),
                        MySpacing.width(4),
                        Icon(
                          LucideIcons.chevron_down,
                          size: 20,
                          color: theme.colorScheme.onSurface,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            MySpacing.height(12),
            SizedBox(
              height: 303,
              child: SfCircularChart(
                  tooltipBehavior: controller.timeByLocation,
                  series: <CircularSeries>[
                    PieSeries<ChartData, int>(
                        dataSource: controller.generateChartData(),
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.inside))
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
