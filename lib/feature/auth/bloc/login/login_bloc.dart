import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/feature/auth/model/login_model.dart';
import 'package:moviehub/services/auth/auth_service.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;
  LoginBloc(this.authService) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final data = await authService.login(event.loginModel);
      emit(LoginSuccess(data['access_token']));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
