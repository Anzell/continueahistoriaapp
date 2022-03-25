import 'package:continueahistoriaapp/domain/entities/user_entity.dart';

import '../models/user_model.dart';

class UserMapper {
  static UserModel entityToModel(UserEntity entity) => UserModel(id: entity.id, email: entity.email, username: entity.username);
  static UserEntity modelToEntity(UserModel model) => UserEntity(id: model.id, email: model.email, username: model.username);
}