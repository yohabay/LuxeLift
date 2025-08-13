import 'package:flutter/material.dart';
import '../models/location_model.dart';

class LocationSearchWidget extends StatefulWidget {
  final Function(Location pickup, Location dropoff) onLocationSelected;
  final Location? initialPickup;
  final Location? initialDropoff;

  const LocationSearchWidget({
    super.key,
    required this.onLocationSelected,
    this.initialPickup,
    this.initialDropoff,
  });

  @override
  State<LocationSearchWidget> createState() => _LocationSearchWidgetState();
}

class _LocationSearchWidgetState extends State<LocationSearchWidget> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();
  final FocusNode _pickupFocus = FocusNode();
  final FocusNode _dropoffFocus = FocusNode();
  
  List<Location> _pickupSuggestions = [];
  List<Location> _dropoffSuggestions = [];
  bool _showPickupSuggestions = false;
  bool _showDropoffSuggestions = false;

  // Mock locations for demonstration
  final List<Location> _mockLocations = [
    Location(
      latitude: 37.7749,
      longitude: -122.4194,
      address: 'San Francisco International Airport (SFO)',
    ),
    Location(
      latitude: 37.7849,
      longitude: -122.4094,
      address: 'Union Square, San Francisco',
    ),
    Location(
      latitude: 37.7949,
      longitude: -122.3994,
      address: 'Financial District, San Francisco',
    ),
    Location(
      latitude: 37.8049,
      longitude: -122.3894,
      address: 'Nob Hill, San Francisco',
    ),
    Location(
      latitude: 37.7649,
      longitude: -122.4294,
      address: 'Golden Gate Park, San Francisco',
    ),
    Location(
      latitude: 37.7549,
      longitude: -122.4394,
      address: 'Sunset District, San Francisco',
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialPickup != null) {
      _pickupController.text = widget.initialPickup?.address ?? '';
    }
    if (widget.initialDropoff != null) {
      _dropoffController.text = widget.initialDropoff?.address ?? '';
    }
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    _pickupFocus.dispose();
    _dropoffFocus.dispose();
    super.dispose();
  }

  void _searchLocations(String query, bool isPickup) {
    if (query.isEmpty) {
      setState(() {
        if (isPickup) {
          _pickupSuggestions = [];
          _showPickupSuggestions = false;
        } else {
          _dropoffSuggestions = [];
          _showDropoffSuggestions = false;
        }
      });
      return;
    }

    final suggestions = _mockLocations
        .where((location) =>
            location.address?.toLowerCase().contains(query.toLowerCase()) ?? false)
        .toList();

    setState(() {
      if (isPickup) {
        _pickupSuggestions = suggestions;
        _showPickupSuggestions = true;
      } else {
        _dropoffSuggestions = suggestions;
        _showDropoffSuggestions = true;
      }
    });
  }

  void _selectLocation(Location location, bool isPickup) {
    setState(() {
      if (isPickup) {
        _pickupController.text = location.address ?? '';
        _showPickupSuggestions = false;
        _pickupFocus.unfocus();
      } else {
        _dropoffController.text = location.address ?? '';
        _showDropoffSuggestions = false;
        _dropoffFocus.unfocus();
      }
    });

    // Check if both locations are selected
    if (_pickupController.text.isNotEmpty && _dropoffController.text.isNotEmpty) {
      final pickup = _mockLocations.firstWhere(
        (loc) => loc.address == _pickupController.text,
        orElse: () => Location(
          latitude: 37.7749,
          longitude: -122.4194,
          address: _pickupController.text,
        ),
      );
      final dropoff = _mockLocations.firstWhere(
        (loc) => loc.address == _dropoffController.text,
        orElse: () => Location(
          latitude: 37.7849,
          longitude: -122.4094,
          address: _dropoffController.text,
        ),
      );
      widget.onLocationSelected(pickup, dropoff);
    }
  }

  void _swapLocations() {
    final temp = _pickupController.text;
    _pickupController.text = _dropoffController.text;
    _dropoffController.text = temp;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Pickup Location
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              TextField(
                controller: _pickupController,
                focusNode: _pickupFocus,
                decoration: const InputDecoration(
                  hintText: 'Pickup location',
                  prefixIcon: Icon(Icons.my_location, color: Colors.green),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
                onChanged: (value) => _searchLocations(value, true),
                onTap: () {
                  if (_pickupController.text.isNotEmpty) {
                    _searchLocations(_pickupController.text, true);
                  }
                },
              ),
              if (_showPickupSuggestions && _pickupSuggestions.isNotEmpty)
                Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _pickupSuggestions.length,
                    itemBuilder: (context, index) {
                      final location = _pickupSuggestions[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on, size: 20),
                        title: Text(
                          location.address ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                        onTap: () => _selectLocation(location, true),
                        dense: true,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),

        // Swap Button
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 2,
                color: Colors.grey[300],
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _swapLocations,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Icon(
                    Icons.swap_vert,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 2,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),

        // Dropoff Location
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              TextField(
                controller: _dropoffController,
                focusNode: _dropoffFocus,
                decoration: const InputDecoration(
                  hintText: 'Dropoff location',
                  prefixIcon: Icon(Icons.location_on, color: Colors.red),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
                onChanged: (value) => _searchLocations(value, false),
                onTap: () {
                  if (_dropoffController.text.isNotEmpty) {
                    _searchLocations(_dropoffController.text, false);
                  }
                },
              ),
              if (_showDropoffSuggestions && _dropoffSuggestions.isNotEmpty)
                Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _dropoffSuggestions.length,
                    itemBuilder: (context, index) {
                      final location = _dropoffSuggestions[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on, size: 20),
                        title: Text(
                          location.address ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                        onTap: () => _selectLocation(location, false),
                        dense: true,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
