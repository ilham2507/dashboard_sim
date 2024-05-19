import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drawer/data/services/auth/auth_event.dart';
import 'package:drawer/data/services/auth/auth_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drawer/data/services/api/api_services.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      final response = await http.post(
        Uri.parse('${ApiServices.baseUrl}/login'),
        body: jsonEncode({
          'email': event.email,
          'password': event.password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final token = jsonResponse['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_SHORT,
        );
        emit(AuthenticationSuccess());
      } else {
        final jsonResponse = jsonDecode(response.body);
        final error = jsonResponse['message'];

        Fluttertoast.showToast(
          msg: error,
          toastLength: Toast.LENGTH_SHORT,
        );

        emit(AuthenticationFailure(error: error));
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
      );

      emit(AuthenticationFailure(error: error.toString()));
    }
  }
}
