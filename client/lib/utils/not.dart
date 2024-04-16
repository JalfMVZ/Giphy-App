import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/services/bloc/notifications_bloc.dart';

class ContadorPage extends StatefulWidget {
  const ContadorPage({super.key});

  @override
  _ContadorPageState createState() => _ContadorPageState();
}

class _ContadorPageState extends State<ContadorPage> {
  int _hours = 0;
  int _minutes = 20; // Establecer los minutos en 20
  int _seconds = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_hours == 0 && _minutes == 20 && _seconds == 0) {
          // Enviar el evento de notificación al bloc de notificaciones
          BlocProvider.of<NotificationsBloc>(context)
              .add(const SendNotificationEvent());
        }

        if (_hours == 0 && _minutes == 0 && _seconds == 0) {
          _timer.cancel();
        } else if (_minutes == 0 && _seconds == 0) {
          _hours--;
          _minutes = 59;
          _seconds = 59;
        } else if (_seconds == 0) {
          _minutes--;
          _seconds = 59;
        } else {
          _seconds--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador de Tiempo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Tiempo Restante:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              '$_hours horas $_minutes minutos $_seconds segundos',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
