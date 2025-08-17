import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: user == null
          ? const Center(child: Text('User not logged in'))
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 280,
                  floating: false,
                  pinned: true,
                  backgroundColor: AppTheme.secondaryColor,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppTheme.secondaryColor,
                            AppTheme.secondaryColorLight,
                          ],
                        ),
                      ),
                      child: SafeArea(
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 40),
                                // Premium profile avatar with glow effect
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.primaryColor.withOpacity(0.3),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: AppTheme.primaryColor,
                                    child: Text(
                                      user.name.substring(0, 1).toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 36,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star, color: AppTheme.accentColor, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${user.rating?.toStringAsFixed(1) ?? '5.0'} Elite Member',
                                        style: const TextStyle(
                                          color: AppTheme.accentColor,
                                          fontWeight: FontWeight.w600,
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
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: Colors.white),
                      onPressed: () {
                        // Handle edit profile
                      },
                    ),
                  ],
                ),
                
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Stats row
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.directions_car,
                                title: 'Total Trips',
                                value: '${user.totalTrips ?? 47}',
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.access_time,
                                title: 'Hours Saved',
                                value: '${(user.totalTrips ?? 47) * 0.5}h',
                                color: AppTheme.secondaryColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.eco,
                                title: 'CO₂ Saved',
                                value: '${(user.totalTrips ?? 47) * 2.1}kg',
                                color: AppTheme.accentColor,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        _buildPremiumSection(
                          title: 'Account & Security',
                          items: [
                            _PremiumListItem(
                              icon: Icons.shield_outlined,
                              title: 'Privacy & Security',
                              subtitle: 'Manage your data and privacy settings',
                              onTap: () {},
                            ),
                            _PremiumListItem(
                              icon: Icons.lock_outline,
                              title: 'Change Password',
                              subtitle: 'Update your account password',
                              onTap: () {},
                            ),
                            _PremiumListItem(
                              icon: Icons.fingerprint,
                              title: 'Biometric Login',
                              subtitle: 'Enable fingerprint or face unlock',
                              trailing: Switch(
                                value: true,
                                onChanged: (value) {},
                                activeColor: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        _buildPremiumSection(
                          title: 'Preferences & Experience',
                          items: [
                            _PremiumListItem(
                              icon: Icons.tune,
                              title: 'Ride Preferences',
                              subtitle: 'Customize your default ride settings',
                              onTap: () => context.push('/passenger/ride-customization'),
                            ),
                            _PremiumListItem(
                              icon: Icons.contacts_outlined,
                              title: 'Emergency Contacts',
                              subtitle: '3 contacts added',
                              onTap: () {},
                            ),
                            _PremiumListItem(
                              icon: Icons.language,
                              title: 'Language & Region',
                              subtitle: 'English (US)',
                              onTap: () {},
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        _buildPremiumSection(
                          title: 'Membership & Rewards',
                          items: [
                            _PremiumListItem(
                              icon: Icons.card_membership,
                              title: 'Elite Membership',
                              subtitle: 'Gold Elite • 2,450 points available',
                              onTap: () => context.push('/passenger/loyalty-rewards'),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'GOLD',
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            _PremiumListItem(
                              icon: Icons.card_giftcard,
                              title: 'Referral Program',
                              subtitle: 'Earn \$10 for each friend you invite',
                              onTap: () {},
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 32),
                        
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.errorColor.withOpacity(0.3)),
                          ),
                          child: TextButton.icon(
                            onPressed: () {
                              _showLogoutDialog(context, authProvider);
                            },
                            icon: const Icon(Icons.logout, color: AppTheme.errorColor),
                            label: const Text(
                              'Sign Out',
                              style: TextStyle(
                                color: AppTheme.errorColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumSection({
    required String title,
    required List<_PremiumListItem> items,
  }) {
    return Container(
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.secondaryColor,
              ),
            ),
          ),
          ...items.map((item) => _buildPremiumListTile(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildPremiumListTile(_PremiumListItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            item.icon,
            color: AppTheme.primaryColor,
            size: 20,
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.secondaryColor,
          ),
        ),
        subtitle: item.subtitle != null
            ? Text(
                item.subtitle!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              )
            : null,
        trailing: item.trailing ??
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
        onTap: item.onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out of your account?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                authProvider.logout();
                Navigator.of(context).pop();
                context.go('/auth/welcome');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
              ),
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }
}

class _PremiumListItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  _PremiumListItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });
}
