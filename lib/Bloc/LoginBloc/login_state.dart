part of 'login_bloc.dart';

class LoginState extends Equatable{
  final String message;

  const LoginState({
    this.message='',
  });

  @override
  List<Object?> get props => [message];
}