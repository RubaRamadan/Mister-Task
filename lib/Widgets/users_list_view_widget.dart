import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/Bloc/UsersBloc/user_bloc.dart';
import 'package:task_manager_app/Widgets/reusable_user_card.dart';
import '../Models/user.dart';

class UsersListViewWidget extends StatelessWidget {
  const UsersListViewWidget({super.key, required this.usersList, required this.page});
  final List<User> usersList;
  final int page;
  @override
  Widget build(BuildContext context) {
    return   RefreshIndicator(
      onRefresh: ()async{
        BlocProvider.of<UserBloc>(context).add(RefreshPage(page: page));
      },
        child: ListView.builder(
          itemCount: usersList.length,
          itemBuilder: (context, index) {
            var user =usersList[index];
            return ReusableUserCard(user :user);
          },
        ));
  }
}
