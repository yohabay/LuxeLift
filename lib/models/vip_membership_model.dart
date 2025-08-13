import 'package:flutter/material.dart';

enum MembershipTier {
  platinum,
  diamond,
  black,
  royal,
}

class VipMembership {
  final String id;
  final String userId;
  final MembershipTier tier;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final List<String> benefits;
  final double discountPercentage;
  final int priorityLevel;
  final Map<String, dynamic> metadata;
  final double annualFee;
  final double creditBalance;
  final int freeRidesPerMonth;
  final bool hasPersonalConcierge;
  final bool hasPriorityBooking;
  final bool hasAirportLounge;
  final bool hasFreeCancellation;

  const VipMembership({
    required this.id,
    required this.userId,
    required this.tier,
    required this.startDate,
    this.endDate,
    required this.isActive,
    required this.benefits,
    required this.discountPercentage,
    required this.priorityLevel,
    required this.metadata,
    required this.annualFee,
    required this.creditBalance,
    required this.freeRidesPerMonth,
    required this.hasPersonalConcierge,
    required this.hasPriorityBooking,
    required this.hasAirportLounge,
    required this.hasFreeCancellation,
  });

  VipMembership copyWith({
    String? id,
    String? userId,
    MembershipTier? tier,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    List<String>? benefits,
    double? discountPercentage,
    int? priorityLevel,
    Map<String, dynamic>? metadata,
    double? annualFee,
    double? creditBalance,
    int? freeRidesPerMonth,
    bool? hasPersonalConcierge,
    bool? hasPriorityBooking,
    bool? hasAirportLounge,
    bool? hasFreeCancellation,
  }) {
    return VipMembership(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tier: tier ?? this.tier,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      benefits: benefits ?? this.benefits,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      priorityLevel: priorityLevel ?? this.priorityLevel,
      metadata: metadata ?? this.metadata,
      annualFee: annualFee ?? this.annualFee,
      creditBalance: creditBalance ?? this.creditBalance,
      freeRidesPerMonth: freeRidesPerMonth ?? this.freeRidesPerMonth,
      hasPersonalConcierge: hasPersonalConcierge ?? this.hasPersonalConcierge,
      hasPriorityBooking: hasPriorityBooking ?? this.hasPriorityBooking,
      hasAirportLounge: hasAirportLounge ?? this.hasAirportLounge,
      hasFreeCancellation: hasFreeCancellation ?? this.hasFreeCancellation,
    );
  }

  String get tierName {
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

  IconData get tierIcon {
    switch (tier) {
      case MembershipTier.platinum:
        return Icons.star;
      case MembershipTier.diamond:
        return Icons.diamond;
      case MembershipTier.black:
        return Icons.credit_card;
      case MembershipTier.royal:
        return Icons.emoji_events;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tier': tier.name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isActive': isActive,
      'benefits': benefits,
      'discountPercentage': discountPercentage,
      'priorityLevel': priorityLevel,
      'metadata': metadata,
      'annualFee': annualFee,
      'creditBalance': creditBalance,
      'freeRidesPerMonth': freeRidesPerMonth,
      'hasPersonalConcierge': hasPersonalConcierge,
      'hasPriorityBooking': hasPriorityBooking,
      'hasAirportLounge': hasAirportLounge,
      'hasFreeCancellation': hasFreeCancellation,
    };
  }

  factory VipMembership.fromJson(Map<String, dynamic> json) {
    return VipMembership(
      id: json['id'] as String,
      userId: json['userId'] as String,
      tier: MembershipTier.values.firstWhere(
        (e) => e.name == json['tier'],
        orElse: () => MembershipTier.platinum,
      ),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null 
          ? DateTime.parse(json['endDate'] as String) 
          : null,
      isActive: json['isActive'] as bool,
      benefits: List<String>.from(json['benefits'] as List),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      priorityLevel: (json['priorityLevel'] as int),
      metadata: Map<String, dynamic>.from(json['metadata'] as Map),
      annualFee: (json['annualFee'] as num).toDouble(),
      creditBalance: (json['creditBalance'] as num).toDouble(),
      freeRidesPerMonth: (json['freeRidesPerMonth'] as int),
      hasPersonalConcierge: (json['hasPersonalConcierge'] as bool),
      hasPriorityBooking: (json['hasPriorityBooking'] as bool),
      hasAirportLounge: (json['hasAirportLounge'] as bool),
      hasFreeCancellation: (json['hasFreeCancellation'] as bool),
    );
  }

  @override
  String toString() {
    return 'VipMembership(id: $id, tier: $tierName, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VipMembership && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}