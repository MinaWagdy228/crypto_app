import 'package:crypto_app/features/settings/presentation/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'features/splash/presentation/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tMinus1 Crypto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'NeueMontreal',
      ),
      home: const SettingsScreen(),
    );
  }
}