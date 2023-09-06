import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/utils/constants.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;
  late AuthRemoteDataSrcImpl remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully when the status code is 200 or 201',
        () async {
      when(() => client.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer(
              (_) async => http.Response('User created successfully', 201));

      final result = remoteDataSource.createUser;

      expect(result(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          completes);

      verify(
        () => client.post(
          (Uri.https(kBaseUrl, kCreateUserEndpoint)),
          body: jsonEncode(
              {'createdAt': 'createdAt', 'name': 'name', 'avatar': 'avatar'}),
          headers: {'Content-Type': 'application/json'},
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  test('should throw [APIException] when the status code is not 201 or 200',
      () async {
    when(() => client.post(any(), body: any(named: 'body'), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('Invalid email address', 400));

    methodCall() => remoteDataSource.createUser(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        );

    expect(
      methodCall,
      throwsA(
        const APIException(
          message: 'Invalid email address',
          statusCode: 400,
        ),
      ),
    );

    verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
        body: jsonEncode({
          'createdAt': 'createdAt',
          'name': 'name',
          'avatar': 'avatar',
        }), headers: {'Content-Type': 'application/json'})).called(1);

    verifyNoMoreInteractions(client);
  });

  group('getUsers', () {
    const tUsers = [UserModel.empty()];
    test('should return [List<User>] when the status code is 200', () async {
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
      );
      final result = await remoteDataSource.getUsers();

      expect(result, equals(tUsers));

      verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)))
          .called(1);

      verifyNoMoreInteractions(client);
    });
  });

  test(
    'should throw [APIException] when the status code is not 200 or 201',
    () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('Server Down', 500));

      final methodCall = remoteDataSource.getUsers();
      expect(() => methodCall,
          throwsA(const APIException(message: 'Server Down', statusCode: 500)));

      verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)));

      verifyNoMoreInteractions(client);
    },
  );
}
