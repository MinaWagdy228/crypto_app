import 'package:crypto_app/core/routing/RouteGenerator.dart';
import 'package:crypto_app/data/model/UserModel.dart';
import 'package:crypto_app/features/profile/ProfileScreen.dart';
import 'package:crypto_app/features/settings/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/routing/AppRoutes.dart';
import 'features/splash/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('userBox');
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tMinus1 Crypto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'NeueMontreal'),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
