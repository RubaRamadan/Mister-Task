part of 'user_bloc.dart';

abstract class UserEvent extends Equatable{
  const UserEvent();

  @override
  List<Object?> get props => [];
}


class GetUsers extends UserEvent{
  @override
  List<Object?> get props => [];
}

class RefreshPage extends UserEvent{
  final int page;

  const RefreshPage({required this.page});

  @override
  List<Object?> get props => [page];
}

class SelectUser extends UserEvent{
  final String userName;

  const SelectUser({required this.userName});

  @override
  List<Object?> get props => [userName];
}


