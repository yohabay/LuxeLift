import './driver_model.dart';

class User {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String? profileImage;
  final String userType; // 'passenger' or 'driver'
  final double rating;
  final int totalTrips;
  final DateTime createdAt;
  final Vehicle? vehicle;

  User({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.profileImage,
    required this.userType,
    this.rating = 0.0,
    this.totalTrips = 0,
    required this.createdAt,
    this.vehicle,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'],
      profileImage: json['profileImage'],
      userType: json['userType'] ?? 'passenger',
      rating: (json['rating'] ?? 0.0).toDouble(),
      totalTrips: json['totalTrips'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      vehicle: json['vehicle'] != null
          ? Vehicle.fromJson(json['vehicle'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'profileImage': profileImage,
      'userType': userType,
      'rating': rating,
      'totalTrips': totalTrips,
      'createdAt': createdAt.toIso8601String(),
      'vehicle': vehicle?.toJson(),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? profileImage,
    String? userType,
    double? rating,
    int? totalTrips,
    DateTime? createdAt,
    Vehicle? vehicle,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      userType: userType ?? this.userType,
      rating: rating ?? this.rating,
      totalTrips: totalTrips ?? this.totalTrips,
      createdAt: createdAt ?? this.createdAt,
      vehicle: vehicle ?? this.vehicle,
    );
  }
}