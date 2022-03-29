import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {
  test("should equatable working", () {
    final obj1 = ResumedGameRoom(id: "id1", phrasesNumber: 2, playersNumber: 2, title: "era uma vez");
    final obj2 = ResumedGameRoom(id: "id1", phrasesNumber: 2, playersNumber: 2, title: "era uma vez");
    expect(obj1, equals(obj2));
  });
}