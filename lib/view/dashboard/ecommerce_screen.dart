import 'package:fldc/controller/dashboard/ecommerce_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/utils/utils.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_list_extension.dart';
import 'package:fldc/helpers/widgets/my_progress_bar.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_star_rating.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/images.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EcommerceScreen extends StatefulWidget {
  const EcommerceScreen({super.key});

  @override
  State<EcommerceScreen> createState() => _EcommerceScreenState();
}

class _EcommerceScreenState extends State<EcommerceScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late EcommerceController controller = Get.put(EcommerceController());

  @override
  void initState() {
    // controller = EcommerceController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'ecommerce_dashboard_controller',
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
                        MyBreadcrumbItem(name: 'eCommerce'),
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
                      sizes: 'lg-6',
                      child: MyFlex(
                        contentPadding: false,
                        children: [
                          MyFlexItem(
                              sizes: 'lg-6 md-6',
                              child: stateCart(
                                  LucideIcons.shopping_cart,
                                  contentTheme.primary,
                                  "Total Order",
                                  "11275",
                                  "Increased by +1.34")),
                          MyFlexItem(
                              sizes: 'lg-6 md-6',
                              child: stateCart(
                                  LucideIcons.luggage,
                                  contentTheme.secondary,
                                  "Total Sales",
                                  "\$1783",
                                  "Decreased by -1.34")),
                          MyFlexItem(
                              sizes: 'lg-6 md-6',
                              child: stateCart(
                                  LucideIcons.user,
                                  contentTheme.success,
                                  "Total Visitors",
                                  "365238",
                                  "Increased by +1.34")),
                          MyFlexItem(
                              sizes: 'lg-6 md-6',
                              child: stateCart(
                                  LucideIcons.circle_dollar_sign,
                                  contentTheme.info,
                                  "Total Income",
                                  "\$12543",
                                  "Increased by +1.34")),
                          MyFlexItem(
                              sizes: 'lg-6 md-6',
                              child: stateCart(
                                  LucideIcons.receipt,
                                  contentTheme.danger,
                                  "Total Expenses",
                                  "\$22540",
                                  "Decreased by -1.34")),
                          MyFlexItem(
                              sizes: 'lg-6 md-6',
                              child: stateCart(
                                  LucideIcons.heart,
                                  contentTheme.warning,
                                  "Total Products",
                                  "1387",
                                  "Increased by +1.34")),
                        ],
                      ),
                    ),
                    MyFlexItem(
                        sizes: 'lg-6',
                        child: _buildAxisCrossingBaseValueSample()),
                    MyFlexItem(sizes: 'lg-3 md-6', child: customerService()),
                    MyFlexItem(
                        sizes: 'lg-3 md-6', child: topCountriesBySales()),
                    MyFlexItem(sizes: 'lg-3 md-6', child: topSellingProduct()),
                    MyFlexItem(sizes: 'lg-3 md-6', child: customerReview()),
                    MyFlexItem(child: productOrder()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget topSellingProduct() {
    Widget productData(String image, productName, cartCount) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 38,
            width: 38,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium(productName, fontWeight: 600),
              // buildReviewStar(iconSize: 16),
              MyStarRating(
                rating: 4.5,
              )
            ],
          ),
          Spacer(),
          MyText.bodyMedium(cartCount, fontWeight: 600),
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      padding: MySpacing.only(left: 23, top: 19, bottom: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Top Selling Products", fontWeight: 600),
          MySpacing.height(14),
          productData(Images.product[0], 'Jacket', '268'),
          MySpacing.height(12),
          productData(Images.product[1], 'Dress', '853'),
          MySpacing.height(12),
          productData(Images.product[2], 'Kurtis', '624'),
          MySpacing.height(12),
          productData(Images.product[3], 'Dress', '486'),
          MySpacing.height(12),
          productData(Images.product[4], 'Couple Dress', '574'),
          MySpacing.height(12),
          productData(Images.product[5], 'Top', '897'),
          MySpacing.height(12),
          productData(Images.product[1], 'Shirt', '856'),
          MySpacing.height(12),
          productData(Images.product[0], 'Pant', '345'),
        ],
      ),
    );
  }

  Widget topCountriesBySales() {
    Widget buildData(String image, name, count) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 43,
            width: 43,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(12),
          Expanded(
              child: MyText.bodyMedium(name,
                  fontWeight: 600, overflow: TextOverflow.ellipsis)),
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
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: MyText.titleMedium("Top Countries By Sales",
                      fontWeight: 600, overflow: TextOverflow.ellipsis)),
              MyContainer(
                  height: 32, width: 32, paddingAll: 0, child: buildPopUpMenu())
            ],
          ),
          MySpacing.height(16),
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

  Widget customerReview() {
    Widget reviews(String title, percentage, double progress, Color color) {
      return Row(
        children: [
          MyText.bodyMedium(title, fontWeight: 600),
          MySpacing.width(16),
          Expanded(
            child: MyProgressBar(
              height: 8,
              progress: progress,
              radius: 8,
              activeColor: color,
              inactiveColor: color.withAlpha(32),
            ),
          ),
          MySpacing.width(16),
          MyText.bodyMedium(percentage, fontWeight: 600),
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      borderRadiusAll: 8,
      padding: MySpacing.only(left: 23, top: 20, bottom: 20, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Customer Reviews", fontWeight: 600),
          MySpacing.height(20),
          MyContainer.bordered(
              height: 90, borderRadiusAll: 8, child: buildReviewStar()),
          MySpacing.height(16),
          Center(
              child:
                  MyText.bodyMedium("(4.5 Rating out of 5)", fontWeight: 600)),
          MySpacing.height(16),
          reviews("5 Star", '50 %', 1.5, contentTheme.primary),
          MySpacing.height(16),
          reviews("4 Star", '40 %', 1, contentTheme.success),
          MySpacing.height(16),
          reviews("3 Star", '30 %', .5, contentTheme.info),
          MySpacing.height(16),
          reviews("2 Star", '20 %', .2, contentTheme.warning),
          MySpacing.height(16),
          reviews("1 Star", '10 %', .1, contentTheme.danger),
          MySpacing.height(20),
          MyText.titleMedium("Total 700+ Review", fontWeight: 600),
          MySpacing.height(20),
          MyButton.block(
            onPressed: () {},
            backgroundColor: contentTheme.primary,
            elevation: 0,
            padding: MySpacing.xy(8, 16),
            borderRadiusAll: 8,
            child: MyText.bodyMedium(
              "See all Customer Reviews",
              fontWeight: 600,
              color: contentTheme.onPrimary,
            ),
          )
        ],
      ),
    );
  }

  Widget buildReviewStar({double? iconSize = 20}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (double i = 0; i < 5; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                controller.initialRating = i;
              });
            },
            child: i <= controller.initialRating
                ? Icon(
                    Icons.star,
                    color: AppColors.star,
                    size: iconSize,
                  )
                : Icon(
                    Icons.star_outline,
                    color: AppColors.star,
                    size: iconSize,
                  ),
          ),
      ],
    );
  }

  Widget productOrder() {
    return MyCard(
      borderRadiusAll: 8,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      paddingAll: 23,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Product Order", fontWeight: 600),
          MySpacing.height(20),
          if (controller.order.isNotEmpty)
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
                      'Order Id',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Customer Name',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Location',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Order Date',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Payments',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Quantity',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Price',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Total Amount',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Status',
                      color: contentTheme.primary,
                    )),
                  ],
                  rows: controller.order
                      .mapIndexed((index, data) => DataRow(cells: [
                            DataCell(SizedBox(
                              width: 150,
                              child: MyText.bodyMedium("#${data.orderId}",
                                  fontWeight: 600),
                            )),
                            DataCell(SizedBox(
                              width: 150,
                              child: MyText.bodyMedium(data.customerName,
                                  fontWeight: 600),
                            )),
                            DataCell(SizedBox(
                                width: 130,
                                child: MyText.bodyMedium(data.location,
                                    fontWeight: 600))),
                            DataCell(SizedBox(
                              width: 130,
                              child: MyText.bodyMedium(
                                  "${Utils.getDateStringFromDateTime(data.orderDate)}",
                                  fontWeight: 600),
                            )),
                            DataCell(SizedBox(
                                width: 100,
                                child: MyText.bodyMedium(data.payment,
                                    fontWeight: 600))),
                            DataCell(SizedBox(
                              width: 100,
                              child: MyText.bodyMedium("${data.quantity}",
                                  fontWeight: 600),
                            )),
                            DataCell(SizedBox(
                              width: 100,
                              child: MyText.bodyMedium("\$${data.price}",
                                  fontWeight: 600),
                            )),
                            DataCell(SizedBox(
                              width: 100,
                              child: MyText.bodyMedium(
                                  "\$${data.quantity * data.price}",
                                  fontWeight: 600),
                            )),
                            DataCell(MyContainer(
                              padding: MySpacing.xy(8, 4),
                              color: getStatusColor(data.status)?.withAlpha(32),
                              child: MyText.bodySmall(
                                data.status,
                                fontWeight: 600,
                                color: getStatusColor(data.status),
                              ),
                            )),
                          ]))
                      .toList()),
            ),
        ],
      ),
    );
  }

  Color? getStatusColor(String? status) {
    switch (status) {
      case "Delivered":
        return contentTheme.primary;
      case "Shopping":
        return contentTheme.success;
      case "New":
        return contentTheme.warning;
      case "Pending":
        return contentTheme.danger;
      default:
        return null;
    }
  }

  Widget customerService() {
    Widget customerData(String avatar, name, email, number) {
      return Row(
        children: [
          MyContainer.rounded(
            height: 40,
            width: 40,
            paddingAll: 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(avatar, fit: BoxFit.cover),
          ),
          MySpacing.width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(name,
                    fontWeight: 600,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                MyText.bodySmall(email,
                    fontWeight: 600, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          MyText.bodyMedium(numberFormatter('$number'), fontWeight: 600),
        ],
      );
    }

    return MyCard(
      borderRadiusAll: 8,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Customer Services", fontWeight: 600),
          MySpacing.height(12),
          MyText.bodyMedium("28 % of the goal reached (\$25k)",
              fontWeight: 600, maxLines: 1, overflow: TextOverflow.ellipsis),
          MySpacing.height(12),
          MyProgressBar(
              width: 400,
              progress: 0.3,
              height: 8,
              radius: 8,
              inactiveColor: theme.dividerColor,
              activeColor: colorScheme.primary),
          MySpacing.height(12),
          Row(
            children: [
              Icon(LucideIcons.calendar, size: 16),
              MySpacing.width(8),
              MyText.bodyMedium("This Month: \$${numberFormatter('13040')}",
                  fontWeight: 600, muted: true)
            ],
          ),
          MySpacing.height(12),
          MyText.titleMedium("Top Customer", fontWeight: 600),
          MySpacing.height(12),
          customerData(
              Images.avatars[1], "Josephine", "josephine@gmail.com", '\$12435'),
          Divider(height: 20),
          customerData(Images.avatars[2], "Andrew Cron", "andrewcron@gmail.com",
              '\$15980'),
          Divider(height: 20),
          customerData(Images.avatars[3], "Jordi Hilbert",
              "jordihilbert@gmail.com", '\$11450'),
          Divider(height: 20),
          customerData(
              Images.avatars[4], "Evie Spencer", "evie@gmail.com", '\$12435'),
          Divider(height: 20),
          customerData(Images.avatars[5], "Effie Boehm",
              "effieboehm264@gmail.com", '\$9000'),
        ],
      ),
    );
  }

  Widget _buildAxisCrossingBaseValueSample() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
      borderRadiusAll: 8,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Population growth rate of countries",
              fontWeight: 600),
          MySpacing.height(12),
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                labelIntersectAction: AxisLabelIntersectAction.wrap,
                crossesAt: controller.crossAt,
                placeLabelsNearAxisLine: false),
            primaryYAxis: const NumericAxis(
                axisLine: AxisLine(width: 0),
                minimum: -2,
                maximum: 1500,
                majorTickLines: MajorTickLines(size: 0)),
            series: controller.getSeries(),
            tooltipBehavior: controller.tooltipBehavior,
          ),
        ],
      ),
    );
  }

  Widget stateCart(
      IconData icon, Color color, String valueName, totalValue, stateValue) {
    return MyCard(
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      borderRadiusAll: 8,
      paddingAll: 23,
      child: Row(
        children: [
          MyContainer(
            height: 70,
            width: 70,
            paddingAll: 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: color.withAlpha(36),
            borderRadiusAll: 8,
            child: Icon(icon, color: color),
          ),
          MySpacing.width(20),
          Expanded(
            child: SizedBox(
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodyMedium(valueName,
                      fontWeight: 600, overflow: TextOverflow.ellipsis),
                  MyText.bodyLarge(numberFormatter('$totalValue'),
                      fontWeight: 600, overflow: TextOverflow.ellipsis),
                  MyText.bodySmall(stateValue,
                      fontWeight: 600, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
