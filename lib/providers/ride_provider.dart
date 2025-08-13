import 'package:flutter/material.dart';
import '../models/ride_model.dart';
import '../models/driver_model.dart';
import '../models/location_model.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';
import '../enums/ride_status.dart';

enum RideProviderStatus {
  idle,
  booking,
  findingDriver,
  driverFound,
  driverArrived,
  tripStarted,
  tripCompleted,
}

class RideProvider extends ChangeNotifier {
  RideProviderStatus _status = RideProviderStatus.idle;
  Ride? _currentRide;
  Driver? _assignedDriver;
  List<Ride> _rideHistory = [];
  bool _isLoading = false;
  String? _error;
  double _estimatedFare = 0.0;
  String _selectedVehicleType = 'economy';

  RideProviderStatus get status => _status;
  Ride? get currentRide => _currentRide;
  Driver? get assignedDriver => _assignedDriver;
  List<Ride> get rideHistory => _rideHistory;
  bool get isLoading => _isLoading;
  String? get error => _error;
  double get estimatedFare => _estimatedFare;
  String get selectedVehicleType => _selectedVehicleType;

  final ApiService _apiService = ApiService();

  void setSelectedVehicleType(String vehicleType) {
    _selectedVehicleType = vehicleType;
    _calculateEstimatedFare();
    notifyListeners();
  }

  void _calculateEstimatedFare() {
    // Calculate fare based on vehicle type and distance
    switch (_selectedVehicleType) {
      case 'economy':
        _estimatedFare = 25.0;
        break;
      case 'comfort':
        _estimatedFare = 35.0;
        break;
      case 'premium':
        _estimatedFare = 50.0;
        break;
      default:
        _estimatedFare = 25.0;
    }
  }

  Future<bool> bookRide({
    required String pickupLocation,
    required String dropoffLocation,
    required double pickupLat,
    required double pickupLng,
    required double dropoffLat,
    required double dropoffLng,
    required String vehicleType,
  }) async {
    _isLoading = true;
    _error = null;
    _status = RideProviderStatus.booking;
    notifyListeners();

    try {
      final response = await _apiService.bookRide({
        'pickupLocation': pickupLocation,
        'dropoffLocation': dropoffLocation,
        'pickupLat': pickupLat,
        'pickupLng': pickupLng,
        'dropoffLat': dropoffLat,
        'dropoffLng': dropoffLng,
        'vehicleType': vehicleType,
        'fare': _estimatedFare,
      });

      _currentRide = Ride.fromJson(response);
      _status = RideProviderStatus.findingDriver;
      _isLoading = false;
      notifyListeners();

      // Start looking for driver
      _findDriver();
      return true;
    } catch (e) {
      _error = e.toString();
      _status = RideProviderStatus.idle;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> _findDriver() async {
    // Simulate driver finding process
    await Future.delayed(const Duration(seconds: 5));
    
    // Mock driver data
    _assignedDriver = Driver(
      id: '1',
      name: 'John Doe',
      phone: '+1234567890',
      rating: 4.8,
      vehicle: Vehicle(
        make: 'Toyota',
        model: 'Camry',
        color: 'White',
        plateNumber: 'ABC 123',
        year: 2020,
      ),
      profileImage: null,
      currentLat: 37.7749,
      currentLng: -122.4194,
      totalTrips: 1250,
      yearsExperience: 5,
      joinDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
    );
    
    _status = RideProviderStatus.driverFound;
    await NotificationService.showDriverFoundNotification();
    notifyListeners();
  }

  void driverArrived() {
    _status = RideProviderStatus.driverArrived;
    NotificationService.showDriverArrivedNotification();
    notifyListeners();
  }

  void startTrip() {
    _status = RideProviderStatus.tripStarted;
    NotificationService.showTripStartedNotification();
    notifyListeners();
  }

  void completeTrip() {
    _status = RideProviderStatus.tripCompleted;
    if (_currentRide != null) {
      _rideHistory.insert(0, _currentRide!);
    }
    NotificationService.showTripCompletedNotification();
    notifyListeners();
  }

  void resetRide() {
    _status = RideProviderStatus.idle;
    _currentRide = null;
    _assignedDriver = null;
    _error = null;
    _estimatedFare = 0.0;
    notifyListeners();
  }

  Future<void> loadRideHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getRideHistory();
      _rideHistory = (response as List)
          .map((ride) => Ride.fromJson(ride))
          .toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> cancelRide() async {
    if (_currentRide == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.cancelRide(_currentRide!.id);
      resetRide();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> rateDriver(double rating, String? feedback) async {
    if (_currentRide == null || _assignedDriver == null) return false;

    try {
      await _apiService.rateDriver({
        'rideId': _currentRide!.id,
        'driverId': _assignedDriver!.id,
        'rating': rating,
        'feedback': feedback,
      });
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
