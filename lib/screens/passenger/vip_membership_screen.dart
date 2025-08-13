import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/luxury_service_provider.dart';
import '../../models/vip_membership_model.dart';
import '../../theme/app_theme.dart';

class VipMembershipScreen extends StatefulWidget {
  const VipMembershipScreen({super.key});

  @override
  State<VipMembershipScreen> createState() => _VipMembershipScreenState();
}

class _VipMembershipScreenState extends State<VipMembershipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // VIP App Bar
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'VIP Membership',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      top: 20,
                      child: Icon(
                        Icons.diamond,
                        size: 100,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    const Positioned(
                      left: 20,
                      bottom: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Exclusive',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Privileges',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.go('/passenger/home'),
            ),
          ),

          // Current Membership
          SliverToBoxAdapter(
            child: Consumer<LuxuryServiceProvider>(
              builder: (context, provider, _) {
                final membership = provider.userMembership;
                if (membership == null) {
                  return const _NoMembershipCard();
                }
                return _CurrentMembershipCard(membership: membership);
              },
            ),
          ),

          // Membership Tiers
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Membership Tiers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose the perfect tier for your luxury lifestyle',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Membership Cards
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _MembershipTierCard(
                  tier: MembershipTier.platinum,
                  title: 'Platinum Elite',
                  price: 2500,
                  color: const Color(0xFFE5E4E2),
                  benefits: [
                    'Priority booking',
                    '10% discount on all rides',
                    '2 free rides per month',
                    'Free cancellation',
                    '24/7 premium support',
                    'Exclusive vehicle access',
                  ],
                  isPopular: false,
                ),
                const SizedBox(height: 16),
                _MembershipTierCard(
                  tier: MembershipTier.diamond,
                  title: 'Diamond Prestige',
                  price: 5000,
                  color: const Color(0xFFB9F2FF),
                  benefits: [
                    'All Platinum benefits',
                    'Personal concierge service',
                    '15% discount on all rides',
                    '5 free rides per month',
                    'Airport lounge access',
                    'Luxury vehicle priority',
                    'Complimentary upgrades',
                  ],
                  isPopular: true,
                ),
                const SizedBox(height: 16),
                _MembershipTierCard(
                  tier: MembershipTier.black,
                  title: 'Black Card',
                  price: 10000,
                  color: const Color(0xFF000000),
                  benefits: [
                    'All Diamond benefits',
                    'Dedicated account manager',
                    '20% discount on all rides',
                    '10 free rides per month',
                    'Exclusive exotic vehicles',
                    'Private jet booking',
                    'Event planning services',
                  ],
                  isPopular: false,
                ),
                const SizedBox(height: 16),
                _MembershipTierCard(
                  tier: MembershipTier.royal,
                  title: 'Royal Crown',
                  price: 25000,
                  color: const Color(0xFFFFD700),
                  benefits: [
                    'All Black Card benefits',
                    'Unlimited luxury rides',
                    '25% discount on all services',
                    'Personal security detail',
                    'Yacht & helicopter access',
                    'Global concierge service',
                    'Red carpet experiences',
                    'Exclusive events invitation',
                  ],
                  isPopular: false,
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoMembershipCard extends StatelessWidget {
  const _NoMembershipCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B73FF), Color(0xFF9DD5EA)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.diamond,
            size: 60,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          const Text(
            'Join VIP Membership',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Unlock exclusive benefits and luxury experiences',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Scroll to membership tiers
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF6B73FF),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Explore Memberships',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrentMembershipCard extends StatelessWidget {
  final VipMembership membership;

  const _CurrentMembershipCard({required this.membership});

  @override
  Widget build(BuildContext context) {
    final daysLeft = membership.endDate.difference(DateTime.now()).inDays;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            membership.tierColor,
            membership.tierColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: membership.tierColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.diamond,
                color: membership.tier == MembershipTier.black 
                    ? Colors.white 
                    : Colors.black,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      membership.tierDisplayName,
                      style: TextStyle(
                        color: membership.tier == MembershipTier.black 
                            ? Colors.white 
                            : Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Active until ${_formatDate(membership.endDate)}',
                      style: TextStyle(
                        color: membership.tier == MembershipTier.black 
                            ? Colors.white70 
                            : Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$daysLeft days left',
                  style: TextStyle(
                    color: membership.tier == MembershipTier.black 
                        ? Colors.white 
                        : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _MembershipStat(
                  label: 'Credit Balance',
                  value: '\$${membership.creditBalance.toStringAsFixed(0)}',
                  textColor: membership.tier == MembershipTier.black 
                      ? Colors.white 
                      : Colors.black,
                ),
              ),
              Expanded(
                child: _MembershipStat(
                  label: 'Free Rides Left',
                  value: membership.freeRidesPerMonth > 100 
                      ? 'Unlimited' 
                      : '${membership.freeRidesPerMonth}',
                  textColor: membership.tier == MembershipTier.black 
                      ? Colors.white 
                      : Colors.black,
                ),
              ),
              Expanded(
                child: _MembershipStat(
                  label: 'Discount',
                  value: '${membership.discountPercentage.toStringAsFixed(0)}%',
                  textColor: membership.tier == MembershipTier.black 
                      ? Colors.white 
                      : Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showBenefits(context, membership),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: membership.tier == MembershipTier.black 
                          ? Colors.white 
                          : Colors.black,
                    ),
                    foregroundColor: membership.tier == MembershipTier.black 
                        ? Colors.white 
                        : Colors.black,
                  ),
                  child: const Text('View Benefits'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showUpgradeOptions(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: membership.tier == MembershipTier.black 
                        ? Colors.white 
                        : Colors.black,
                    foregroundColor: membership.tier == MembershipTier.black 
                        ? Colors.black 
                        : Colors.white,
                  ),
                  child: const Text('Upgrade'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showBenefits(BuildContext context, VipMembership membership) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${membership.tierDisplayName} Benefits',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...membership.benefits.map((benefit) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 12),
                  Expanded(child: Text(benefit)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _showUpgradeOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upgrade Membership'),
        content: const Text('Choose a higher tier to unlock more exclusive benefits.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to upgrade flow
            },
            child: const Text('Upgrade'),
          ),
        ],
      ),
    );
  }
}

class _MembershipStat extends StatelessWidget {
  final String label;
  final String value;
  final Color textColor;

  const _MembershipStat({
    required this.label,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _MembershipTierCard extends StatelessWidget {
  final MembershipTier tier;
  final String title;
  final double price;
  final Color color;
  final List<String> benefits;
  final bool isPopular;

  const _MembershipTierCard({
    required this.tier,
    required this.title,
    required this.price,
    required this.color,
    required this.benefits,
    required this.isPopular,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = tier == MembershipTier.black;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isPopular ? Border.all(color: AppTheme.accentColor, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          if (isPopular)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.accentColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              ),
              child: const Text(
                'MOST POPULAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.diamond,
                        color: isDark ? Colors.white : Colors.black,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${price.toStringAsFixed(0)}/year',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ...benefits.map((benefit) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          benefit,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _upgradeMembership(context, tier),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPopular ? AppTheme.accentColor : color,
                      foregroundColor: isDark || isPopular ? Colors.white : Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Upgrade to $title',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _upgradeMembership(BuildContext context, MembershipTier tier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upgrade to $title'),
        content: Text('Upgrade your membership to $title for \$${price.toStringAsFixed(0)}/year?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<LuxuryServiceProvider>(context, listen: false)
                  .upgradeMembership(tier);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Successfully upgraded to $title!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Upgrade'),
          ),
        ],
      ),
    );
  }
}
