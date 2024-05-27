part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {}

class LoadUser extends UsersEvent {}

class LoadUserManager extends UsersEvent {}

class StoreUser extends UsersEvent {
  final Map<String, dynamic> userData;

  StoreUser({required this.userData});
}

class GetUserById extends UsersEvent {
  final String userId;

  GetUserById({required this.userId});
}

class GetUserData extends UsersEvent {}

class UpdateUserById extends UsersEvent {
  final Map<String, dynamic> userData;
  final String? imagePath;
  final String userId;

  UpdateUserById({
    required this.userId,
    required this.userData,
    this.imagePath,
  });
}

class DeleteUserById extends UsersEvent {
  final String userId;

  DeleteUserById({required this.userId});
}
