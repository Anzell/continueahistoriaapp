class ServerConstants{
  static const url = "http://localhost:3000";
  //static const url = "https://serene-mesa-82236.herokuapp.com";
  static const signUpPath = "/api/register/user";
  static const loginPath = "/api/login/user";
  static const getUserByIdPath = "/api/user/";
  static const getRoomsOfPlayer = "/api/rooms/";
  static const createRoom = "/api/createRoom";
}

class ServerCodes {
  static const  serverFailure = "server_failure";
  static const unknownError = "unknown";
  static const emailAlreadyRegistered = "email_already_exists";
  static const usernameAlreadyRegistered = "username_already_exists";
  static const success = "success";
  static const invalidCredentials = "invalid_credentials";
  static const validationError = "validation_error";
  static const acessDenied = "acess_denied";
}

class TypeSocketMessages {
  static const playerEnterInRoom = "player_enter_in_room";
  static const sendPhraseToHistory = "send_phrase_to_history";
  static const joinRoom = "player_join_room";
  static const serverFailure = "server_failure";
  static const error = "error";
}