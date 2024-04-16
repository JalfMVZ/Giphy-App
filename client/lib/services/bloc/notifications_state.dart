part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();
  
  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {}
