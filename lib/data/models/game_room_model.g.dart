// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameRoomModel _$GameRoomModelFromJson(Map json) => GameRoomModel(
      history: (json['history'] as List<dynamic>?)
          ?.map(
              (e) => PhraseModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      id: json['id'] as String?,
      name: json['name'] as String?,
      adminsIds: (json['adminsIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      playersIds: (json['playersIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      someoneIsTapping: json['someoneIsTapping'] as bool?,
      lastTappedId: json['lastTappedId'] as String?,
    );

Map<String, dynamic> _$GameRoomModelToJson(GameRoomModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('adminsIds', instance.adminsIds);
  writeNotNull('someoneIsTapping', instance.someoneIsTapping);
  writeNotNull('lastTappedId', instance.lastTappedId);
  writeNotNull('playersIds', instance.playersIds);
  writeNotNull('history', instance.history?.map((e) => e.toJson()).toList());
  return val;
}
