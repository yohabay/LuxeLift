import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/driver_provider.dart';
import '../../models/ride_model.dart';
import '../../models/location_model.dart';
import '../../enums/ride_status.dart';

class DriverTripsScreen extends StatefulWidget {
  const DriverTripsScreen({super.key});

  @override
  State<DriverTripsScreen> createState() => _DriverTripsScreenState();
}

class _DriverTripsScreenState extends State<DriverTripsScreen> {
  String selectedFilter = 'All';
  final List<String> filters = ['All', 'Completed', 'Cancelled'];

  // Sample trip data
  final List<Ride> sampleTrips = [
    Ride(
      id: 'trip_1',
      passengerId: 'passenger_1',
      driverId: 'driver_1',
      pickupLocation: Location(
        address: 'Bole International Airport',
        latitude: 8.9806,
        longitude: 38.7992,
      ),
      dropoffLocation: Location(
        address: 'Piazza',
        latitude: 9.0320,
        longitude: 38.7469,
      ),
      fare: 65.0,
      status: RideStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      completedAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      passengerName: 'John Doe',
      rating: 5,
      vehicleType: 'economy',
    ),
    Ride(
      id: 'trip_2',
      passengerId: 'passenger_2',
      driverId: 'driver_1',
      pickupLocation: Location(
        address: 'Merkato',
        latitude: 9.0084,
        longitude: 38.7575,
      ),
      dropoffLocation: Location(
        address: 'CMC',
        latitude: 9.0054,
        longitude: 38.7636,
      ),
      fare: 35.0,
      status: RideStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      completedAt: DateTime.now().subtract(const Duration(days: 1, hours: -1)),
      passengerName: 'Jane Smith',
      rating: 4,
      vehicleType: 'economy',
    ),
    Ride(
      id: 'trip_3',
      passengerId: 'passenger_3',
      driverId: 'driver_1',
      pickupLocation: Location(
        address: 'Addis Ababa University',
        latitude: 9.0084,
        longitude: 38.7575,
      ),
      dropoffLocation: Location(
        address: 'Meskel Square',
        latitude: 9.0054,
        longitude: 38.7636,
      ),
      fare: 25.0,
      status: RideStatus.cancelled,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      passengerName: 'Mike Johnson',
      vehicleType: 'economy',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTrips = _getFilteredTrips();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/driver/home'),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter;
                
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    checkmarkColor: Theme.of(context).primaryColor,
                  ),
                );
              },
            ),
          ),
          
          // Trip List
          Expanded(
            child: filteredTrips.isEmpty
                ? _EmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredTrips.length,
                    itemBuilder: (context, index) {
                      final trip = filteredTrips[index];
                      return _TripCard(trip: trip);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  List<Ride> _getFilteredTrips() {
    switch (selectedFilter) {
      case 'Completed':
        return sampleTrips.where((trip) => trip.status == RideStatus.completed).toList();
      case 'Cancelled':
        return sampleTrips.where((trip) => trip.status == RideStatus.cancelled).toList();
      default:
        return sampleTrips;
    }
  }
}

class _TripCard extends StatelessWidget {
  final Ride trip;

  const _TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.passengerName ?? 'Unknown Passenger',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _formatDate(trip.createdAt),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${trip.fare.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _StatusBadge(status: trip.status),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Route
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 20,
                    color: Colors.grey[300],
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.pickupLocation.address ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      trip.dropoffLocation.address ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Rating (if completed)
          if (trip.status == RideStatus.completed && trip.rating != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Rating: ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      size: 16,
                      color: index < (trip.rating ?? 0)
                          ? Colors.amber
                          : Colors.grey[300],
                    );
                  }),
                ),
                const SizedBox(width: 8),
                Text(
                  '${trip.rating}/5',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final RideStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;
    
    switch (status) {
      case RideStatus.completed:
        color = Colors.green;
        text = 'Completed';
        break;
      case RideStatus.cancelled:
        color = Colors.red;
        text = 'Cancelled';
        break;
      default:
        color = Colors.orange;
        text = 'In Progress';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          const Text(
            'No trips found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your trip history will appear here',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
