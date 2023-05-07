// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

class UserState extends Equatable {
  final User? user;
  final bool loading;
  final bool userExists;

  const UserState({
    required this.user,
    required this.loading,
    required this.userExists,
  });

  @override
  List<Object?> get props => [user, loading, userExists];

  UserState copyWith({
    User? user,
    bool? loading,
    bool? userExists,
  }) {
    return UserState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      userExists: userExists ?? this.userExists,
    );
  }
}
