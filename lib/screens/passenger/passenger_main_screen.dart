import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PassengerMainScreen extends StatefulWidget {
  const PassengerMainScreen({super.key, required this.child});

  final Widget child;

  @override
  State<PassengerMainScreen> createState() => _PassengerMainScreenState();
}

class _PassengerMainScreenState extends State<PassengerMainScreen> {
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
    if (path.startsWith('/passenger/home')) {
      return 0;
    } else if (path.startsWith('/passenger/history')) {
      return 1;
    } else if (path.startsWith('/passenger/wallet')) {
      return 2;
    } else if (path.startsWith('/passenger/notifications')) {
      return 3;
    } else if (path.startsWith('/passenger/profile')) {
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
              context.go('/passenger/home');
              break;
            case 1:
              context.go('/passenger/history');
              break;
            case 2:
              context.go('/passenger/wallet');
              break;
            case 3:
              context.go('/passenger/notifications');
              break;
            case 4:
              context.go('/passenger/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
