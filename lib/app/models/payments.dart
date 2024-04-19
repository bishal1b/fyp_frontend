// To parse this JSON data, do
//
//     final paymentResponse = paymentResponseFromJson(jsonString);

import 'dart:convert';

PaymentResponse paymentResponseFromJson(String str) =>
    PaymentResponse.fromJson(json.decode(str));

String paymentResponseToJson(PaymentResponse data) =>
    json.encode(data.toJson());

class PaymentResponse {
  final bool? success;
  final String? message;
  final List<Payment>? payments;

  PaymentResponse({
    this.success,
    this.message,
    this.payments,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentResponse(
        success: json["success"],
        message: json["message"],
        payments: json["payments"] == null
            ? []
            : List<Payment>.from(
                json["payments"]!.map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "payments": payments == null
            ? []
            : List<dynamic>.from(payments!.map((x) => x.toJson())),
      };
}

class Payment {
  final String? paymentId;
  final String? bookingId;
  final String? amount;
  final String? mode;
  final DateTime? createdAt;
  final String? otherDetails;
  final String? paymentBy;
  final String? vehicleId;
  final String? total;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final String? bookedBy;
  final String? email;
  final String? fullName;
  final String? address;
  final String? contact;
  final String? title;
  final String? description;
  final String? noOfSeats;
  final String? imageUrl;
  final String? category;
  final String? addedBy;
  final String? rating;
  final String? perDayPrice;

  Payment({
    this.paymentId,
    this.bookingId,
    this.amount,
    this.mode,
    this.createdAt,
    this.otherDetails,
    this.paymentBy,
    this.vehicleId,
    this.total,
    this.startDate,
    this.endDate,
    this.status,
    this.bookedBy,
    this.email,
    this.fullName,
    this.address,
    this.contact,
    this.title,
    this.description,
    this.noOfSeats,
    this.imageUrl,
    this.category,
    this.addedBy,
    this.rating,
    this.perDayPrice,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentId: json["payment_id"],
        bookingId: json["booking_id"],
        amount: json["amount"],
        mode: json["mode"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        otherDetails: json["other_details"],
        paymentBy: json["payment_by"],
        vehicleId: json["vehicle_id"],
        total: json["total"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"],
        bookedBy: json["booked_by"],
        email: json["email"],
        fullName: json["full_name"],
        address: json["address"],
        contact: json["contact"],
        title: json["title"],
        description: json["description"],
        noOfSeats: json["no_of_seats"],
        imageUrl: json["image_url"],
        category: json["category"],
        addedBy: json["added_by"],
        rating: json["rating"],
        perDayPrice: json["per_day_price"],
      );

  Map<String, dynamic> toJson() => {
        "payment_id": paymentId,
        "booking_id": bookingId,
        "amount": amount,
        "mode": mode,
        "created_at": createdAt?.toIso8601String(),
        "other_details": otherDetails,
        "payment_by": paymentBy,
        "vehicle_id": vehicleId,
        "total": total,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "status": status,
        "booked_by": bookedBy,
        "email": email,
        "full_name": fullName,
        "address": address,
        "contact": contact,
        "title": title,
        "description": description,
        "no_of_seats": noOfSeats,
        "image_url": imageUrl,
        "category": category,
        "added_by": addedBy,
        "rating": rating,
        "per_day_price": perDayPrice,
      };
}
