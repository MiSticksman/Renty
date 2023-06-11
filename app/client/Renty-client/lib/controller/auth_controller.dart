import 'package:client/api/dto/request/user/login.dart';
import 'package:client/bloc/auth/auth_bloc.dart';
import 'package:client/bloc/auth/auth_event.dart';
import 'package:client/bloc/auth/auth_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/screens/home/home_screen.dart';
import 'package:client/screens/profile/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthController {
  final BuildContext context;
  AuthController({required this.context});

  void handleLogin(String email, String password) {
    bool isValidEmail =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    if (isValidEmail == false) {
      toastInfo(msg: "Неверный email формат!");
    } else {
      context
          .read<AuthBloc>()
          .add(LoginEvent(LoginRequest(email: email, password: password)));
      final state = context.read<AuthBloc>().state;
      if (state is LoginUserFailedState) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else if (state is LoggedInState) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
  }
}
