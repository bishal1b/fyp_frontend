// To parse this JSON data, do
//
//     final bookingsResponse = bookingsResponseFromJson(jsonString);

import 'dart:convert';

BookingsResponse bookingsResponseFromJson(String str) =>
    BookingsResponse.fromJson(json.decode(str));

String bookingsResponseToJson(BookingsResponse data) =>
    json.encode(data.toJson());

class BookingsResponse {
  final bool? success;
  final String? message;
  final List<Booking>? bookings;

  BookingsResponse({
    this.success,
    this.message,
    this.bookings,
  });

  factory BookingsResponse.fromJson(Map<String, dynamic> json) =>
      BookingsResponse(
        success: json["success"],
        message: json["message"],
        bookings: json["bookings"] == null
            ? []
            : List<Booking>.from(
                json["bookings"]!.map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "bookings": bookings == null
            ? []
            : List<dynamic>.from(bookings!.map((x) => x.toJson())),
      };
}

class Booking {
  final String? bookingId;
  final String? vehicleId;
  final String? total;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final String? bookedBy;
  final DateTime? createdAt;
  final String? title;
  final String? description;
  final String? noOfSeats;
  final String? imageUrl;
  final String? category;
  final String? addedBy;
  final String? rating;
  final String? perDayPrice;
  final String? email;
  final String? fullName;
  final String? address;
  final String? contact;

  Booking({
    this.bookingId,
    this.vehicleId,
    this.total,
    this.startDate,
    this.endDate,
    this.status,
    this.bookedBy,
    this.createdAt,
    this.title,
    this.description,
    this.noOfSeats,
    this.imageUrl,
    this.category,
    this.addedBy,
    this.rating,
    this.perDayPrice,
    this.email,
    this.fullName,
    this.address,
    this.contact,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        bookingId: json["booking_id"],
        vehicleId: json["vehicle_id"],
        total: json["total"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"],
        bookedBy: json["booked_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        title: json["title"],
        description: json["description"],
        noOfSeats: json["no_of_seats"],
        imageUrl: json["image_url"],
        category: json["category"],
        addedBy: json["added_by"],
        rating: json["rating"],
        perDayPrice: json["per_day_price"],
        email: json["email"],
        fullName: json["full_name"],
        address: json["address"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "vehicle_id": vehicleId,
        "total": total,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "status": status,
        "booked_by": bookedBy,
        "created_at": createdAt?.toIso8601String(),
        "title": title,
        "description": description,
        "no_of_seats": noOfSeats,
        "image_url": imageUrl,
        "category": category,
        "added_by": addedBy,
        "rating": rating,
        "per_day_price": perDayPrice,
        "email": email,
        "full_name": fullName,
        "address": address,
        "contact": contact,
      };
}
