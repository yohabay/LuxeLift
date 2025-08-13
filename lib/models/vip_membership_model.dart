enum MembershipTier {
  platinum,
  diamond,
  black,
  royal
}

class VipMembership {
  final String id;
  final String userId;
  final MembershipTier tier;
  final DateTime startDate;
  final DateTime endDate;
  final double annualFee;
  final List<String> benefits;
  final double discountPercentage;
  final bool hasPersonalConcierge;
  final bool hasPriorityBooking;
  final bool hasAirportLounge;
  final bool hasFreeCancellation;
  final int freeRidesPerMonth;
  final double creditBalance;
  final bool isActive;

  VipMembership({
    required this.id,
    required this.userId,
    required this.tier,
    required this.startDate,
    required this.endDate,
    required this.annualFee,
    required this.benefits,
    required this.discountPercentage,
    this.hasPersonalConcierge = false,
    this.hasPriorityBooking = false,
    this.hasAirportLounge = false,
    this.hasFreeCancellation = false,
    this.freeRidesPerMonth = 0,
    this.creditBalance = 0.0,
    this.isActive = true,
  });

  String get tierDisplayName {
    switch (tier) {
      case MembershipTier.platinum:
        return 'Platinum Elite';
      case MembershipTier.diamond:
        return 'Diamond Prestige';
      case MembershipTier.black:
        return 'Black Card';
      case MembershipTier.royal:
        return 'Royal Crown';
    }
  }

  Color get tierColor {
    switch (tier) {
      case MembershipTier.platinum:
        return const Color(0xFFE5E4E2);
      case MembershipTier.diamond:
        return const Color(0xFFB9F2FF);
      case MembershipTier.black:
        return const Color(0xFF000000);
      case MembershipTier.royal:
        return const Color(0xFFFFD700);
    }
  }

  factory VipMembership.fromJson(Map<String, dynamic> json) {
    return VipMembership(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      tier: MembershipTier.values.firstWhere(
        (e) => e.toString().split('.').last == json['tier'],
        orElse: () => MembershipTier.platinum,
      ),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      annualFee: (json['annualFee'] ?? 0.0).toDouble(),
      benefits: List<String>.from(json['benefits'] ?? []),
      discountPercentage: (json['discountPercentage'] ?? 0.0).toDouble(),
      hasPersonalConcierge: json['hasPersonalConcierge'] ?? false,
      hasPriorityBooking: json['hasPriorityBooking'] ?? false,
      hasAirportLounge: json['hasAirportLounge'] ?? false,
      hasFreeCancellation: json['hasFreeCancellation'] ?? false,
      freeRidesPerMonth: json['freeRidesPerMonth'] ?? 0,
      creditBalance: (json['creditBalance'] ?? 0.0).toDouble(),
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tier': tier.toString().split('.').last,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'annualFee': annualFee,
      'benefits': benefits,
      'discountPercentage': discountPercentage,
      'hasPersonalConcierge': hasPersonalConcierge,
      'hasPriorityBooking': hasPriorityBooking,
      'hasAirportLounge': hasAirportLounge,
      'hasFreeCancellation': hasFreeCancellation,
      'freeRidesPerMonth': freeRidesPerMonth,
      'creditBalance': creditBalance,
      'isActive': isActive,
    };
  }
}
