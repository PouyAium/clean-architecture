import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domains/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domains/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domains/usecases/get_users.dart';


import 'authentication_repository.mock.dart';

void main() {
  late GetUsers usecase;
  late AuthenticationRepository repository;

  setUp(
    () {
      repository = MockAuthRepo();
      usecase = GetUsers(repository);
    },
  );

  final List<User> tResponse = [const User.empty()];

  test(
    'should call the [AuthRepo.getUser] and return [List<User>]',
    () async {
      // arrange
      when(
        () => repository.getUsers(),
      ).thenAnswer(
        (_) async => Right(tResponse),
      );

      final result = await usecase();

      expect(result, equals(Right<dynamic, List<User>>(tResponse)));
      verify(() => repository.getUsers()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
