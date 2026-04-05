abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserLoginSuccessState extends UserStates {}

class UserSignUpSuccessState extends UserStates {}

class UserErrorState extends UserStates {
  final String errorMessage;

  UserErrorState(this.errorMessage);
}
