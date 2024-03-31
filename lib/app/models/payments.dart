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
  final String? createdAt;
  final String? otherDetails;
  final String? paymentBy;
  final String? email;
  final String? fullName;
  final String? address;
  final String? contact;

  Payment({
    this.paymentId,
    this.bookingId,
    this.amount,
    this.mode,
    this.createdAt,
    this.otherDetails,
    this.paymentBy,
    this.email,
    this.fullName,
    this.address,
    this.contact,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentId: json["payment_id"],
        bookingId: json["booking_id"],
        amount: json["amount"],
        mode: json["mode"],
        createdAt: json["created_at"],
        otherDetails: json["other_details"],
        paymentBy: json["payment_by"],
        email: json["email"],
        fullName: json["full_name"],
        address: json["address"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "payment_id": paymentId,
        "booking_id": bookingId,
        "amount": amount,
        "mode": mode,
        "created_at": createdAt,
        "other_details": otherDetails,
        "payment_by": paymentBy,
        "email": email,
        "full_name": fullName,
        "address": address,
        "contact": contact,
      };
}
