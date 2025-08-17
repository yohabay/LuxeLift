import 'package:flutter/material.dart';
import '../models/wallet_model.dart';
import '../models/transaction_model.dart';
import '../services/api_service.dart';

class WalletProvider extends ChangeNotifier {
  Wallet? _wallet;
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  String? _error;

  Wallet? get wallet => _wallet;
  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final ApiService _apiService = ApiService();

  Future<void> loadWallet() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getWallet();
      _wallet = Wallet.fromJson(response);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadTransactions() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getTransactions();
      _transactions = (response as List)
          .map((transaction) => Transaction.fromJson(transaction))
          .toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addMoney(double amount, String paymentMethod) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.addMoney({
        'amount': amount,
        'paymentMethod': paymentMethod,
      });

      _wallet = Wallet.fromJson(response);
      await loadTransactions(); // Refresh transactions
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> withdrawMoney(double amount, String bankAccount) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.withdrawMoney({
        'amount': amount,
        'bankAccount': bankAccount,
      });

      _wallet = Wallet.fromJson(response);
      await loadTransactions(); // Refresh transactions
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
