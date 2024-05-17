import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessage {
  final firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final FOMtoken = await firebaseMessaging.getToken();
      print('Token: $FOMtoken');
    } else {
      print('User declined notification permissions');
    }
  }
}
