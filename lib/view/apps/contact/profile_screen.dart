import 'package:fldc/controller/apps/contact/profile_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late ProfileController controller;
  @override
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    controller = ProfileController();
    outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'profile_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Profile",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Profile'),
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
                    MyFlexItem(
                        sizes: 'lg-6',
                        child: MyCard(
                          paddingAll: 23,
                          shadow: MyShadow(
                              elevation: .5, position: MyShadowPosition.bottom),
                          borderRadiusAll: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.titleLarge("Account Detail",
                                  fontWeight: 600),
                              MySpacing.height(16),
                              MyContainer.rounded(
                                paddingAll: 0,
                                height: 100,
                                width: 100,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.asset(Images.avatars[9],
                                    fit: BoxFit.cover),
                              ),
                              MySpacing.height(20),
                              Row(
                                children: [
                                  Expanded(
                                    child: fields("First Name", "First Name",
                                        controller.nameTE),
                                  ),
                                  MySpacing.width(16),
                                  Expanded(
                                    child: fields("Last Name", "Last Name",
                                        controller.lastNameTE),
                                  ),
                                ],
                              ),
                              MySpacing.height(12),
                              fields("Email", "Email", controller.emailTE),
                              MySpacing.height(12),
                              fields(
                                  "Address", "Address", controller.addressTE),
                              MySpacing.height(12),
                              Row(
                                children: [
                                  Expanded(
                                    child: fields(
                                        "City", "City", controller.cityTE),
                                  ),
                                  MySpacing.width(16),
                                  Expanded(
                                    child: fields(
                                        "State", "State", controller.stateTE),
                                  ),
                                ],
                              ),
                              MySpacing.height(12),
                              fields("Password", "Password",
                                  controller.passwordTE),
                              MySpacing.height(23),
                              Align(
                                alignment: Alignment.topRight,
                                child: MyContainer(
                                  paddingAll: 0,
                                  height: 44,
                                  width: 200,
                                  borderRadiusAll: 8,
                                  color: contentTheme.primary,
                                  child: Center(
                                    child: MyText.bodyMedium(
                                      "Save Changes",
                                      fontWeight: 600,
                                      color: contentTheme.onPrimary,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
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

  Widget fields(
      String? hintText, title, TextEditingController? textEditingController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodyMedium(title, fontWeight: 600),
        MySpacing.height(8),
        TextField(
          controller: textEditingController,
          decoration: InputDecoration(
              hintText: hintText,
              border: outlineInputBorder,
              disabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              filled: true),
        ),
      ],
    );
  }
}
