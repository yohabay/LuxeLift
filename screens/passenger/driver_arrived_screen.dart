import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/ride_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';

class DriverArrivedScreen extends StatefulWidget {
  const DriverArrivedScreen({super.key});

  @override
  State<DriverArrivedScreen> createState() => _DriverArrivedScreenState();
}

class _DriverArrivedScreenState extends State<DriverArrivedScreen> {
  int waitTime = 0;

  @override
  void initState() {
    super.initState();
    _startWaitTimer();
    _autoStartTrip();
  }

  void _startWaitTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          waitTime++;
        });
        _startWaitTimer();
      }
    });
  }

  void _autoStartTrip() {
    Future.delayed(const Duration(seconds: 15), () {
      if (mounted) {
        context.go('/passenger/trip-started');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final rideProvider = Provider.of<RideProvider>(context);
    final currentRide = rideProvider.currentRide;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border(
                  bottom: BorderSide(color: Colors.blue[200]!),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Driver Has Arrived',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Please get in the vehicle',
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Arrival Confirmation
                    Card(
                      color: Colors.green[50],
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 64,
                              color: Colors.green[600],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Your driver is here!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Look for the white Toyota Corolla',
                              style: TextStyle(color: Colors.green[700]),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Waiting time: ${waitTime ~/ 60}:${(waitTime % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(
                                color: Colors.green[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Driver Info
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Colors.blue[600],
                                  child: const Text(
                                    'AT',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Amanuel Tadesse',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.yellow[600],
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            '4.8',
                                            style: TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                          const Text(
                                            ' • 1247 trips',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.phone),
                                            style: IconButton.styleFrom(
                                              backgroundColor: Colors.blue[600],
                                              foregroundColor: Colors.white,
                                              minimumSize: const Size(32, 32),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.message),
                                            style: IconButton.styleFrom(
                                              backgroundColor: Colors.grey[200],
                                              minimumSize: const Size(32, 32),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Toyota Corolla',
                                        style: TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'White',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'AA-123-456',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'License Plate',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Trip Details
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Trip Details',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pickup',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        'Bole Atlas, Addis Ababa',
                                        style: TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Destination',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        'Merkato, Addis Ababa',
                                        style: TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Instructions
                    Card(
                      color: Colors.yellow[50],
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Before you get in:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[800],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '• Verify the license plate: AA-123-456\n'
                              '• Confirm driver name: Amanuel Tadesse\n'
                              '• Check that it\'s a white Toyota Corolla',
                              style: TextStyle(
                                color: Colors.yellow[700],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    CustomButton(
                      text: 'I\'m in the car - Start Trip',
                      onPressed: () {
                        context.go('/passenger/trip-started');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
