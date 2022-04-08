import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/send_phrase_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SendPhraseConverter converter;

  setUp(() {
    converter = SendPhraseConverter();
  });

  test("should return converted object if data provided is valid", () {
    final result = converter(SendPhraseConverterParams(userId: "validId", roomId: "validId", phrase: "Era uma vez"));
    expect(result, equals(Right(SendPhraseConverted(userId: "validId", roomId: "validId", phrase: "Era uma vez"))));
  });


  test("should return validation error if data provided is fail", () {
    Either result;
    result = converter(SendPhraseConverterParams(roomId: "validId", phrase: "Era uma vez"));
    expect(result, equals(Left(ValidationFailure(message: SendPhraseConverterErrorMessages.missingUser))));
    result = converter(SendPhraseConverterParams(roomId: "validId", phrase: "Era uma vez", userId: ""));
    expect(result, equals(Left(ValidationFailure(message: SendPhraseConverterErrorMessages.missingUser))));
    result = converter(SendPhraseConverterParams( phrase: "Era uma vez", userId: "validId"));
    expect(result, equals(Left(ValidationFailure(message: SendPhraseConverterErrorMessages.missingRoom))));
    result = converter(SendPhraseConverterParams( phrase: "Era uma vez", userId: "validId", roomId: ""));
    expect(result, equals(Left(ValidationFailure(message: SendPhraseConverterErrorMessages.missingRoom))));
    result = converter(SendPhraseConverterParams(userId: "validId", roomId: "validId"));
    expect(result, equals(Left(ValidationFailure(message: SendPhraseConverterErrorMessages.missingPhrase))));
    result = converter(SendPhraseConverterParams(userId: "validId", roomId: "validId", phrase: ""));
    expect(result, equals(Left(ValidationFailure(message: SendPhraseConverterErrorMessages.missingPhrase))));
    result = converter(SendPhraseConverterParams(userId: "validId", roomId: "validId", phrase: "Frase invalida"));
    expect(result, equals(Left(ValidationFailure(message: SendPhraseConverterErrorMessages.invalidPhrase))));
    result = converter(SendPhraseConverterParams(userId: "validId", roomId: "validId", phrase: "outra frase que é invalida por ter mais palavras do que o permitido"));
    expect(result, equals(Left(ValidationFailure(message: SendPhraseConverterErrorMessages.invalidPhrase))));
  });
}
