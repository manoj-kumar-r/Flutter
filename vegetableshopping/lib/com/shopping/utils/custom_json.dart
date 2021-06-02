import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:vegetableshopping/com/shopping/models/data_model.dart';

class CustomJson {
  static Future<List<ProductModel>> loadProductJson() async {
    var data = await rootBundle.loadString('assets/json/data.json');
    final parsed = json.decode(data).cast<Map<String, dynamic>>();
    return parsed
        .map<ProductModel>((json) => ProductModel.fromJson(json))
        .toList();
  }

  static Future<List<SearchModel>> loadSearchJson() async {
    var data = await rootBundle.loadString('assets/json/search.json');
    final parsed = json.decode(data).cast<Map<String, dynamic>>();
    return parsed
        .map<SearchModel>((json) => SearchModel.fromJson(json))
        .toList();
  }

  static Future<List<CategoryModel>> loadCatJson() async {
    var data = await rootBundle.loadString('assets/json/cat.json');
    final parsed = json.decode(data).cast<Map<String, dynamic>>();
    return parsed
        .map<CategoryModel>((json) => CategoryModel.fromJson(json))
        .toList();
  }
}
