import 'package:fldc/controller/DashboardAirlineController.dart';
import 'package:fldc/controller/HomeScreenController.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/services/api.service.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardAirline extends StatefulWidget {
  const DashboardAirline({super.key});

  @override
  State<DashboardAirline> createState() => _DashboardAirlineState();
}

class _DashboardAirlineState extends State<DashboardAirline>
    with SingleTickerProviderStateMixin, UIMixin {
  late DashboardAirlineController controller = Get.put(DashboardAirlineController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
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
                          MyBreadcrumbItem(name: 'Dashboard'),
                        ],
                      ),
                    ],
                  ))
            ],
          );
        },
      ),
    );
  }
}
