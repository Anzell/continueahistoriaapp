import 'package:continueahistoriaapp/core/converters/converter.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ListenRoomByIdConverter implements Converter<ListenRoomByIdConverted, ListenRoomByIdConverterParams>{
  @override
  Either<ValidationFailure, ListenRoomByIdConverted> call(ListenRoomByIdConverterParams params) {
    if(params.roomId == null || params.roomId == ""){
      return Left(ValidationFailure(message: ListenRoomByIdConverterErrorMessages.missingRoomId));
    }
    return Right(ListenRoomByIdConverted(roomId: params.roomId!));
  }

}

class ListenRoomByIdConverted extends Equatable {
  final String roomId;

  const ListenRoomByIdConverted({required this.roomId});

  @override
  List<Object> get props => [roomId];
}



class ListenRoomByIdConverterParams extends Equatable {
  final String? roomId;

  const ListenRoomByIdConverterParams({this.roomId});

  @override
  List<Object?> get props => [roomId];
}

class ListenRoomByIdConverterErrorMessages {
  static const String missingRoomId = "É necessário informar uma sala";
}