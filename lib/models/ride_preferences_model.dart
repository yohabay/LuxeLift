class RidePreferences {
  final String id;
  final String userId;
  final String? preferredMusic;
  final int? preferredTemperature;
  final bool quietMode;
  final String? preferredDriverGender;
  final List<String> requestedAmenities;
  final String? specialInstructions;
  final bool allowCalls;
  final bool allowMessages;
  final String? preferredRoute;

  RidePreferences({
    required this.id,
    required this.userId,
    this.preferredMusic,
    this.preferredTemperature,
    this.quietMode = false,
    this.preferredDriverGender,
    this.requestedAmenities = const [],
    this.specialInstructions,
    this.allowCalls = true,
    this.allowMessages = true,
    this.preferredRoute,
  });

  factory RidePreferences.fromJson(Map<String, dynamic> json) {
    return RidePreferences(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      preferredMusic: json['preferredMusic'],
      preferredTemperature: json['preferredTemperature'],
      quietMode: json['quietMode'] ?? false,
      preferredDriverGender: json['preferredDriverGender'],
      requestedAmenities: List<String>.from(json['requestedAmenities'] ?? []),
      specialInstructions: json['specialInstructions'],
      allowCalls: json['allowCalls'] ?? true,
      allowMessages: json['allowMessages'] ?? true,
      preferredRoute: json['preferredRoute'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'preferredMusic': preferredMusic,
      'preferredTemperature': preferredTemperature,
      'quietMode': quietMode,
      'preferredDriverGender': preferredDriverGender,
      'requestedAmenities': requestedAmenities,
      'specialInstructions': specialInstructions,
      'allowCalls': allowCalls,
      'allowMessages': allowMessages,
      'preferredRoute': preferredRoute,
    };
  }
}
