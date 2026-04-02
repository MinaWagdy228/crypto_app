import 'package:hive/hive.dart';

part 'UserModel.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String mobile;
  @HiveField(3)
  final String password;

  UserModel({
    required this.username,
    required this.email,
    required this.mobile,
    required this.password,
  });
}
