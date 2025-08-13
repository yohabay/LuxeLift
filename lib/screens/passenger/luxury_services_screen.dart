import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/luxury_service_provider.dart';
import '../../models/luxury_service_model.dart';
import '../../models/vip_membership_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';

class LuxuryServicesScreen extends StatefulWidget {
  const LuxuryServicesScreen({super.key});

  @override
  State<LuxuryServicesScreen> createState() => _LuxuryServicesScreenState();
}

class _LuxuryServicesScreenState extends State<LuxuryServicesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedServiceIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.darkGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildMembershipCard(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildConciergeServices(),
                    _buildExclusiveExperiences(),
                    _buildPersonalServices(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Luxury Services',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Show service history
            },
            icon: const Icon(
              Icons.history,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipCard() {
    return Consumer<LuxuryServiceProvider>(
      builder: (context, provider, child) {
        final membership = provider.currentMembership;
        if (membership == null) {
          return _buildUpgradeMembershipCard();
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                membership.tierColor.withOpacity(0.8),
                membership.tierColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: membership.tier == MembershipTier.black
                    ? Colors.black.withOpacity(0.3)
                    : membership.tierColor.withOpacity(0.3),
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
                    membership.tierIcon,
                    color: membership.tier == MembershipTier.black
                        ? Colors.white
                        : Colors.black,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          membership.tierName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: membership.tier == MembershipTier.black
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Text(
                          'Priority Level ${membership.priorityLevel}',
                          style: TextStyle(
                            fontSize: 14,
                            color: membership.tier == MembershipTier.black
                                ? Colors.white70
                                : Colors.black54,
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
                      color: membership.tier == MembershipTier.black
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${membership.discountPercentage.toInt()}% OFF',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: membership.tier == MembershipTier.black
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Available Services: ${membership.benefits.length}',
                style: TextStyle(
                  fontSize: 16,
                  color: membership.tier == MembershipTier.black
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUpgradeMembershipCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppTheme.goldGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accentColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.diamond,
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'Upgrade to VIP',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Unlock exclusive luxury services and premium benefits',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          LuxuryButton(
            text: 'Upgrade Now',
            onPressed: () {
              // TODO: Navigate to membership upgrade
            },
            icon: Icons.upgrade,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: AppTheme.goldGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: 'Concierge'),
          Tab(text: 'Experiences'),
          Tab(text: 'Personal'),
        ],
      ),
    );
  }

  Widget _buildConciergeServices() {
    final services = [
      {
        'title': 'Personal Concierge',
        'subtitle': '24/7 luxury assistance',
        'icon': Icons.support_agent,
        'price': '\$50/hour',
        'description': 'Dedicated personal assistant for all your needs',
      },
      {
        'title': 'Restaurant Reservations',
        'subtitle': 'Exclusive dining experiences',
        'icon': Icons.restaurant,
        'price': '\$25/booking',
        'description': 'Priority reservations at Michelin-starred restaurants',
      },
      {
        'title': 'Event Planning',
        'subtitle': 'Luxury event coordination',
        'icon': Icons.event,
        'price': '\$200/event',
        'description': 'Complete planning for special occasions',
      },
      {
        'title': 'Travel Planning',
        'subtitle': 'Bespoke travel experiences',
        'icon': Icons.flight_takeoff,
        'price': '\$150/trip',
        'description': 'Customized luxury travel itineraries',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceCard(service, index);
      },
    );
  }

  Widget _buildExclusiveExperiences() {
    final experiences = [
      {
        'title': 'Private Yacht Charter',
        'subtitle': 'Luxury maritime experience',
        'icon': Icons.directions_boat,
        'price': '\$2,500/day',
        'description': 'Exclusive yacht charter with crew and catering',
      },
      {
        'title': 'Helicopter Tours',
        'subtitle': 'Aerial luxury sightseeing',
        'icon': Icons.flight_takeoff,
        'price': '\$800/hour',
        'description': 'Private helicopter tours with professional pilot',
      },
      {
        'title': 'Private Jet Access',
        'subtitle': 'On-demand aviation',
        'icon': Icons.airplanemode_active,
        'price': '\$5,000/flight',
        'description': 'Access to private jet fleet for instant travel',
      },
      {
        'title': 'Exclusive Events',
        'subtitle': 'VIP access to premium events',
        'icon': Icons.stars,
        'price': 'Varies',
        'description': 'Priority access to exclusive galas and premieres',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: experiences.length,
      itemBuilder: (context, index) {
        final experience = experiences[index];
        return _buildServiceCard(experience, index);
      },
    );
  }

  Widget _buildPersonalServices() {
    final services = [
      {
        'title': 'Personal Shopper',
        'subtitle': 'Luxury shopping assistance',
        'icon': Icons.shopping_bag,
        'price': '\$100/session',
        'description': 'Personal shopping at high-end boutiques',
      },
      {
        'title': 'Home Services',
        'subtitle': 'Premium household management',
        'icon': Icons.home,
        'price': '\$75/hour',
        'description': 'Professional home cleaning and organization',
      },
      {
        'title': 'Personal Chef',
        'subtitle': 'Private culinary experiences',
        'icon': Icons.restaurant_menu,
        'price': '\$300/meal',
        'description': 'Michelin-trained chefs for private dining',
      },
      {
        'title': 'Wellness Services',
        'subtitle': 'Premium health and beauty',
        'icon': Icons.spa,
        'price': '\$200/session',
        'description': 'In-home spa and wellness treatments',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceCard(service, index);
      },
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service, int index) {
    final isSelected = _selectedServiceIndex == index;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedServiceIndex = index;
            });
            _showServiceDetails(service);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isSelected 
                  ? Colors.white.withOpacity(0.15)
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected 
                    ? AppTheme.accentColor
                    : Colors.white.withOpacity(0.1),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: AppTheme.goldGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    service['icon'] as IconData,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['title'] as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service['subtitle'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        service['price'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isSelected ? Icons.check_circle : Icons.arrow_forward_ios,
                  color: isSelected ? AppTheme.accentColor : Colors.white54,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showServiceDetails(Map<String, dynamic> service) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: AppTheme.goldGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      service['icon'] as IconData,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    service['title'] as String,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service['description'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      service['price'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  LuxuryButton(
                    text: 'Book Service',
                    onPressed: () {
                      Navigator.pop(context);
                      _bookService(service);
                    },
                    icon: Icons.calendar_today,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _bookService(Map<String, dynamic> service) {
    // TODO: Implement service booking
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking ${service['title']}...'),
        backgroundColor: AppTheme.successColor,
      ),
    );
  }

  IconData _getServiceIcon(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'helicopter':
        return Icons.flight_takeoff; // Using flight_takeoff instead of helicopter
      case 'yacht':
        return Icons.directions_boat;
      case 'jet':
        return Icons.airplanemode_active;
      case 'concierge':
        return Icons.support_agent;
      default:
        return Icons.star;
    }
  }
}
