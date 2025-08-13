import 'package:flutter/material.dart';
import '../models/luxury_service_model.dart';
import '../models/premium_vehicle_model.dart';
import '../models/vip_membership_model.dart';

class LuxuryServiceProvider extends ChangeNotifier {
  List<LuxuryService> _availableServices = [];
  List<PremiumVehicle> _premiumVehicles = [];
  VipMembership? _userMembership;
  bool _isLoading = false;
  String? _error;

  List<LuxuryService> get availableServices => _availableServices;
  List<PremiumVehicle> get premiumVehicles => _premiumVehicles;
  VipMembership? get userMembership => _userMembership;
  bool get isLoading => _isLoading;
  String? get error => _error;

  LuxuryServiceProvider() {
    _initializeLuxuryServices();
    _initializePremiumVehicles();
    _initializeUserMembership();
  }

  void _initializeLuxuryServices() {
    _availableServices = [
      LuxuryService(
        id: 'concierge_1',
        type: LuxuryServiceType.concierge,
        name: 'Personal Concierge',
        description: 'Dedicated personal assistant for your entire journey',
        basePrice: 150.0,
        durationMinutes: 480,
        inclusions: [
          'Personal assistant',
          'Restaurant reservations',
          'Event planning',
          'Shopping assistance',
          'Travel arrangements'
        ],
        requiresAdvanceBooking: true,
        minAdvanceHours: 24,
        iconPath: 'assets/icons/concierge.png',
      ),
      LuxuryService(
        id: 'vip_airport_1',
        type: LuxuryServiceType.airportVip,
        name: 'VIP Airport Experience',
        description: 'Skip lines with our premium airport service',
        basePrice: 200.0,
        durationMinutes: 180,
        inclusions: [
          'Fast-track security',
          'Lounge access',
          'Personal escort',
          'Baggage handling',
          'Meet & greet service'
        ],
        requiresAdvanceBooking: true,
        minAdvanceHours: 12,
        iconPath: 'assets/icons/airport_vip.png',
      ),
      LuxuryService(
        id: 'bodyguard_1',
        type: LuxuryServiceType.bodyguard,
        name: 'Executive Protection',
        description: 'Professional security detail for high-profile clients',
        basePrice: 500.0,
        durationMinutes: 480,
        inclusions: [
          'Trained security personnel',
          'Risk assessment',
          'Route planning',
          'Discrete protection',
          '24/7 monitoring'
        ],
        requiresAdvanceBooking: true,
        minAdvanceHours: 48,
        iconPath: 'assets/icons/bodyguard.png',
      ),
      LuxuryService(
        id: 'helicopter_1',
        type: LuxuryServiceType.helicopter,
        name: 'Helicopter Transfer',
        description: 'Skip traffic with luxury helicopter transport',
        basePrice: 2000.0,
        durationMinutes: 60,
        inclusions: [
          'Luxury helicopter',
          'Professional pilot',
          'Champagne service',
          'Aerial photography',
          'Landing permits'
        ],
        requiresAdvanceBooking: true,
        minAdvanceHours: 72,
        iconPath: 'assets/icons/helicopter.png',
      ),
    ];
  }

  void _initializePremiumVehicles() {
    _premiumVehicles = [
      PremiumVehicle(
        id: 'rolls_royce_1',
        make: 'Rolls-Royce',
        model: 'Phantom',
        year: 2024,
        vehicleClass: VehicleClass.superLuxury,
        color: 'Midnight Black',
        plateNumber: 'LUX-001',
        features: [
          'Starlight Headliner',
          'Champagne Cooler',
          'Massage Seats',
          'Privacy Glass',
          'Premium Sound System'
        ],
        images: [
          'assets/vehicles/rolls_royce_phantom_1.jpg',
          'assets/vehicles/rolls_royce_phantom_2.jpg',
        ],
        pricePerKm: 15.0,
        pricePerMinute: 5.0,
        maxPassengers: 4,
        hasWifi: true,
        hasBar: true,
        hasMassage: true,
        hasPrivacyPartition: true,
        hasEntertainment: true,
        description: 'The pinnacle of luxury motoring with unparalleled comfort and prestige.',
        rating: 4.9,
      ),
      PremiumVehicle(
        id: 'bentley_1',
        make: 'Bentley',
        model: 'Mulsanne',
        year: 2023,
        vehicleClass: VehicleClass.luxury,
        color: 'Pearl White',
        plateNumber: 'LUX-002',
        features: [
          'Handcrafted Interior',
          'Rear Entertainment',
          'Climate Control',
          'Premium Leather',
          'Mood Lighting'
        ],
        images: [
          'assets/vehicles/bentley_mulsanne_1.jpg',
          'assets/vehicles/bentley_mulsanne_2.jpg',
        ],
        pricePerKm: 12.0,
        pricePerMinute: 4.0,
        maxPassengers: 4,
        hasWifi: true,
        hasBar: false,
        hasMassage: true,
        hasPrivacyPartition: false,
        hasEntertainment: true,
        description: 'British luxury at its finest with exceptional craftsmanship.',
        rating: 4.8,
      ),
      PremiumVehicle(
        id: 'ferrari_1',
        make: 'Ferrari',
        model: 'Roma',
        year: 2024,
        vehicleClass: VehicleClass.exotic,
        color: 'Rosso Corsa',
        plateNumber: 'LUX-003',
        features: [
          'V8 Turbo Engine',
          'Carbon Fiber Interior',
          'Sport Seats',
          'Premium Audio',
          'Performance Mode'
        ],
        images: [
          'assets/vehicles/ferrari_roma_1.jpg',
          'assets/vehicles/ferrari_roma_2.jpg',
        ],
        pricePerKm: 25.0,
        pricePerMinute: 8.0,
        maxPassengers: 2,
        hasWifi: true,
        hasBar: false,
        hasMassage: false,
        hasPrivacyPartition: false,
        hasEntertainment: true,
        description: 'Italian supercar excellence for the ultimate driving experience.',
        rating: 4.9,
      ),
    ];
  }

