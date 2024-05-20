part of 'role_bloc.dart';

@immutable
sealed class RoleState {}

final class RoleInitial extends RoleState {}

final class RoleLoading extends RoleState {}

final class RoleLoaded extends RoleState {
  final List<Role> roles;
  RoleLoaded(this.roles);
}

final class RoleError extends RoleState {
  final String error;
  RoleError(this.error);
}
