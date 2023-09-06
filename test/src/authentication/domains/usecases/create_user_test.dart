//? What does the class depend on
//! Answer -- AuthenticationRepository
// How can we create fake version of the dependency
//! Answer -- MockTail
// How do we control what our dependencies do
//! Answer -- Using the MockTail's APIs

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domains/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domains/usecases/create_user.dart';

import 'authentication_repository.mock.dart';



void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
    // registerFallbackValue(Football());
  });

  final params = CreateUserParams.empty();

  test(
    'should call the [AuthRepo.createUser]',
    () => () async {
      // Arrange
      // STUB
      when(
        () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
      },

  );
}

// class Football{
//
// }
