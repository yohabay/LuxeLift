enum LuxuryServiceType {
  concierge,
  personalShopper,
  eventPlanning,
  businessMeeting,
  airportVip,
  redCarpet,
  privateJet,
  yacht,
  helicopter,
  bodyguard,
  interpreter,
  photographer
}

class LuxuryService {
  final String id;
  final LuxuryServiceType type;
  final String name;
  final String description;
  final double basePrice;
  final int durationMinutes;
  final List<String> inclusions;
  final bool requiresAdvanceBooking;
  final int minAdvanceHours;
  final String iconPath;
  final bool isAvailable;

  LuxuryService({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.durationMinutes,
    required this.inclusions,
    this.requiresAdvanceBooking = false,
    this.minAdvanceHours = 0,
    required this.iconPath,
    this.isAvailable = true,
  });

  factory LuxuryService.fromJson(Map<String, dynamic> json) {
    return LuxuryService(
      id: json['id'] ?? '',
      type: LuxuryServiceType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => LuxuryServiceType.concierge,
      ),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      basePrice: (json['basePrice'] ?? 0.0).toDouble(),
      durationMinutes: json['durationMinutes'] ?? 0,
      inclusions: List<String>.from(json['inclusions'] ?? []),
      requiresAdvanceBooking: json['requiresAdvanceBooking'] ?? false,
      minAdvanceHours: json['minAdvanceHours'] ?? 0,
      iconPath: json['iconPath'] ?? '',
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'name': name,
      'description': description,
      'basePrice': basePrice,
      'durationMinutes': durationMinutes,
      'inclusions': inclusions,
      'requiresAdvanceBooking': requiresAdvanceBooking,
      'minAdvanceHours': minAdvanceHours,
      'iconPath': iconPath,
      'isAvailable': isAvailable,
    };
  }
}
