import 'package:crypto_app/data/datasource/local/AuthLocalDataSource.dart';
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
    final user = await localDataSource.getUserByEmail(email);

    if (user == null) {
      return false;
    }

    if (user.password == password) {
      await localDataSource.saveLoginSession(true);
      return true;
    }
    return false;
  }

  @override
  Future<bool> loginUserByPhoneNumber(
    String phoneNumber,
    String password,
  ) async {
    final user = await localDataSource.getUserByPhoneNumber(phoneNumber);

    if (user == null) {
      return false;
    }

    if (user.password == password) {
      await localDataSource.saveLoginSession(true);
      return true;
    }

    return false;
  }

  @override
  Future<bool?> isLoggedIn() async {
    return await localDataSource.getIsLoggedIn();
  }

  @override
  Future<void> logoutUser() async {
    await localDataSource.saveLoginSession(false);
  }
}
