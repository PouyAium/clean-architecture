import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/utils/constants.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    //1. check to make sure that it returns the right data when call to the
    // status code is 200 or the proper response code
    //2. check to make sure that it "THROWS A CUSTOM EXCEPTION" with the
    // right message when the status code is the bad one
    try {
      final response = await _client.post(
        Uri.https(kBaseUrl, kCreateUserEndpoint),
        body: jsonEncode(
          {
            'createdAt': createdAt,
            'name': name,
            // 'avatar': avatar, -> creating random avatar for users
          },
        ),
        headers: {
          'Content-Type': 'application/json'
        }
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw (APIException(
            message: response.body, statusCode: response.statusCode));
      }
    } on APIException catch (_) {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response =
          await _client.get(Uri.https(kBaseUrl, kGetUsersEndpoint));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw (APIException(
            message: response.body, statusCode: response.statusCode));
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((usersData) => UserModel.fromMap(usersData))
          .toList();
    } on APIException catch (_) {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
