import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main (){
  test("should test equatable is working", () {
    const obj1 = UserEntity(id: "id", username: "username", email: "email@email.com");
    const obj2 = UserEntity(id: "id", username: "username", email: "email@email.com");
    expect(obj1, equals(obj2));
  });
}