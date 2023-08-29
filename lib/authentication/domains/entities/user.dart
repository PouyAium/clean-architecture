import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  final int id;
  final DateTime createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [id, createdAt, name, avatar];
}
