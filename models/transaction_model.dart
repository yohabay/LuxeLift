enum TransactionType { credit, debit }
enum TransactionStatus { pending, completed, failed }

class Transaction {
  final String id;
  final String userId;
  final double amount;
  final TransactionType type;
  final TransactionStatus status;
  final String description;
  final String? rideId;
  final String? paymentMethod;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.status,
    required this.description,
    this.rideId,
    this.paymentMethod,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      type: TransactionType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => TransactionType.debit,
      ),
      status: TransactionStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => TransactionStatus.pending,
      ),
      description: json['description'] ?? '',
      rideId: json['rideId'],
      paymentMethod: json['paymentMethod'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'description': description,
      'rideId': rideId,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
