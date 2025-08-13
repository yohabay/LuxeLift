import 'package:flutter/material.dart';
import '../models/driver_model.dart';
import '../models/ride_model.dart';
import '../services/api_service.dart';
import '../enums/ride_status.dart';

class DriverProvider extends ChangeNotifier {
  Driver? _driver;
  bool _isOnline = false;
  bool _isLoading = false;
  String? _error;
  List<Ride> _activeRides = [];
  List<Ride> _rideHistory = [];
  double _todayEarnings = 0.0;
  double _weeklyEarnings = 0.0;
  double _monthlyEarnings = 0.0;

  Driver? get driver => _driver;
  bool get isOnline => _isOnline;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Ride> get activeRides => _activeRides;
  List<Ride> get rideHistory => _rideHistory;
  double get todayEarnings => _todayEarnings;
  double get weeklyEarnings => _weeklyEarnings;
  double get monthlyEarnings => _monthlyEarnings;

  final ApiService _apiService = ApiService();

  Future<void> toggleOnlineStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      _isOnline = !_isOnline;
      await _apiService.updateDriverStatus(_isOnline);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isOnline = !_isOnline; // Revert on error
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> acceptRide(String rideId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.acceptRide(rideId);
      // Update ride status in active rides
      final rideIndex = _activeRides.indexWhere((r) => r.id == rideId);
      if (rideIndex != -1) {
        _activeRides[rideIndex] = _activeRides[rideIndex].copyWith(status: RideStatus.accepted);
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> startTrip(String rideId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.startTrip(rideId);
      final rideIndex = _activeRides.indexWhere((r) => r.id == rideId);
      if (rideIndex != -1) {
        _activeRides[rideIndex] = _activeRides[rideIndex].copyWith(status: RideStatus.inProgress);
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> completeTrip(String rideId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final completedRideData = await _apiService.completeTrip(rideId);
      final completedRide = Ride.fromJson(completedRideData);
      
      // Move from active to history
      _activeRides.removeWhere((r) => r.id == rideId);
      _rideHistory.insert(0, completedRide);
      
      // Update earnings
      _todayEarnings += completedRide.fare;
      _weeklyEarnings += completedRide.fare;
      _monthlyEarnings += completedRide.fare;
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadEarnings() async {
    _isLoading = true;
    notifyListeners();

    try {
      final earnings = await _apiService.getDriverEarnings();
      _todayEarnings = (earnings['today'] ?? 0.0).toDouble();
      _weeklyEarnings = (earnings['weekly'] ?? 0.0).toDouble();
      _monthlyEarnings = (earnings['monthly'] ?? 0.0).toDouble();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
