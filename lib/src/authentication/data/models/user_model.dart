import 'dart:convert';

import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domains/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  factory UserModel.fromJson(String source) => UserModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  String toJson() => jsonEncode(toMap());

   const UserModel.empty() :
    this(id: '1',
    createdAt: '_empty.createdAt',
    name: '_empty.name',
    avatar: '_empty.avatar',
  );

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          createdAt: map['createdAt'] as String,
          name: map['name'] as String,
          avatar: map['avatar'] as String,
        );

  DataMap toMap() => {
        'id': id,
        'createdAt': createdAt,
        'name': name,
        'avatar': avatar,
      };

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
  }) =>
      UserModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
      );
}
