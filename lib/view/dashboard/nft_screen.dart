import 'package:fldc/controller/dashboard/nft_controller.dart';
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
import 'package:fldc/helpers/widgets/my_list_extension.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/images.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:fldc/view/ui/carousels_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NFTScreen extends StatefulWidget {
  const NFTScreen({super.key});

  @override
  State<NFTScreen> createState() => _NFTScreenState();
}

class _NFTScreenState extends State<NFTScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late NFTController controller;

  @override
  void initState() {
    controller = NFTController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        tag: 'nft_dashboard_controller',
        init: controller,
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
                        MyBreadcrumbItem(name: 'NFT Dashboard'),
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
                        sizes: 'lg-3 md-6 sm-12',
                        child: nftStatesCard(
                            LucideIcons.album,
                            contentTheme.primary,
                            "Total Assets",
                            "354",
                            "0.25%")),
                    MyFlexItem(
                        sizes: 'lg-3 md-6 sm-12',
                        child: nftStatesCard(
                            LucideIcons.scroll,
                            contentTheme.success,
                            "Total Value",
                            "\$1,478",
                            "0.85%")),
                    MyFlexItem(
                        sizes: 'lg-3 md-6 sm-12',
                        child: nftStatesCard(
                            LucideIcons.tag,
                            contentTheme.secondary,
                            "Total Soles",
                            "953",
                            "1.35%")),
                    MyFlexItem(
                        sizes: 'lg-3 md-6 sm-12',
                        child: nftStatesCard(
                            LucideIcons.circle_dollar_sign,
                            contentTheme.info,
                            "Total Revenue",
                            "\$3,356,356",
                            "0.235%")),
                    MyFlexItem(
                        sizes: 'lg-3 md-6 sm-12',
                        child: nftCard(
                            "Color Abstract -NFT",
                            Images.nft[0],
                            Images.avatars[1],
                            "Bloom NFT",
                            "@bloom678",
                            "0.43",
                            "Last 4 days",
                            "1.23k")),
                    MyFlexItem(
                        sizes: 'lg-3 md-6 sm-12',
                        child: nftCard(
                            "Space Fluid -NFT",
                            Images.nft[1],
                            Images.avatars[2],
                            "Colors NFT",
                            "@colors678",
                            "0.15",
                            "Last 2 days",
                            "1.51k")),
                    MyFlexItem(sizes: 'lg-6', child: buildDefaultLineChart()),
                    MyFlexItem(
                        sizes: 'lg-8',
                        child: MyCard(
                          shadow: MyShadow(
                              position: MyShadowPosition.bottom, elevation: .5),
                          borderRadiusAll: 8,
                          paddingAll: 23,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText.titleMedium("Trending Auction :",
                                      fontWeight: 600),
                                  MyContainer(
                                    onTap: () {},
                                    borderRadiusAll: 8,
                                    color: contentTheme.primary.withAlpha(36),
                                    padding: MySpacing.xy(8, 8),
                                    child: MyText.bodyMedium("View All",
                                        fontWeight: 600,
                                        color: contentTheme.primary),
                                  )
                                ],
                              ),
                              MySpacing.height(23),
                              SizedBox(
                                height: 426,
                                child: ListView(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      buildTrendingAuction(
                                          Images.profile[1],
                                          "2.23k",
                                          "3 days",
                                          Images.avatars[4],
                                          'Bloom NFT',
                                          '@bloom453',
                                          'Color Abstract -NFT',
                                          '0.4%'),
                                      MySpacing.width(16),
                                      buildTrendingAuction(
                                          Images.profile[2],
                                          "1.65k",
                                          "4 days",
                                          Images.avatars[5],
                                          'Ergos NFT',
                                          '@ergos456',
                                          'Fluid Abstract -NFT',
                                          '0.32%'),
                                      MySpacing.width(16),
                                      buildTrendingAuction(
                                          Images.profile[3],
                                          "2.45k",
                                          "6 days",
                                          Images.avatars[6],
                                          'Caros NFT',
                                          '@caros465',
                                          'Space Fluid -NFT',
                                          '0.32%'),
                                      MySpacing.width(16),
                                      buildTrendingAuction(
                                          Images.profile[4],
                                          "6.45k",
                                          "2 days",
                                          Images.avatars[7],
                                          'Daron NFT',
                                          '@daron675',
                                          'Fluid Abstract -NFT',
                                          '2.22%'),
                                    ]),
                              )
                            ],
                          ),
                        )),
                    MyFlexItem(sizes: 'lg-4', child: buildFeatureCollection()),
                    MyFlexItem(child: trendingNFT()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget trendingNFT() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Trending NFT :", fontWeight: 600),
          MySpacing.height(20),
          if (controller.trendingNFT.isNotEmpty)
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
                      'Collection',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Rank',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Volume',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      '24H %',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      '7D %',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Floor Price',
                      color: contentTheme.primary,
                    )),
                    DataColumn(
                        label: MyText.labelLarge(
                      'Items',
                      color: contentTheme.primary,
                    )),
                  ],
                  rows: controller.trendingNFT
                      .mapIndexed((index, data) => DataRow(cells: [
                            DataCell(SizedBox(
                              width: 260,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  MyContainer.rounded(
                                    height: 32,
                                    width: 32,
                                    paddingAll: 0,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.asset(
                                      Images.nft[index % Images.nft.length],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  MySpacing.width(12),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium(data['name'],
                                          fontWeight: 600),
                                      MyText.bodySmall(data['nftId'],
                                          fontWeight: 600),
                                    ],
                                  )
                                ],
                              ),
                            )),
                            DataCell(SizedBox(
                              width: 150,
                              child: MyText.bodyMedium("#${data['rank']}",
                                  fontWeight: 600),
                            )),
                            DataCell(SizedBox(
                              width: 150,
                              child: MyText.bodyMedium("${data['volume']}BTC",
                                  fontWeight: 600),
                            )),
                            DataCell(SizedBox(
                              width: 150,
                              child: MyText.bodyMedium(data['24h'],
                                  fontWeight: 600),
                            )),
                            DataCell(SizedBox(
                                width: 150,
                                child: MyText.bodyMedium(data['7d'],
                                    fontWeight: 600))),
                            DataCell(SizedBox(
                              width: 150,
                              child: MyText.bodyMedium(
                                  "${data['floor_price']}BTC",
                                  fontWeight: 600),
                            )),
                            DataCell(SizedBox(
                                width: 150,
                                child: MyText.bodyMedium(data['item'],
                                    fontWeight: 600))),
                          ]))
                      .toList()),
            ),
        ],
      ),
    );
  }

  Widget buildFeatureCollection() {
    Widget collectionData(
        String image1, image2, image3, image4, avatar, name, id) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyFlex(
            contentPadding: false,
            children: [
              MyFlexItem(
                  sizes: 'lg-6 md-6 sm-6 xs-6',
                  child: MyContainer.bordered(
                      paddingAll: 0,
                      height: 165,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadiusAll: 8,
                      child: Image.asset(image1, fit: BoxFit.cover))),
              MyFlexItem(
                  sizes: 'lg-6 md-6 sm-6 xs-6',
                  child: MyContainer.bordered(
                      paddingAll: 0,
                      height: 165,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadiusAll: 8,
                      child: Image.asset(image2, fit: BoxFit.cover))),
              MyFlexItem(
                  sizes: 'lg-6 md-6 sm-6 xs-6',
                  child: MyContainer.bordered(
                      paddingAll: 0,
                      height: 165,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadiusAll: 8,
                      child: Image.asset(image3, fit: BoxFit.cover))),
              MyFlexItem(
                  sizes: 'lg-6 md-6 sm-6 xs-6',
                  child: MyContainer.bordered(
                      paddingAll: 0,
                      height: 165,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadiusAll: 8,
                      child: Image.asset(image4, fit: BoxFit.cover))),
            ],
          ),
          Divider(height: 32),
          Row(
            children: [
              MyContainer.rounded(
                paddingAll: 0,
                height: 30,
                width: 30,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  avatar,
                  fit: BoxFit.cover,
                ),
              ),
              MySpacing.width(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodyMedium(name, fontWeight: 600),
                  MyText.bodySmall(id, fontWeight: 600),
                ],
              )
            ],
          )
        ],
      );
    }

    return MyCard(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.titleMedium("Featured Collection :", fontWeight: 600),
              MyContainer(
                onTap: () {},
                borderRadiusAll: 8,
                color: contentTheme.primary.withAlpha(36),
                padding: MySpacing.xy(8, 8),
                child: MyText.bodyMedium("View All",
                    fontWeight: 600, color: contentTheme.primary),
              )
            ],
          ),
          MySpacing.height(23),
          SizedBox(
            height: 425,
            child: PageView(
              pageSnapping: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              reverse: true,
              scrollBehavior: AppScrollBehavior(),
              physics: ClampingScrollPhysics(),
              controller: controller.animatedPageController,
              onPageChanged: controller.onChangeAnimatedCarousel,
              children: <Widget>[
                collectionData(Images.nft[0], Images.nft[1], Images.nft[2],
                    Images.nft[0], Images.avatars[8], "Cimon", "@cimon678"),
                collectionData(Images.nft[3], Images.nft[4], Images.nft[0],
                    Images.nft[0], Images.avatars[6], "Json", "@json675"),
                collectionData(
                    Images.nft[1],
                    Images.nft[2],
                    Images.nft[3],
                    Images.nft[0],
                    Images.avatars[7],
                    "Melisson",
                    "@melisson345"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withAlpha(140),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }

  Widget buildTrendingAuction(
      String image, like, time, avatar, name, id, nftTitle, percentage) {
    return MyContainer.bordered(
      width: 245,
      paddingAll: 0,
      borderRadiusAll: 8,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Stack(
            children: [
              MyContainer(
                borderRadiusAll: 0,
                paddingAll: 0,
                height: 250,
                width: 250,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(image, fit: BoxFit.cover),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyContainer(
                      padding: MySpacing.xy(8, 8),
                      borderRadiusAll: 8,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LucideIcons.heart, size: 14),
                          MySpacing.width(4),
                          MyText.bodySmall(like, fontWeight: 600)
                        ],
                      ),
                    ),
                    MySpacing.height(12),
                    MyContainer(
                      padding: MySpacing.xy(8, 8),
                      borderRadiusAll: 8,
                      child: MyText.bodySmall(time, fontWeight: 600),
                    ),
                  ],
                ),
              )
            ],
          ),
          MySpacing.height(12),
          Padding(
            padding: MySpacing.nTop(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyContainer.rounded(
                      paddingAll: 0,
                      height: 36,
                      width: 36,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(avatar, fit: BoxFit.cover),
                    ),
                    MySpacing.width(12),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.bodyMedium(name, fontWeight: 600),
                          MyText.bodySmall(id, fontWeight: 600),
                        ]),
                  ],
                ),
                MySpacing.height(12),
                MyText.bodyMedium(nftTitle, fontWeight: 600),
                MySpacing.height(12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: MyText.bodyMedium("Highest", fontWeight: 600)),
                    Icon(LucideIcons.bitcoin, size: 16),
                    MySpacing.width(4),
                    MyText.bodyMedium(percentage, fontWeight: 600),
                  ],
                ),
                MySpacing.height(12),
                MyButton.block(
                    elevation: 0,
                    onPressed: () {},
                    backgroundColor: contentTheme.primary,
                    child: MyText.bodyMedium(
                      "Place Bid",
                      fontWeight: 600,
                      color: contentTheme.onPrimary,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildDefaultLineChart() {
    return MyCard(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadiusAll: 8,
      padding: MySpacing.only(left: 23, top: 20, bottom: 4, right: 23),
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Crypto Chart", fontWeight: 600),
          MySpacing.height(12),
          SizedBox(
            height: 295,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              legend: Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  position: LegendPosition.bottom),
              primaryXAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 2,
                  majorGridLines: const MajorGridLines(width: 0)),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}%',
                  axisLine: const AxisLine(width: 0),
                  majorTickLines:
                      const MajorTickLines(size: 8, color: Colors.transparent)),
              series: controller.getDefaultLineSeries(),
              tooltipBehavior: TooltipBehavior(enable: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget nftStatesCard(
      IconData icon, Color iconColor, String title, subTitle, percentage) {
    return MyCard(
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      borderRadiusAll: 8,
      paddingAll: 23,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyContainer(
            paddingAll: 0,
            height: 48,
            width: 48,
            color: iconColor.withAlpha(36),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            borderRadiusAll: 8,
            child: Icon(icon, color: iconColor),
          ),
          MySpacing.width(20),
          SizedBox(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(title,
                    fontWeight: 600, overflow: TextOverflow.ellipsis),
                MyText.bodyLarge(subTitle,
                    fontWeight: 600, overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    MyText.bodySmall(percentage, fontWeight: 600),
                    MySpacing.width(4),
                    Icon(LucideIcons.chevron_up, size: 12),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nftCard(
      String title, backgroundImage, image, name, id, highest, time, like) {
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      alignment: Alignment.bottomCenter,
      children: [
        MyCard(
          borderRadiusAll: 8,
          shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
          height: 350,
          width: double.infinity,
          paddingAll: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        MyContainer(
          borderRadiusAll: 8,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          marginAll: 23,
          color: contentTheme.background.withOpacity(.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.titleMedium(title, fontWeight: 600),
              MySpacing.height(12),
              Row(
                children: [
                  MyContainer.rounded(
                    paddingAll: 0,
                    height: 32,
                    width: 32,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  MySpacing.width(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodyMedium(name, fontWeight: 600),
                      MyText.bodySmall(id, fontWeight: 600),
                    ],
                  ),
                ],
              ),
              MySpacing.height(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 36,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.bodyMedium("Highest Bid",
                              fontWeight: 600, overflow: TextOverflow.ellipsis),
                          MyText.bodySmall("${highest} BTC",
                              fontWeight: 600, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 36,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MyText.bodyMedium("Ending-in",
                            fontWeight: 600, overflow: TextOverflow.ellipsis),
                        MyText.bodySmall(time,
                            fontWeight: 600, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
              MySpacing.height(12),
              MyButton.block(
                  elevation: 0,
                  backgroundColor: contentTheme.primary,
                  onPressed: () {},
                  child: MyText.bodyMedium(
                    "Place Bid",
                    fontWeight: 600,
                    color: contentTheme.onPrimary,
                  ))
            ],
          ),
        ),
        Positioned(
          top: 23,
          right: 23,
          child: MyContainer(
            padding: MySpacing.xy(8, 8),
            borderRadiusAll: 8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.heart, size: 14),
                MySpacing.width(4),
                MyText.bodySmall(like, fontWeight: 600)
              ],
            ),
          ),
        )
      ],
    );
  }
}
