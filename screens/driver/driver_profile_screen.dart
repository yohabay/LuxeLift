import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/driver_provider.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/driver/home'),
        ),
      ),
      body: Consumer2<AuthProvider, DriverProvider>(
        builder: (context, authProvider, driverProvider, _) {
          final user = authProvider.user;
          final driver = driverProvider.driver;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          user?.name.substring(0, 1).toUpperCase() ?? 'D',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.name ?? 'Driver Name',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${driver?.rating.toStringAsFixed(1) ?? '4.8'} Rating',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '${driver?.totalTrips ?? 0} Trips',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Vehicle Information
                _ProfileSection(
                  title: 'Vehicle Information',
                  children: [
                    _ProfileItem(
                      icon: Icons.directions_car,
                      title: 'Vehicle',
                      subtitle: driver?.vehicle.displayName ?? 'White Toyota Corolla',
                    ),
                    _ProfileItem(
                      icon: Icons.confirmation_number,
                      title: 'License Plate',
                      subtitle: driver?.vehicle.plateNumber ?? 'AA-123-456',
                    ),
                    _ProfileItem(
                      icon: Icons.calendar_today,
                      title: 'Year',
                      subtitle: driver?.vehicle.year.toString() ?? '2020',
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Personal Information
                _ProfileSection(
                  title: 'Personal Information',
                  children: [
                    _ProfileItem(
                      icon: Icons.phone,
                      title: 'Phone',
                      subtitle: user?.phone ?? '+251 9XX XXX XXX',
                    ),
                    _ProfileItem(
                      icon: Icons.email,
                      title: 'Email',
                      subtitle: driver?.email ?? 'driver@example.com',
                    ),
                    _ProfileItem(
                      icon: Icons.badge,
                      title: 'License Number',
                      subtitle: driver?.licenseNumber ?? 'DL123456789',
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Account Status
                _ProfileSection(
                  title: 'Account Status',
                  children: [
                    _ProfileItem(
                      icon: Icons.verified,
                      title: 'Verification Status',
                      subtitle: driver?.isVerified == true ? 'Verified' : 'Pending',
                      trailing: Icon(
                        driver?.isVerified == true ? Icons.check_circle : Icons.pending,
                        color: driver?.isVerified == true ? Colors.green : Colors.orange,
                      ),
                    ),
                    _ProfileItem(
                      icon: Icons.calendar_today,
                      title: 'Member Since',
                      subtitle: _formatDate(driver?.joinDate ?? DateTime.now()),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Action Buttons
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Edit profile functionality
                        },
                        child: const Text('Edit Profile'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          // Support functionality
                        },
                        child: const Text('Contact Support'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          authProvider.logout();
                          context.go('/');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Logout'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _ProfileSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;

  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600]),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
