enum VehicleClass {
  luxury,
  superLuxury,
  exotic,
  vintage,
  limousine,
  suv,
  helicopter,
  yacht,
  privateJet
}

class PremiumVehicle {
  final String id;
  final String make;
  final String model;
  final int year;
  final VehicleClass vehicleClass;
  final String color;
  final String plateNumber;
  final List<String> features;
  final List<String> images;
  final double pricePerKm;
  final double pricePerMinute;
  final int maxPassengers;
  final bool hasWifi;
  final bool hasBar;
  final bool hasMassage;
  final bool hasPrivacyPartition;
  final bool hasEntertainment;
  final String description;
  final double rating;
  final bool isAvailable;

  PremiumVehicle({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.vehicleClass,
    required this.color,
    required this.plateNumber,
    required this.features,
    required this.images,
    required this.pricePerKm,
    required this.pricePerMinute,
    required this.maxPassengers,
    this.hasWifi = false,
    this.hasBar = false,
    this.hasMassage = false,
    this.hasPrivacyPartition = false,
    this.hasEntertainment = false,
    required this.description,
    this.rating = 0.0,
    this.isAvailable = true,
  });

  String get displayName => '$year $make $model';
  String get classDisplayName {
    switch (vehicleClass) {
      case VehicleClass.luxury:
        return 'Luxury';
      case VehicleClass.superLuxury:
        return 'Super Luxury';
      case VehicleClass.exotic:
        return 'Exotic';
      case VehicleClass.vintage:
        return 'Vintage';
      case VehicleClass.limousine:
        return 'Limousine';
      case VehicleClass.suv:
        return 'Luxury SUV';
      case VehicleClass.helicopter:
        return 'Helicopter';
      case VehicleClass.yacht:
        return 'Yacht';
      case VehicleClass.privateJet:
        return 'Private Jet';
    }
  }

  factory PremiumVehicle.fromJson(Map<String, dynamic> json) {
    return PremiumVehicle(
      id: json['id'] ?? '',
      make: json['make'] ?? '',
      model: json['model'] ?? '',
      year: json['year'] ?? 2020,
      vehicleClass: VehicleClass.values.firstWhere(
        (e) => e.toString().split('.').last == json['vehicleClass'],
        orElse: () => VehicleClass.luxury,
      ),
      color: json['color'] ?? '',
      plateNumber: json['plateNumber'] ?? '',
      features: List<String>.from(json['features'] ?? []),
      images: List<String>.from(json['images'] ?? []),
      pricePerKm: (json['pricePerKm'] ?? 0.0).toDouble(),
      pricePerMinute: (json['pricePerMinute'] ?? 0.0).toDouble(),
      maxPassengers: json['maxPassengers'] ?? 4,
      hasWifi: json['hasWifi'] ?? false,
      hasBar: json['hasBar'] ?? false,
      hasMassage: json['hasMassage'] ?? false,
      hasPrivacyPartition: json['hasPrivacyPartition'] ?? false,
      hasEntertainment: json['hasEntertainment'] ?? false,
      description: json['description'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'make': make,
      'model': model,
      'year': year,
      'vehicleClass': vehicleClass.toString().split('.').last,
      'color': color,
      'plateNumber': plateNumber,
      'features': features,
      'images': images,
      'pricePerKm': pricePerKm,
      'pricePerMinute': pricePerMinute,
      'maxPassengers': maxPassengers,
      'hasWifi': hasWifi,
      'hasBar': hasBar,
      'hasMassage': hasMassage,
      'hasPrivacyPartition': hasPrivacyPartition,
      'hasEntertainment': hasEntertainment,
      'description': description,
      'rating': rating,
      'isAvailable': isAvailable,
    };
  }
}
