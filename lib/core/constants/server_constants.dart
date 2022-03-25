class ServerConstants{
  static const url = "http://localhost:3000";
  static const signUpPath = "/api/register/user";
}

class ServerCodes {
  static const  serverFailure = "server_failure";
  static const unknownError = "unknown";
  static const emailAlreadyRegistered = "email_already_exists";
  static const usernameAlreadyRegistered = "username_already_exists";
  static const success = "success";
  static const invalidCredentials = "invalid_credentials";
  static const validationError = "validation_error";
}