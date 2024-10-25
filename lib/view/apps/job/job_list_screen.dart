import 'package:fldc/controller/apps/job/job_list_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/images.dart';
import 'package:fldc/model/job_modal.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late JobListController controller;

  @override
  void initState() {
    controller = JobListController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'job_list_controller',
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
                        MyBreadcrumbItem(name: 'Job List'),
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
                      maxCrossAxisExtent: 400,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 370),
                  shrinkWrap: true,
                  itemCount: controller.job.length,
                  itemBuilder: (context, index) {
                    JobModal job = controller.job[index];
                    return MyCard(
                      shadow: MyShadow(
                          elevation: .5, position: MyShadowPosition.bottom),
                      borderRadiusAll: 8,
                      paddingAll: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: MySpacing.all(23),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyContainer.rounded(
                                  paddingAll: 0,
                                  height: 44,
                                  width: 44,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                      Images.landscape[
                                          index % Images.landscape.length],
                                      fit: BoxFit.cover),
                                ),
                                MySpacing.height(12),
                                MyText.bodyLarge(job.jobTitle,
                                    fontWeight: 600,
                                    overflow: TextOverflow.ellipsis),
                                MySpacing.height(12),
                                MyText.bodyMedium(controller.dummyTexts[index],
                                    maxLines: 3,
                                    fontWeight: 600,
                                    muted: true,
                                    letterSpacing: 1),
                                MySpacing.height(12),
                                job.jobWork.isNotEmpty
                                    ? Wrap(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        spacing: 12,
                                        runSpacing: 12,
                                        children: job.jobWork.map((e) {
                                          return MyContainer(
                                              borderRadiusAll: 8,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              padding: MySpacing.xy(8, 8),
                                              color: getStatusColor(e)!
                                                  .withAlpha(36),
                                              child: MyText.bodySmall(e,
                                                  fontWeight: 600,
                                                  color: getStatusColor(e)));
                                        }).toList(),
                                      )
                                    : SizedBox(height: 30),
                              ],
                            ),
                          ),
                          Spacer(),
                          Divider(height: 40),
                          Padding(
                            padding: MySpacing.nTop(23),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium("\$${job.price}/h",
                                          fontWeight: 600),
                                      MyText.bodySmall(job.jobLocation,
                                          fontWeight: 600,
                                          muted: true,
                                          overflow: TextOverflow.ellipsis)
                                    ],
                                  ),
                                ),
                                MyContainer.bordered(
                                  onTap: () => controller.goToDetailScreen(),
                                  borderRadiusAll: 8,
                                  paddingAll: 8,
                                  child: MyText.bodySmall("Detail",
                                      fontWeight: 600),
                                ),
                                MySpacing.width(12),
                                MyContainer(
                                  paddingAll: 8,
                                  borderRadiusAll: 8,
                                  onTap: () {},
                                  color: contentTheme.primary,
                                  child: MyText.bodySmall("Apply Now",
                                      fontWeight: 600,
                                      color: contentTheme.onPrimary),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Color? getStatusColor(String? status) {
    switch (status) {
      case "Project Work":
        return contentTheme.primary;
      case "Shift Work":
        return contentTheme.secondary;
      case "Middle Level":
        return contentTheme.warning;
      default:
        return null;
    }
  }
}
