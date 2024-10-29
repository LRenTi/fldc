import 'package:fldc/controller/HomeScreenController.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late HomescreenController controller = Get.put(HomescreenController());

  @override
  void initState() {
    // controller = AnalyticsController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: const Text("Testing"),
    );
  }
}
