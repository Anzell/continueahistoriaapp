import 'package:continueahistoriaapp/core/converters/converter.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetRoomsByPlayerIdConverter implements Converter<GetRoomsByPlayerIdConverted, GetRoomsByPlayerIdConverterParams> {
  @override
  Either<ValidationFailure, GetRoomsByPlayerIdConverted> call(GetRoomsByPlayerIdConverterParams params) {
    if(params.userId == null || params.userId == ""){
      return Left(ValidationFailure(message: GetRoomsByPlayerIdConverterErrorMessages.missingUserId));
    }
    return Right(GetRoomsByPlayerIdConverted(userId: params.userId!));
  }

}

class GetRoomsByPlayerIdConverted extends Equatable{
  final String userId;

  const GetRoomsByPlayerIdConverted({required this.userId});

  @override
  List<Object> get props => [userId];
}

class GetRoomsByPlayerIdConverterParams extends Equatable{
  final String? userId;

  const GetRoomsByPlayerIdConverterParams({this.userId});

  @override
  List<Object?> get props => [userId];
}

class GetRoomsByPlayerIdConverterErrorMessages {
  static const missingUserId = "É necessário informar o usuário";
}