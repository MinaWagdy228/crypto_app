import 'package:crypto_app/data/datasource/local/localDataSource.dart';
import 'package:crypto_app/data/model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<UserModel> box;
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.box, required this.sharedPreferences});

  @override
  Future<bool?> getIsLoggedIn() async {
    return sharedPreferences.getBool('IS_LOGGED_IN') ?? false;
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    return box.get(email);
  }

  @override
  Future<UserModel?> getUserByPhoneNumber(String phoneNumber) async {
    return box.get(phoneNumber);
  }

  @override
  Future<void> saveLoginSession(bool isLoggedIn) async {
    await sharedPreferences.setBool('IS_LOGGED_IN', isLoggedIn);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await box.put(user.mobile, user);
    await box.put(user.email, user);
  }
}
