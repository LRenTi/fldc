import 'dart:convert';

import 'package:fldc/helpers/services/json_decoder.dart';
import 'package:fldc/model/identifier_model.dart';
import 'package:flutter/services.dart';

class JobModal extends IdentifierModel {
  final String jobTitle, jobLocation;
  final int jobHr, price;
  final List<String> jobWork;

  JobModal(super.id, this.jobTitle, this.jobLocation, this.jobHr, this.price,
      this.jobWork);

  static JobModal fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String jobTitle = decoder.getString('job_title');
    String jobLocation = decoder.getString('job_location');
    int jobHr = decoder.getInt('job_hr');
    int price = decoder.getInt('price');
    List<String>? jobWork = decoder.getObjectListOrNull('job_work');

    return JobModal(
        decoder.getId, jobTitle, jobLocation, jobHr, price, jobWork!);
  }

  static List<JobModal> listFromJSON(List<dynamic> list) {
    return list.map((e) => JobModal.fromJSON(e)).toList();
  }

  static List<JobModal>? _dummyList;

  static Future<List<JobModal>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/job.json');
  }
}
