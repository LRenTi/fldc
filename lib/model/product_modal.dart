import 'dart:convert';

import 'package:fldc/helpers/services/json_decoder.dart';
import 'package:fldc/model/identifier_model.dart';
import 'package:flutter/services.dart';

class ProductModal extends IdentifierModel {
  final String name, image;
  final int categoryId, stock;
  final double price, rating;

  ProductModal(super.id, this.name, this.image, this.categoryId, this.stock,
      this.price, this.rating);

  static ProductModal fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String name = decoder.getString('name');
    String image = decoder.getString('image');
    int categoryId = decoder.getInt('category_id');
    int stock = decoder.getInt('stock');
    double price = decoder.getDouble('price');
    double rating = decoder.getDouble('rating');

    return ProductModal(
        decoder.getId, name, image, categoryId, stock, price, rating);
  }

  static List<ProductModal> listFromJSON(List<dynamic> list) {
    return list.map((e) => ProductModal.fromJSON(e)).toList();
  }

  static List<ProductModal>? _dummyList;

  static Future<List<ProductModal>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/product.json');
  }
}
