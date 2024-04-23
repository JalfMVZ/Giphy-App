import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_bloc_tutorial/local_notifications/local_notifications.dart';

class MessageNotifierProvider with ChangeNotifier {
  final IOWebSocketChannel _channel = IOWebSocketChannel.connect(
      Uri.parse("https://nrzflppxdncjxqneceme.supabase.co"));
  late final BehaviorSubject<dynamic> _notifyStream = BehaviorSubject()
    ..addStream(_channel.stream);

  MessageNotifierProvider() : super() {
    _notifyStream.listen((message) {
      final data = message as Map<String, dynamic>;
      final messageType = data['type'];
      if (messageType == 'new_service') {
        final service = data['service'];
        final id = data['id'];
        _showNotification(id, 'Nuevo servicio agregado',
            'Se ha agregado un nuevo servicio: $service');
      }
    });
  }
  //! conectar base sql server
  //* permitir escuchar eventos en sql server
  //? definir esos eventos, insert, update
  //* fecha de vencimiento pasó , notificar

  BehaviorSubject<dynamic> get notifyStream => _notifyStream;
  Sink<dynamic> get notifyMessageSink => _channel.sink;

  List<dynamic> inbox = [];

  void addInbox(dynamic message) {
    inbox.add(message);
    notifyListeners();
  }

  void _showNotification(int id, String title, String body) {
    LocalNotification.showLocalNotification(id: id, title: title, body: body);
  }
}
