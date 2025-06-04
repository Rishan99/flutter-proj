part of 'splash_bloc.dart';

abstract class SplashState {}

class SplashInitial extends SplashState implements LoadedState {}

class SplashNavigateToLogin extends SplashState implements LoadedState {}

class SplashNavigateToHome extends SplashState implements LoadedState {}
