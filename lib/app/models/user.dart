// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  final bool? success;
  final String? message;
  final User? user;

  UserResponse({
    this.success,
    this.message,
    this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        success: json["success"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user": user?.toJson(),
      };
}

class User {
  final String? fullName;
  final String? email;
  final String? contact;
  final String? address;
  final String? role;
  final String? imageUrl;
  final DateTime? createdAt;

  User({
    this.imageUrl,
    this.fullName,
    this.email,
    this.contact,
    this.address,
    this.role,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json["full_name"],
        email: json["email"],
        contact: json["contact"],
        address: json["address"],
        role: json["role"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "contact": contact,
        "address": address,
        "role": role,
        "created_at": createdAt?.toIso8601String(),
      };
}
