import 'package:fldc/controller/apps/chat_controller.dart';
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
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/images.dart';
import 'package:fldc/model/chat_modal.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late ChatController controller;

  @override
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    controller = ChatController();
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
          width: 1, strokeAlign: 0, color: colorScheme.onSurface.withAlpha(80)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'chat_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Chat",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Chat'),
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
                    MyFlexItem(sizes: 'lg-3 md-12', child: buildChatIndex()),
                    MyFlexItem(sizes: 'lg-6 md-12', child: buildChat()),
                    MyFlexItem(sizes: 'lg-3 md-12', child: profileDetail()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget profileDetail() {
    return MyCard(
      paddingAll: 23,
      borderRadiusAll: 8,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.selectChat != null)
            Center(
              child: MyContainer.roundBordered(
                paddingAll: 0,
                height: 100,
                width: 100,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  controller.selectChat!.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          MySpacing.height(12),
          if (controller.selectChat != null)
            Center(
              child: MyText.bodyMedium(controller.selectChat!.firstName,
                  fontWeight: 600),
            ),
          MySpacing.height(8),
          if (controller.selectChat != null)
            Center(
                child: MyText.bodyMedium(controller.selectChat!.email,
                    fontWeight: 600)),
          MySpacing.height(16),
          MyText.titleSmall("Media", fontWeight: 600),
          MySpacing.height(12),
          StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 3,
                mainAxisCellCount: 2,
                child: MyContainer(
                    borderRadiusAll: 8,
                    paddingAll: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(Images.profile[0], fit: BoxFit.cover)),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                child: MyContainer(
                    borderRadiusAll: 8,
                    paddingAll: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(Images.profile[1], fit: BoxFit.cover)),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 2,
                child: MyContainer(
                    borderRadiusAll: 8,
                    paddingAll: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(Images.profile[2], fit: BoxFit.cover)),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                child: MyContainer(
                    borderRadiusAll: 8,
                    paddingAll: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(Images.profile[3], fit: BoxFit.cover)),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 4,
                mainAxisCellCount: 2,
                child: MyContainer(
                    borderRadiusAll: 8,
                    paddingAll: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(Images.profile[4], fit: BoxFit.cover)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildChatIndex() {
    return MyCard(
      paddingAll: 23,
      borderRadiusAll: 8,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Inbox", fontWeight: 600),
          MySpacing.height(12),
          searchField(),
          MySpacing.height(12),
          MyText.bodyMedium(
            "Message (${controller.chat.length})",
            fontWeight: 600,
          ),
          MySpacing.height(12),
          SizedBox(
            height: 620,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.separated(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  itemCount: controller.searchChat.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ChatModel chat = controller.searchChat[index];
                    return MyContainer.bordered(
                      onTap: () => controller.onChangeChat(chat),
                      borderRadiusAll: 8,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyContainer.rounded(
                                paddingAll: 0,
                                height: 36,
                                width: 36,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.asset(
                                  chat.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              MySpacing.width(8),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: MyText.bodyMedium(
                                        chat.firstName,
                                        fontWeight: 600,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    MyText.bodySmall(
                                      '${Utils.getTimeStringFromDateTime(
                                        chat.messages.lastOrNull != null
                                            ? chat.messages.lastOrNull!.sendAt
                                            : DateTime.now(),
                                        showSecond: false,
                                      )}',
                                      fontWeight: 600,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          MySpacing.height(8),
                          MyText.bodySmall(
                            chat.messages.lastOrNull!.message,
                            fontWeight: 600,
                            muted: true,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return MySpacing.height(12);
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget searchField() {
    return TextFormField(
      onChanged: controller.onSearchChat,
      controller: controller.searchController,
      style: MyTextStyle.bodyMedium(),
      decoration: InputDecoration(
        hintText: "Search",
        isDense: true,
        contentPadding: MySpacing.xy(16, 12),
        filled: true,
        hintStyle: MyTextStyle.bodyMedium(),
        prefixIcon: Icon(LucideIcons.search),
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
      ),
    );
  }

  Widget buildChat() {
    return MyCard(
      paddingAll: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      borderRadiusAll: 8,
      child: Column(
        children: [
          Padding(
            padding: MySpacing.only(left: 23, right: 23, top: 22),
            child: Row(
              children: [
                if (controller.selectChat != null)
                  MyContainer.rounded(
                    height: 44,
                    width: 44,
                    paddingAll: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      controller.selectChat!.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                MySpacing.width(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.selectChat != null)
                      MyText.bodyMedium(controller.selectChat!.firstName,
                          fontWeight: 600),
                    MyText.bodySmall("Active Now", fontWeight: 600, muted: true)
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 43),
          Padding(
            padding: MySpacing.only(left: 23, right: 23, bottom: 12),
            child: SizedBox(
              height: 590,
              child: ListView.separated(
                  controller: controller.scrollController,
                  itemCount: (controller.selectChat?.messages ?? []).length,
                  itemBuilder: (context, index) {
                    final message =
                        (controller.selectChat?.messages ?? [])[index];
                    final isSent = message.fromMe == true;
                    final theme =
                        isSent ? contentTheme.primary : contentTheme.secondary;
                    return Row(
                      mainAxisAlignment: isSent
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isSent)
                          Column(
                            children: [
                              MyContainer.rounded(
                                height: 32,
                                width: 32,
                                paddingAll: 0,
                                child: Image.asset(
                                  controller.selectChat!.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              mediumHeight,
                              MyText.bodySmall(
                                '${Utils.getTimeStringFromDateTime(
                                  message.sendAt,
                                  showSecond: false,
                                )}',
                                fontSize: 8,
                                muted: true,
                                fontWeight: 600,
                              ),
                            ],
                          ),
                        MySpacing.width(12),
                        Expanded(
                          child: Wrap(
                            alignment: isSent
                                ? WrapAlignment.end
                                : WrapAlignment.start,
                            children: [
                              MyContainer(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(
                                    left: isSent
                                        ? MediaQuery.of(context).size.width *
                                            0.20
                                        : 0,
                                    right: isSent
                                        ? 0
                                        : MediaQuery.of(context).size.width *
                                            0.20,
                                  ),
                                  color: theme.withAlpha(30),
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  child: MyText.bodyMedium(
                                    message.message,
                                    fontWeight: 600,
                                    color: isSent
                                        ? contentTheme.primary
                                        : contentTheme.secondary,
                                    overflow: TextOverflow.clip,
                                  )),
                            ],
                          ),
                        ),
                        MySpacing.width(12),
                        if (controller.selectChat != null && isSent)
                          Column(
                            children: [
                              MyContainer.rounded(
                                height: 32,
                                width: 32,
                                paddingAll: 0,
                                child: Image.asset(
                                  Images.avatars[6],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              MySpacing.height(4),
                              MyText.bodySmall(
                                '${Utils.getTimeStringFromDateTime(
                                  message.sendAt,
                                  showSecond: false,
                                )}',
                                fontSize: 8,
                                muted: true,
                                fontWeight: 600,
                              ),
                            ],
                          ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return MySpacing.height(12);
                  }),
            ),
          ),
          Padding(
            padding: MySpacing.only(left: 23, right: 23, bottom: 22),
            child: sendMessage(),
          ),
        ],
      ),
    );
  }

  Widget sendMessage() {
    Widget messageOption(GestureTapCallback? onTap, IconData icon) {
      return MyContainer(
        onTap: onTap,
        paddingAll: 0,
        height: 43,
        width: 43,
        borderRadiusAll: 8,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: contentTheme.primary,
        child: Icon(icon, size: 20, color: contentTheme.onPrimary),
      );
    }

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            maxLines: 3,
            minLines: 1,
            controller: controller.messageController,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            style: MyTextStyle.bodyMedium(fontWeight: 600),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: MySpacing.xy(12, 16),
              hintText: "Send message...",
              hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
              border: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              disabledBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
            ),
          ),
        ),
        MySpacing.width(12),
        messageOption(() {}, LucideIcons.paperclip),
        MySpacing.width(12),
        messageOption(() => controller.sendMessage(), LucideIcons.send),
      ],
    );
  }
}
