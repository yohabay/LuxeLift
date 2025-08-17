import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/luxury_vehicle_model.dart';
import '../../theme/app_theme.dart';

class LuxuryBookingScreen extends StatefulWidget {
  const LuxuryBookingScreen({super.key});

  @override
  State<LuxuryBookingScreen> createState() => _LuxuryBookingScreenState();
}

class _LuxuryBookingScreenState extends State<LuxuryBookingScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  String selectedVehicleCategory = 'premium';
  bool showPreferences = false;
  
  final List<LuxuryVehicle> availableVehicles = [
    LuxuryVehicle(
      id: '1',
      category: 'economy',
      brand: 'Toyota',
      model: 'Corolla',
      color: 'White',
      plateNumber: 'AA-123-456',
      year: 2022,
      amenities: ['Air Conditioning', 'Music System'],
      priceMultiplier: 1.0,
      imageUrl: '/placeholder.svg?height=120&width=200',
      description: 'Comfortable and reliable for everyday trips',
    ),
    LuxuryVehicle(
      id: '2',
      category: 'premium',
      brand: 'BMW',
      model: '3 Series',
      color: 'Black',
      plateNumber: 'BB-789-012',
      year: 2023,
      amenities: ['Leather Seats', 'Premium Audio', 'Climate Control', 'WiFi'],
      priceMultiplier: 1.5,
      imageUrl: '/placeholder.svg?height=120&width=200',
      description: 'Premium comfort with luxury amenities',
    ),
    LuxuryVehicle(
      id: '3',
      category: 'luxury',
      brand: 'Mercedes-Benz',
      model: 'S-Class',
      color: 'Silver',
      plateNumber: 'CC-345-678',
      year: 2024,
      amenities: ['Massage Seats', 'Champagne Service', 'Premium Audio', 'Privacy Glass', 'WiFi', 'Chauffeur'],
      priceMultiplier: 2.5,
      imageUrl: '/placeholder.svg?height=120&width=200',
      description: 'Ultimate luxury experience with professional chauffeur',
    ),
    LuxuryVehicle(
      id: '4',
      category: 'eco',
      brand: 'Tesla',
      model: 'Model S',
      color: 'Blue',
      plateNumber: 'DD-901-234',
      year: 2024,
      amenities: ['Autopilot', 'Premium Audio', 'Climate Control', 'WiFi'],
      priceMultiplier: 1.8,
      imageUrl: '/placeholder.svg?height=120&width=200',
      isEcoFriendly: true,
      description: 'Eco-friendly luxury with cutting-edge technology',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('Choose Your Ride'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => showPreferences = !showPreferences),
            icon: Icon(
              showPreferences ? Icons.tune : Icons.tune_outlined,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Current Location',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Text('2 min', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 6),
                    width: 2,
                    height: 20,
                    color: Colors.grey[300],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Downtown Business District',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Text('15 min', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),

            if (showPreferences)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.accentColor.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ride Preferences',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _PreferenceChip(label: 'Quiet Mode', isSelected: false),
                        _PreferenceChip(label: 'Climate Control', isSelected: true),
                        _PreferenceChip(label: 'Premium Audio', isSelected: false),
                        _PreferenceChip(label: 'WiFi', isSelected: true),
                      ],
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: availableVehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = availableVehicles[index];
                  final isSelected = selectedVehicleCategory == vehicle.category;
                  
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedVehicleCategory = vehicle.category),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? AppTheme.primaryColor : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected 
                                  ? AppTheme.primaryColor.withOpacity(0.2)
                                  : Colors.black.withOpacity(0.05),
                              blurRadius: isSelected ? 15 : 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Vehicle Image
                            Container(
                              width: 80,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[100],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  vehicle.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.directions_car,
                                      size: 40,
                                      color: AppTheme.primaryColor,
                                    );
                                  },
                                ),
                              ),
                            ),
                            
                            const SizedBox(width: 16),
                            
                            // Vehicle Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        vehicle.categoryDisplayName,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      if (vehicle.isEcoFriendly)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppTheme.successColor.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: const Text(
                                            'ECO',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.successColor,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    vehicle.displayName,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    vehicle.description,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Amenities
                                  Wrap(
                                    spacing: 4,
                                    runSpacing: 4,
                                    children: vehicle.amenities.take(3).map((amenity) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          amenity,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: AppTheme.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Price and ETA
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${(25.0 * vehicle.priceMultiplier).toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                const Text(
                                  '3 min away',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (isSelected)
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to ride tracking
                      context.go('/passenger/ride-tracking');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Book Luxury Ride',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreferenceChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _PreferenceChip({
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppTheme.primaryColor : Colors.grey[300]!,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : Colors.grey[700],
        ),
      ),
    );
  }
}
