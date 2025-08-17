class Location {
  final double latitude;
  final double longitude;
  final String address;
  final String? name;
  final String? placeId;

  Location({
    required this.latitude,
    required this.longitude,
    required this.address,
    this.name,
    this.placeId,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      address: json['address'] ?? '',
      name: json['name'],
      placeId: json['placeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'name': name,
      'placeId': placeId,
    };
  }

  Location copyWith({
    double? latitude,
    double? longitude,
    String? address,
    String? name,
    String? placeId,
  }) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      name: name ?? this.name,
      placeId: placeId ?? this.placeId,
    );
  }

  @override
  String toString() {
    return name ?? address;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Location &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.address == address;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^ longitude.hashCode ^ address.hashCode;
  }
}
