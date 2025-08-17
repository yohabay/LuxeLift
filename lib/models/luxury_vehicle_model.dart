class LuxuryVehicle {
  final String id;
  final String category; // 'economy', 'premium', 'luxury', 'executive', 'eco'
  final String brand;
  final String model;
  final String color;
  final String plateNumber;
  final int year;
  final List<String> amenities;
  final double priceMultiplier;
  final String imageUrl;
  final bool isAccessible;
  final bool isEcoFriendly;
  final int maxPassengers;
  final String description;

  LuxuryVehicle({
    required this.id,
    required this.category,
    required this.brand,
    required this.model,
    required this.color,
    required this.plateNumber,
    required this.year,
    required this.amenities,
    required this.priceMultiplier,
    required this.imageUrl,
    this.isAccessible = false,
    this.isEcoFriendly = false,
    this.maxPassengers = 4,
    required this.description,
  });

  String get displayName => '$color $brand $model';
  String get categoryDisplayName {
    switch (category) {
      case 'economy': return 'Economy';
      case 'premium': return 'Premium';
      case 'luxury': return 'Luxury';
      case 'executive': return 'Executive';
      case 'eco': return 'Eco-Friendly';
      default: return 'Standard';
    }
  }

  factory LuxuryVehicle.fromJson(Map<String, dynamic> json) {
    return LuxuryVehicle(
      id: json['id'] ?? '',
      category: json['category'] ?? 'economy',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      color: json['color'] ?? '',
      plateNumber: json['plateNumber'] ?? '',
      year: json['year'] ?? 2020,
      amenities: List<String>.from(json['amenities'] ?? []),
      priceMultiplier: (json['priceMultiplier'] ?? 1.0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      isAccessible: json['isAccessible'] ?? false,
      isEcoFriendly: json['isEcoFriendly'] ?? false,
      maxPassengers: json['maxPassengers'] ?? 4,
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'brand': brand,
      'model': model,
      'color': color,
      'plateNumber': plateNumber,
      'year': year,
      'amenities': amenities,
      'priceMultiplier': priceMultiplier,
      'imageUrl': imageUrl,
      'isAccessible': isAccessible,
      'isEcoFriendly': isEcoFriendly,
      'maxPassengers': maxPassengers,
      'description': description,
    };
  }
}
