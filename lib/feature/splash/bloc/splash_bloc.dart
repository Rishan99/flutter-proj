import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/core/bloc/event/bloc_event.dart';
import 'package:moviehub/services/core/preference_service.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final PreferenceService preferenceService;
  SplashBloc(this.preferenceService) : super(SplashInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    add(CheckAuthStatus());
  }

  Future<void> _onCheckAuthStatus(CheckAuthStatus event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    if (preferenceService.accessToken.isEmpty) {
      emit(SplashNavigateToLogin());
    } else {
      emit(SplashNavigateToHome());
    }
  }
}
