import 'package:fldc/controller/apps/contact/member_list_controller.dart';
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
import 'package:fldc/model/contact_model.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({super.key});

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller = Get.put(MemberListController());

  @override
  void initState() {
    // controller = MemberListController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'member_list_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Contact",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Member List'),
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
                    MyFlexItem(child: contactList()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget contactList() {
    return GridView.builder(
      itemCount: controller.contact.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 380,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 255,
      ),
      itemBuilder: (context, index) {
        ContactModel contact = controller.contact[index];
        return MyCard(
          paddingAll: 0,
          borderRadiusAll: 8,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.nBottom(16),
                child: Center(
                  child: MyContainer.rounded(
                      height: 100,
                      width: 100,
                      paddingAll: 0,
                      borderRadiusAll: 8,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(contact.image, fit: BoxFit.cover)),
                ),
              ),
              MySpacing.height(16),
              Center(
                child: MyText.bodyMedium(contact.name,
                    fontWeight: 600, overflow: TextOverflow.ellipsis),
              ),
              MySpacing.height(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.map_pin, size: 16),
                  MySpacing.width(8),
                  MyText.bodySmall(contact.city, fontWeight: 600, muted: true),
                ],
              ),
              Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyContainer(
                    paddingAll: 0,
                    height: 32,
                    width: 32,
                    onTap: () {},
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: contentTheme.success.withAlpha(32),
                    child: Icon(LucideIcons.phone_call,
                        color: contentTheme.success, size: 16),
                  ),
                  MyContainer(
                    paddingAll: 0,
                    height: 32,
                    width: 32,
                    onTap: () {},
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: contentTheme.secondary.withAlpha(32),
                    child: Icon(LucideIcons.message_square,
                        color: contentTheme.secondary, size: 16),
                  ),
                  MyContainer(
                    color: contentTheme.primary.withAlpha(32),
                    paddingAll: 0,
                    height: 32,
                    width: 32,
                    onTap: () {},
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Icon(LucideIcons.mail,
                        size: 16, color: contentTheme.primary),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
