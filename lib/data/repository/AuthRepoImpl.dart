import 'package:crypto_app/data/datasource/local/localDataSource.dart';
import 'package:crypto_app/data/model/UserModel.dart';
import 'AuthRepo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthLocalDataSource localDataSource;

  AuthRepoImpl({required this.localDataSource});

  @override
  Future<void> signUp(UserModel user) async {
    await localDataSource.saveUser(user);
  }

  @override
  Future<bool> loginUserByEmail(String email, String password) async {
    if (!_validateEmail(email)) return false;

    final user = await localDataSource.getUserByEmail(email);

    return _validateAndLogin(user, password);
  }

  @override
  Future<bool> loginUserByPhoneNumber(
    String phoneNumber,
    String password,
  ) async {
    if (!_validatePhoneNumber(phoneNumber)) return false;

    final user = await localDataSource.getUserByPhoneNumber(phoneNumber);

    return _validateAndLogin(user, password);
  }

  Future<bool> _validateAndLogin(UserModel? user, String password) async {
    if (user != null && _validatePassword(password, user.password)) {
      await localDataSource.saveLoginSession(true);
      await localDataSource.saveLoggedInUserKey(user.email);
      return true;
    }
    return false;
  }

  @override
  Future<bool> isLoggedIn() async {
    final result = await localDataSource.getIsLoggedIn();
    return result ?? false;
  }

  @override
  Future<void> logoutUser() async {
    await localDataSource.saveLoginSession(false);
  }

  bool _validatePassword(String inputPassword, String storedPassword) {
    return inputPassword == storedPassword;
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _validatePhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^\d{11}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final key = await localDataSource.getLoggedInUserKey();
    if (key != null) {
      return await localDataSource.getUserByEmail(key);
    }
    return null;
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await localDataSource.saveUser(user);
    await localDataSource.saveLoggedInUserKey(user.email);
  }
}
