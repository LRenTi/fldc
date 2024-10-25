import 'package:appflowy_board/appflowy_board.dart';
import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/images.dart';
import 'package:flutter/material.dart';

class KanBanBoardController extends MyController {
  final AppFlowyBoardController boardData = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );
  late AppFlowyBoardScrollController boardController;

  @override
  void onInit() {
    super.onInit();
    final group1 = AppFlowyGroupData(
      id: "To Do",
      items: [
        TextItem("18 jul 2021", "ios App home page", "Meat combo",
            Images.avatars[0]),
        TextItem("18 jul 2021", "Top Nav Layout Design", "Donica",
            Images.avatars[1]),
        TextItem("15 jul 2021", "Invite user to a project", "Kevina",
            Images.avatars[2]),
      ],
      name: 'To Do',
    );
    final group2 = AppFlowyGroupData(
      id: "In Progress",
      items: [
        TextItem(
            "15 jun 2020", "Write A release note", "Jamey", Images.avatars[3]),
        TextItem("15 jun 2020", "Enable analytics tracking", "Ivor",
            Images.avatars[4]),
      ],
      name: 'In Progress',
    );

    final group3 = AppFlowyGroupData(
      id: "Done",
      items: [
        TextItem(
            "5 Aug 2018", "KanBan Board Design", "Linoel", Images.avatars[5]),
        TextItem("9 Aug 2018", "Code HTML emial Template", "Skye",
            Images.avatars[6]),
        TextItem("10 Aug 2018", "Brand Logo Design", "Luce", Images.avatars[7]),
        TextItem("16 Aug 2018", "Improve animation loader", "Adina",
            Images.avatars[8]),
      ],
      name: 'Review',
    );

    final group4 = AppFlowyGroupData(
      id: "Wait",
      items: [
        TextItem("16 Jul 2021", "DashBoard Design", "Jeno", Images.avatars[9]),
      ],
      name: 'Done',
    );

    boardData.addGroup(group1);
    boardData.addGroup(group2);
    boardData.addGroup(group3);
    boardData.addGroup(group4);
  }
}

class TextItem extends AppFlowyGroupItem {
  final String date, title, name, image;

  TextItem(this.date, this.title, this.name, this.image);

  @override
  String get id => title;
}
