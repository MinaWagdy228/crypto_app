import '../model/UserModel.dart';

abstract class AuthRepo {
  Future<void> signUp(UserModel user);

  Future<bool> loginUserByEmail(String email, String password);

  Future<bool> loginUserByPhoneNumber(String phoneNumber, String password);

  Future<bool> isLoggedIn();

  Future<void> logoutUser();

  Future<UserModel?> getCurrentUser();

  Future<void> updateUser(UserModel user);
}
