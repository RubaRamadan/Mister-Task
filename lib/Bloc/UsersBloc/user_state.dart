part of 'user_bloc.dart';

class UserState extends Equatable{
  final List<User> usersList;
  final int page;
  final int totalPagesNumber;
  final String selectedManagerName;

  const UserState({
    this.usersList=const <User>[],
    this.page=1,
    this.totalPagesNumber=1,
    this.selectedManagerName='',
  });

  @override
  List<Object?> get props => [usersList,page,totalPagesNumber];
}


