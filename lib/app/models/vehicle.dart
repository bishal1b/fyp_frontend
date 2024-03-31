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
  final String? title;
  final String? description;
  final String? perDayPrice;
  final String? imageUrl;
  final String? addedBy;
  final String? category;
  final String? rating;
  final String? noOfSeats;
  final String? categoryId;
  final String? email;
  final String? fullName;

  Vehicle({
    this.vehicleId,
    this.title,
    this.description,
    this.perDayPrice,
    this.imageUrl,
    this.addedBy,
    this.category,
    this.rating,
    this.noOfSeats,
    this.categoryId,
    this.email,
    this.fullName,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        vehicleId: json["vehicle_id"],
        title: json["title"],
        description: json["description"],
        perDayPrice: json["per_day_price"],
        imageUrl: json["image_url"],
        addedBy: json["added_by"],
        category: json["category"],
        rating: json["rating"],
        noOfSeats: json["no_of_seats"],
        categoryId: json["category_id"],
        email: json["email"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "vehicle_id": vehicleId,
        "title": title,
        "description": description,
        "per_day_price": perDayPrice,
        "image_url": imageUrl,
        "added_by": addedBy,
        "category": category,
        "rating": rating,
        "no_of_seats": noOfSeats,
        "category_id": categoryId,
        "email": email,
        "full_name": fullName,
      };
}
