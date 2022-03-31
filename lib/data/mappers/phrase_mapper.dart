import 'package:continueahistoriaapp/data/models/phrase_model.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';

class PhraseMapper {
  static Phrase modelToEntity(PhraseModel model) => Phrase(
    senderId: model.senderId,
    sendAt: model.sendAt,
    phrase: model.phrase,
  );

  static PhraseModel entityToModel(Phrase entity) => PhraseModel(
    sendAt: entity.sendAt,
    senderId: entity.senderId,
    phrase: entity.phrase,
  );
}