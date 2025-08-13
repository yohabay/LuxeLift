import '../enums/ride_status.dart';
import 'location_model.dart';

class Ride {
  final String id;
  final String passengerId;
  final String? driverId;
  final Location pickupLocation;
  final Location dropoffLocation;
  final String vehicleType;
  final double fare;
  final RideStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final double? rating;
  final String? feedback;
  final double distance;
  final int estimatedDuration; // in minutes
  final String? passengerName;
  final String? driverName;
  final String? driverPhone;

  Ride({
    required this.id,
    required this.passengerId,
    this.driverId,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.vehicleType,
    required this.fare,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.rating,
    this.feedback,
    this.distance = 0.0,
    this.estimatedDuration = 0,
    this.passengerName,
    this.driverName,
    this.driverPhone,
  });

  // Legacy getters for backward compatibility
  double get pickupLat => pickupLocation.latitude;
  double get pickupLng => pickupLocation.longitude;
  double get dropoffLat => dropoffLocation.latitude;
  double get dropoffLng => dropoffLocation.longitude;

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'] ?? '',
      passengerId: json['passengerId'] ?? '',
      driverId: json['driverId'],
      pickupLocation: json['pickupLocation'] is Map<String, dynamic>
          ? Location.fromJson(json['pickupLocation'])
          : Location(
              latitude: (json['pickupLat'] ?? 0.0).toDouble(),
              longitude: (json['pickupLng'] ?? 0.0).toDouble(),
              address: json['pickupLocation'] ?? '',
            ),
      dropoffLocation: json['dropoffLocation'] is Map<String, dynamic>
          ? Location.fromJson(json['dropoffLocation'])
          : Location(
              latitude: (json['dropoffLat'] ?? 0.0).toDouble(),
              longitude: (json['dropoffLng'] ?? 0.0).toDouble(),
              address: json['dropoffLocation'] ?? '',
            ),
      vehicleType: json['vehicleType'] ?? 'economy',
      fare: (json['fare'] ?? 0.0).toDouble(),
      status: json['status'] is String
          ? RideStatus.fromString(json['status'])
          : RideStatus.pending,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt']) 
          : null,
      rating: json['rating']?.toDouble(),
      feedback: json['feedback'],
      distance: (json['distance'] ?? 0.0).toDouble(),
      estimatedDuration: json['estimatedDuration'] ?? 0,
      passengerName: json['passengerName'],
      driverName: json['driverName'],
      driverPhone: json['driverPhone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'passengerId': passengerId,
      'driverId': driverId,
      'pickupLocation': pickupLocation.toJson(),
      'dropoffLocation': dropoffLocation.toJson(),
      'vehicleType': vehicleType,
      'fare': fare,
      'status': status.value,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'rating': rating,
      'feedback': feedback,
      'distance': distance,
      'estimatedDuration': estimatedDuration,
      'passengerName': passengerName,
      'driverName': driverName,
      'driverPhone': driverPhone,
    };
  }

  Ride copyWith({
    String? id,
    String? passengerId,
    String? driverId,
    Location? pickupLocation,
    Location? dropoffLocation,
    String? vehicleType,
    double? fare,
    RideStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    double? rating,
    String? feedback,
    double? distance,
    int? estimatedDuration,
    String? passengerName,
    String? driverName,
    String? driverPhone,
  }) {
    return Ride(
      id: id ?? this.id,
      passengerId: passengerId ?? this.passengerId,
      driverId: driverId ?? this.driverId,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      vehicleType: vehicleType ?? this.vehicleType,
      fare: fare ?? this.fare,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      rating: rating ?? this.rating,
      feedback: feedback ?? this.feedback,
      distance: distance ?? this.distance,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      passengerName: passengerName ?? this.passengerName,
      driverName: driverName ?? this.driverName,
      driverPhone: driverPhone ?? this.driverPhone,
    );
  }
}
