import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/Bloc/LoginBloc/login_bloc.dart';
import 'package:task_manager_app/Widgets/reusable_button.dart';
import 'package:task_manager_app/Widgets/reusable_text_field.dart';
import 'package:task_manager_app/screens/Home/tasks_screen.dart';

import '../../Core/functions.dart';
import '../../Widgets/reusable_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginForm(),
    );
  }

  Widget _loginForm() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.message == 'Login succeeded') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const TasksScreen(),
              ),
              (route) => false);
        } else {
          ReusableSnackBar().showSnackBarMessage(
              isErrorSnackBar: true, message: state.message, context: context);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                 height: 150,
                width: 150,
                child: Image.asset('assets/images/logo.png')),
                const SizedBox(height: 10,),
                const Text('Welcome... Manage your tasks easily using Mr.Task app',textAlign: TextAlign.center,style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black54
                ),),
                const SizedBox(height: 50,),
                ReusableTextField(
                    onChangedFunc: (value) {},
                    validationFunc: (String value) {
                      InputValidator.validate(value);
                    },
                    hint: 'Email',
                    isPasswordField: false,
                    textEditingController: emailEditingController,
                    minLines: 1,
                    maxLines: 1),
                ReusableTextField(
                    onChangedFunc: (value) {},
                    validationFunc: (String value) {
                      InputValidator.validate(value);
                    },
                    hint: 'Password',
                    isPasswordField: true,
                    textEditingController: passwordEditingController,
                    minLines: 1,
                    maxLines: 1),
                const SizedBox(
                  height: 20,
                ),
                ReusableButton(
                    btnText: 'Log In',
                    onTapFunction: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<LoginBloc>(context).add(LoginBtnClicked(
                          email: emailEditingController.text,
                          password: passwordEditingController.text,
                        ));
                      }
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
