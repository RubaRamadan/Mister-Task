part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginBtnClicked extends LoginEvent{
  final String email;
  final String password;

  LoginBtnClicked({required this.email, required this.password});

  @override
  List<Object?> get props => [email,password];
}


