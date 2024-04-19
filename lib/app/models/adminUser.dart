// To parse this JSON data, do
//
//     final adminUserResponse = adminUserResponseFromJson(jsonString);

import 'dart:convert';

AdminUserResponse adminUserResponseFromJson(String str) =>
    AdminUserResponse.fromJson(json.decode(str));

String adminUserResponseToJson(AdminUserResponse data) =>
    json.encode(data.toJson());

class AdminUserResponse {
  final bool? success;
  final String? message;
  final List<User>? users;

  AdminUserResponse({
    this.success,
    this.message,
    this.users,
  });

  factory AdminUserResponse.fromJson(Map<String, dynamic> json) =>
      AdminUserResponse(
        success: json["success"],
        message: json["message"],
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  final String? userId;
  final String? email;
  final String? fullName;
  final String? role;
  final String? address;
  final String? contact;
  final DateTime? createdAt;
  final String? imageUrl;
  final String? liscenceImage;

  User({
    this.userId,
    this.email,
    this.fullName,
    this.role,
    this.address,
    this.contact,
    this.createdAt,
    this.imageUrl,
    this.liscenceImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        email: json["email"],
        fullName: json["full_name"],
        role: json["role"],
        address: json["address"],
        contact: json["contact"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        imageUrl: json["image_url"],
        liscenceImage: json["liscence_image"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "full_name": fullName,
        "role": role,
        "address": address,
        "contact": contact,
        "created_at": createdAt?.toIso8601String(),
        "image_url": imageUrl,
        "liscence_image": liscenceImage,
      };
}
