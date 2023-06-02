import 'package:client/api/dto/request/user/login.dart';
import 'package:client/api/dto/response/user/login.dart';
import 'package:client/api/repository/auth_repository.dart';
import 'package:client/bloc/auth/auth_event.dart';
import 'package:client/bloc/auth/auth_state.dart';
import 'package:client/common/utils/http_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  late LoginResponse response;

  AuthBloc() : super(LoggedOutState()) {
    on<LoginEvent>(
          (event, emit) async {
            var response = await _authRepository.login(event.loginRequest);
            HttpUtil().loginResponse = response;
            emit(LoggedInState(response: response));
      },
    );

    on<LogoutEvent>(
          (event, emit) async {
            _authRepository.logout();
            HttpUtil().loginResponse = null;
            emit(LoggedOutState());
      },
    );

  }

}
