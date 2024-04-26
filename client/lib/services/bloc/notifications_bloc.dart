import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc_tutorial/local_notifications/local_notifications.dart';
import 'package:flutter_bloc_tutorial/preferences/pref_usuarios.dart';
import 'package:http/http.dart' as http;

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  var mensaje = message.data;
  var title = mensaje['title'];
  var body = mensaje['body'];
  Random random = Random();
  var id = random.nextInt(100000);
  LocalNotification.showLocalNotification(id: id, title: title, body: body);
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(NotificationsInitial()) {
    _onForegroundMessage();
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true);

    await LocalNotification.requestPermissionLocalNotifications();
    settings.authorizationStatus;
    _getToken();
  }

  void _getToken() async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    if (token != null) {
      final prefs = PreferenciesUsers();
      final lastToken = prefs.token;

      if (token != lastToken) {
        final response = await _sendTokenToServer(token, id: prefs.deviceId);
        if (response.statusCode == 200) {
          prefs.token = token;
        } else {
          print('Error al enviar el token al servidor: ${response.body}');
        }
      }
    }
  }

  Future<http.Response> _sendTokenToServer(String deviceId, {int? id}) async {
    final url = 'https://tu-servidor.com/api/registrar-dispositivo';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'DEVICEID': deviceId,
        if (id != null) 'ID': id.toString(),
      },
    );
    return response;
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void handleRemoteMessage(RemoteMessage message) {
    var mensaje = message.data;
    var title = mensaje['title'];
    var body = mensaje['body'];
    print(title);
    print(body);
    Random random = Random();
    var id = random.nextInt(100000);

    LocalNotification.showLocalNotification(id: id, title: title, body: body);
  }
}
