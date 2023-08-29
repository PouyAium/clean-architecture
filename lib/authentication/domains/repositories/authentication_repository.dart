import 'package:tdd_tutorial/authentication/domains/entities/user.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  // Left -> Failed(Failure) -> error
  // Right -> Success(void) -> action
  // typedef -> ResultVoid<Failure, Right(void)>
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  // Left -> Failed(Failure) -> error
  // Right -> Success(List<User>) -> data
  // typedef ResultFuture<Failure, Right(List<User>)>
  ResultFuture<List<User>> getUsers();
}
