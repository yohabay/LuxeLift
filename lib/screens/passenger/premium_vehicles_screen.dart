import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/luxury_service_provider.dart';
import '../../models/premium_vehicle_model.dart';
import '../../theme/app_theme.dart';

class PremiumVehiclesScreen extends StatefulWidget {
  const PremiumVehiclesScreen({super.key});

  @override
  State<PremiumVehiclesScreen> createState() => _PremiumVehiclesScreenState();
}

class _PremiumVehiclesScreenState extends State<PremiumVehiclesScreen> {
  VehicleClass? selectedClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Premium App Bar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Premium Fleet',
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
                    colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      top: 30,
                      child: Icon(
                        Icons.directions_car,
                        size: 120,
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
                            'Luxury',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Collection',
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

          // Vehicle Class Filter
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              margin: const EdgeInsets.all(16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: VehicleClass.values.map((vehicleClass) {
                  final isSelected = selectedClass == vehicleClass;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FilterChip(
                      label: Text(_getClassDisplayName(vehicleClass)),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedClass = selected ? vehicleClass : null;
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
                }).toList(),
              ),
            ),
          ),

          // Vehicles List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: Consumer<LuxuryServiceProvider>(
              builder: (context, provider, _) {
                var vehicles = provider.premiumVehicles;
                
                if (selectedClass != null) {
                  vehicles = vehicles.where((v) => v.vehicleClass == selectedClass).toList();
                }
                
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final vehicle = vehicles[index];
                      return _PremiumVehicleCard(vehicle: vehicle);
                    },
                    childCount: vehicles.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getClassDisplayName(VehicleClass vehicleClass) {
    switch (vehicleClass) {
      case VehicleClass.luxury:
        return 'Luxury';
      case VehicleClass.superLuxury:
        return 'Super Luxury';
      case VehicleClass.exotic:
        return 'Exotic';
      case VehicleClass.vintage:
        return 'Vintage';
      case VehicleClass.limousine:
        return 'Limousine';
      case VehicleClass.suv:
        return 'SUV';
      case VehicleClass.helicopter:
        return 'Helicopter';
      case VehicleClass.yacht:
        return 'Yacht';
      case VehicleClass.privateJet:
        return 'Private Jet';
    }
  }
}

class _PremiumVehicleCard extends StatelessWidget {
  final PremiumVehicle vehicle;

  const _PremiumVehicleCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _showVehicleDetails(context, vehicle),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle Image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [Colors.grey[300]!, Colors.grey[100]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.directions_car,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getClassColor(vehicle.vehicleClass),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          vehicle.classDisplayName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            vehicle.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 5.0,
                                  color: Colors.black54,
                                  offset: Offset(1.0, 1.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Vehicle Details
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicle.displayName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                vehicle.color,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${vehicle.pricePerKm.toStringAsFixed(0)}/km',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.accentColor,
                              ),
                            ),
                            Text(
                              '\$${vehicle.pricePerMinute.toStringAsFixed(0)}/min',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Features
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (vehicle.hasWifi) _FeatureChip(icon: Icons.wifi, label: 'WiFi'),
                        if (vehicle.hasBar) _FeatureChip(icon: Icons.local_bar, label: 'Bar'),
                        if (vehicle.hasMassage) _FeatureChip(icon: Icons.airline_seat_legroom_extra, label: 'Massage'),
                        if (vehicle.hasPrivacyPartition) _FeatureChip(icon: Icons.privacy_tip, label: 'Privacy'),
                        if (vehicle.hasEntertainment) _FeatureChip(icon: Icons.tv, label: 'Entertainment'),
                        _FeatureChip(icon: Icons.people, label: '${vehicle.maxPassengers} seats'),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Text(
                      vehicle.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _bookVehicle(context, vehicle),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Book This Vehicle',
                          style: TextStyle(
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
        ),
      ),
    );
  }

  Color _getClassColor(VehicleClass vehicleClass) {
    switch (vehicleClass) {
      case VehicleClass.luxury:
        return Colors.blue;
      case VehicleClass.superLuxury:
        return Colors.purple;
      case VehicleClass.exotic:
        return Colors.red;
      case VehicleClass.vintage:
        return Colors.brown;
      case VehicleClass.limousine:
        return Colors.black;
      case VehicleClass.suv:
        return Colors.green;
      case VehicleClass.helicopter:
        return Colors.orange;
      case VehicleClass.yacht:
        return Colors.cyan;
      case VehicleClass.privateJet:
        return Colors.indigo;
    }
  }

  void _showVehicleDetails(BuildContext context, PremiumVehicle vehicle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.6,
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

                  // Vehicle Header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vehicle.displayName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${vehicle.color} • ${vehicle.plateNumber}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
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
                          color: _getClassColor(vehicle.vehicleClass),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          vehicle.classDisplayName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Pricing
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '\$${vehicle.pricePerKm.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.accentColor,
                                ),
                              ),
                              const Text(
                                'per km',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: Colors.grey[300],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '\$${vehicle.pricePerMinute.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.accentColor,
                                ),
                              ),
                              const Text(
                                'per minute',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    vehicle.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Features
                  const Text(
                    'Premium Features',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...vehicle.features.map((feature) => Padding(
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
                            feature,
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
                        _bookVehicle(context, vehicle);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Book This Vehicle',
                        style: TextStyle(
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

  void _bookVehicle(BuildContext context, PremiumVehicle vehicle) {
    // Show booking confirmation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Vehicle Booked'),
        content: Text('Your ${vehicle.displayName} has been reserved successfully.'),
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

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
