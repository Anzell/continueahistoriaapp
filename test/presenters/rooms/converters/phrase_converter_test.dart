import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/phrase_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PhraseConverter converter;

  setUp(() {
    converter = PhraseConverter();
  });

  test("should return right if data provided is valid", () {
    final expected = PhraseConverted(
      phrase: Phrase(phrase: "Era uma vez", sendAt: DateTime(2021, 10, 10), senderId: "validId"),
    );
    final result =
        converter(PhraseConverterParams(sendAt: DateTime(2021, 10, 10), senderId: "validId", phrase: "Era uma vez"));
    expect(result, equals(Right(expected)));
  });

  test("should return left if data provided is invalid", () {
    Either result;
    result = converter(PhraseConverterParams());
    expect(result, equals(Left(ValidationFailure(message: PhraseConverterErrorMessages.missingPhrase))));
    result = converter(PhraseConverterParams(phrase: ""));
    expect(result, equals(Left(ValidationFailure(message: PhraseConverterErrorMessages.missingPhrase))));
  });
}
