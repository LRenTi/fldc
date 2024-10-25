import 'package:fldc/controller/my_controller.dart';
import 'package:flutter/material.dart';

class ToastMessageController extends MyController {
  final TickerProvider ticker;
  late AnimationController animationController =
  AnimationController(vsync: ticker, duration: Duration(seconds: 20));

  ToastMessageController(this.ticker);
}
