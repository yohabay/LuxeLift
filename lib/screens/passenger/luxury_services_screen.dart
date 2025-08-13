import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/luxury_service_provider.dart';
import '../../models/luxury_service_model.dart';
import '../../theme/app_theme.dart';

class LuxuryServicesScreen extends StatefulWidget {
  const LuxuryServicesScreen({super.key});

  @override
  State<LuxuryServicesScreen> createState() => _LuxuryServicesScreenState();
}

class _LuxuryServicesScreenState extends State<LuxuryServicesScreen> {
  String selectedCategory = 'All';
  final List<String> categories = ['All', 'Transport', 'Concierge', 'Security', 'VIP'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Luxury App Bar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Luxury Services',
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
                  gradient: AppTheme.goldGradient,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      top: 50,
                      child: Icon(
                        Icons.diamond,
                        size: 150,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    const Positioned(
                      left: 20,
                      bottom: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Premium',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Experiences',
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

          // VIP Membership Card
          SliverToBoxAdapter(
            child: Consumer<LuxuryServiceProvider>(
              builder: (context, provider, _) {
                final membership = provider.userMembership;
                if (membership == null) return const SizedBox.shrink();

                return Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
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
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            membership.tierDisplayName,
                            style: TextStyle(
                              color: membership.tier == MembershipTier.black 
                                  ? Colors.white 
                                  : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
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
                              'ACTIVE',
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
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Credit Balance',
                                  style: TextStyle(
                                    color: membership.tier == MembershipTier.black 
                                        ? Colors.white70 
                                        : Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '\$${membership.creditBalance.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: membership.tier == MembershipTier.black 
                                        ? Colors.white 
                                        : Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Free Rides Left',
                                  style: TextStyle(
                                    color: membership.tier == MembershipTier.black 
                                        ? Colors.white70 
                                        : Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  membership.freeRidesPerMonth > 100 
                                      ? 'Unlimited' 
                                      : '${membership.freeRidesPerMonth}',
                                  style: TextStyle(
                                    color: membership.tier == MembershipTier.black 
                                        ? Colors.white 
                                        : Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Category Filter
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;
                  
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      selectedColor: AppTheme.accentColor.withOpacity(0.2),
                      checkmarkColor: AppTheme.accentColor,
                      labelStyle: TextStyle(
                        color: isSelected ? AppTheme.accentColor : Colors.grey[600],
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Services Grid
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: Consumer<LuxuryServiceProvider>(
              builder: (context, provider, _) {
                final services = provider.availableServices;
                
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final service = services[index];
                      return _LuxuryServiceCard(service: service);
                    },
                    childCount: services.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LuxuryServiceCard extends StatelessWidget {
  final LuxuryService service;

  const _LuxuryServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            _showServiceDetails(context, service);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: AppTheme.goldGradient,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    _getServiceIcon(service.type),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  service.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  service.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      'From \$${service.basePrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accentColor,
                      ),
                    ),
                    const Spacer(),
                    if (service.requiresAdvanceBooking)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${service.minAdvanceHours}h',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.orange[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getServiceIcon(LuxuryServiceType type) {
    switch (type) {
      case LuxuryServiceType.concierge:
        return Icons.support_agent;
      case LuxuryServiceType.personalShopper:
        return Icons.shopping_bag;
      case LuxuryServiceType.eventPlanning:
        return Icons.event;
      case LuxuryServiceType.businessMeeting:
        return Icons.business_center;
      case LuxuryServiceType.airportVip:
        return Icons.flight;
      case LuxuryServiceType.redCarpet:
        return Icons.star;
      case LuxuryServiceType.privateJet:
        return Icons.airplanemode_active;
      case LuxuryServiceType.yacht:
        return Icons.directions_boat;
      case LuxuryServiceType.helicopter:
        return Icons.helicopter;
      case LuxuryServiceType.bodyguard:
        return Icons.security;
      case LuxuryServiceType.interpreter:
        return Icons.translate;
      case LuxuryServiceType.photographer:
        return Icons.camera_alt;
    }
  }

  void _showServiceDetails(BuildContext context, LuxuryService service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: AppTheme.goldGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          _getServiceIcon(service.type),
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'From \$${service.basePrice.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 18,
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
                  Text(
                    'Description',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Inclusions',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...service.inclusions.map((inclusion) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
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
                            inclusion,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _bookService(context, service);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        service.requiresAdvanceBooking 
                            ? 'Schedule Service' 
                            : 'Book Now',
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
          );
        },
      ),
    );
  }

  void _bookService(BuildContext context, LuxuryService service) {
    // Show booking confirmation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Service Booked'),
        content: Text('Your ${service.name} has been scheduled successfully.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
