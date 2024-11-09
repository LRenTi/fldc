import 'package:fldc/controller/HomeScreenController.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:fldc/widgets/Cards.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    super.initState();
  }

  bool isTestEnvironment() {
    final Uri currentUri = Uri.base;
    if(currentUri.host == 'lrenti.github.io/webfldc') {
      print('Test Environment active: ${currentUri.host}');
      return true;
    }
    else {
      print('Test Environment inactive: ${currentUri.host}');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Padding(
            padding: MySpacing.x(flexSpacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Welcome to FlyLat DataCenter",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Home'),
                      ],
                    ),
                  ],
                ),
                MySpacing.height(flexSpacing),
                MyFlex(
                  children: [
                    if (isTestEnvironment())
                      MyFlexItem(
                        sizes: "lg-6 md-6",
                        child: MyCard(
                          shadow: MyShadow(
                              elevation: 0.5,
                              position: MyShadowPosition.bottom),
                          borderRadiusAll: 8,
                          paddingAll: 23,
                          color: Colors.redAccent,
                          child: Column(
                            children: [
                              Text(
                                "In Development!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              MySpacing.height(flexSpacing),
                              Text(
                                "This application is still in a very early Stage. If you have any problems or suggestion please contact me.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    MyFlexItem(
                      sizes: "lg-3 md-6",
                      child: CardOpenExternal(
                        title: "Discord",
                        description:
                            "Connect with us on the Avian Air Discord server!",
                        icon: FontAwesomeIcons.discord,
                        color: Color(0xFF7289da),
                        url: "https://discord.gg/jzNMHWDNmF",
                      ),
                    ),
                    MyFlexItem(
                      sizes: "lg-3 md-6",
                      child: CardOpenExternal(
                        title: "flyLat",
                        description:
                            "Visit FlyLat website for more information.",
                        icon: FontAwesomeIcons.planeDeparture,
                        color: Color(0xFF375a7f),
                        url: "https://flylat.net/",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
