import 'package:continueahistoriaapp/core/converters/converter.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SendPhraseConverter implements Converter<SendPhraseConverted, SendPhraseConverterParams>{
  @override
  Either<ValidationFailure, SendPhraseConverted> call(SendPhraseConverterParams params) {
    if(params.roomId == null || params.roomId == ""){
      return Left(ValidationFailure(message: SendPhraseConverterErrorMessages.missingRoom));
    }
    if(params.userId == null || params.userId == ""){
      return Left(ValidationFailure(message: SendPhraseConverterErrorMessages.missingUser));
    }
    if(params.phrase == null || params.phrase == ""){
      return Left(ValidationFailure(message: SendPhraseConverterErrorMessages.missingPhrase));
    }
    if(params.phrase!.replaceAll(RegExp('\\s+'), ' ').split(" ").length != 3){
      return Left(ValidationFailure(message: SendPhraseConverterErrorMessages.invalidPhrase));
    }
    return Right(SendPhraseConverted(phrase: params.phrase!, userId: params.userId!, roomId: params.roomId!));
  }

}

class SendPhraseConverted extends Equatable{
  final String phrase;
  final String userId;
  final String roomId;

  const SendPhraseConverted({required this.phrase, required this.userId, required this.roomId});

  @override
  List<Object> get props => [phrase, roomId, userId];
}

class SendPhraseConverterParams extends Equatable {
  final String? phrase;
  final String? userId;
  final String? roomId;

  const SendPhraseConverterParams({this.phrase, this.userId, this.roomId});

  @override
  List<Object?> get props => [phrase, roomId, userId];
}

class SendPhraseConverterErrorMessages {
  static const missingUser = "É necessário informar usuário";
  static const missingRoom = "É necessário informar sala";
  static const missingPhrase = "É necessário informar frase";
  static const invalidPhrase = "Frase em formato inválido (valido somente 3 palavras)";
}

