import 'package:continueahistoriaapp/data/mappers/phrase_mapper.dart';
import 'package:continueahistoriaapp/data/models/phrase_model.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {
  final model = PhraseModel(
      phrase: "era uma vez",
      sendAt: DateTime(2021,10,10),
      senderId: "validId"
  );

  final entity = Phrase(
      phrase: "era uma vez",
      sendAt: DateTime(2021,10,10),
      senderId: "validId"
  );

  test("should convert entity to model", () {
    expect(PhraseMapper.entityToModel(entity), equals(model));
  });

  test("should convert model to entity", () {
    expect(PhraseMapper.modelToEntity(model), equals(entity));
  });
}