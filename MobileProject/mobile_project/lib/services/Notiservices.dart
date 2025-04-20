import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> requestNotificationPermission() async {
    if (Platform.isIOS) {
      final permissionStatus = await Permission.notification.request();
      if (permissionStatus.isGranted) {
        print('Notification permission granted');
      } else if (permissionStatus.isDenied) {
        print('Notification permission denied');
      } else if (permissionStatus.isPermanentlyDenied) {
        print('Notification permission permanently denied');
        openAppSettings();
      }
    }

    if (Platform.isAndroid) {
      final status = await _firebaseMessaging.requestPermission();
      if (status.authorizationStatus == AuthorizationStatus.authorized) {
        print('Notification permission granted on Android');
      } else {
        print('Notification permission denied on Android');
      }
    }
  }

}
