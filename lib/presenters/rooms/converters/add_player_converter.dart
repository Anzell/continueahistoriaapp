import 'package:continueahistoriaapp/core/converters/converter.dart';
import 'package:dartz/dartz.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:equatable/equatable.dart';

class AddPlayerConverter implements Converter<AddPlayerConverted, AddPlayerConverterParams> {
  @override
  Either<ValidationFailure, AddPlayerConverted> call(AddPlayerConverterParams params) {
    if (params.username == null || params.username == "") {
      return Left(ValidationFailure(message: AddPlayerConverterErrorMessages.missingUser));
    }
    if (params.roomId == null || params.roomId == "") {
      return Left(ValidationFailure(message: AddPlayerConverterErrorMessages.missingRoomId));
    }
    return Right(AddPlayerConverted(roomId: params.roomId!, username: params.username!));
  }
}

class AddPlayerConverted extends Equatable {
  final String username;
  final String roomId;

  const AddPlayerConverted({required this.roomId, required this.username});

  @override
  List<Object> get props => [roomId, username];
}

class AddPlayerConverterParams extends Equatable {
  final String? username;
  final String? roomId;

  const AddPlayerConverterParams({this.roomId, this.username});

  @override
  List<Object?> get props => [roomId, username];
}

class AddPlayerConverterErrorMessages {
  static const missingUser = "É necessário informar o apelido do usuario";
  static const missingRoomId = "É necessário informar a sala";
}
