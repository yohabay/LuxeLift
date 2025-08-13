import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://api.example.com/api';
  
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await _getAuthToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Auth endpoints
  Future<Map<String, dynamic>> sendOtp(String phoneNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/send-otp'),
      headers: await _getHeaders(),
      body: jsonEncode({'phoneNumber': phoneNumber}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send OTP: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String phoneNumber, String otp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/verify-otp'),
      headers: await _getHeaders(),
      body: jsonEncode({
        'phoneNumber': phoneNumber,
        'otp': otp,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to verify OTP: ${response.body}');
    }
  }

  // User endpoints
  Future<Map<String, dynamic>> getUserProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/profile'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user profile: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/user/profile'),
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }

  // Driver endpoints
  Future<void> updateDriverStatus(bool isOnline) async {
    final response = await http.put(
      Uri.parse('$baseUrl/driver/status'),
      headers: await _getHeaders(),
      body: jsonEncode({'isOnline': isOnline}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update driver status: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> acceptRide(String rideId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/rides/$rideId/accept'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to accept ride: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> startTrip(String rideId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/rides/$rideId/start'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to start trip: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> completeTrip(String rideId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/rides/$rideId/complete'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to complete trip: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getDriverEarnings() async {
    final response = await http.get(
      Uri.parse('$baseUrl/driver/earnings'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get driver earnings: ${response.body}');
    }
  }

  // Ride endpoints
  Future<Map<String, dynamic>> bookRide(Map<String, dynamic> rideData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/rides'),
      headers: await _getHeaders(),
      body: jsonEncode(rideData),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to book ride: ${response.body}');
    }
  }

  Future<List<dynamic>> getRideHistory() async {
    final response = await http.get(
      Uri.parse('$baseUrl/rides/history'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get ride history: ${response.body}');
    }
  }

  Future<void> cancelRide(String rideId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/rides/$rideId'),
      headers: await _getHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel ride: ${response.body}');
    }
  }

  Future<void> rateDriver(Map<String, dynamic> ratingData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/rides/rate'),
      headers: await _getHeaders(),
      body: jsonEncode(ratingData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to rate driver: ${response.body}');
    }
  }

  // Wallet endpoints
  Future<Map<String, dynamic>> getWallet() async {
    final response = await http.get(
      Uri.parse('$baseUrl/wallet'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get wallet: ${response.body}');
    }
  }

  Future<List<dynamic>> getTransactions() async {
    final response = await http.get(
      Uri.parse('$baseUrl/wallet/transactions'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get transactions: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> addMoney(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/wallet/add'),
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add money: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> withdrawMoney(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/wallet/withdraw'),
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to withdraw money: ${response.body}');
    }
  }

  // Notification endpoints
  Future<List<dynamic>> getNotifications() async {
    final response = await http.get(
      Uri.parse('$baseUrl/notifications'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get notifications: ${response.body}');
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    final response = await http.put(
      Uri.parse('$baseUrl/notifications/$notificationId/read'),
      headers: await _getHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to mark notification as read: ${response.body}');
    }
  }

  Future<void> markAllNotificationsAsRead() async {
    final response = await http.put(
      Uri.parse('$baseUrl/notifications/read-all'),
      headers: await _getHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to mark all notifications as read: ${response.body}');
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/notifications/$notificationId'),
      headers: await _getHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete notification: ${response.body}');
    }
  }
}
