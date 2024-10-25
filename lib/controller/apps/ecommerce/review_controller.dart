import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/widgets/my_text_utils.dart';
import 'package:fldc/images.dart';

class ReviewController extends MyController {
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));
  List review = [
    {
      "name": "Adrien Roy",
      "rating": 3.4,
      "image": Images.avatars[0],
      "time": "joined 18, Sep 2022"
    },
    {
      "name": "Sonia",
      "rating": 2.6,
      "image": Images.avatars[1],
      "time": "joined 28, Sep 2022"
    },
    {
      "name": "William",
      "rating": 2.9,
      "image": Images.avatars[2],
      "time": "joined 18, Sep 2022"
    },
    {
      "name": "James",
      "rating": 3.6,
      "image": Images.avatars[3],
      "time": "joined 16, Sep 2022"
    },
    {
      "name": "Deo",
      "rating": 1.7,
      "image": Images.avatars[4],
      "time": "joined 15, Sep 2022"
    },
  ];
}
