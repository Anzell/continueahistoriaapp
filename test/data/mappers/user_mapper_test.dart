import 'package:continueahistoriaapp/data/mappers/user_mapper.dart';
import 'package:continueahistoriaapp/data/models/user_model.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {
  const entity = UserEntity(
      id: "testId",
      username: "testUsername",
      email: "email@email.com",
  );

  const model = UserModel(
    id: "testId",
    username: "testUsername",
    email: "email@email.com",
  );

  test("should convert entity to model", () {
    expect(UserMapper.entityToModel(entity), equals(model));
  });

  test("should convert model to entity", () {
    expect(UserMapper.modelToEntity(model), equals(entity));
  });
}