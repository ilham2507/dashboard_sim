import 'package:drawer/data/model/user.dart';
import 'package:drawer/data/services/users/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserService userService;

  UsersBloc({required this.userService}) : super(UsersInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UsersLoading());
      try {
        final result = await userService.getUsers();
        emit(UsersLoaded(result));
      } catch (e) {
        emit(UsersError(e.toString()));
      }
    });

    on<StoreUser>((event, emit) async {
      emit(UsersStoring());
      try {
        final Map<String, String> userData =
            event.userData.map((key, value) => MapEntry(key, value.toString()));
        await userService.storeUser(userData, event.imagePath);
        emit(UserStored());
      } catch (e) {
        emit(UsersError(e.toString()));
      }
    });

    on<GetUserById>((event, emit) async {
      emit(UsersLoading());
      try {
        final user = await userService.getUserById(event.userId);
        emit(UserByIdLoaded(user));
      } catch (e) {
        emit(UsersError(e.toString()));
      }
    });

    on<UpdateUserById>((event, emit) async {
      emit(UsersLoading());
      try {
        final Map<String, String> userData =
            event.userData.map((key, value) => MapEntry(key, value.toString()));
        await userService.updateUserById(event.userId, userData,
            imagePath: event.imagePath);
        final updatedUser = await userService.getUserById(event.userId);
        emit(UserUpdated(updatedUser));
      } catch (e) {
        emit(UsersError(e.toString()));
      }
    });
  }
}
