import 'package:flutter/material.dart';
import 'package:luxelift/models/trip_model.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Trip> trips = [
      Trip(
        id: '1',
        from: 'Bole International Airport',
        to: 'Piazza',
        date: DateTime.now().subtract(const Duration(days: 1)),
        price: 250.00,
        driverName: 'Abebe Bikila',
        carModel: 'Toyota Vitz',
      ),
      Trip(
        id: '2',
        from: 'Merkato',
        to: 'CMC',
        date: DateTime.now().subtract(const Duration(days: 3)),
        price: 350.00,
        driverName: 'Haile Gebreselassie',
        carModel: 'Lifan 520',
      ),
      Trip(
        id: '3',
        from: 'Addis Ababa University',
        to: 'Meskel Square',
        date: DateTime.now().subtract(const Duration(days: 7)),
        price: 150.00,
        driverName: 'Kenenisa Bekele',
        carModel: 'Toyota Yaris',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip History'),
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          final trip = trips[index];
          return TripCard(trip: trip);
        },
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  trip.date.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '\${trip.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    trip.from,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.flag, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    trip.to,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.driverName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      trip.carModel,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
