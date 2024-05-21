import 'package:drawer/data/model/role.dart';
import 'package:drawer/data/model/user.dart';
import 'package:drawer/data/services/roles/role_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final RoleServices roleServices;

  RoleBloc({required this.roleServices}) : super(RoleInitial()) {
    on<LoadRole>((event, emit) async {
      emit(RoleLoading());
      try {
        final result = await roleServices.getRoles();
        emit(RoleLoaded(result));
      } catch (e) {
        emit(RoleError(e.toString()));
      }
    });
  }
}
