import 'dart:convert';

import 'package:fldc/helpers/services/json_decoder.dart';
import 'package:fldc/images.dart';
import 'package:fldc/model/identifier_model.dart';
import 'package:flutter/services.dart';

class ContactModel extends IdentifierModel {
  final String name, email, phoneNumber, city, image;

  ContactModel(
      super.id, this.name, this.email, this.phoneNumber, this.city, this.image);

  static ContactModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String name = decoder.getString('name');
    String email = decoder.getString('email');
    String phoneNumber = decoder.getString('phone_number');
    String city = decoder.getString('city');
    String image = Images.randomImage(Images.avatars);

    return ContactModel(decoder.getId, name, email, phoneNumber, city, image);
  }

  static List<ContactModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => ContactModel.fromJSON(e)).toList();
  }

  static List<ContactModel>? _dummyList;

  static Future<List<ContactModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/contact.json');
  }
}
