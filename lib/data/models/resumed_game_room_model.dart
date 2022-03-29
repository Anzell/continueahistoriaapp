import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/resumed_game_room.dart';

part 'resumed_game_room_model.g.dart';

@JsonSerializable()
class ResumedGameRoomModel extends ResumedGameRoom {
  ResumedGameRoomModel({
    required String id,
    required String title,
    required int playersNumber,
    required int phrasesNumber,
  }) : super(
          id: id,
          title: title,
          playersNumber: playersNumber,
          phrasesNumber: phrasesNumber,
        );

  factory ResumedGameRoomModel.fromJson(Map<String, dynamic> json) => _$ResumedGameRoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResumedGameRoomModelToJson(this);
}
