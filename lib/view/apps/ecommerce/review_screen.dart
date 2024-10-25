import 'package:fldc/controller/apps/ecommerce/review_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_star_rating.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late ReviewController controller;

  @override
  void initState() {
    controller = ReviewController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'review_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Ecommerce",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Review'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 600,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 280),
                  shrinkWrap: true,
                  itemCount: controller.review.length,
                  itemBuilder: (context, index) {
                    return MyCard(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shadow: MyShadow(
                          elevation: .5, position: MyShadowPosition.bottom),
                      borderRadiusAll: 8,
                      paddingAll: 0,
                      child: Column(
                        children: [
                          Padding(
                            padding: MySpacing.nBottom(23),
                            child: Row(
                              children: [
                                MyContainer.rounded(
                                  paddingAll: 0,
                                  height: 50,
                                  width: 50,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                      controller.review[index]['image'],
                                      fit: BoxFit.cover),
                                ),
                                MySpacing.width(12),
                                Expanded(
                                  child: MyText.bodyMedium(
                                      controller.review[index]['name'],
                                      fontWeight: 600),
                                ),
                                MyText.bodyMedium(
                                    controller.review[index]['time'],
                                    fontWeight: 600),
                              ],
                            ),
                          ),
                          Divider(height: 40),
                          Padding(
                            padding: MySpacing.x(23),
                            child: MyText.bodyMedium(
                              controller.dummyTexts[index],
                              fontWeight: 600,
                              muted: true,
                              maxLines: 5,
                              letterSpacing: 1,
                            ),
                          ),
                          Divider(height: 40),
                          Padding(
                            padding: MySpacing.only(left: 23, right: 23),
                            child: Row(
                              children: [
                                MyStarRating(
                                    rating: controller.review[index]['rating']),
                                MySpacing.width(4),
                                MyText.bodySmall(
                                    "(${controller.review[index]['rating']})",
                                    fontWeight: 600),
                                Spacer(),
                                Icon(LucideIcons.thumbs_up, size: 20),
                                MySpacing.width(4),
                                MyText.bodySmall("${12 - index}",
                                    fontWeight: 600),
                                MySpacing.width(12),
                                Icon(LucideIcons.message_circle, size: 20),
                                MySpacing.width(4),
                                MyText.bodySmall("Reply", fontWeight: 600),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
