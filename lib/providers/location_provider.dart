import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LocationProvider extends ChangeNotifier {
  Position? _currentPosition;
  String? _currentAddress;
  bool _isLoading = false;
  String? _error;
  bool _hasPermission = false;

  Position? get currentPosition => _currentPosition;
  String? get currentAddress => _currentAddress;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasPermission => _hasPermission;

  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    _hasPermission = status.isGranted;
    notifyListeners();
    return _hasPermission;
  }

  Future<void> getCurrentLocation({BuildContext? context}) async {
    // Bypass for testing if context is provided and authProvider indicates bypass user
    if (context != null) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.phoneNumber == '960700200') {
        _currentPosition = Position(
          latitude: 9.0192,
          longitude: 38.7525,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0.0,
          headingAccuracy: 0.0,
        );
        _currentAddress = 'Mock Street, Addis Ababa, Ethiopia';
        _isLoading = false;
        notifyListeners();
        return;
      }
    }

    if (!_hasPermission) {
      final granted = await requestLocationPermission();
      if (!granted) {
        _error = 'Location permission denied';
        notifyListeners();
        return;
      }
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _currentPosition = position;
      
      // Get address from coordinates
      await _getAddressFromCoordinates(position.latitude, position.longitude);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    _currentAddress = 'Unknown location';
  }

  Future<void> searchPlaces(String query) async {
    // Search functionality disabled as geocoding is not available
    notifyListeners();
  }

  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    return Geolocator.distanceBetween(lat1, lng1, lat2, lng2) / 1000; // in km
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearSearchResults() {
    // Search functionality disabled as geocoding is not available
    notifyListeners();
  }
}
