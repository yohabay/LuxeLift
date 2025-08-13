import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/auth/welcome_screen.dart';
import '../screens/auth/phone_screen.dart';
import '../screens/auth/verify_otp_screen.dart';
import '../screens/passenger/home_screen.dart';
import '../screens/passenger/booking_screen.dart';
import '../screens/passenger/finding_driver_screen.dart';
import '../screens/passenger/driver_found_screen.dart';
import '../screens/passenger/driver_arrived_screen.dart';
import '../screens/passenger/trip_started_screen.dart';
import '../screens/passenger/trip_completed_screen.dart';
import '../screens/passenger/trip_history_screen.dart';
import '../screens/passenger/wallet_screen.dart';
import '../screens/passenger/profile_screen.dart';
import '../screens/passenger/notifications_screen.dart';
import '../screens/passenger/settings_screen.dart';
import '../screens/passenger/rewards_screen.dart';
import '../screens/passenger/luxury_services_screen.dart';
import '../screens/passenger/premium_vehicles_screen.dart';
import '../screens/passenger/vip_membership_screen.dart';
import '../screens/driver/driver_home_screen.dart';
import '../screens/driver/driver_profile_screen.dart';
import '../screens/driver/driver_earnings_screen.dart';
import '../screens/driver/driver_trips_screen.dart';
import '../screens/driver/vehicle_management_screen.dart';
import '../screens/driver/support_screen.dart';
import '../screens/loading_screen.dart';
import '../screens/passenger/passenger_main_screen.dart';
import '../screens/driver/driver_main_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      
      // Loading screen
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      
      // Auth routes
      GoRoute(
        path: '/auth/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/auth/phone',
        builder: (context, state) => const PhoneScreen(),
      ),
      GoRoute(
        path: '/auth/verify-otp',
        builder: (context, state) => VerifyOtpScreen(
          phoneNumber: state.extra as String? ?? '',
        ),
      ),
      
      // Passenger routes
      ShellRoute(
        builder: (context, state, child) => PassengerMainScreen(child: child),
        routes: [
          GoRoute(
            path: '/passenger/home',
            builder: (context, state) => const PassengerHomeScreen(),
          ),
          GoRoute(
            path: '/passenger/history',
            builder: (context, state) => const TripHistoryScreen(),
          ),
          GoRoute(
            path: '/passenger/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/passenger/booking',
        builder: (context, state) => const BookingScreen(),
      ),
      GoRoute(
        path: '/passenger/finding-driver',
        builder: (context, state) => const FindingDriverScreen(),
      ),
      GoRoute(
        path: '/passenger/driver-found',
        builder: (context, state) => const DriverFoundScreen(),
      ),
      GoRoute(
        path: '/passenger/driver-arrived',
        builder: (context, state) => const DriverArrivedScreen(),
      ),
      GoRoute(
        path: '/passenger/trip-started',
        builder: (context, state) => const TripStartedScreen(),
      ),
      GoRoute(
        path: '/passenger/trip-completed',
        builder: (context, state) => const TripCompletedScreen(),
      ),
      GoRoute(
        path: '/passenger/wallet',
        builder: (context, state) => const WalletScreen(),
      ),
      GoRoute(
        path: '/passenger/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/passenger/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/passenger/rewards',
        builder: (context, state) => const RewardsScreen(),
      ),
      // New luxury routes
      GoRoute(
        path: '/passenger/luxury-services',
        builder: (context, state) => const LuxuryServicesScreen(),
      ),
      GoRoute(
        path: '/passenger/premium-vehicles',
        builder: (context, state) => const PremiumVehiclesScreen(),
      ),
      GoRoute(
        path: '/passenger/vip-membership',
        builder: (context, state) => const VipMembershipScreen(),
      ),
      
      // Driver routes
      ShellRoute(
        builder: (context, state, child) => DriverMainScreen(child: child),
        routes: [
          GoRoute(
            path: '/driver/home',
            builder: (context, state) => const DriverHomeScreen(),
          ),
          GoRoute(
            path: '/driver/profile',
            builder: (context, state) => const DriverProfileScreen(),
          ),
          GoRoute(
            path: '/driver/earnings',
            builder: (context, state) => const DriverEarningsScreen(),
          ),
          GoRoute(
            path: '/driver/trips',
            builder: (context, state) => const DriverTripsScreen(),
          ),
          GoRoute(
            path: '/driver/vehicle-management',
            builder: (context, state) => const VehicleManagementScreen(),
          ),
          GoRoute(
            path: '/driver/support',
            builder: (context, state) => const SupportScreen(),
          ),
        ],
      ),
    ],
  );
}
