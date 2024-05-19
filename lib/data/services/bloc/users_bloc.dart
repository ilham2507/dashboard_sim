import 'package:drawer/data/model/user.dart';
import 'package:drawer/data/services/bloc/user_services.dart';
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
  }
}
