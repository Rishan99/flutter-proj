// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/auth/model/login_model.dart';
import 'package:moviehub/services/auth/auth_service.dart';
import 'package:moviehub/services/core/preference_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;
  final PreferenceService preferenceService;
  LoginBloc(
    this.authService,
    this.preferenceService,
  ) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final data = await authService.login(event.loginModel);
      preferenceService.accessToken = data['token'];
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
