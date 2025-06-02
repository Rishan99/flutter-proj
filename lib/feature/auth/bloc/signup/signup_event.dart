part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupRequested extends SignupEvent {
  final SignupModel signupModel;
  SignupRequested(this.signupModel);
}
