import 'package:appflowy_board/appflowy_board.dart';
import 'package:fldc/controller/apps/kanban_board_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class KanBanBoardScreen extends StatefulWidget {
  const KanBanBoardScreen({super.key});

  @override
  State<KanBanBoardScreen> createState() => _KanBanBoardScreenState();
}

class _KanBanBoardScreenState extends State<KanBanBoardScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late KanBanBoardController controller;
  late ScrollController _controller;

  @override
  void initState() {
    controller = KanBanBoardController();
    controller.boardController = AppFlowyBoardScrollController();
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'kanban_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Kanban",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Kanban'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: AppFlowyBoard(
                  config: AppFlowyBoardConfig(
                      stretchGroupHeight: false,
                      groupBackgroundColor: contentTheme.primary.withAlpha(20)),
                  controller: controller.boardData,
                  cardBuilder: (context, group, groupItem) {
                    return AppFlowyGroupCard(
                      key: ValueKey(groupItem.id),
                      decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(8)),
                      child: buildCard(groupItem),
                    );
                  },
                  boardScrollController: controller.boardController,
                  footerBuilder: (context, columnData) {
                    return MySpacing.height(16);
                  },
                  headerBuilder: (context, columnData) {
                    return SizedBox(
                      height: 40,
                      child: ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AppFlowyGroupHeader(
                              title: MyText.bodyMedium(
                                  columnData.headerData.groupName,
                                  fontSize: 16,
                                  fontWeight: 600,
                                  muted: true),
                              margin: MySpacing.x(16),
                              height: 40);
                        },
                      ),
                    );
                  },
                  groupConstraints: BoxConstraints.tightFor(width: 400),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCard(AppFlowyGroupItem item) {
    if (item is TextItem) {
      return Padding(
        padding: MySpacing.all(23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium(item.title, fontWeight: 600),
            MySpacing.height(12),
            MyText.bodyMedium(item.date, muted: true, fontWeight: 600),
            MySpacing.height(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MyContainer.rounded(
                        paddingAll: 0,
                        height: 32,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset(item.image)),
                    MySpacing.width(8),
                    MyText.bodyMedium(item.name, fontWeight: 600),
                  ],
                ),
                MyContainer.none(
                  paddingAll: 8,
                  borderRadiusAll: 5,
                  child: PopupMenuButton(
                    offset: Offset(-150, 15),
                    position: PopupMenuPosition.under,
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                          padding: MySpacing.xy(16, 8),
                          height: 10,
                          child: Row(
                            children: [
                              Icon(LucideIcons.circle_plus, size: 20),
                              MySpacing.width(8),
                              MyText.bodySmall("Add People", fontWeight: 600)
                            ],
                          )),
                      PopupMenuItem(
                          padding: MySpacing.xy(16, 8),
                          height: 10,
                          child: Row(
                            children: [
                              Icon(LucideIcons.pencil, size: 20),
                              MySpacing.width(8),
                              MyText.bodySmall("Edit", fontWeight: 600)
                            ],
                          )),
                      PopupMenuItem(
                          padding: MySpacing.xy(16, 8),
                          height: 10,
                          child: Row(
                            children: [
                              Icon(LucideIcons.trash, size: 20),
                              MySpacing.width(8),
                              MyText.bodySmall("Delete", fontWeight: 600)
                            ],
                          )),
                      PopupMenuItem(
                          padding: MySpacing.xy(16, 8),
                          height: 10,
                          child: Row(
                            children: [
                              Icon(LucideIcons.log_out, size: 20),
                              MySpacing.width(8),
                              MyText.bodySmall("Leave", fontWeight: 600)
                            ],
                          )),
                    ],
                    child: Icon(LucideIcons.ellipsis_vertical, size: 18),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    if (item is RichTextItem) {
      return RichTextCard(item: item);
    }

    throw UnimplementedError();
  }
}

class RichTextCard extends StatefulWidget {
  final RichTextItem item;

  const RichTextCard({
    required this.item,
    super.key,
  });

  @override
  State<RichTextCard> createState() => _RichTextCardState();
}

class _RichTextCardState extends State<RichTextCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.title,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

class RichTextItem extends AppFlowyGroupItem {
  final String title;
  final String subtitle;

  RichTextItem({required this.title, required this.subtitle});

  @override
  String get id => title;
}
