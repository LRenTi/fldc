import 'dart:convert';

import 'package:fldc/helpers/services/json_decoder.dart';
import 'package:fldc/model/identifier_model.dart';
import 'package:flutter/services.dart';

class Food extends IdentifierModel {
  final String image, foodName, customerName, address;
  final double price;
  final bool pending;

  Food(super.id, this.image, this.foodName, this.customerName, this.address,
      this.price, this.pending);

  static Food fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String image = decoder.getString('image');
    String foodName = decoder.getString('food_name');
    String customerName = decoder.getString('customer_name');
    String address = decoder.getString('address');
    double price = decoder.getDouble('price');
    bool pending = decoder.getBool('isPending');

    return Food(
        decoder.getId, image, foodName, customerName, address, price, pending);
  }

  static List<Food> listFromJSON(List<dynamic> list) {
    return list.map((e) => Food.fromJSON(e)).toList();
  }

  static List<Food>? _dummyList;

  static Future<List<Food>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/food_data.json');
  }
}
