// To parse this JSON data, do
//
//     final statsResponse = statsResponseFromJson(jsonString);

import 'dart:convert';

StatsResponse statsResponseFromJson(String str) => StatsResponse.fromJson(json.decode(str));

String statsResponseToJson(StatsResponse data) => json.encode(data.toJson());

class StatsResponse {
    final bool? success;
    final String? message;
    final Stats? stats;

    StatsResponse({
        this.success,
        this.message,
        this.stats,
    });

    factory StatsResponse.fromJson(Map<String, dynamic> json) => StatsResponse(
        success: json["success"],
        message: json["message"],
        stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "stats": stats?.toJson(),
    };
}

class Stats {
    final String? totalUsers;
    final String? totalVehicles;
    final String? totalIncome;
    final String? totalMonthlyIncome;
    final List<TopCategory>? topCategories;

    Stats({
        this.totalUsers,
        this.totalVehicles,
        this.totalIncome,
        this.totalMonthlyIncome,
        this.topCategories,
    });

    factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        totalUsers: json["total_users"],
        totalVehicles: json["total_vehicles"],
        totalIncome: json["total_income"],
        totalMonthlyIncome: json["total_monthly_income"],
        topCategories: json["top_categories"] == null ? [] : List<TopCategory>.from(json["top_categories"]!.map((x) => TopCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_users": totalUsers,
        "total_vehicles": totalVehicles,
        "total_income": totalIncome,
        "total_monthly_income": totalMonthlyIncome,
        "top_categories": topCategories == null ? [] : List<dynamic>.from(topCategories!.map((x) => x.toJson())),
    };
}

class TopCategory {
    final dynamic categoryId;
    final String? category;
    final dynamic totalIncome;
    final double? percentage;

    TopCategory({
        this.categoryId,
        this.category,
        this.totalIncome,
        this.percentage,
    });

    factory TopCategory.fromJson(Map<String, dynamic> json) => TopCategory(
        categoryId: json["category_id"],
        category: json["category"],
        totalIncome: json["total_income"],
        percentage: json["percentage"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category": category,
        "total_income": totalIncome,
        "percentage": percentage,
    };
}
