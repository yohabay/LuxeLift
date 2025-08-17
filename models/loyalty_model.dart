class LoyaltyProgram {
  final String id;
  final String userId;
  final String tier; // 'bronze', 'silver', 'gold', 'platinum', 'diamond'
  final int points;
  final int totalTrips;
  final double totalSpent;
  final List<String> availableRewards;
  final List<String> unlockedBenefits;
  final DateTime joinDate;
  final DateTime? nextTierDate;
  final int pointsToNextTier;

  LoyaltyProgram({
    required this.id,
    required this.userId,
    required this.tier,
    required this.points,
    required this.totalTrips,
    required this.totalSpent,
    required this.availableRewards,
    required this.unlockedBenefits,
    required this.joinDate,
    this.nextTierDate,
    required this.pointsToNextTier,
  });

  String get tierDisplayName {
    switch (tier) {
      case 'bronze': return 'Bronze Elite';
      case 'silver': return 'Silver Elite';
      case 'gold': return 'Gold Elite';
      case 'platinum': return 'Platinum Elite';
      case 'diamond': return 'Diamond Elite';
      default: return 'Member';
    }
  }

  factory LoyaltyProgram.fromJson(Map<String, dynamic> json) {
    return LoyaltyProgram(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      tier: json['tier'] ?? 'bronze',
      points: json['points'] ?? 0,
      totalTrips: json['totalTrips'] ?? 0,
      totalSpent: (json['totalSpent'] ?? 0.0).toDouble(),
      availableRewards: List<String>.from(json['availableRewards'] ?? []),
      unlockedBenefits: List<String>.from(json['unlockedBenefits'] ?? []),
      joinDate: json['joinDate'] != null 
          ? DateTime.parse(json['joinDate'])
          : DateTime.now(),
      nextTierDate: json['nextTierDate'] != null 
          ? DateTime.parse(json['nextTierDate'])
          : null,
      pointsToNextTier: json['pointsToNextTier'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tier': tier,
      'points': points,
      'totalTrips': totalTrips,
      'totalSpent': totalSpent,
      'availableRewards': availableRewards,
      'unlockedBenefits': unlockedBenefits,
      'joinDate': joinDate.toIso8601String(),
      'nextTierDate': nextTierDate?.toIso8601String(),
      'pointsToNextTier': pointsToNextTier,
    };
  }
}
