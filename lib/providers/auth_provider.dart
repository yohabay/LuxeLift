import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;
  String? _phoneNumber;
  String? _verificationId;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get phoneNumber => _phoneNumber;
  String? get verificationId => _verificationId;
  bool get isAuthenticated => _user != null;

  Future<void> sendOTP(String phoneNumber) async {
    _isLoading = true;
    _error = null;
    _phoneNumber = phoneNumber;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock verification ID
      _verificationId = 'mock_verification_id_${DateTime.now().millisecondsSinceEpoch}';
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> verifyOTP(String otp) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock verification - accept any 6-digit OTP
      if (otp.length == 6) {
        // Create mock user
        _user = User(
          id: 'user_${DateTime.now().millisecondsSinceEpoch}',
          name: _phoneNumber == '960700200' ? 'Test User' : 'John Doe',
          phone: _phoneNumber ?? '',
          email: 'user@example.com',
          userType: UserType.passenger,
          isVerified: true,
          createdAt: DateTime.now(),
          rating: 4.8,
          totalTrips: 25,
        );
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Invalid OTP';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _user = null;
    _phoneNumber = null;
    _verificationId = null;
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<void> updateProfile({
    String? name,
    String? email,
  }) async {
    if (_user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      _user = _user!.copyWith(
        name: name ?? _user!.name,
        email: email ?? _user!.email,
      );
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> switchUserType(UserType newType) async {
    if (_user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      _user = _user!.copyWith(userType: newType);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
