part of 'users_bloc.dart';

@immutable
sealed class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;
  UsersLoaded(this.users);
}

class UserByIdLoaded extends UsersState {
  final User user;
  final bool loadedById;
  UserByIdLoaded(this.user, {this.loadedById = true});
}

class UsersError extends UsersState {
  final String error;
  UsersError(this.error);
}

class UsersStoring extends UsersState {}

class UserStored extends UsersState {}

class UserUpdated extends UsersState {
  final User user;

  UserUpdated(this.user);
}

class UserDeleted extends UsersState {}
