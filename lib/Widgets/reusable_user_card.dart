import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/Widgets/reusable_loading.dart';
import '../Bloc/UsersBloc/user_bloc.dart';
import '../Models/user.dart';

class ReusableUserCard extends StatefulWidget {
  const ReusableUserCard({super.key, required this.user});
  final User user;
  @override
  State<ReusableUserCard> createState() => _ReusableUserCardState();
}

class _ReusableUserCardState extends State<ReusableUserCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: CachedNetworkImage(
            imageUrl: widget.user.avatar,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            placeholder: (context, url) => loading(),
            errorWidget: (context, url, error) => loading(),
          ),
        ),
          title: Text('${widget.user.firstName} ${widget.user.lastName}',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(widget.user.email),
          onTap: (){
            BlocProvider.of<UserBloc>(context).add(SelectUser(userName: '${widget.user.firstName} ${widget.user.lastName}'));
            Navigator.of(context).pop();
          },
      ),
    );
  }
}
