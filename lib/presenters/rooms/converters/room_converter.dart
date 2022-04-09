import 'package:continueahistoriaapp/core/converters/converter.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RoomConverter implements Converter<RoomConverted, RoomConverterParams> {
  @override
  Either<ValidationFailure, RoomConverted> call(RoomConverterParams params) {
    return Right(
      RoomConverted(
        gameRoom: GameRoom(
          name: params.name,
          id: params.id,
          playersIds: params.playerIds as List<String>?,
          adminsIds: params.adminsIds as List<String>?,
          history: params.history as List<Phrase>?,
        ),
      ),
    );
  }
}

class RoomConverted extends Equatable {
  final GameRoom gameRoom;

  const RoomConverted({required this.gameRoom});

  @override
  List<Object> get props => [gameRoom];
}

class RoomConverterParams extends Equatable {
  final String? name;
  final String? id;
  final List<Phrase?>? history;
  final List<String?>? adminsIds;
  final List<String?>? playerIds;

  const RoomConverterParams({this.history, this.adminsIds, this.id, this.name, this.playerIds});

  @override
  List<Object?> get props => [name, id, history, playerIds, adminsIds];
}
