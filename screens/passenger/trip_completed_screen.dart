import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_button.dart';

class TripCompletedScreen extends StatefulWidget {
  const TripCompletedScreen({super.key});

  @override
  State<TripCompletedScreen> createState() => _TripCompletedScreenState();
}

class _TripCompletedScreenState extends State<TripCompletedScreen> {
  int rating = 0;
  final TextEditingController reviewController = TextEditingController();
  bool isSubmitting = false;

  final Map<String, dynamic> tripDetails = {
    'fare': 45,
    'distance': '5.2 km',
    'duration': '18 minutes',
    'driver': 'Amanuel Tadesse',
  };

  Future<void> handleSubmitRating() async {
    setState(() {
      isSubmitting = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Save trip to history (in a real app, this would be saved to backend)
    // For now, we'll just navigate back to home
    setState(() {
      isSubmitting = false;
    });

    if (mounted) {
      context.go('/passenger/home');
    }
  }

  void handleSkip() {
    context.go('/passenger/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Success Header
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
                        'Trip Completed!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Thank you for riding with us',
                        style: TextStyle(color: Colors.green[700]),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Trip Summary
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.receipt, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'Trip Summary',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryRow('Distance:', tripDetails['distance']),
                      _buildSummaryRow('Duration:', tripDetails['duration']),
                      _buildSummaryRow('Fare:', '\$${tripDetails['fare']}'),
                      _buildSummaryRow('Payment:', 'Wallet'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Driver Rating
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rate Your Driver',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.blue,
                            child: Text(
                              'AT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tripDetails['driver'],
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const Text(
                                'Your driver',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                rating = index + 1;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(
                                Icons.star,
                                size: 32,
                                color: index < rating
                                    ? Colors.yellow[600]
                                    : Colors.grey[300],
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: reviewController,
                        decoration: const InputDecoration(
                          hintText: 'Leave a review (optional)',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Action Buttons
              Column(
                children: [
                  CustomButton(
                    text: isSubmitting ? 'Submitting...' : 'Submit Rating',
                    onPressed: rating == 0 || isSubmitting ? null : handleSubmitRating,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: handleSkip,
                    child: const Text('Skip Rating'),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () => context.go('/passenger/home'),
                    icon: const Icon(Icons.home),
                    label: const Text('Back to Home'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }
}
