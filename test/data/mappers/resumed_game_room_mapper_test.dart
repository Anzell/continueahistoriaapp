import 'package:continueahistoriaapp/data/mappers/resumed_game_room_mapper.dart';
import 'package:continueahistoriaapp/data/models/resumed_game_room_model.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {
  final model = ResumedGameRoomModel(
      id: "validRoomId",
      title: "Era uma vez",
      phrasesNumber: 21,
      playersNumber: 2
  );

  final entity = ResumedGameRoom(
      id: "validRoomId",
      title: "Era uma vez",
      phrasesNumber: 21,
      playersNumber: 2
  );

  test("should convert entity to model", () {
    expect(ResumedGameRoomMapper.entityToModel(entity), equals(model));
  });

  test("should convert model to entity", () {
    expect(ResumedGameRoomMapper.modelToEntity(model), equals(entity));
  });
}