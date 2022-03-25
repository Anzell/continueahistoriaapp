import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String? id;
  final String? username;
  final String? email;

  const UserEntity({this.id, this.email, this.username});

  @override
  List<Object?> get props => [id, username, email];

}