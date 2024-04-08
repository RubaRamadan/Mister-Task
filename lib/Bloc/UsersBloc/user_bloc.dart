import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Backend/get_users.dart';
import '../../Models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<GetUsers>(_onGetUsers);
    on<RefreshPage>(_onRefreshPage);
    on<SelectUser>(_onSelectUser);
  }

  void _onGetUsers(GetUsers event, Emitter<UserState> emit) async {
    String manager=state.selectedManagerName;
    emit(const UserState(page: 1));
    var p = await getUsers(1);
    emit(UserState(
        usersList: List<User>.from(p['data']?.map((e) => User.fromMap(e))),
        totalPagesNumber: p['total_pages'],
        selectedManagerName: manager
    ));
  }

  void _onRefreshPage(RefreshPage event, Emitter<UserState> emit) async {
    int page = state.page + 1;
    int totalPagesNumber = state.totalPagesNumber;
    String manager=state.selectedManagerName;
    if(page<=state.totalPagesNumber) {
      var p = await getUsers(state.page+1);
      emit(
        UserState(
            usersList: List<User>.from(p['data']?.map((e) => User.fromMap(e))),
            page: state.page + 1,
            totalPagesNumber: totalPagesNumber,
            selectedManagerName: manager
        ),
      );
    }
  }

  void _onSelectUser(SelectUser event, Emitter<UserState> emit) async {
      emit(
        UserState(
            selectedManagerName: event.userName
        ),
      );
  }



}
