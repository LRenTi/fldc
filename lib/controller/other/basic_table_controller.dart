import 'dart:math';

import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/extensions/string.dart';
import 'package:fldc/helpers/widgets/my_text_utils.dart';
import 'package:fldc/model/visitor_by_channels_model.dart';
import 'package:fldc/view/other/basic_table_screen.dart';
import 'package:flutter/material.dart';

class BasicTableController extends MyController {
  List<Data> datas = Data.factory();
  DataTableSource? data;
  List<VisitorByChannelsModel> visitorByChannel = [];

  @override
  void onInit() {
    super.onInit();
    VisitorByChannelsModel.dummyList.then((value) {
      visitorByChannel = value;
      update();
    });
    data = MyData(datas);
  }

  void removeData(index) {
    visitorByChannel.removeAt(index);
    update();
  }
}

class Data {
  final int id, qty;
  final String name;
  final String code;
  final double amount;

  Data(this.id, this.qty, this.name, this.code, this.amount);

  static factory([int seeds = 30]) {
    return List.generate(
        seeds,
        (index) => Data(
            index + 1,
            Random().nextInt(100),
            MyTextUtils.getDummyText(2, withStop: false),
            MyTextUtils.getDummyText(1, withStop: false).toLowerCase(),
            (Random().nextDouble() * 100).toStringAsPrecision(2).toDouble()));
  }
}
