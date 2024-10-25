import 'dart:convert';

import 'package:fldc/helpers/services/json_decoder.dart';
import 'package:fldc/model/identifier_model.dart';
import 'package:flutter/services.dart';

class CategoryModel extends IdentifierModel {
  final String name;

  CategoryModel(super.id, this.name);

  static CategoryModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String name = decoder.getString('name');

    return CategoryModel(decoder.getId, name);
  }

  static List<CategoryModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => CategoryModel.fromJSON(e)).toList();
  }

  static List<CategoryModel>? _dummyList;

  static Future<List<CategoryModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/category.json');
  }
}
