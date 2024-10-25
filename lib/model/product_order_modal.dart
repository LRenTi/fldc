import 'dart:convert';

import 'package:fldc/helpers/services/json_decoder.dart';
import 'package:fldc/model/identifier_model.dart';
import 'package:flutter/services.dart';

class ProductOrderModal extends IdentifierModel {
  final String orderId, customerName, location, payment, status;
  final int quantity, price;
  final DateTime orderDate;

  ProductOrderModal(super.id, this.orderId, this.customerName, this.location,
      this.payment, this.status, this.quantity, this.price, this.orderDate);

  static ProductOrderModal fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String orderId = decoder.getString('order_id');
    String customerName = decoder.getString('customer_name');
    String location = decoder.getString('location');
    String payment = decoder.getString('payments');
    String status = decoder.getString('status');
    int quantity = decoder.getInt('quantity');
    int price = decoder.getInt('price');
    DateTime orderDate = decoder.getDateTime('order_date');

    return ProductOrderModal(decoder.getId, orderId, customerName, location,
        payment, status, quantity, price, orderDate);
  }

  static List<ProductOrderModal> listFromJSON(List<dynamic> list) {
    return list.map((e) => ProductOrderModal.fromJSON(e)).toList();
  }

  static List<ProductOrderModal>? _dummyList;

  static Future<List<ProductOrderModal>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/product_order.json');
  }
}
