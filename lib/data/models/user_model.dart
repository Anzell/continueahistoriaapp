import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';


@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    String? id,
    String? username,
    String? email,
  }) : super(
          id: id,
          username: username,
          email: email,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
