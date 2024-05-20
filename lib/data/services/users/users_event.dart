part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {}

class LoadUser extends UsersEvent {}

class StoreUser extends UsersEvent {
  final Map<String, dynamic> userData;
  final String imagePath;

  StoreUser({required this.userData, required this.imagePath});
}
