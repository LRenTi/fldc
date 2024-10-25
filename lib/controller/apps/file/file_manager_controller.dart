import 'package:colorful_iconify_flutter/icons/flat_color_icons.dart';
import 'package:colorful_iconify_flutter/icons/fxemoji.dart';
import 'package:colorful_iconify_flutter/icons/vscode_icons.dart';
import 'package:fldc/controller/my_controller.dart';

class FileManagerController extends MyController {
  List recentFil = [
    {
      "image": FlatColorIcons.opened_folder,
      "file_name": "Folder",
      "file_size": 1340000000,
    },
    {
      "image": VscodeIcons.file_type_word,
      "file_name": "Video",
      "file_size": 125000000000,
    },
    {
      "image": VscodeIcons.file_type_sketch,
      "file_name": "Sketch",
      "file_size": 109125000,
    },
    {
      "image": VscodeIcons.file_type_video,
      "file_name": "Video",
      "file_size": 250000000000,
    },
    {
      "image": Fxemoji.documentwithpicture,
      "file_name": "Image",
      "file_size": 445000000,
    },
    {
      "image": FlatColorIcons.opened_folder,
      "file_name": "Folder",
      "file_size": 1350000000,
    },
    {
      "image": VscodeIcons.file_type_video,
      "file_name": "Video",
      "file_size": 375000000000,
    },
    {
      "image": VscodeIcons.file_type_pdf2,
      "file_name": "Pdf",
      "file_size": 63375000,
    },
  ];
}
