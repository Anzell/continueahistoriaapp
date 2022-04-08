import 'package:continueahistoriaapp/core/converters/converter.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateRoomConverter implements Converter<CreateRoomConverted, CreateRoomConverterParams>{
  @override
  Either<ValidationFailure, CreateRoomConverted> call(CreateRoomConverterParams params) {
    if(params.roomData == null){
      return Left(ValidationFailure(message: CreateRoomConverterErrorMessages.missingRoomData));
    }
    if(params.userId == null || params.userId == ""){
      return Left(ValidationFailure(message: CreateRoomConverterErrorMessages.missingUser));
    }
    return Right(CreateRoomConverted(userId: params.userId!, roomData: params.roomData!));
  }

}

class CreateRoomConverted extends Equatable {
  final GameRoom roomData;
  final String userId;

  const CreateRoomConverted({required this.userId, required this.roomData});

  @override
  List<Object> get props => [userId, roomData];
}

class CreateRoomConverterParams extends Equatable{
  final GameRoom? roomData;
  final String? userId;

  const CreateRoomConverterParams({ this.userId,  this.roomData});

  @override
  List<Object?> get props => [userId, roomData];
}

class CreateRoomConverterErrorMessages {
  static const missingRoomData = "É necessário informar uma sala para criar";
  static const missingUser = "É necessário informar o usuário criador da sala";

}