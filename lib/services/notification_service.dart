import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
    await _requestPermissions();
  }

  static Future<void> _requestPermissions() async {
    await Permission.notification.request();
  }

  static void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    print('Notification tapped: ${response.payload}');
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'ride_updates',
      'Ride Updates',
      channelDescription: 'Notifications for ride status updates',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(id, title, body, details, payload: payload);
  }

  static Future<void> showDriverFoundNotification() async {
    await showNotification(
      id: 1,
      title: 'Driver Found!',
      body: 'Your driver is on the way to pick you up.',
      payload: 'driver_found',
    );
  }

  static Future<void> showDriverArrivedNotification() async {
    await showNotification(
      id: 2,
      title: 'Driver Arrived',
      body: 'Your driver has arrived at the pickup location.',
      payload: 'driver_arrived',
    );
  }

  static Future<void> showTripStartedNotification() async {
    await showNotification(
      id: 3,
      title: 'Trip Started',
      body: 'Your trip has started. Enjoy your ride!',
      payload: 'trip_started',
    );
  }

  static Future<void> showTripCompletedNotification() async {
    await showNotification(
      id: 4,
      title: 'Trip Completed',
      body: 'You have reached your destination. Thank you for riding with us!',
      payload: 'trip_completed',
    );
  }

  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }
}