  void _initializeUserMembership() {
    // Mock VIP membership for demonstration
    _userMembership = VipMembership(
      id: 'membership_1',
      userId: 'user_1',
      tier: MembershipTier.diamond,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now().add(const Duration(days: 335)),
      annualFee: 5000.0,
      benefits: [
        'Priority booking',
        'Personal concierge',
        'Airport lounge access',
        'Free cancellation',
        'Exclusive vehicles',
        '24/7 support'
      ],
      discountPercentage: 15.0,
      hasPersonalConcierge: true,
      hasPriorityBooking: true,
      hasAirportLounge: true,
      hasFreeCancellation: true,
      freeRidesPerMonth: 5,
      creditBalance: 1250.0,
    );
  }

  Future<void> bookLuxuryService(String serviceId, DateTime scheduledTime) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // In a real app, this would make an API call to book the service
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> upgradeMembership(MembershipTier newTier) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Update membership tier
      if (_userMembership != null) {
        _userMembership = VipMembership(
          id: _userMembership!.id,
          userId: _userMembership!.userId,
          tier: newTier,
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 365)),
          annualFee: _getAnnualFeeForTier(newTier),
          benefits: _getBenefitsForTier(newTier),
          discountPercentage: _getDiscountForTier(newTier),
          hasPersonalConcierge: newTier.index >= MembershipTier.diamond.index,
          hasPriorityBooking: true,
          hasAirportLounge: newTier.index >= MembershipTier.diamond.index,
          hasFreeCancellation: true,
          freeRidesPerMonth: _getFreeRidesForTier(newTier),
          creditBalance: _userMembership!.creditBalance,
        );
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  double _getAnnualFeeForTier(MembershipTier tier) {
    switch (tier) {
      case MembershipTier.platinum:
        return 2500.0;
      case MembershipTier.diamond:
        return 5000.0;
      case MembershipTier.black:
        return 10000.0;
      case MembershipTier.royal:
        return 25000.0;
    }
  }

  List<String> _getBenefitsForTier(MembershipTier tier) {
    final baseBenefits = ['Priority booking', 'Free cancellation', '24/7 support'];
    
    switch (tier) {
      case MembershipTier.platinum:
        return [...baseBenefits, '10% discount', '2 free rides/month'];
      case MembershipTier.diamond:
        return [...baseBenefits, 'Personal concierge', 'Airport lounge', '15% discount', '5 free rides/month'];
      case MembershipTier.black:
        return [...baseBenefits, 'Personal concierge', 'Airport lounge', 'Exclusive vehicles', '20% discount', '10 free rides/month'];
      case MembershipTier.royal:
        return [...baseBenefits, 'Personal concierge', 'Airport lounge', 'Exclusive vehicles', 'Private jet access', '25% discount', 'Unlimited rides'];
    }
  }

  double _getDiscountForTier(MembershipTier tier) {
    switch (tier) {
      case MembershipTier.platinum:
        return 10.0;
      case MembershipTier.diamond:
        return 15.0;
      case MembershipTier.black:
        return 20.0;
      case MembershipTier.royal:
        return 25.0;
    }
  }

  int _getFreeRidesForTier(MembershipTier tier) {
    switch (tier) {
      case MembershipTier.platinum:
        return 2;
      case MembershipTier.diamond:
        return 5;
      case MembershipTier.black:
        return 10;
      case MembershipTier.royal:
        return 999; // Unlimited
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
