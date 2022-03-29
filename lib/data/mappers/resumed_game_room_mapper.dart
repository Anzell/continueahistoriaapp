import 'package:continueahistoriaapp/data/models/resumed_game_room_model.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';

class ResumedGameRoomMapper {
  static ResumedGameRoomModel entityToModel(ResumedGameRoom entity){
    return ResumedGameRoomModel(id: entity.id, title: entity.title, playersNumber: entity.playersNumber, phrasesNumber: entity.phrasesNumber);
  }

  static ResumedGameRoom modelToEntity(ResumedGameRoomModel model){
    return ResumedGameRoom(id: model.id, phrasesNumber: model.phrasesNumber, playersNumber: model.playersNumber, title: model.title);
  }
}