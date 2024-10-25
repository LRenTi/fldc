import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/widgets/my_text_utils.dart';
import 'package:fldc/model/shopping_cart_data.dart';
import 'package:fldc/model/shopping_product_data.dart';

class PosController extends MyController {
  List<ShoppingProduct> shopping = [];
  ShoppingProduct? shoppingProduct;
  List<ShoppingCart> shoppingCart = [];
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));
  late double order = 0, tax = 30, offer = 50, total = 0;
  int selectSize = 1;

  @override
  void onInit() {
    ShoppingProduct.dummyList.then((value) {
      shopping = value;
      shoppingProduct = shopping[0];
      update();
    });
    ShoppingCart.dummyList.then((value) {
      shoppingCart = value;
      update();
    });
    super.onInit();
  }

  void onSelectSize(int size) {
    selectSize = size;
    update();
  }

  void onChangeProduct(ShoppingProduct product) {
    shoppingProduct = product;
    update();
  }

  bool increaseAble(ShoppingCart cart) {
    return cart.quantity < cart.product.quantity;
  }

  bool decreaseAble(ShoppingCart cart) {
    return cart.quantity > 1;
  }

  void increment(ShoppingCart cart) {
    if (!increaseAble(cart)) return;
    cart.quantity++;
    calculateBilling();
    update();
  }

  void decrement(ShoppingCart cart) {
    if (!decreaseAble(cart)) return;
    cart.quantity--;
    update();
  }

  void calculateBilling() {
    order = 0;
    for (ShoppingCart cart in shoppingCart) {
      order = order + (cart.product.price * cart.quantity);
    }
    total = order + tax - offer;
    update();
  }
}
