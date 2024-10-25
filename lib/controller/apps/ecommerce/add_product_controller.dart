import 'package:file_picker/file_picker.dart';
import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/helpers/widgets/my_form_validator.dart';
import 'package:flutter/cupertino.dart';

enum StockAvailability {
  inStock,
  outOfStock;
}

enum StockType {
  fixedStock,
  dailyStock;
}

enum ProductCategory {
  footWear,
  furniture,
  homeDecor,
  kitchen,
  lighting,
  lawnAndGarden,
  beddingAndBath,
  clothing,
  phone,
  laptop,
  gameConsole;
}

class AddProductController extends MyController {
  TextEditingController productName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController discountPrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();
  List<PlatformFile> files = [];
  MyFormValidator basicValidator = MyFormValidator();
  StockAvailability selectStock = StockAvailability.inStock;
  StockType stockType = StockType.dailyStock;

  @override
  void onInit() {
    productName = TextEditingController();
    quantity = TextEditingController();
    price = TextEditingController(text: "199");
    discount = TextEditingController(text: "12%");
    discountPrice = TextEditingController(text: "99");
    description = TextEditingController(
        text:
            "Introducing the app screen for the app store, a user-friendly and visually appealing platform designed to enhance your app browsing experience");
    super.onInit();
  }

  void onChangeStock(StockAvailability? value) {
    selectStock = value ?? selectStock;
    update();
  }

  void onChangeStockType(StockType? value) {
    stockType = value ?? stockType;
    update();
  }

  Future<void> pickFiles() async {
    var result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg']);
    if (result?.files.isNotEmpty ?? false) {
      files.addAll(result!.files);
    }
    update();
  }

  void removeFile(PlatformFile file) {
    files.remove(file);
    update();
  }
}
