import 'dart:convert';

import 'package:fldc/helpers/services/json_decoder.dart';
import 'package:fldc/images.dart';
import 'package:fldc/model/identifier_model.dart';
import 'package:flutter/services.dart';

class PopularCandidateModal extends IdentifierModel {
  final String name, userId, image;

  PopularCandidateModal(super.id, this.name, this.userId, this.image);

  static PopularCandidateModal fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String name = decoder.getString('name');
    String userId = decoder.getString('userId');
    String image = Images.randomImage(Images.avatars);
    
    return PopularCandidateModal(decoder.getId, name, userId, image);
  }

  static List<PopularCandidateModal> listFromJSON(List<dynamic> list) {
    return list.map((e) => PopularCandidateModal.fromJSON(e)).toList();
  }

  static List<PopularCandidateModal>? _dummyList;

  static Future<List<PopularCandidateModal>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/popular_candidate.json');
  }
}
