part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class SendNotificationEvent extends NotificationsEvent {
  const SendNotificationEvent();

  @override
  List<Object> get props => [];
}
