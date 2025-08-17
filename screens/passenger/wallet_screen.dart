import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with TickerProviderStateMixin {
  double balance = 247.50;
  final TextEditingController addAmountController = TextEditingController();
  bool isLoading = false;
  late AnimationController _balanceAnimationController;
  late Animation<double> _balanceAnimation;

  final List<Map<String, dynamic>> transactions = [
    {
      'id': 'txn_1',
      'type': 'debit',
      'amount': 45.0,
      'description': 'Executive Ride to Merkato',
      'date': DateTime.now(),
      'category': 'ride',
    },
    {
      'id': 'txn_2',
      'type': 'credit',
      'amount': 100.0,
      'description': 'Elite Membership Bonus',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'category': 'bonus',
    },
    {
      'id': 'txn_3',
      'type': 'debit',
      'amount': 67.50,
      'description': 'Luxury Ride to CMC',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'category': 'ride',
    },
    {
      'id': 'txn_4',
      'type': 'credit',
      'amount': 200.0,
      'description': 'Wallet Top-up',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'category': 'topup',
    },
  ];

  @override
  void initState() {
    super.initState();
    _balanceAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _balanceAnimation = Tween<double>(begin: 0.0, end: balance).animate(
      CurvedAnimation(parent: _balanceAnimationController, curve: Curves.easeOut),
    );
    _balanceAnimationController.forward();
  }

  @override
  void dispose() {
    _balanceAnimationController.dispose();
    addAmountController.dispose();
    super.dispose();
  }

  Future<void> handleAddMoney() async {
    final amount = double.tryParse(addAmountController.text);
    if (amount == null || amount <= 0) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      balance += amount;
      transactions.insert(0, {
        'id': 'txn_${DateTime.now().millisecondsSinceEpoch}',
        'type': 'credit',
        'amount': amount,
        'description': 'Wallet Top-up',
        'date': DateTime.now(),
        'category': 'topup',
      });
      addAmountController.clear();
      isLoading = false;
    });

    // Animate new balance
    _balanceAnimation = Tween<double>(begin: balance - amount, end: balance).animate(
      CurvedAnimation(parent: _balanceAnimationController, curve: Curves.easeOut),
    );
    _balanceAnimationController.reset();
    _balanceAnimationController.forward();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Funds added successfully!'),
          backgroundColor: AppTheme.successColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.secondaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.secondaryColor,
                      AppTheme.secondaryColorLight,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: AppTheme.accentColor.withOpacity(0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.account_balance_wallet_outlined,
                                        color: AppTheme.accentColor,
                                        size: 24,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'LuxeLift Wallet',
                                        style: TextStyle(
                                          color: AppTheme.accentColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Text(
                                      'ELITE',
                                      style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              AnimatedBuilder(
                                animation: _balanceAnimation,
                                builder: (context, child) {
                                  return Text(
                                    '\$${_balanceAnimation.value.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Available Balance',
                                style: TextStyle(
                                  color: AppTheme.accentColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.go('/passenger/home'),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.add_circle_outline,
                          title: 'Add Funds',
                          color: AppTheme.primaryColor,
                          onTap: () => _showAddFundsBottomSheet(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.send_outlined,
                          title: 'Transfer',
                          color: AppTheme.secondaryColor,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.history,
                          title: 'History',
                          color: AppTheme.accentColor,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent Transactions',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.secondaryColor,
                                ),
                              ),
                              Text(
                                'View All',
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...transactions.take(5).map((transaction) => _buildTransactionTile(transaction)).toList(),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile(Map<String, dynamic> transaction) {
    final isCredit = transaction['type'] == 'credit';
    final category = transaction['category'] as String;
    
    IconData categoryIcon;
    Color categoryColor;
    
    switch (category) {
      case 'ride':
        categoryIcon = Icons.directions_car;
        categoryColor = AppTheme.primaryColor;
        break;
      case 'bonus':
        categoryIcon = Icons.card_giftcard;
        categoryColor = AppTheme.successColor;
        break;
      case 'topup':
        categoryIcon = Icons.add_circle;
        categoryColor = AppTheme.secondaryColor;
        break;
      default:
        categoryIcon = Icons.account_balance_wallet;
        categoryColor = AppTheme.accentColor;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lightBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: categoryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              categoryIcon,
              size: 20,
              color: categoryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['description'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.secondaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(transaction['date']),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isCredit ? '+' : '-'}\$${transaction['amount'].toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isCredit ? AppTheme.successColor : AppTheme.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddFundsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Funds',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondaryColor,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: addAmountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$ ',
                  hintText: '0.00',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Row(
                children: [25, 50, 100, 200].map((amount) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: OutlinedButton(
                        onPressed: () {
                          addAmountController.text = amount.toString();
                        },
                        child: Text('\$$amount'),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isLoading ? null : () {
                    handleAddMoney();
                    Navigator.pop(context);
                  },
                  child: Text(isLoading ? 'Processing...' : 'Add Funds'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
