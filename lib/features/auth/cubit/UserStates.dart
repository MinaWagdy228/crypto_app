import '../../../data/model/UserModel.dart';

abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserLoginSuccessState extends UserStates {}

class UserSignUpSuccessState extends UserStates {}

class UserErrorState extends UserStates {
  final String errorMessage;
  UserErrorState(this.errorMessage);
}

class UserLoadedState extends UserStates {
  final UserModel user;
  UserLoadedState(this.user);
}

class UserProfileUpdateSuccessState extends UserStates {}

// Emitted when the app opens and the user has an active session
class UserAuthenticatedState extends UserStates {}

// Emitted when the app opens and the user needs to log in
class UserUnauthenticatedState extends UserStates {}
