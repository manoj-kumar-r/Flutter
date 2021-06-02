class ProductModel {
  final String name;
  final String photoUrl;
  final String quantity;
  final int id;
  final double price;

  ProductModel(this.name, this.photoUrl, this.quantity, this.id, this.price);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      json['name'] as String,
      json['photo_url'] as String,
      json['quantity'] as String,
      json['id'] as int,
      json['price'] as double,
    );
  }
}

class SearchModel {
  final String name;

  SearchModel(this.name);

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(json['name'] as String);
  }
}

class CategoryModel {
  final String catName;
  final String catUrl;

  CategoryModel(this.catName, this.catUrl);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(json['catName'] as String, json['catUrl'] as String);
  }
}
