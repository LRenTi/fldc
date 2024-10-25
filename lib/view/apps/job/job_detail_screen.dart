import 'package:fldc/controller/apps/job/job_detail_controller.dart';
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
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/images.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({super.key});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late JobDetailController controller;

  @override
  void initState() {
    controller = JobDetailController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'job_detail_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Job",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Job Detail'),
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
                    MyFlexItem(sizes: 'lg-8 md-6', child: jobHeader()),
                    MyFlexItem(
                        sizes: 'lg-4 md-6',
                        child: Column(
                          children: [
                            MyCard(
                              shadow: MyShadow(
                                  position: MyShadowPosition.bottom,
                                  elevation: .5),
                              paddingAll: 23,
                              borderRadiusAll: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.bodyMedium("Apply Now job expired?",
                                      fontWeight: 600),
                                  MySpacing.height(12),
                                  MyText.bodySmall(controller.dummyTexts[7],
                                      fontWeight: 600,
                                      muted: true,
                                      maxLines: 4),
                                  MySpacing.height(16),
                                  MyButton.block(
                                      backgroundColor: contentTheme.primary,
                                      elevation: 0,
                                      borderRadiusAll: 8,
                                      onPressed: () {},
                                      child: MyText.bodyMedium("Apply Now",
                                          color: contentTheme.onPrimary,
                                          fontWeight: 600))
                                ],
                              ),
                            ),
                            MySpacing.height(12),
                            jobDetail(),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget jobHeader() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyContainer(
            paddingAll: 0,
            borderRadiusAll: 8,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: 190,
            width: double.infinity,
            child: Image.asset(Images.authBackground, fit: BoxFit.cover),
          ),
          MySpacing.height(12),
          MyText.titleMedium("Job Title", fontWeight: 600),
          MySpacing.height(12),
          MyContainer(
            borderRadiusAll: 8,
            width: double.infinity,
            color: contentTheme.secondary.withAlpha(32),
            child: MyText.bodyLarge("Senior Product Manager",
                color: contentTheme.secondary, fontWeight: 600),
          ),
          MySpacing.height(12),
          MyText.titleMedium("Job Description :", fontWeight: 600),
          MySpacing.height(12),
          MyText.bodyMedium(controller.dummyTexts[9],
              fontWeight: 600, maxLines: 3, muted: true),
          MySpacing.height(12),
          MyText.titleMedium("Responsibility :", fontWeight: 600),
          MySpacing.height(12),
          MyText.bodyMedium(controller.dummyTexts[8],
              maxLines: 2, fontWeight: 600, muted: true),
          MySpacing.height(12),
          MyText.bodyMedium(controller.dummyTexts[5],
              maxLines: 3, fontWeight: 600, muted: true),
          MySpacing.height(12),
          MyText.bodyMedium(controller.dummyTexts[3],
              fontWeight: 600, maxLines: 4, muted: true),
          MySpacing.height(12),
          MyText.titleMedium("Skills", fontWeight: 600),
          MySpacing.height(12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: controller.skills.map((e) {
              return MyContainer(
                onTap: () {},
                paddingAll: 12,
                borderRadiusAll: 8,
                color: contentTheme.secondary.withAlpha(32),
                child: MyText.bodySmall(e,
                    fontWeight: 700, color: contentTheme.secondary),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget jobDetail() {
    Widget detailData(String title, description) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium(title, fontWeight: 600),
          MySpacing.height(4),
          MyText.bodySmall(description, fontWeight: 600, muted: true)
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Job Detail", fontWeight: 600),
          MySpacing.height(12),
          detailData("Job Creation Date", "March 12,2021"),
          MySpacing.height(20),
          detailData("Recruitment", "March 15,2021 to March 17,2021"),
          MySpacing.height(20),
          detailData("Hiring Manager", "Bagus Fikri"),
          MySpacing.height(20),
          detailData("Department", "Design"),
          MySpacing.height(20),
          detailData("Recruitment Quota", "120"),
          MySpacing.height(20),
          detailData("job Type", "Full Time"),
          MySpacing.height(20),
          detailData("Experience", "4 Year+"),
          MySpacing.height(20),
          detailData("Location", "Canada"),
        ],
      ),
    );
  }
}
