
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/Backend/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginBtnClicked>(_onLoginClicked);
  }

  void _onLoginClicked(LoginBtnClicked event, Emitter<LoginState> emit) async{
    var p = await login(event.email,event.password);
    emit(LoginState(message: p));
  }
}
