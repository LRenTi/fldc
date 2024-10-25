import 'package:fldc/controller/dashboard/food_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/model/food_data.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late FoodController controller;

  @override
  void initState() {
    controller = Get.put(FoodController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'food_dashboard_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        MyBreadcrumbItem(name: 'Food'),
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
                    buildOverView(
                        'Total Monthly Earning',
                        LucideIcons.coins,
                        contentTheme.primary,
                        '12.95%',
                        '\$45K',
                        LucideIcons.chevron_down),
                    buildOverView(
                        'Daily Sales',
                        LucideIcons.badge_dollar_sign,
                        contentTheme.success,
                        '2.46%',
                        '\$1547',
                        LucideIcons.chevron_up),
                    buildOverView(
                        'Total Customer',
                        LucideIcons.users,
                        contentTheme.info,
                        '6.73%',
                        '267',
                        LucideIcons.chevron_up),
                    buildOverView(
                        'New Customer',
                        LucideIcons.user_plus,
                        contentTheme.secondary,
                        '5.34%',
                        '7',
                        LucideIcons.chevron_down),
                    MyFlexItem(
                      sizes: 'lg-3 md-6',
                      child: MyCard(
                        padding: MySpacing.fromLTRB(24, 24, 24, 12),
                        borderRadiusAll: 12,
                        shadow: MyShadow(elevation: .5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.bodyMedium("Total Sales", fontWeight: 600),
                            SizedBox(height: 355, child: buildTotalSales()),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: 'lg-9 md-6',
                      child: MyCard(
                        paddingAll: 24,
                        borderRadiusAll: 12,
                        shadow: MyShadow(elevation: .5),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText.bodyMedium("Summary", fontWeight: 600),
                                PopupMenuButton<TimeUnit>(
                                  onSelected: controller.onSelectedOrderRequest,
                                  itemBuilder: (BuildContext context) {
                                    return TimeUnit.values.map((unit) {
                                      return PopupMenuItem<TimeUnit>(
                                        value: unit,
                                        height: 32,
                                        child: MyText.bodySmall(
                                          unit
                                              .toString()
                                              .split('.')
                                              .last
                                              .capitalize!,
                                          color: theme.colorScheme.onSurface,
                                          fontWeight: 600,
                                        ),
                                      );
                                    }).toList();
                                  },
                                  color: theme.cardTheme.color,
                                  child: MyContainer.bordered(
                                    padding: MySpacing.xy(12, 8),
                                    borderRadiusAll: 8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        MyText.bodyMedium(
                                            controller.timeUnit
                                                .toString()
                                                .split('.')
                                                .last
                                                .capitalize!,
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: 600),
                                        MySpacing.width(4),
                                        Icon(LucideIcons.chevron_down,
                                            size: 22,
                                            color: theme.colorScheme.onSurface),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            buildSplineAreaChart(),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                        sizes: 'lg-6',
                        child: MyCard(
                          borderRadiusAll: 12,
                          paddingAll: 24,
                          shadow: MyShadow(elevation: .5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: MyText.bodyMedium(
                                        'Recent Order Request',
                                        fontWeight: 600,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  PopupMenuButton<RecentOrderRequest>(
                                    onSelected: controller.onRecentOrderRequest,
                                    itemBuilder: (BuildContext context) {
                                      return RecentOrderRequest.values
                                          .map((unit) {
                                        return PopupMenuItem<
                                            RecentOrderRequest>(
                                          value: unit,
                                          height: 32,
                                          child: MyText.bodySmall(
                                            unit
                                                .toString()
                                                .split('.')
                                                .last
                                                .capitalize!,
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: 600,
                                          ),
                                        );
                                      }).toList();
                                    },
                                    color: theme.cardTheme.color,
                                    child: MyContainer.bordered(
                                      padding: MySpacing.xy(12, 8),
                                      borderRadiusAll: 8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          MyText.bodyMedium(
                                              controller.recentOrderRequest
                                                  .toString()
                                                  .split('.')
                                                  .last
                                                  .capitalize!,
                                              color:
                                                  theme.colorScheme.onSurface,
                                              fontWeight: 600),
                                          MySpacing.width(4),
                                          Icon(LucideIcons.chevron_down,
                                              size: 22,
                                              color:
                                                  theme.colorScheme.onSurface),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              MySpacing.height(12),
                              recentOrderRequest(),
                            ],
                          ),
                        )),
                    MyFlexItem(
                        sizes: 'lg-6',
                        child: MyCard(
                          borderRadiusAll: 12,
                          paddingAll: 24,
                          shadow: MyShadow(elevation: .5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText.titleMedium('Delivery Map',
                                      fontWeight: 600),
                                  PopupMenuButton<OrderMap>(
                                    onSelected: controller.onSelectedOrderMap,
                                    itemBuilder: (BuildContext context) {
                                      return OrderMap.values.map((unit) {
                                        return PopupMenuItem<OrderMap>(
                                          value: unit,
                                          height: 32,
                                          child: MyText.bodySmall(
                                            unit
                                                .toString()
                                                .split('.')
                                                .last
                                                .capitalize!,
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: 600,
                                          ),
                                        );
                                      }).toList();
                                    },
                                    color: theme.cardTheme.color,
                                    child: MyContainer.bordered(
                                      padding: MySpacing.xy(12, 8),
                                      borderRadiusAll: 8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          MyText.bodyMedium(
                                              controller.orderMap
                                                  .toString()
                                                  .split('.')
                                                  .last
                                                  .capitalize!,
                                              color:
                                                  theme.colorScheme.onSurface,
                                              fontWeight: 600),
                                          MySpacing.width(4),
                                          Icon(LucideIcons.chevron_down,
                                              size: 22,
                                              color:
                                                  theme.colorScheme.onSurface),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              MySpacing.height(12),
                              SizedBox(
                                height: 327,
                                child: deliveryMap(),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget recentOrderRequest() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: controller.food.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        childAspectRatio: 3.9,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
      ),
      itemBuilder: (context, index) {
        Food food = controller.food[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  MyContainer(
                    borderRadiusAll: 12,
                    paddingAll: 0,
                    height: 90,
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(food.image, fit: BoxFit.cover),
                  ),
                  MySpacing.width(20),
                  Expanded(
                    child: SizedBox(
                      height: 80,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.titleMedium(food.foodName,
                              fontWeight: 600, overflow: TextOverflow.ellipsis),
                          MyText.bodyMedium("\$${food.price}",
                              fontWeight: 600, overflow: TextOverflow.ellipsis),
                          MyContainer(
                            paddingAll: 4,
                            color: food.pending == true
                                ? contentTheme.danger
                                : contentTheme.primary,
                            child: Center(
                              child: MyText.bodySmall(
                                  food.pending == true
                                      ? 'Pending'
                                      : 'Delivered',
                                  color: contentTheme.onPrimary,
                                  fontWeight: 600),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget deliveryMap() {
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

  SfCartesianChart buildSplineAreaChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
          interval: 1,
          majorGridLines: MajorGridLines(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}%',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: controller.getSplineAreaSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  SfCircularChart buildTotalSales() {
    return SfCircularChart(
      legend: Legend(
          isVisible: true,
          iconHeight: 20,
          iconWidth: 20,
          position: LegendPosition.bottom,
          textStyle: MyTextStyle.bodyMedium(fontWeight: 600),
          overflowMode: LegendItemOverflowMode.none),
      series: controller.getRadialBarSeries(),
    );
  }

  MyFlexItem buildOverView(String title, IconData icon, Color iconColor,
      String rank, String price, IconData iconUpDown) {
    return MyFlexItem(
        sizes: 'lg-3 md-6 sm-6 xs-12',
        child: MyCard(
          borderRadiusAll: 12,
          paddingAll: 24,
          shadow: MyShadow(elevation: .5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.bodyMedium(title, fontWeight: 600),
                  MyContainer(
                    paddingAll: 12,
                    borderRadiusAll: 8,
                    color: iconColor.withOpacity(.2),
                    child: Icon(icon, color: iconColor, size: 20),
                  )
                ],
              ),
              MySpacing.height(12),
              Row(
                children: [
                  Expanded(
                    child: MyText.titleLarge(price,
                        fontWeight: 700,
                        muted: true,
                        letterSpacing: .5,
                        overflow: TextOverflow.ellipsis),
                  ),
                  MySpacing.width(4),
                  Row(
                    children: [
                      Icon(iconUpDown,
                          size: 16,
                          color: iconUpDown == LucideIcons.chevron_down
                              ? contentTheme.danger
                              : contentTheme.primary),
                      MyText.bodyMedium(rank,
                          color: iconUpDown == LucideIcons.chevron_down
                              ? contentTheme.danger
                              : contentTheme.primary,
                          fontWeight: 600,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
