import 'package:flutter/material.dart';

enum UserType { passenger, driver }

class User {
  final String id;
  final String name;
  final String phone;
  final String email;
  final UserType userType;
  final String? profileImage;
  final bool isVerified;
  final DateTime createdAt;
  final double rating;
  final int totalTrips;

  const User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.userType,
    this.profileImage,
    required this.isVerified,
    required this.createdAt,
    required this.rating,
    required this.totalTrips,
  });

  User copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    UserType? userType,
    String? profileImage,
    bool? isVerified,
    DateTime? createdAt,
    double? rating,
    int? totalTrips,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      profileImage: profileImage ?? this.profileImage,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      rating: rating ?? this.rating,
      totalTrips: totalTrips ?? this.totalTrips,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'userType': userType.name,
      'profileImage': profileImage,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
      'rating': rating,
      'totalTrips': totalTrips,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      userType: UserType.values.firstWhere(
        (e) => e.name == json['userType'],
        orElse: () => UserType.passenger,
      ),
      profileImage: json['profileImage'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalTrips: json['totalTrips'] as int? ?? 0,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, phone: $phone, email: $email, userType: $userType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
