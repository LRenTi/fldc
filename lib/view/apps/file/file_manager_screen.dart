import 'package:colorful_iconify_flutter/icons/flat_color_icons.dart';
import 'package:fldc/controller/apps/file/file_manager_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/utils/utils.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_progress_bar.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class FileManagerScreen extends StatefulWidget {
  const FileManagerScreen({super.key});

  @override
  State<FileManagerScreen> createState() => _FileManagerScreenState();
}

class _FileManagerScreenState extends State<FileManagerScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late FileManagerController controller;

  @override
  void initState() {
    controller = FileManagerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'file_manager_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "File",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'File Manager'),
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
                      sizes: 'lg-9',
                      child: MyFlex(
                        contentPadding: false,
                        children: [
                          MyFlexItem(
                              child: MyText.titleMedium("Directory File",
                                  fontWeight: 600)),
                          MyFlexItem(
                              sizes: 'lg-4 md-6',
                              child: directory(
                                  "Photo Pantie", "100 Files", "2 GB Used")),
                          MyFlexItem(
                              sizes: 'lg-4 md-6',
                              child: directory(
                                  "Personal Images", "60 Files", "12 GB Used")),
                          MyFlexItem(
                              sizes: 'lg-4 md-6',
                              child: directory(
                                  "Foto Pantai", "20 Files", "1.45 GB Used")),
                          MyFlexItem(
                              sizes: 'lg-4 md-6',
                              child:
                                  directory("Movies", "40 Files", "1 TB Used")),
                          MyFlexItem(
                              sizes: 'lg-4 md-6',
                              child: directory(
                                  "My Documents", "400 Files", "7 GB Used")),
                          MyFlexItem(
                              sizes: 'lg-4 md-6',
                              child: directory(
                                  "My Images", "350 Files", "9 GB Used")),
                          MyFlexItem(child: fileTypes()),
                        ],
                      ),
                    ),
                    MyFlexItem(sizes: 'lg-3', child: myCloud()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget fileTypes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.titleMedium("File Types", fontWeight: 600),
        MySpacing.height(16),
        GridView.builder(
          itemCount: controller.recentFil.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 350,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: 170,
          ),
          itemBuilder: (_, index) {
            var file = controller.recentFil[index];
            return MyCard(
              borderRadiusAll: 8,
              paddingAll: 0,
              shadow:
                  MyShadow(elevation: .5, position: MyShadowPosition.bottom),
              child: Padding(
                padding: MySpacing.y(12),
                child: Column(
                  children: [
                    Iconify(file['image'], size: 70),
                    MySpacing.height(12),
                    Center(
                        child: MyText.bodyLarge(file['file_name'],
                            fontWeight: 600)),
                    Divider(height: 28),
                    MyText.bodyMedium(
                        "File Size : ${Utils.getStorageStringFromByte(file['file_size'])}",
                        fontWeight: 600)
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget myCloud() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        storage(),
        MySpacing.height(20),
        storageDetail(),
      ],
    );
  }

  Widget storageDetail() {
    Widget details(IconData icon, Color iconColor, String fileName, folderFile,
        folderSize, double process) {
      return MyCard(
        borderRadiusAll: 8,
        paddingAll: 23,
        shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MyContainer(
                  height: 44,
                  width: 44,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadiusAll: 6,
                  color: iconColor.withAlpha(36),
                  paddingAll: 0,
                  child: Icon(icon, color: iconColor),
                ),
                MySpacing.width(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium(fileName, fontWeight: 600),
                    MyText.bodySmall("${folderFile} File",
                        fontWeight: 600, muted: true),
                  ],
                ),
                Spacer(),
                MyText.bodyMedium(folderSize, fontWeight: 700),
              ],
            ),
            MySpacing.height(22),
            MyProgressBar(
                width: 500,
                progress: process,
                height: 7,
                radius: 4,
                inactiveColor: theme.dividerColor,
                activeColor: iconColor),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.titleMedium("Detail Storage", fontWeight: 600),
        MySpacing.height(12),
        details(LucideIcons.file, contentTheme.primary, "Document", "112",
            "1 GB", .6),
        MySpacing.height(12),
        details(LucideIcons.image, contentTheme.secondary, "Image", "186",
            "1 TB", .3),
        MySpacing.height(12),
        details(LucideIcons.circle_play, contentTheme.info, "Video", "157",
            "23 GB", .5),
        MySpacing.height(12),
        details(LucideIcons.badge_info, contentTheme.success, "Other", "147",
            "12 GB", .4),
      ],
    );
  }

  Widget storage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.titleMedium("Storage", fontWeight: 600),
        MySpacing.height(20),
        MyContainer(
          color: contentTheme.primary.withOpacity(.05),
          borderRadiusAll: 8,
          paddingAll: 23,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.database, color: contentTheme.primary),
                  MySpacing.width(8),
                  MyText.bodyMedium("Disc A",
                      fontWeight: 700, color: contentTheme.primary),
                  Spacer(),
                  MyText.bodyMedium("300 GB",
                      fontWeight: 700, color: contentTheme.primary)
                ],
              ),
              MySpacing.height(20),
              MyText.bodySmall("Used of 250 GB", fontWeight: 600),
              MySpacing.height(12),
              MyProgressBar(
                  width: 500,
                  progress: 0.2,
                  height: 7,
                  radius: 4,
                  inactiveColor: theme.dividerColor,
                  activeColor: contentTheme.primary),
            ],
          ),
        ),
      ],
    );
  }

  Widget directory(String fileName, totalFile, uses) {
    return MyCard(
      height: 130,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Iconify(FlatColorIcons.opened_folder, size: 45),
              MySpacing.width(12),
              Expanded(
                child: MyText.bodyMedium(fileName,
                    fontWeight: 600, overflow: TextOverflow.ellipsis),
              ),
              buildPopUpMenu()
            ],
          ),
          MySpacing.height(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodyMedium(totalFile, fontWeight: 600),
              MyText.bodyMedium(uses, fontWeight: 600),
            ],
          )
        ],
      ),
    );
  }

  Widget buildPopUpMenu() {
    return PopupMenuButton(
      offset: Offset(0, 20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
            padding: MySpacing.xy(16, 8),
            height: 10,
            child: MyText.bodySmall("Refresh Report", fontWeight: 600)),
        PopupMenuItem(
            padding: MySpacing.xy(16, 8),
            height: 10,
            child: MyText.bodySmall("Export to CSV", fontWeight: 600)),
        PopupMenuItem(
            padding: MySpacing.xy(16, 8),
            height: 10,
            child: MyText.bodySmall("Export to PDF", fontWeight: 600)),
        PopupMenuItem(
            padding: MySpacing.xy(16, 8),
            height: 10,
            child: MyText.bodySmall("Share Report", fontWeight: 600)),
      ],
      child: Icon(
        LucideIcons.ellipsis_vertical,
        size: 20,
      ),
    );
  }
}
