import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';
import 'package:continueahistoriaapp/domain/usecases/room/send_phrase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'send_phrase_test.mocks.dart';

@GenerateMocks([RoomRepository])
void main(){
  late MockRoomRepository mockRoomRepository;
  late SendPhraseUseCase sendPhraseUseCase;

  setUp((){
    mockRoomRepository = MockRoomRepository();
    sendPhraseUseCase = SendPhraseUseCase(repository: mockRoomRepository);
  });

  test("should return Right None if call to repository is success", () async{
    when(mockRoomRepository.sendPhrase(roomId: anyNamed("roomId"), userId: anyNamed("userId"), phrase: anyNamed("phrase"))).thenAnswer((_) async => Right(None()));
    final result = await sendPhraseUseCase(SendPhraseUseCaseParams(
      phrase: "valid",
      userId: "valid",
      roomId: "valid",
    ));
    expect(result, equals(Right(None())));
  });

  test("should return Left if call to repository is fail", () async{
    when(mockRoomRepository.sendPhrase(roomId: anyNamed("roomId"), userId: anyNamed("userId"), phrase: anyNamed("phrase"))).thenAnswer((_) async => Left(ServerFailure()));
    final result = await sendPhraseUseCase(SendPhraseUseCaseParams(
      phrase: "valid",
      userId: "valid",
      roomId: "valid",
    ));
    expect(result, equals(Left(ServerFailure())));
  });
}