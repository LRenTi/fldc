import 'dart:math';

import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/widgets/my_text_utils.dart';
import 'package:fldc/model/popular_candidate_modal.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class JobController extends MyController {
  List<PopularCandidateModal> popularCandidate = [];
  List<PopularCandidateModal> searchCandidate = [];
  PopularCandidateModal? selectCandidate;
  SearchController searchController = SearchController();
  bool followToggle = true;
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));
  int touchedIndex = -1;

  final TooltipBehavior chart = TooltipBehavior(
      enable: true,
      format: 'point.x : point.yValue1 : point.yValue2',
      tooltipPosition: TooltipPosition.pointer);

  List<ChartSampleData> chartData() {
    Random random = Random();
    return List.generate(
        7,
        (index) => ChartSampleData(
            x: (2015 + index),
            y: (50 + random.nextInt(40)),
            yValue: (2000 + random.nextInt(2000))));
  }

  void onSearchCandidate(String query) {
    final input = query.toLowerCase();
    searchCandidate = popularCandidate
        .where((candidate) =>
            candidate.name.toLowerCase().contains(input) ||
            candidate.userId.toLowerCase().contains(input))
        .toList();
    update();
  }

  void onChangeCandidate(PopularCandidateModal singleCandidate) {
    selectCandidate = singleCandidate;
    update();
  }

  void onChangeFollowToggle() {
    followToggle = !followToggle;
    update();
  }

  @override
  void onInit() {
    PopularCandidateModal.dummyList.then((value) {
      popularCandidate = value;
      searchCandidate = value;
      selectCandidate = popularCandidate[0];
      update();
    });
    super.onInit();
  }
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
