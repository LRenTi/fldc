import 'dart:async';

import 'package:fldc/controller/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _ChartData {
  _ChartData(this.x, this.y, this.y2);

  final double x;
  final double y;
  final double y2;
}

class NFTController extends MyController {
  late TooltipBehavior tooltipBehavior;

  int selectedAnimatedCarousel = 0, animatedCarouselSize = 3;
  final PageController animatedPageController = PageController(initialPage: 0);

  void onChangeAnimatedCarousel(int value) {
    selectedAnimatedCarousel = value;
    update();
  }

  Timer? timerAnimation;

  @override
  void onInit() {
    super.onInit();
    timerAnimation = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (selectedAnimatedCarousel < animatedCarouselSize - 1) {
        selectedAnimatedCarousel++;
      } else {
        selectedAnimatedCarousel = 0;
      }

      if(animatedPageController.hasClients) {
        animatedPageController.animateToPage(selectedAnimatedCarousel,
            duration: Duration(seconds: 1), curve: Curves.ease);
        update();
      }
    });
    tooltipBehavior = TooltipBehavior(enable: true, header: '');
  }

  @override
  void dispose() {
    timerAnimation?.cancel();
    animatedPageController.dispose();
    super.dispose();
  }

  List<LineSeries<_ChartData, num>> getDefaultLineSeries() {
    final List<_ChartData> chartData = <_ChartData>[
      _ChartData(2005, 21, 28),
      _ChartData(2006, 24, 44),
      _ChartData(2007, 36, 48),
      _ChartData(2008, 38, 50),
      _ChartData(2009, 54, 66),
      _ChartData(2011, 40, 78),
      _ChartData(2012, 36, 43),
      _ChartData(2013, 27, 37),
      _ChartData(2014, 77, 52),
      _ChartData(2015, 20, 44),
      _ChartData(2016, 70, 84)
    ];
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          width: 2,
          name: 'Ethereum',
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData,
          width: 2,
          name: 'Bitcoin',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }

  List trendingNFT = [
    {
      "name": "Starter Sense NFT",
      "nftId": "@startersense678",
      "rank": "1",
      "volume": "2.56",
      "24h": "10.5",
      "7d": "3.4",
      "floor_price": "2.45",
      "item": "13.5k",
    },
    {
      "name": "Lorem Kekkei NFT",
      "nftId": "@loremkekkei746",
      "rank": "2",
      "volume": "3.36",
      "24h": "9.5",
      "7d": "7.8",
      "floor_price": "3.25",
      "item": "12.5k",
    },
    {
      "name": "Chiharu NFT",
      "nftId": "@Chiharu345",
      "rank": "3",
      "volume": "3.98",
      "24h": "12.4",
      "7d": "4.3",
      "floor_price": "6.89",
      "item": "12.9k",
    },
    {
      "name": "Creative Filtered NFT",
      "nftId": "@creative357",
      "rank": "4",
      "volume": "4.32",
      "24h": "20.5",
      "7d": "4.88",
      "floor_price": "5.43",
      "item": "17.2k",
    },
    {
      "name": "Robotic Body NFT",
      "nftId": "@roboticbody957",
      "rank": "5",
      "volume": "23.56",
      "24h": "23.3",
      "7d": "75.4",
      "floor_price": "23.4",
      "item": "65.3k",
    }
  ];
}
