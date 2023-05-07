part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class AuthUserEvent extends UserEvent {
  const AuthUserEvent();
}

class AddUserEvent extends UserEvent {
  final String name;

  const AddUserEvent({
    required this.name,
  });
}
