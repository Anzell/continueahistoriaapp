// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrase_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhraseModel _$PhraseModelFromJson(Map json) => PhraseModel(
      sendAt: DateHelper.milissecondsToDateTime(json['sendAt'] as int?),
      senderId: json['senderId'] as String?,
      phrase: json['phrase'] as String?,
    );

Map<String, dynamic> _$PhraseModelToJson(PhraseModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('senderId', instance.senderId);
  writeNotNull('phrase', instance.phrase);
  writeNotNull('sendAt', DateHelper.dateTimeToMilisseconds(instance.sendAt));
  return val;
}
