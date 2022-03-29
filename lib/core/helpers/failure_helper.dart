import 'package:continueahistoriaapp/core/constants/error_messages.dart';

import '../failures/failures.dart';

class FailureHelper {
  static String mapFailureToMessage(Failure failure) {
    switch(failure.runtimeType) {
      case ValidationFailure:
        return (failure as ValidationFailure).message;
      case UsernameAlreadyRegisteredFailure:
        return ErrorMessages.usernameAlreadyExists;
      case EmailAlreadyRegisteredFailure:
        return ErrorMessages.emailAlreadyExists;
      case InvalidCredentialsFailure:
         return ErrorMessages.invalidCredentials;
      case AccessDeniedFailure:
        return ErrorMessages.accessDenied;
      case ServerFailure:
        return ErrorMessages.serverFailure;
      default:
        return ErrorMessages.unknownError;
    }
  }
}