import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/usecases/future_usecases.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SendPhraseUseCase implements FutureUseCase<None, SendPhraseUseCaseParams>{
  final RoomRepository repository;

  const SendPhraseUseCase({required this.repository});

  @override
  Future<Either<Failure, None>> call(SendPhraseUseCaseParams params) async {
    return await repository.sendPhrase(roomId: params.roomId, userId: params.userId, phrase: params.phrase);
  }

}

class SendPhraseUseCaseParams extends Equatable {
  final String userId;
  final String phrase;
  final String roomId;

  const SendPhraseUseCaseParams({required this.userId, required this.phrase, required this.roomId});

  @override
  List<Object> get props => [userId, phrase, roomId];
}