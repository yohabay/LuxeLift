import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/ride_preferences_model.dart';
import '../../theme/app_theme.dart';

class RideCustomizationScreen extends StatefulWidget {
  const RideCustomizationScreen({super.key});

  @override
  State<RideCustomizationScreen> createState() => _RideCustomizationScreenState();
}

class _RideCustomizationScreenState extends State<RideCustomizationScreen> {
  String? selectedMusic = 'Jazz';
  int temperature = 22;
  bool quietMode = false;
  String? preferredDriverGender;
  List<String> selectedAmenities = ['Climate Control'];
  final TextEditingController _instructionsController = TextEditingController();

  final List<String> musicOptions = ['Jazz', 'Classical', 'Pop', 'Rock', 'Electronic', 'None'];
  final List<String> availableAmenities = [
    'Climate Control',
    'Premium Audio',
    'WiFi',
    'Refreshments',
    'Phone Charger',
    'Newspapers',
    'Privacy Glass',
    'Massage Seats',
  ];

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('Customize Your Ride'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionCard(
              title: 'Music Preference',
              icon: Icons.music_note,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: musicOptions.map((music) {
                      final isSelected = selectedMusic == music;
                      return GestureDetector(
                        onTap: () => setState(() => selectedMusic = music),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primaryColor : Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? AppTheme.primaryColor : Colors.grey[300]!,
                            ),
                          ),
                          child: Text(
                            music,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _SectionCard(
              title: 'Temperature Control',
              icon: Icons.thermostat,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.ac_unit, color: Colors.blue),
                      Expanded(
                        child: Slider(
                          value: temperature.toDouble(),
                          min: 16,
                          max: 28,
                          divisions: 12,
                          activeColor: AppTheme.primaryColor,
                          label: '${temperature}°C',
                          onChanged: (value) => setState(() => temperature = value.round()),
                        ),
                      ),
                      const Icon(Icons.wb_sunny, color: Colors.orange),
                    ],
                  ),
                  Text(
                    '${temperature}°C',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _SectionCard(
              title: 'Ride Experience',
              icon: Icons.volume_off,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Quiet Mode'),
                    subtitle: const Text('Minimal conversation during the ride'),
                    value: quietMode,
                    activeColor: AppTheme.primaryColor,
                    onChanged: (value) => setState(() => quietMode = value),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _SectionCard(
              title: 'Driver Preference',
              icon: Icons.person,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => preferredDriverGender = 'Male'),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: preferredDriverGender == 'Male' 
                                  ? AppTheme.primaryColor 
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: preferredDriverGender == 'Male' 
                                    ? AppTheme.primaryColor 
                                    : Colors.grey[300]!,
                              ),
                            ),
                            child: Text(
                              'Male Driver',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: preferredDriverGender == 'Male' 
                                    ? Colors.white 
                                    : Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => preferredDriverGender = 'Female'),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: preferredDriverGender == 'Female' 
                                  ? AppTheme.primaryColor 
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: preferredDriverGender == 'Female' 
                                    ? AppTheme.primaryColor 
                                    : Colors.grey[300]!,
                              ),
                            ),
                            child: Text(
                              'Female Driver',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: preferredDriverGender == 'Female' 
                                    ? Colors.white 
                                    : Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => preferredDriverGender = null),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: preferredDriverGender == null 
                                  ? AppTheme.primaryColor 
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: preferredDriverGender == null 
                                    ? AppTheme.primaryColor 
                                    : Colors.grey[300]!,
                              ),
                            ),
                            child: Text(
                              'No Preference',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: preferredDriverGender == null 
                                    ? Colors.white 
                                    : Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _SectionCard(
              title: 'Requested Amenities',
              icon: Icons.star,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: availableAmenities.map((amenity) {
                      final isSelected = selectedAmenities.contains(amenity);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedAmenities.remove(amenity);
                            } else {
                              selectedAmenities.add(amenity);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primaryColor : Colors.grey[100],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? AppTheme.primaryColor : Colors.grey[300]!,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isSelected)
                                const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              if (isSelected) const SizedBox(width: 4),
                              Text(
                                amenity,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _SectionCard(
              title: 'Special Instructions',
              icon: Icons.note,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  TextField(
                    controller: _instructionsController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Any special requests or instructions for your driver...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _savePreferences,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Save Preferences',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _savePreferences() {
    final preferences = RidePreferences(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'current_user_id',
      preferredMusic: selectedMusic,
      preferredTemperature: temperature,
      quietMode: quietMode,
      preferredDriverGender: preferredDriverGender,
      requestedAmenities: selectedAmenities,
      specialInstructions: _instructionsController.text.isNotEmpty 
          ? _instructionsController.text 
          : null,
    );

    // Save preferences logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ride preferences saved successfully!'),
        backgroundColor: AppTheme.successColor,
      ),
    );

    context.pop();
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
