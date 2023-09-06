import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/src/authentication/domains/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domains/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domains/usecases/get_users.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    emit(const CreatingUser());

    final result = await _createUser(
        CreateUserParams(createdAt: createdAt, name: name, avatar: avatar));

    result.fold(
          (failure) => emit(AuthenticationError(failure.message)),
          (_) => emit(const UserCreated()),
    );
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());

    final result = await _getUsers();
    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
