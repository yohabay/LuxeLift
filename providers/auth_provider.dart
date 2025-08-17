import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;
  String? _phoneNumber;

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get phoneNumber => _phoneNumber;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final userData = prefs.getString('user_data');

      if (token != null && userData != null) {
        _user = User.fromJson({
          'id': 'mock_user_id',
          'name': 'Test User',
          'email': 'test@example.com',
          'phone': '960700200',
          'userType': 'passenger', // ✅ fixed
          'rating': 4.5,
          'totalTrips': 10,
          'createdAt': DateTime.now().toIso8601String(),
        });
        _isAuthenticated = true;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> sendOtp(String phoneNumber) async {
    _isLoading = true;
    _error = null;
    _phoneNumber = phoneNumber;
    notifyListeners();

    // Mock behavior: always succeed
    await Future.delayed(Duration(seconds: 1)); // simulate network delay
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1)); // simulate network delay

    // Mock Passenger
    if (phoneNumber == '960700200' && otp == '123456') {
      _user = User(
        id: 'mock_user_id',
        name: 'Test User',
        phone: '0960700200',
        email: 'test@example.com',
        userType: 'passenger',
        rating: 4.5,
        totalTrips: 10,
        createdAt: DateTime.now(),
      );
      _isAuthenticated = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', 'mock_auth_token');
      await prefs.setString('user_data', _user!.toJson().toString());

      _isLoading = false;
      notifyListeners();
      return true;
    }

    // Mock Driver
    if (phoneNumber == '960700200' && otp == '654321') {
      _user = User(
        id: 'mock_driver_id',
        name: 'Test Driver',
        phone: '960700200',
        email: 'driver@example.com',
        userType: 'driver',
        rating: 4.9,
        totalTrips: 50,
        createdAt: DateTime.now(),
      );
      _isAuthenticated = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', 'mock_auth_token_driver');
      await prefs.setString('user_data', _user!.toJson().toString());

      _isLoading = false;
      notifyListeners();
      return true;
    }

    // Any other OTP fails
    _error = 'Invalid OTP';
    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> registerAndVerifyOtp({
    required String phoneNumber,
    required String otp,
    required String fullName,
    String? email,
    required bool isElite,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Mock registration: succeed if OTP is '123456'
    if (otp == '123456') {
      _user = User(
        id: 'new_driver_${DateTime.now().millisecondsSinceEpoch}',
        name: fullName,
        phone: phoneNumber,
        email: email != null && email.isNotEmpty ? email : null,
        userType: isElite ? 'elite_driver' : 'driver',
        rating: 5.0, // Initial rating
        totalTrips: 0, // New driver
        createdAt: DateTime.now(),
      );
      _isAuthenticated = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', 'mock_auth_token_new_driver');
      await prefs.setString('user_data', _user!.toJson().toString());

      _isLoading = false;
      notifyListeners();
      return true;
    }

    _error = 'Invalid OTP. Please try again.';
    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');

    _user = null;
    _isAuthenticated = false;
    _error = null;
    _phoneNumber = null;

    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<bool> updateProfile({String? name, String? email}) async {
    _isLoading = true;
    notifyListeners();

    // Mock update
    await Future.delayed(Duration(seconds: 1));
    _user = User.fromJson({
      'id': _user?.id ?? 'mock_user_id',
      'name': name ?? _user?.name ?? 'Test User',
      'email': email ?? _user?.email ?? 'test@example.com',
      'phone': _user?.phone ?? '0960700200',
      'userType': 'passenger', // correct
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', _user!.toJson().toString());

    _isLoading = false;
    notifyListeners();
    return true;
  }
}
