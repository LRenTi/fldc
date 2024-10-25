import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/widgets/my_text_utils.dart';

class JobDetailController extends MyController {
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));

  List skills = [
    "HTML",
    "CSS",
    "Js",
    "PHP",
    "Python",
    "C",
    "C++",
    "Flutter",
    "React",
    "Next",
    "Vue",
    "+"
  ];
}
