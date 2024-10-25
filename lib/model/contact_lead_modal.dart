import 'dart:convert';

import 'package:fldc/helpers/services/json_decoder.dart';
import 'package:fldc/images.dart';
import 'package:fldc/model/identifier_model.dart';
import 'package:flutter/services.dart';

class ContactLeadModal extends IdentifierModel {
  final String contactName, number, location, image;
  final int leadsScore;
  final DateTime createdAt;

  ContactLeadModal(super.id, this.contactName, this.number, this.location,
      this.leadsScore, this.createdAt, this.image);

  static ContactLeadModal fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String contactName = decoder.getString('contact_name');
    String number = decoder.getString('number');
    String location = decoder.getString('location');
    String image = Images.randomImage(Images.landscape);
    int leadsScore = decoder.getInt('leads_score');
    DateTime createdAt = decoder.getDateTime('created_at');
    return ContactLeadModal(decoder.getId, contactName, number, location,
        leadsScore, createdAt, image);
  }

  static List<ContactLeadModal> listFromJSON(List<dynamic> list) {
    return list.map((e) => ContactLeadModal.fromJSON(e)).toList();
  }

  static List<ContactLeadModal>? _dummyList;

  static Future<List<ContactLeadModal>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/contact_leads.json');
  }
}
