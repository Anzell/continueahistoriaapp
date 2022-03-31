import 'package:continueahistoriaapp/data/models/phrase_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/game_room.dart';

part 'game_room_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, includeIfNull: false)
class GameRoomModel extends GameRoom {
  @override
  List<PhraseModel>? history;

  GameRoomModel({
    this.history,
    String? id,
    String? name,
    List<String>? adminsIds,
    List<String>? playersIds,
  }) : super(
          id: id,
          history: history,
          name: name,
          adminsIds: adminsIds,
          playersIds: playersIds,
        );

  factory GameRoomModel.fromJson(Map<String, dynamic> json) => _$GameRoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$GameRoomModelToJson(this);
}
