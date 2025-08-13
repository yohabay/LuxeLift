class Vehicle {
  final String make;
  final String model;
  final String color;
  final String plateNumber;
  final int year;

  Vehicle({
    required this.make,
    required this.model,
    required this.color,
    required this.plateNumber,
    required this.year,
  });

  String get displayName => '$color $make $model';

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      make: json['make'] ?? '',
      model: json['model'] ?? '',
      color: json['color'] ?? '',
      plateNumber: json['plateNumber'] ?? '',
      year: json['year'] ?? 2020,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'color': color,
      'plateNumber': plateNumber,
      'year': year,
    };
  }
}

class Driver {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final double rating;
  final Vehicle vehicle;
  final String? profileImage;
  final double currentLat;
  final double currentLng;
  final int totalTrips;
  final int yearsExperience;
  final bool isOnline;
  final bool isVerified;
  final String? licenseNumber;
  final DateTime joinDate;

  Driver({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.rating,
    required this.vehicle,
    this.profileImage,
    required this.currentLat,
    required this.currentLng,
    this.totalTrips = 0,
    this.yearsExperience = 0,
    this.isOnline = true,
    this.isVerified = false,
    this.licenseNumber,
    required this.joinDate,
    String? vehicleModel,
  });

  // Legacy getters for backward compatibility
  String get vehicleModel => vehicle.displayName;
  String get vehicleNumber => vehicle.plateNumber;
  String get vehicleColor => vehicle.color;

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      vehicle: json['vehicle'] != null 
          ? Vehicle.fromJson(json['vehicle'])
          : Vehicle(
              make: json['vehicleModel']?.split(' ').last ?? 'Toyota',
              model: json['vehicleModel']?.split(' ').first ?? 'Corolla',
              color: json['vehicleColor'] ?? 'White',
              plateNumber: json['vehicleNumber'] ?? 'AA-123-456',
              year: 2020,
            ),
      profileImage: json['profileImage'],
      currentLat: (json['currentLat'] ?? 0.0).toDouble(),
      currentLng: (json['currentLng'] ?? 0.0).toDouble(),
      totalTrips: json['totalTrips'] ?? 0,
      yearsExperience: json['yearsExperience'] ?? 0,
      isOnline: json['isOnline'] ?? true,
      isVerified: json['isVerified'] ?? false,
      licenseNumber: json['licenseNumber'],
      joinDate: json['joinDate'] != null 
          ? DateTime.parse(json['joinDate'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'rating': rating,
      'vehicle': vehicle.toJson(),
      'profileImage': profileImage,
      'currentLat': currentLat,
      'currentLng': currentLng,
      'totalTrips': totalTrips,
      'yearsExperience': yearsExperience,
      'isOnline': isOnline,
      'isVerified': isVerified,
      'licenseNumber': licenseNumber,
      'joinDate': joinDate.toIso8601String(),
    };
  }

  Driver copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    double? rating,
    Vehicle? vehicle,
    String? profileImage,
    double? currentLat,
    double? currentLng,
    int? totalTrips,
    int? yearsExperience,
    bool? isOnline,
    bool? isVerified,
    String? licenseNumber,
    DateTime? joinDate,
  }) {
    return Driver(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      rating: rating ?? this.rating,
      vehicle: vehicle ?? this.vehicle,
      profileImage: profileImage ?? this.profileImage,
      currentLat: currentLat ?? this.currentLat,
      currentLng: currentLng ?? this.currentLng,
      totalTrips: totalTrips ?? this.totalTrips,
      yearsExperience: yearsExperience ?? this.yearsExperience,
      isOnline: isOnline ?? this.isOnline,
      isVerified: isVerified ?? this.isVerified,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      joinDate: joinDate ?? this.joinDate,
    );
  }
}
