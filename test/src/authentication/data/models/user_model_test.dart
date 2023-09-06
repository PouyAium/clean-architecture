import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/domains/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  final tJson = fixtures('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  test('should be subclass of the [user] entity', () {
    //! Arrange

    //! Act

    // Assert
    expect(tModel, isA<User>());
  });

  group('fromMap ', () {
    test('should return a [UserModel] with the correct data', () {
      // act
      final result = UserModel.fromMap(tMap);

      // assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the correct data', () {
      // act
      final result = UserModel.fromJson(tJson);

      // assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the correct data', () {
      // act
      final result = tModel.toMap();

      // assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [Json] string with the correct data', () {
      // act
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name",
        "avatar": "_empty.avatar"
      });

      // assert
      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return [UserModel] with different data', () {
      // arrange

      // act
      final result = tModel.copyWith(name : 'Pouya');

      // assert
      expect(result.name, equals('Pouya') );
    });
  });
}
