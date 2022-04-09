import 'package:continueahistoriaapp/core/converters/converter.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class PhraseConverter implements Converter<PhraseConverted, PhraseConverterParams> {
  @override
  Either<ValidationFailure, PhraseConverted> call(PhraseConverterParams params) {
    if (params.phrase == null || params.phrase == "") {
      return Left(ValidationFailure(message: PhraseConverterErrorMessages.missingPhrase));
    }
    return Right(PhraseConverted(
      phrase: Phrase(
        phrase: params.phrase,
        sendAt: params.sendAt,
        senderId: params.senderId,
      ),
    ));
  }
}

class PhraseConverted extends Equatable {
  final Phrase phrase;

  const PhraseConverted({required this.phrase});

  @override
  List<Object> get props => [phrase];
}

class PhraseConverterParams extends Equatable {
  final String? phrase;
  final String? senderId;
  final DateTime? sendAt;

  const PhraseConverterParams({this.phrase, this.sendAt, this.senderId});

  @override
  List<Object?> get props => [phrase, senderId, sendAt];
}

class PhraseConverterErrorMessages {
  static const missingPhrase = "É necessário informar a frase";
}
