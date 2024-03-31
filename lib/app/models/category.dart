// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromJson(jsonString);

import 'dart:convert';

CategoriesResponse categoriesResponseFromJson(String str) =>
    CategoriesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(CategoriesResponse data) =>
    json.encode(data.toJson());

class CategoriesResponse {
  final bool? success;
  final String? message;
  final List<Category>? categories;

  CategoriesResponse({
    this.success,
    this.message,
    this.categories,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        success: json["success"],
        message: json["message"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Category {
  final String? categoryId;
  final String? category;
  final String? isDeleted;

  Category({
    this.categoryId,
    this.category,
    this.isDeleted,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        category: json["category"],
        isDeleted: json["is_deleted"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category": category,
        "is_deleted": isDeleted,
      };
}
