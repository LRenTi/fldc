import 'package:fldc/controller/my_controller.dart';
import 'package:fldc/model/category_modal.dart';
import 'package:fldc/model/product_modal.dart';
import 'package:flutter/material.dart';

class ProductListController extends MyController {
  List<ProductModal> product = [];
  List<ProductModal> searchProduct = [];
  List<ProductModal> allProduct = [];
  List<CategoryModel> category = [];
  RangeValues rangeSlider = RangeValues(100, 1500);
  double minimumPrice = 100;
  double maximumPrice = 1500;
  int selectCategory = 0, selectRating = 0;
  SearchController searchController = SearchController();

  @override
  void onInit() {
    ProductModal.dummyList.then((value) {
      product = value;
      searchProduct = value;
      allProduct = value;
      update();
    });
    CategoryModel.dummyList.then((value) {
      category = value;
      update();
    });
    super.onInit();
  }

  void filterByStart(double rating) {
    searchProduct = allProduct.where((star) {
      return star.rating >= rating;
    }).toList();
    update();
  }

  void filterByCategory(int query) {
    searchProduct = allProduct.where((product) {
      return product.categoryId == query;
    }).toList();
    update();
  }

  void filterByPrice(RangeValues value) {
    rangeSlider = value;
    searchProduct = allProduct.where((price) {
      return price.price >= rangeSlider.start && price.price <= rangeSlider.end;
    }).toList();
    update();
  }

  void onSearchProduct(String query) {
    final input = query.toLowerCase();
    searchProduct = allProduct
        .where((search) => search.name.toLowerCase().contains(input))
        .toList();
    update();
  }

  void onSelectCategories(int id) {
    selectCategory = id;
    update();
  }

  void onSelectRating(int id) {
    selectRating = id;
    update();
  }
}
