import 'package:fldc/controller/dashboard/job_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/images.dart';
import 'package:fldc/model/popular_candidate_modal.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late JobController controller = Get.put(JobController());

  @override
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    // controller = JobController();
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
          width: 1, strokeAlign: 0, color: colorScheme.onSurface.withAlpha(80)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'job_dashboard_controller',
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
                        MyBreadcrumbItem(name: 'Job'),
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
                        sizes: 'xl-2 lg-4 md-6 sm-12',
                        child: jobStateCard(LucideIcons.users,
                            contentTheme.primary, "Total Jobs", "5678564")),
                    MyFlexItem(
                        sizes: 'xl-2 lg-4 md-6 sm-12',
                        child: jobStateCard(LucideIcons.file_input,
                            contentTheme.secondary, "Apply Jobs", "5678564")),
                    MyFlexItem(
                        sizes: 'xl-2 lg-4 md-6 sm-12',
                        child: jobStateCard(LucideIcons.user_plus,
                            contentTheme.success, "New Jobs", "5678564")),
                    MyFlexItem(
                        sizes: 'xl-2 lg-4 md-6 sm-12',
                        child: jobStateCard(LucideIcons.book_open_check,
                            contentTheme.info, "Interview", "5678564")),
                    MyFlexItem(
                        sizes: 'xl-2 lg-4 md-6 sm-12',
                        child: jobStateCard(LucideIcons.award,
                            contentTheme.warning, "Hired", "5678564")),
                    MyFlexItem(
                        sizes: 'xl-2 lg-4 md-6 sm-12',
                        child: jobStateCard(LucideIcons.git_pull_request,
                            contentTheme.danger, "Rejected", "5678564")),
                    MyFlexItem(sizes: 'lg-6 md-12', child: popularCandidate()),
                    MyFlexItem(
                        sizes: 'lg-6 md-12', child: applicationStatistic()),
                    MyFlexItem(
                        sizes: 'lg-3 md-6 sm-12', child: recentCandidate()),
                    MyFlexItem(
                        sizes: 'lg-3 md-6 sm-12', child: mostViewedCVs()),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-12', child: recentChat()),
                    MyFlexItem(
                        sizes: 'lg-3 md-6 sm-12', child: workingFormat()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget recentChat() {
    Widget chat(String image, name, message) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 44,
            width: 44,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium(name, fontWeight: 600),
              MyText.bodyMedium(message,
                  fontWeight: 600,
                  maxLines: 1,
                  muted: true,
                  overflow: TextOverflow.ellipsis),
            ],
          )),
          MySpacing.width(28),
          Icon(LucideIcons.message_square, size: 20)
        ],
      );
    }

    return MyCard(
        shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
        borderRadiusAll: 8,
        padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          MyText.titleMedium("Recent Chat", fontWeight: 600),
          MySpacing.height(20),
          chat(Images.avatars[12], "Alexandra", controller.dummyTexts[6]),
          MySpacing.height(12),
          chat(Images.avatars[11], "Amanda", controller.dummyTexts[5]),
          MySpacing.height(12),
          chat(Images.avatars[10], "Bernadette", controller.dummyTexts[4]),
          MySpacing.height(12),
          chat(Images.avatars[9], "Elizabeth", controller.dummyTexts[3]),
          MySpacing.height(12),
          chat(Images.avatars[8], "Grace", controller.dummyTexts[2]),
          MySpacing.height(12),
          chat(Images.avatars[7], "Olivia", controller.dummyTexts[1])
        ]));
  }

  Widget workingFormat() {
    return MyCard(
      borderRadiusAll: 8,
      padding: MySpacing.only(left: 23, top: 20, bottom: 4, right: 23),
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Working Format", fontWeight: 600),
          SizedBox(height: 362, child: _buildDefaultDoughnutChart())
        ],
      ),
    );
  }

  SfCircularChart _buildDefaultDoughnutChart() {
    return SfCircularChart(
      legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.bottom),
      series: _getDefaultDoughnutSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'Onsite', y: 55, text: '55%'),
      ChartSampleData(x: 'Remote', y: 31, text: '31%'),
      ChartSampleData(x: 'Hybrid', y: 20, text: '20%')
    ];
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          radius: '80%',
          explode: true,
          explodeOffset: '10%',
          dataSource: chartData,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(isVisible: true))
    ];
  }

  Widget recentCandidate() {
    Widget candidatesData(String image, title, subtitle) {
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
                MyText.bodyMedium(title, fontWeight: 600),
                MyText.bodySmall(subtitle,
                    fontWeight: 600,
                    muted: true,
                    maxLines: 1,
                    overflow: TextOverflow.visible)
              ],
            ),
          )
        ],
      );
    }

    return MyCard(
        shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
        borderRadiusAll: 8,
        padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.titleMedium("Recent Candidate", fontWeight: 600),
            MySpacing.height(20),
            candidatesData(
                Images.avatars[3], "Nicholas Bell", controller.dummyTexts[0]),
            MySpacing.height(12),
            candidatesData(
                Images.avatars[4], "Audrey Hughes", controller.dummyTexts[1]),
            MySpacing.height(12),
            candidatesData(
                Images.avatars[5], "Jack Mathis", controller.dummyTexts[2]),
            MySpacing.height(12),
            candidatesData(
                Images.avatars[6], "Lillian Walker", controller.dummyTexts[3]),
            MySpacing.height(12),
            candidatesData(
                Images.avatars[7], "Joanne Lewis", controller.dummyTexts[4]),
            MySpacing.height(12),
            candidatesData(
                Images.avatars[8], "Amanda Turner", controller.dummyTexts[5]),
          ],
        ));
  }

  Widget mostViewedCVs() {
    Widget cv(String title) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 44,
            width: 44,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: contentTheme.primary.withAlpha(40),
            child: Icon(LucideIcons.file_text, color: contentTheme.primary),
          ),
          MySpacing.width(12),
          Expanded(
              child: MyText.bodyMedium(title,
                  fontWeight: 600, overflow: TextOverflow.ellipsis)),
          InkWell(onTap: () {}, child: Icon(LucideIcons.download))
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Most Viewed CV's", fontWeight: 600),
          MySpacing.height(20),
          cv("Claire Watson"),
          MySpacing.height(12),
          cv("Warren Peters"),
          MySpacing.height(12),
          cv("Evan White"),
          MySpacing.height(12),
          cv("Benjamin Manning"),
          MySpacing.height(12),
          cv("Nicholas Bell"),
          MySpacing.height(12),
          cv("Audrey Hughes"),
        ],
      ),
    );
  }

  Widget applicationStatistic() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Application Statistic", fontWeight: 600),
          MySpacing.height(20),
          SizedBox(
            height: 292,
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
                ColumnSeries<ChartSampleData, dynamic>(
                    animationDuration: 2000,
                    width: 0.5,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    color: contentTheme.primary,
                    dataSource: controller.chartData(),
                    xValueMapper: (ChartSampleData data, _) => data.x,
                    yValueMapper: (ChartSampleData data, _) => data.y,
                    name: 'Unit Sold'),
                LineSeries<ChartSampleData, dynamic>(
                    animationDuration: 4500,
                    animationDelay: 2000,
                    dataSource: controller.chartData(),
                    xValueMapper: (ChartSampleData data, _) => data.x,
                    yValueMapper: (ChartSampleData data, _) => data.yValue,
                    yAxisName: 'yAxis1',
                    markerSettings: const MarkerSettings(isVisible: true),
                    name: 'Total Transaction')
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget popularCandidate() {
    Widget socialMedia(IconData icon, Color color) {
      return MyContainer(
        height: 32,
        width: 32,
        paddingAll: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: color.withAlpha(32),
        child: Icon(icon, color: color, size: 16),
      );
    }

    return MyCard(
      borderRadiusAll: 8,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Popular Candidate", fontWeight: 600),
          MySpacing.height(12),
          SizedBox(
            height: 300,
            child: MyFlex(
              contentPadding: false,
              children: [
                MyFlexItem(
                    sizes: 'lg-6 md-6 sm-6 xs-6',
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: controller.onSearchCandidate,
                          controller: controller.searchController,
                          style: MyTextStyle.bodySmall(fontWeight: 600),
                          decoration: InputDecoration(
                              border: outlineInputBorder,
                              enabledBorder: outlineInputBorder,
                              disabledBorder: outlineInputBorder,
                              hintText: "Search Candidate",
                              hintStyle: MyTextStyle.bodySmall(fontWeight: 700),
                              isDense: true,
                              contentPadding: MySpacing.xy(12, 16),
                              prefixIcon: Icon(LucideIcons.search)),
                        ),
                        MySpacing.height(12),
                        SizedBox(
                          height: 250,
                          child: ListView.separated(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shrinkWrap: true,
                              itemCount: controller.searchCandidate.length,
                              itemBuilder: (context, index) {
                                PopularCandidateModal candidate =
                                    controller.searchCandidate[index];
                                return MyButton(
                                  padding: MySpacing.xy(12, 16),
                                  borderRadiusAll: 8,
                                  backgroundColor:
                                      theme.colorScheme.surface.withAlpha(5),
                                  splashColor:
                                      theme.colorScheme.onSurface.withAlpha(10),
                                  onPressed: () =>
                                      controller.onChangeCandidate(candidate),
                                  child: Row(
                                    children: [
                                      MyContainer.rounded(
                                        height: 32,
                                        width: 32,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        paddingAll: 0,
                                        child: Image.asset(
                                          candidate.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      MySpacing.width(12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText.bodyMedium(candidate.name,
                                              fontWeight: 600,
                                              overflow: TextOverflow.ellipsis),
                                          MyText.bodySmall(candidate.userId,
                                              fontWeight: 600, xMuted: true)
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return MySpacing.height(8);
                              }),
                        ),
                      ],
                    )),
                MyFlexItem(
                    sizes: 'lg-6 md-6 sm-6 xs-6',
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.selectCandidate != null)
                          MyContainer.rounded(
                            height: 100,
                            width: 100,
                            paddingAll: 0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.asset(
                                controller.selectCandidate!.image,
                                fit: BoxFit.cover),
                          ),
                        MySpacing.height(12),
                        if (controller.selectCandidate != null)
                          MyText.bodyMedium(controller.selectCandidate!.name,
                              fontWeight: 600),
                        MySpacing.height(8),
                        if (controller.selectCandidate != null)
                          MyText.bodyMedium(controller.selectCandidate!.userId,
                              fontWeight: 600),
                        MySpacing.height(12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            socialMedia(
                                LucideIcons.facebook, Colors.blueAccent),
                            MySpacing.width(8),
                            socialMedia(LucideIcons.instagram, Colors.red),
                            MySpacing.width(8),
                            socialMedia(LucideIcons.linkedin, Colors.blue),
                            MySpacing.width(8),
                            socialMedia(
                                LucideIcons.dribbble, Colors.deepOrange),
                          ],
                        ),
                        MySpacing.height(20),
                        MyButton.block(
                            elevation: 0,
                            backgroundColor: contentTheme.primary,
                            onPressed: () => controller.onChangeFollowToggle(),
                            borderRadiusAll: 8,
                            padding: MySpacing.xy(12, 20),
                            child: MyText.bodyMedium(
                              controller.followToggle ? "Follow" : "Unfollow",
                              fontWeight: 600,
                              color: contentTheme.onPrimary,
                            ))
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget jobStateCard(IconData icon, Color color, String title, amount) {
    return MyCard(
      height: 95,
      paddingAll: 0,
      borderRadiusAll: 8,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      child: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          Positioned(
              bottom: -8,
              right: -8,
              child: Transform.rotate(
                angle: 5.7,
                child: Icon(
                  icon,
                  size: 60,
                  color: color.withAlpha(32),
                ),
              )),
          Positioned(
            top: 23,
            left: 23,
            bottom: 23,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyContainer(
                  paddingAll: 0,
                  height: 54,
                  width: 54,
                  color: color.withAlpha(32),
                  borderRadiusAll: 8,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Icon(icon, color: color),
                ),
                MySpacing.width(20),
                SizedBox(
                  height: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.titleMedium(title, fontWeight: 600),
                      MyText.bodyMedium(amount, fontWeight: 600),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
