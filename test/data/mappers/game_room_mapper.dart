import 'package:continueahistoriaapp/data/mappers/game_room_mapper.dart';
import 'package:continueahistoriaapp/data/models/game_room_model.dart';
import 'package:continueahistoriaapp/data/models/phrase_model.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final model = GameRoomModel(
      id: "validId",
      name: "era uma vez",
      playersIds: ["player1"],
      adminsIds: ["admin1"],
      history: [
        PhraseModel(
            phrase: "era uma vez",
            senderId: "validId",
            sendAt: DateTime(2021,10,10)
        )
      ]
  );

  final entity = GameRoom(
      id: "validId",
      name: "era uma vez",
      playersIds: ["player1"],
      adminsIds: ["admin1"],
      history: [
        Phrase(
            phrase: "era uma vez",
            senderId: "validId",
            sendAt: DateTime(2021,10,10)
        )
      ]
  );

  test("should convert entity to model", () {
    expect(GameRoomMapper.entityToModel(entity), equals(model));
  });

  test("should convert model to entity", () {
    expect(GameRoomMapper.modelToEntity(model), equals(entity));
  });
}