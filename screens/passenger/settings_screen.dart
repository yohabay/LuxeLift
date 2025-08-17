import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _locationEnabled = true;
  bool _biometricEnabled = true;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppTheme.lightBackground,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSettingsSection(
              title: 'Notifications & Alerts',
              items: [
                _SettingsItem(
                  icon: Icons.notifications_outlined,
                  title: 'Push Notifications',
                  subtitle: 'Receive ride updates and offers',
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                    activeColor: AppTheme.primaryColor,
                  ),
                ),
                _SettingsItem(
                  icon: Icons.email_outlined,
                  title: 'Email Notifications',
                  subtitle: 'Trip receipts and promotional emails',
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: AppTheme.primaryColor,
                  ),
                ),
                _SettingsItem(
                  icon: Icons.sms_outlined,
                  title: 'SMS Alerts',
                  subtitle: 'Critical ride updates via SMS',
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                    activeColor: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            _buildSettingsSection(
              title: 'Privacy & Security',
              items: [
                _SettingsItem(
                  icon: Icons.fingerprint,
                  title: 'Biometric Authentication',
                  subtitle: 'Use fingerprint or face unlock',
                  trailing: Switch(
                    value: _biometricEnabled,
                    onChanged: (value) {
                      setState(() {
                        _biometricEnabled = value;
                      });
                    },
                    activeColor: AppTheme.primaryColor,
                  ),
                ),
                _SettingsItem(
                  icon: Icons.location_on_outlined,
                  title: 'Location Services',
                  subtitle: 'Allow location access for better service',
                  trailing: Switch(
                    value: _locationEnabled,
                    onChanged: (value) {
                      setState(() {
                        _locationEnabled = value;
                      });
                    },
                    activeColor: AppTheme.primaryColor,
                  ),
                ),
                _SettingsItem(
                  icon: Icons.shield_outlined,
                  title: 'Data Privacy',
                  subtitle: 'Manage your data and privacy settings',
                  onTap: () {},
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            _buildSettingsSection(
              title: 'App Preferences',
              items: [
                _SettingsItem(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Switch to dark theme',
                  trailing: Switch(
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                    activeColor: AppTheme.primaryColor,
                  ),
                ),
                _SettingsItem(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: _selectedLanguage,
                  onTap: () => _showLanguageSelector(),
                ),
                _SettingsItem(
                  icon: Icons.attach_money,
                  title: 'Currency',
                  subtitle: _selectedCurrency,
                  onTap: () => _showCurrencySelector(),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            _buildSettingsSection(
              title: 'Support & Information',
              items: [
                _SettingsItem(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  subtitle: 'Get help and support',
                  onTap: () {},
                ),
                _SettingsItem(
                  icon: Icons.chat_outlined,
                  title: 'Contact Support',
                  subtitle: '24/7 customer support',
                  onTap: () {},
                ),
                _SettingsItem(
                  icon: Icons.star_outline,
                  title: 'Rate LuxeLift',
                  subtitle: 'Share your experience',
                  onTap: () {},
                ),
                _SettingsItem(
                  icon: Icons.share_outlined,
                  title: 'Share App',
                  subtitle: 'Invite friends to LuxeLift',
                  onTap: () {},
                ),
                _SettingsItem(
                  icon: Icons.info_outline,
                  title: 'About LuxeLift',
                  subtitle: 'Version 2.1.0',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<_SettingsItem> items,
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
          ...items.map((item) => _buildSettingsTile(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(_SettingsItem item) {
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
        subtitle: Text(
          item.subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
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

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondaryColor,
                ),
              ),
            ),
            ...['English', 'Amharic', 'Oromo', 'Tigrinya'].map((language) {
              return ListTile(
                title: Text(language),
                trailing: _selectedLanguage == language
                    ? const Icon(Icons.check, color: AppTheme.primaryColor)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedLanguage = language;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showCurrencySelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Select Currency',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondaryColor,
                ),
              ),
            ),
            ...['USD', 'ETB', 'EUR', 'GBP'].map((currency) {
              return ListTile(
                title: Text(currency),
                trailing: _selectedCurrency == currency
                    ? const Icon(Icons.check, color: AppTheme.primaryColor)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedCurrency = currency;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });
}
