import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/widgets/my_text_utils.dart';
import 'package:fldc/images.dart';
import 'package:fldc/model/product_modal.dart';
import 'package:get/get.dart';

class ProductDetailController extends MyController {
  List<ProductModal> product = [];
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));
  int isSelectedSize = 1;
  String selectedImage = Images.singleProduct[0];

  List<String> images = [
    Images.singleProduct[0],
    Images.singleProduct[1],
    Images.singleProduct[2],
    Images.singleProduct[3],
  ];

  @override
  void onInit() {
    ProductModal.dummyList.then((value) {
      product = value.sublist(0, 12);
      update();
    });
    super.onInit();
  }

  void onChangeImage(String image) {
    selectedImage = image;
    update();
  }

  void onSelectedSize(id) {
    isSelectedSize = id;
    update();
  }

  void goToProductsScreen() {
    Get.offNamed('/app/ecommerce/products_grid');
  }
}
