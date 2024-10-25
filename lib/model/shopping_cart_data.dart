import 'dart:convert';

import 'package:fldc/helpers/extensions/string.dart';
import 'package:fldc/helpers/services/json_decoder.dart';
import 'package:fldc/model/identifier_model.dart';
import 'package:fldc/model/shopping_product_data.dart';
import 'package:flutter/services.dart';

class ShoppingCart extends IdentifierModel {
  ShoppingProduct product;
  String selectedSize;
  int quantity;
  Color selectedColor;

  ShoppingCart(
    super.id,
    this.product,
    this.selectedSize,
    this.quantity,
    this.selectedColor,
  );

  static ShoppingCart fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    ShoppingProduct product = ShoppingProduct.fromJSON(json['product']);
    String selectedSize = decoder.getString('selectedSize');
    int quantity = decoder.getInt('quantity');
    Color selectedColor =
        decoder.jsonObject['selectedColor'].toString().toColor;

    return ShoppingCart(
      decoder.getId,
      product,
      selectedSize,
      quantity,
      selectedColor,
    );
  }

  static List<ShoppingCart> listFromJSON(List<dynamic> list) {
    return list.map((e) => ShoppingCart.fromJSON(e)).toList();
  }

  static List<ShoppingCart>? _dummyList;

  static Future<List<ShoppingCart>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/shopping_cart.json');
  }
}
