import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DriverMainScreen extends StatefulWidget {
  const DriverMainScreen({super.key, required this.child});

  final Widget child;

  @override
  State<DriverMainScreen> createState() => _DriverMainScreenState();
}

class _DriverMainScreenState extends State<DriverMainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _updateCurrentIndex();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateCurrentIndex();
  }

  void _updateCurrentIndex() {
    final String location = GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    setState(() {
      _currentIndex = _getPageIndex(location);
    });
  }

  int _getPageIndex(String path) {
    if (path.startsWith('/driver/home')) {
      return 0;
    } else if (path.startsWith('/driver/earnings')) {
      return 1;
    } else if (path.startsWith('/driver/trips')) {
      return 2;
    } else if (path.startsWith('/driver/vehicle-management')) {
      return 3;
    } else if (path.startsWith('/driver/support')) {
      return 4;
    }
    return 0; // Default to home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              context.go('/driver/home');
              break;
            case 1:
              context.go('/driver/earnings');
              break;
            case 2:
              context.go('/driver/trips');
              break;
            case 3:
              context.go('/driver/vehicle-management');
              break;
            case 4:
              context.go('/driver/support');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Vehicle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Support',
          ),
        ],
      ),
    );
  }
}
