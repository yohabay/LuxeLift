import 'package:flutter/material.dart';

class LocationSearchWidget extends StatefulWidget {
  final Function(String pickup, String dropoff) onLocationSelected;

  const LocationSearchWidget({
    super.key,
    required this.onLocationSelected,
  });

  @override
  State<LocationSearchWidget> createState() => _LocationSearchWidgetState();
}

class _LocationSearchWidgetState extends State<LocationSearchWidget> {
  final _pickupController = TextEditingController();
  final _dropoffController = TextEditingController();

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 20,
                    color: Colors.grey[300],
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: _pickupController,
                      decoration: const InputDecoration(
                        hintText: 'Pickup location',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                    const Divider(height: 1),
                    TextField(
                      controller: _dropoffController,
                      decoration: const InputDecoration(
                        hintText: 'Where to?',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_pickupController.text.isNotEmpty &&
                    _dropoffController.text.isNotEmpty) {
                  widget.onLocationSelected(
                    _pickupController.text,
                    _dropoffController.text,
                  );
                }
              },
              child: const Text('Book Ride'),
            ),
          ),
        ],
      ),
    );
  }
}
