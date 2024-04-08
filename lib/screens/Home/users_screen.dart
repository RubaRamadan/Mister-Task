import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/Bloc/UsersBloc/user_bloc.dart';
import '../../Models/user.dart';
import '../../Widgets/users_list_view_widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        List<User> usersList = state.usersList;
        int page=state.page;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Select task manager'),
          ),
          body: UsersListViewWidget(
            usersList: usersList,
            page: page,
          ),
        );
      },
    );
  }
}
