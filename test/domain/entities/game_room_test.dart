import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should equatable working", () {
    final obj1 = GameRoom(id: "validId", history: [
      Phrase(senderId: "player1", phrase: "era uma vez", sendAt: DateTime(2021,10,10))
    ],
      playersIds: ["player1"],
      adminsIds: ["admin1"]
    );
    final obj2 = GameRoom(id: "validId", history: [
      Phrase(senderId: "player1", phrase: "era uma vez", sendAt: DateTime(2021,10,10))
    ],
        playersIds: ["player1"],
        adminsIds: ["admin1"]
    );
    expect(obj1, equals(obj2));
  });
}