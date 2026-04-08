import 'package:crypto_app/data/repository/CoinRepo.dart';
import 'package:crypto_app/data/repository/CoinRepoImpl.dart';
import 'package:crypto_app/data/repository/AuthRepo.dart';
import 'package:crypto_app/data/repository/AuthRepoImpl.dart';
import 'package:crypto_app/data/datasource/local/localDataSourceImpl.dart';
import 'package:crypto_app/features/auth/cubit/UserCubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/routing/AppRoutes.dart';
import 'core/routing/RouteGenerator.dart';
import 'data/model/UserModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  final userBox = await Hive.openBox<UserModel>('userBox');

  final prefs = await SharedPreferences.getInstance();

  final authLocalDataSource = AuthLocalDataSourceImpl(
    box: userBox,
    sharedPreferences: prefs,
  );
  final authRepo = AuthRepoImpl(localDataSource: authLocalDataSource);

  runApp(CryptoApp(authRepo: authRepo));
}

class CryptoApp extends StatelessWidget {
  final AuthRepo authRepo;

  const CryptoApp({
    super.key,
    required this.authRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CoinRepo>(
          create: (context) => CoinRepoImpl(),
        ),
        RepositoryProvider<AuthRepo>.value(
          value: authRepo,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(
            create: (context) => UserCubit(authRepo),
          ),
        ],
        child: MaterialApp(
          title: 'tMinus1 Crypto',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true, fontFamily: 'NeueMontreal'),
          initialRoute: AppRoutes.splash,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}