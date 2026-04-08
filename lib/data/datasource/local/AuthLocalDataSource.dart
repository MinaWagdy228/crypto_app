import 'package:crypto_app/data/model/UserModel.dart';


abstract class AuthLocalDataSource {
  // Hive Database
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUserByEmail(String email);
  Future<UserModel?> getUserByPhoneNumber(String phoneNumber);

  // Shared Preferences
  Future<void> saveLoginSession(bool isLoggedIn);
  Future<bool?> getIsLoggedIn();

  // Store the key (email or phone number) of the logged-in user
  Future<void> saveLoggedInUserKey(String key);
  Future<String?> getLoggedInUserKey();
}
