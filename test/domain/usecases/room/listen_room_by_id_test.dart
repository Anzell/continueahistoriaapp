import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';
import 'package:continueahistoriaapp/domain/usecases/room/listen_room_by_id.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'listen_room_by_id_test.mocks.dart';

@GenerateMocks([RoomRepository])
void main() {
  late MockRoomRepository mockRoomRepository;
  late ListenRoomByIdUsecase listenRoomByIdUsecase;

  setUp(() {
    mockRoomRepository = MockRoomRepository();
    listenRoomByIdUsecase = ListenRoomByIdUsecase(repository: mockRoomRepository);
  });

  test("should return valid game room if call to repository is success", () {
      final emit1 =  GameRoom(
          id: "validId",
          name: "era uma vez",
          playersIds: ["player1"],
          adminsIds: ["admin1"],
          history: [Phrase(phrase: "era uma vez", senderId: "validId", sendAt: DateTime(2021, 10, 10))]);
      when(mockRoomRepository.listenRoom(roomId: anyNamed("roomId"))).thenAnswer((_) async* {
        yield Right(emit1);
      });
      expectLater(listenRoomByIdUsecase(ListenRoomByIdUsecaseParams(roomId: "validId")), emitsInOrder([Right(emit1)]));
  });
}