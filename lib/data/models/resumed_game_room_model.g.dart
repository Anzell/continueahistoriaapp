// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resumed_game_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResumedGameRoomModel _$ResumedGameRoomModelFromJson(
        Map<String, dynamic> json) =>
    ResumedGameRoomModel(
      id: json['id'] as String,
      title: json['title'] as String,
      playersNumber: json['playersNumber'] as int,
      phrasesNumber: json['phrasesNumber'] as int,
    );

Map<String, dynamic> _$ResumedGameRoomModelToJson(
        ResumedGameRoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'phrasesNumber': instance.phrasesNumber,
      'playersNumber': instance.playersNumber,
    };
