import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/entities/apiresponse.dart';
import '../../../data/entities/user.dart';
import '../../../data/repository/user_auth_repository_impl.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState(user: null, loading: true, userExists: false)) {
    on<AuthUserEvent>((event, emit) async {
      var authUser = await UserAuthRepositoryImpl().authUser();
      emit(state.copyWith(user: authUser, loading: false));
    });
    on<AddUserEvent>((event, emit) async {
      ApiResponse result = await UserAuthRepositoryImpl().addUser(name: event.name);
      if (result.statusCode == 469) {
        UserAuthRepositoryImpl().errorVibration();
        emit(state.copyWith(userExists: true));
      } else if (result.statusCode == 200) {
        add(const AuthUserEvent());
      }
    });
  }
}
