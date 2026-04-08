import 'package:crypto_app/core/constants/HiveConstants.dart';
import 'package:crypto_app/data/datasource/remote/HomeRemoteDataSourceImpl.dart';
import 'package:crypto_app/data/repository/HomeRepo.dart';
import 'package:crypto_app/data/repository/HomeRepoImpl.dart';
import 'package:crypto_app/data/repository/AuthRepo.dart';
import 'package:crypto_app/data/repository/AuthRepoImpl.dart';
import 'package:crypto_app/data/datasource/local/AuthLocalDataSourceImpl.dart';
import 'package:crypto_app/features/auth/cubit/UserCubit.dart';
import 'package:crypto_app/features/home/cubit/HomeCubit.dart';
import 'package:crypto_app/features/market/cubit/MarketCubit.dart';
import 'package:crypto_app/features/search/cubit/SearchCubit.dart';
import 'package:crypto_app/features/wallet/cubit/WalletCubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/DioHelper.dart';
import 'core/routing/AppRoutes.dart';
import 'core/routing/RouteGenerator.dart';
import 'data/datasource/local/MarketLocalDataSourceImpl.dart';
import 'data/datasource/remote/MarketRemoteDataSourceImpl.dart';
import 'data/model/MarketCoinModel.dart';
import 'data/model/UserModel.dart';
import 'data/repository/MarketRepo.dart';
import 'data/repository/MarketRepoImpl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  final userBox = await Hive.openBox<UserModel>(HiveConstants.userBox);

  Hive.registerAdapter(MarketCoinModelAdapter());
  final favoriteBox = await Hive.openBox<MarketCoinModel>(
    HiveConstants.favoritesBox,
  );

  final prefs = await SharedPreferences.getInstance();

  final authLocalDataSource = AuthLocalDataSourceImpl(
    box: userBox,
    sharedPreferences: prefs,
  );
  final authRepo = AuthRepoImpl(localDataSource: authLocalDataSource);
  final marketLocalDataSource = MarketLocalDataSourceImpl(
    favoritesBox: favoriteBox,
  );
  final marketRepo = MarketRepoImpl(
    localDataSource: marketLocalDataSource,
    remoteDataSource: MarketRemoteDataSourceImpl(),
  );
  final homeRepo = HomeRepoImpl();
  runApp(
    CryptoApp(authRepo: authRepo, marketRepo: marketRepo, homeRepo: homeRepo),
  );
}

class CryptoApp extends StatelessWidget {
  final HomeRepo homeRepo;
  final AuthRepo authRepo;
  final MarketRepo marketRepo;

  const CryptoApp({
    super.key,
    required this.authRepo,
    required this.marketRepo,
    required this.homeRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HomeRepo>.value(value: homeRepo),
        RepositoryProvider<AuthRepo>.value(value: authRepo),
        RepositoryProvider<MarketRepo>.value(value: marketRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(create: (context) => UserCubit(authRepo)),
          BlocProvider<MarketCubit>(
            create: (context) => MarketCubit(marketRepo: marketRepo),
          ),
          BlocProvider<WalletCubit>(
            create: (context) => WalletCubit(marketRepo: marketRepo),
          ),
          BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(marketRepo: marketRepo),
          ),
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(homeRepo: homeRepo),
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
