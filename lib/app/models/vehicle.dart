// To parse this JSON data, do
//
//     final vehicleResponse = vehicleResponseFromJson(jsonString);

import 'dart:convert';

VehicleResponse vehicleResponseFromJson(String str) =>
    VehicleResponse.fromJson(json.decode(str));

String vehicleResponseToJson(VehicleResponse data) =>
    json.encode(data.toJson());

class VehicleResponse {
  final bool? success;
  final String? message;
  final List<Vehicle>? vehicles;

  VehicleResponse({
    this.success,
    this.message,
    this.vehicles,
  });

  factory VehicleResponse.fromJson(Map<String, dynamic> json) =>
      VehicleResponse(
        success: json["success"],
        message: json["message"],
        vehicles: json["vehicles"] == null
            ? []
            : List<Vehicle>.from(
                json["vehicles"]!.map((x) => Vehicle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "vehicles": vehicles == null
            ? []
            : List<dynamic>.from(vehicles!.map((x) => x.toJson())),
      };
}

class Vehicle {
  final String? vehicleId;
  final dynamic plateNumber;
  final String? title;
  final String? description;
  final String? model;
  final String? imageUrl;
  final String? category;
  final String? addedBy;
  final String? rating;
  final String? perDayPrice;
  final String? categoryId;
  final String? isDeleted;
  final String? email;
  final String? fullName;
  final String? address;
  final String? contact;

  Vehicle({
    this.vehicleId,
    this.plateNumber,
    this.title,
    this.description,
    this.model,
    this.imageUrl,
    this.category,
    this.addedBy,
    this.rating,
    this.perDayPrice,
    this.categoryId,
    this.isDeleted,
    this.email,
    this.fullName,
    this.address,
    this.contact,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        vehicleId: json["vehicle_id"],
        plateNumber: json["plate_number"],
        title: json["title"],
        description: json["description"],
        model: json["model"],
        imageUrl: json["image_url"],
        category: json["category"],
        addedBy: json["added_by"],
        rating: json["rating"],
        perDayPrice: json["per_day_price"],
        categoryId: json["category_id"],
        isDeleted: json["is_deleted"],
        email: json["email"],
        fullName: json["full_name"],
        address: json["address"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "vehicle_id": vehicleId,
        "plate_number": plateNumber,
        "title": title,
        "description": description,
        "model": model,
        "image_url": imageUrl,
        "category": category,
        "added_by": addedBy,
        "rating": rating,
        "per_day_price": perDayPrice,
        "category_id": categoryId,
        "is_deleted": isDeleted,
        "email": email,
        "full_name": fullName,
        "address": address,
        "contact": contact,
      };
}
