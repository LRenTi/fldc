import 'package:fl_chart/fl_chart.dart';
import 'package:fldc/controller/dashboard/crm_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/utils/utils.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_dotted_line.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_list_extension.dart';
import 'package:fldc/helpers/widgets/my_progress_bar.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/images.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CRMScreen extends StatefulWidget {
  const CRMScreen({super.key});

  @override
  State<CRMScreen> createState() => _CRMScreenState();
}

class _CRMScreenState extends State<CRMScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late CRMController controller = Get.put(CRMController());

  @override
  void initState() {
    // controller = CRMController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'crm_controller',
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
                        MyBreadcrumbItem(name: 'CRM'),
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
                        sizes: 'lg-2.4 md-6',
                        child: crmStateCard(
                            "\$347M",
                            "Annual Profit",
                            LucideIcons.briefcase,
                            "5.23%",
                            contentTheme.primary)),
                    MyFlexItem(
                        sizes: 'lg-2.4 md-6',
                        child: crmStateCard(
                            "\$23,345",
                            "Daily average Income",
                            LucideIcons.wallet,
                            "5.23%",
                            contentTheme.secondary)),
                    MyFlexItem(
                        sizes: 'lg-2.4 md-6',
                        child: crmStateCard("33%", "Lead Conversation",
                            LucideIcons.radio, "5.23%", contentTheme.danger)),
                    MyFlexItem(
                        sizes: 'lg-2.4 md-6',
                        child: crmStateCard("392", "Campaign sent",
                            LucideIcons.rocket, "5.23%", contentTheme.info)),
                    MyFlexItem(
                        sizes: 'lg-2.4',
                        child: crmStateCard(
                            "12,678",
                            "Annual Deals",
                            LucideIcons.heart_handshake,
                            "7.93%",
                            contentTheme.warning)),
                    MyFlexItem(sizes: 'lg-3 md-6', child: dealType()),
                    MyFlexItem(sizes: 'lg-9 md-6', child: balanceOverView()),
                    MyFlexItem(sizes: 'lg-6', child: dealsOverView()),
                    MyFlexItem(sizes: 'lg-3 md-6', child: leadResponse()),
                    MyFlexItem(sizes: 'lg-3 md-6', child: topDeals()),
                    MyFlexItem(sizes: 'lg-3 md-6', child: openDeals()),
                    MyFlexItem(sizes: 'lg-3 md-6', child: usersActivity()),
                    MyFlexItem(sizes: 'lg-6', child: contactLeads()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget balanceOverView() {
    return MyCard(
      borderRadiusAll: 8,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      padding: MySpacing.only(left: 23, top: 20, bottom: 4, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Balance OverView", fontWeight: 600),
          MySpacing.height(20),
          SizedBox(height: 349, child: _buildDefaultLineChart()),
        ],
      ),
    );
  }

  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(
          overflowMode: LegendItemOverflowMode.scroll,
          position: LegendPosition.bottom,
          isVisible: true,
          toggleSeriesVisibility: true),
      primaryXAxis: NumericAxis(
          isVisible: true,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 2,
          majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}%',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Colors.transparent)),
      series: controller.getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        tooltipPosition: TooltipPosition.auto,
      ),
    );
  }

  Widget openDeals() {
    Widget dealsData(String image, dealsType, dealsDate, price) {
      return MyDottedLine(
        corner: MyDottedLineCorner.all(8),
        color: Colors.grey,
        child: Padding(
          padding: MySpacing.xy(12, 12),
          child: Row(
            children: [
              MyContainer(
                paddingAll: 0,
                height: 44,
                width: 44,
                borderRadiusAll: 8,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              MySpacing.width(12),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText.bodyMedium(dealsType,
                          fontWeight: 600, overflow: TextOverflow.ellipsis),
                      MyText.bodySmall("Closing deal date ${dealsDate}",
                          fontWeight: 600, overflow: TextOverflow.ellipsis)
                    ],
                  ),
                ),
              ),
              MyText.bodyMedium("\$${numberFormatter(price)}",
                  fontWeight: 600, color: contentTheme.primary),
            ],
          ),
        ),
      );
    }

    return MyCard(
      borderRadiusAll: 8,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      padding: MySpacing.all(23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Open Deals", fontWeight: 600),
          MySpacing.height(20),
          dealsData(Images.avatars[1], "SASS app workflow", "26 Jan", "678231"),
          MySpacing.height(12),
          dealsData(
              Images.avatars[2], "Create new component", "8 Fab", "184528"),
          MySpacing.height(12),
          dealsData(Images.avatars[3], "New Email Design Template", "16 March",
              "37524"),
          MySpacing.height(12),
          dealsData(Images.avatars[4], "React Developer", "12 Fab", "150"),
          MySpacing.height(12),
          dealsData(Images.avatars[5], "Modern Design", "12 Aug", "15438"),
        ],
      ),
    );
  }

  Widget usersActivity() {
    return MyCard(
      padding: MySpacing.only(left: 23, top: 20, bottom: 4, right: 23),
      borderRadiusAll: 8,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("User Activity", fontWeight: 600),
          MySpacing.height(20),
          SizedBox(height: 410, child: _buildTrackerColumnChart())
        ],
      ),
    );
  }

  SfCartesianChart _buildTrackerColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
      ),
      primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 100,
          axisLine: AxisLine(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: controller.getTracker(),
      tooltipBehavior: controller.tooltipBehavior,
    );
  }

  Widget leadResponse() {
    Widget leadData(String image, name, processRate, double progress) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 44,
            width: 44,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MyText.bodyMedium(name,
                          fontWeight: 600, overflow: TextOverflow.ellipsis),
                    ),
                    MyText.bodyMedium(processRate,
                        fontWeight: 600, overflow: TextOverflow.ellipsis),
                  ],
                ),
                MySpacing.height(8),
                MyProgressBar(
                  width: 320,
                  height: 8,
                  progress: progress,
                  radius: 8,
                  activeColor: contentTheme.primary,
                  inactiveColor: contentTheme.primary.withAlpha(32),
                )
              ],
            ),
          )
        ],
      );
    }

    return MyCard(
      borderRadiusAll: 8,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Lead Response", fontWeight: 600),
          MySpacing.height(20),
          leadData(Images.avatars[10], "Amelia	Thomson", "1.3", .3),
          MySpacing.height(15),
          leadData(Images.avatars[11], "Ian	Ferguson", "1.4", .4),
          MySpacing.height(15),
          leadData(Images.avatars[12], "Simon	Ross", "2", .8),
          MySpacing.height(15),
          leadData(Images.avatars[13], "Heather", "1.5", .5),
          MySpacing.height(15),
          leadData(Images.avatars[14], "Madeleine Simpson", "1.9", .7),
          MySpacing.height(15),
          leadData(Images.avatars[15], "Oliver Hemmings", "1", .6),
        ],
      ),
    );
  }

  Widget dealsOverView() {
    Widget buildPopUpMenu() {
      return PopupMenuButton(
        offset: Offset(0, 20),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
              padding: MySpacing.xy(16, 8),
              height: 10,
              child: MyText.bodySmall("Action", fontWeight: 600)),
          PopupMenuItem(
              padding: MySpacing.xy(16, 8),
              height: 10,
              child: MyText.bodySmall("Another Action", fontWeight: 600)),
          PopupMenuItem(
              padding: MySpacing.xy(16, 8),
              height: 10,
              child: MyText.bodySmall("Something else here", fontWeight: 600)),
        ],
        child: Icon(LucideIcons.ellipsis_vertical, size: 20),
      );
    }

    return MyCard(
      borderRadiusAll: 8,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.titleMedium("Deals OverView", fontWeight: 600),
              buildPopUpMenu(),
            ],
          ),
          MySpacing.height(20),
          if (controller.dealsOverView.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  sortAscending: true,
                  columnSpacing: 60,
                  onSelectAll: (_) => {},
                  headingRowColor: WidgetStatePropertyAll(
                      contentTheme.primary.withAlpha(40)),
                  dataRowMaxHeight: 56,
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
                      'Deal',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Amount',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Probability',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Status',
                      color: contentTheme.primary,
                    )),
                  ],
                  rows: controller.dealsOverView
                      .mapIndexed(
                        (index, data) => DataRow(
                          cells: [
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyContainer.rounded(
                                  paddingAll: 0,
                                  height: 32,
                                  width: 32,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                      Images.profile[
                                          index % Images.profile.length],
                                      fit: BoxFit.cover),
                                ),
                                MySpacing.width(12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.bodyMedium(data['name'],
                                        fontWeight: 600),
                                    MyText.bodyMedium(data['email'],
                                        fontWeight: 600),
                                  ],
                                ),
                              ],
                            )),
                            DataCell(SizedBox(
                              width: 90,
                              child: MyText.bodyMedium(
                                  "\$${numberFormatter(data['amount'])}",
                                  fontWeight: 600),
                            )),
                            DataCell(SizedBox(
                              width: 100,
                              child: MyText.bodyMedium(data['probability'],
                                  fontWeight: 600),
                            )),
                            DataCell(MyContainer(
                              padding: MySpacing.xy(8, 4),
                              color:
                                  getStatusColor(data['status'])!.withAlpha(32),
                              child: MyText.bodySmall(data['status'],
                                  color: getStatusColor(data['status']),
                                  fontWeight: 600),
                            )),
                          ],
                        ),
                      )
                      .toList()),
            ),
        ],
      ),
    );
  }

  Color? getStatusColor(String? status) {
    switch (status) {
      case "Qualified":
        return contentTheme.primary;
      case "Review":
        return contentTheme.secondary;
      case "Close Won":
        return contentTheme.warning;
      case "Closed Lost":
        return contentTheme.danger;
      default:
        return null;
    }
  }

  Widget contactLeads() {
    return MyCard(
      borderRadiusAll: 8,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Contact Leads", fontWeight: 600),
          MySpacing.height(12),
          if (controller.contactLead.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  sortAscending: true,
                  columnSpacing: 60,
                  onSelectAll: (_) => {},
                  headingRowColor: WidgetStatePropertyAll(
                      contentTheme.primary.withAlpha(40)),
                  dataRowMaxHeight: 57,
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
                      'Contact Name',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Phone Number',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Lead Score',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Location',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Created At',
                      color: contentTheme.primary,
                    )),
                  ],
                  rows: controller.contactLead
                      .mapIndexed(
                        (index, data) => DataRow(
                          cells: [
                            DataCell(Row(
                              children: [
                                MyContainer.rounded(
                                  paddingAll: 0,
                                  height: 32,
                                  width: 32,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                      Images.avatars[
                                          index % Images.avatars.length],
                                      fit: BoxFit.cover),
                                ),
                                MySpacing.width(12),
                                MyText.bodyMedium(data.contactName,
                                    fontWeight: 600),
                              ],
                            )),
                            DataCell(MyText.bodyMedium(data.number,
                                fontWeight: 600)),
                            DataCell(MyText.bodyMedium(
                                data.leadsScore.toString(),
                                fontWeight: 600)),
                            DataCell(MyText.bodyMedium(data.location,
                                fontWeight: 600)),
                            DataCell(SizedBox(
                              width: 100,
                              child: MyText.bodyMedium(
                                  "${Utils.getDateStringFromDateTime(data.createdAt)}",
                                  fontWeight: 600),
                            ))
                          ],
                        ),
                      )
                      .toList()),
            ),
        ],
      ),
    );
  }

  Widget dealType() {
    return MyCard(
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      borderRadiusAll: 8,
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Deal Type", fontWeight: 600),
          MySpacing.height(20),
          SizedBox(
            height: 300,
            child: RadarChart(
              RadarChartData(
                radarTouchData: RadarTouchData(
                  touchCallback: (FlTouchEvent event, response) {
                    if (!event.isInterestedForInteractions) {
                      controller.selectedDataSetIndex = -1;
                      return;
                    }
                    controller.selectedDataSetIndex =
                        response?.touchedSpot?.touchedDataSetIndex ?? -1;
                  },
                ),
                dataSets: controller.showingDataSets(),
                radarBackgroundColor: Colors.transparent,
                borderData: FlBorderData(show: false),
                radarBorderData: BorderSide(color: Colors.transparent),
                titlePositionPercentageOffset: 0.2,
                titleTextStyle: MyTextStyle.bodyMedium(fontSize: 12),
                getTitle: (index, angle) {
                  final usedAngle = controller.relativeAngleMode
                      ? angle + controller.angleValue
                      : controller.angleValue;
                  switch (index) {
                    case 0:
                      return RadarChartTitle(
                        text: 'Pending',
                        angle: usedAngle,
                      );
                    case 2:
                      return RadarChartTitle(
                        text: 'Loss',
                        angle: usedAngle,
                      );
                    case 1:
                      return RadarChartTitle(text: 'Won', angle: usedAngle);
                    default:
                      return RadarChartTitle(text: '');
                  }
                },
                tickCount: 1,
                ticksTextStyle: MyTextStyle.bodyMedium(fontSize: 12),
                tickBorderData: BorderSide(color: Colors.transparent),
                gridBorderData: BorderSide(
                  // color: widget.gridColor,
                  width: 2,
                ),
              ),
              swapAnimationDuration: Duration(milliseconds: 400),
            ),
          ),
          Wrap(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: controller
                .rawDataSets()
                .asMap()
                .map((index, value) {
                  final isSelected = index == controller.selectedDataSetIndex;
                  return MapEntry(
                    index,
                    GestureDetector(
                      onTap: () => controller.onSelectData(index),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(vertical: 2),
                        height: 26,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.grey : Colors.transparent,
                          borderRadius: BorderRadius.circular(46),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 6,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeInToLinear,
                              padding: EdgeInsets.all(isSelected ? 8 : 6),
                              decoration: BoxDecoration(
                                color: value.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            AnimatedDefaultTextStyle(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInToLinear,
                              style: TextStyle(
                                color: isSelected ? value.color : Colors.grey,
                              ),
                              child: Text(value.title),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
                .values
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget topDeals() {
    Widget topDealsData(String image, name, email, number) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 36,
            width: 36,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(name,
                    fontWeight: 600, overflow: TextOverflow.ellipsis),
                MyText.bodySmall(email,
                    fontWeight: 600,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          MyText.bodyMedium("\$${numberFormatter(number)}", fontWeight: 600),
        ],
      );
    }

    Widget buildPopUpMenu() {
      return PopupMenuButton(
        offset: Offset(0, 20),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
              padding: MySpacing.xy(16, 8),
              height: 10,
              child: MyText.bodySmall("Download", fontWeight: 600)),
          PopupMenuItem(
              padding: MySpacing.xy(16, 8),
              height: 10,
              child: MyText.bodySmall("Import", fontWeight: 600)),
          PopupMenuItem(
              padding: MySpacing.xy(16, 8),
              height: 10,
              child: MyText.bodySmall("Export", fontWeight: 600)),
        ],
        child: Icon(LucideIcons.ellipsis_vertical, size: 20),
      );
    }

    return MyCard(
      borderRadiusAll: 8,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.titleMedium("Top Deals", fontWeight: 600),
              buildPopUpMenu()
            ],
          ),
          MySpacing.height(20),
          topDealsData(Images.avatars[0], 'Natalie Carr',
              'nataliecarr@gmail.com', '29836'),
          Divider(height: 24),
          topDealsData(Images.avatars[1], 'Benjamin Morrison',
              'benjaminmorrison@gmail.com', '12540'),
          Divider(height: 24),
          topDealsData(Images.avatars[2], 'Michael James',
              'michaeljames@gmail.com', '11000'),
          Divider(height: 24),
          topDealsData(Images.avatars[3], 'Alexandra Poole',
              'alexandrapoole@gmail.com', '5632'),
          Divider(height: 24),
          topDealsData(Images.avatars[4], 'Blake Roberts',
              'blakeboberts@gmail.com', '13980'),
          Divider(height: 24),
          topDealsData(
              Images.avatars[5], 'Vonne Baker', 'vonnebaker@gmai.com', '15320'),
        ],
      ),
    );
  }

  Widget crmStateCard(
      String amount, title, IconData icon, String rate, Color color) {
    return MyCard(
      height: 130,
      borderRadiusAll: 8,
      paddingAll: 23,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodyMedium(amount, fontWeight: 600),
                      MyText.bodySmall(title,
                          fontWeight: 600, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
              MyContainer(
                  paddingAll: 0,
                  height: 54,
                  width: 54,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadiusAll: 8,
                  color: color.withAlpha(32),
                  child: Icon(icon, color: color))
            ],
          ),
          Row(
            children: [
              MyContainer(
                color: contentTheme.success.withAlpha(32),
                padding: MySpacing.xy(8, 4),
                child: MyText.bodySmall(rate,
                    fontWeight: 600, color: contentTheme.success),
              ),
              MySpacing.width(4),
              Expanded(
                child: MyText.bodySmall("vs last month",
                    fontWeight: 600,
                    muted: true,
                    overflow: TextOverflow.ellipsis),
              )
            ],
          ),
        ],
      ),
    );
  }
}
