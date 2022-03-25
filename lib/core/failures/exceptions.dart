class ServerException implements Exception{}
class EmailAlreadyExistsException implements Exception{}
class UsernameAlreadyExistsException implements Exception{}
class ServerValidationException implements Exception{
  final String message;

  ServerValidationException({required this.message});
}