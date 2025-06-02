part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginRequested extends LoginEvent {
  final LoginModel loginModel;
  LoginRequested(this.loginModel);
}
