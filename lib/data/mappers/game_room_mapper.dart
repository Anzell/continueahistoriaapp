import 'package:continueahistoriaapp/data/mappers/phrase_mapper.dart';
import 'package:continueahistoriaapp/data/models/game_room_model.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';

class GameRoomMapper {
  static GameRoom modelToEntity(GameRoomModel model) => GameRoom(
    id: model.id,
    history: model.history?.map((element) => PhraseMapper.modelToEntity(element)).toList(),
    adminsIds: model.adminsIds,
    playersIds: model.playersIds,
    name: model.name,
    lastTappedId: model.lastTappedId,
    someoneIsTapping: model.someoneIsTapping,
  );

  static GameRoomModel entityToModel(GameRoom entity) => GameRoomModel(
    id: entity.id,
    history: entity.history?.map((element) => PhraseMapper.entityToModel(element)).toList(),
    adminsIds: entity.adminsIds,
    playersIds: entity.playersIds,
    name: entity.name,
    lastTappedId: entity.lastTappedId,
    someoneIsTapping: entity.someoneIsTapping,
  );
}