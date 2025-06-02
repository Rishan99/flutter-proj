import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/feature/auth/model/signup_model.dart';
import 'package:moviehub/services/auth/auth_service.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthService authService;
  SignupBloc(this.authService) : super(SignupInitial()) {
    on<SignupRequested>(_onSignupRequested);
  }

  Future<void> _onSignupRequested(SignupRequested event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    try {
      await authService.register(event.signupModel);
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupError(e.toString()));
    }
  }
}
