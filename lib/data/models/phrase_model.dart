import 'package:continueahistoriaapp/core/helpers/date_helper.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phrase_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, includeIfNull: false)
class PhraseModel extends Phrase {
  @override
  @JsonKey(toJson: DateHelper.dateTimeToMilisseconds, fromJson: DateHelper.milissecondsToDateTime)
  final DateTime? sendAt;

  const PhraseModel({
    this.sendAt,
    String? senderId,
    String? phrase,
  }) : super(
          sendAt: sendAt,
          senderId: senderId,
          phrase: phrase,
        );

  factory PhraseModel.fromJson(Map<String, dynamic> json) => _$PhraseModelFromJson(json);
  Map<String, dynamic> toJson() => _$PhraseModelToJson(this);
}
