import 'package:flutter/material.dart';

class VehicleManagementScreen extends StatefulWidget {
  const VehicleManagementScreen({super.key});

  @override
  State<VehicleManagementScreen> createState() => _VehicleManagementScreenState();
}

class _VehicleManagementScreenState extends State<VehicleManagementScreen> {
  final List<Map<String, String>> _vehicles = [
    {
      'make': 'Toyota',
      'model': 'Corolla',
      'year': '2020',
      'plate': 'AA-123-ET',
      'status': 'Active',
    },
    {
      'make': 'Hyundai',
      'model': 'Elantra',
      'year': '2018',
      'plate': 'BB-456-ET',
      'status': 'Pending Approval',
    },
    {
      'make': 'Mercedes-Benz',
      'model': 'C-Class',
      'year': '2022',
      'plate': 'CC-789-ET',
      'status': 'Active',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Management'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Handle add new vehicle
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add new vehicle functionality')),
              );
            },
          ),
        ],
      ),
      body: _vehicles.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.car_rental,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No Vehicles Added',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add your vehicle to start driving',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle add new vehicle
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Add new vehicle functionality')),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Vehicle'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = _vehicles[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.directions_car, color: Theme.of(context).primaryColor),
                    title: Text(
                      '${vehicle['make']} ${vehicle['model']}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      '${vehicle['year']} - ${vehicle['plate']}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                          ),
                    ),
                    trailing: Chip(
                      label: Text(vehicle['status']!),
                      backgroundColor: vehicle['status'] == 'Active'
                          ? Colors.green[100]
                          : Colors.orange[100],
                      labelStyle: TextStyle(
                        color: vehicle['status'] == 'Active' ? Colors.green[700] : Colors.orange[700],
                      ),
                    ),
                    onTap: () {
                      // Handle view/edit vehicle details
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('View/Edit ${vehicle['make']} ${vehicle['model']}')),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}