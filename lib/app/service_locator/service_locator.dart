import 'package:cura_pet/app/shared_pref/token_shared_prefs.dart';
import 'package:cura_pet/core/network/local/hive_service.dart';
import 'package:cura_pet/core/network/remote/api_service.dart';
import 'package:cura_pet/features/user/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:cura_pet/features/user/data/data_source/remote_datasource/user_remote_data_source.dart';
import 'package:cura_pet/features/user/data/repository/local_repository/user_local_repository.dart';
import 'package:cura_pet/features/user/data/repository/remote_repository/user_remote_repository.dart';
import 'package:cura_pet/features/user/domain/usecase/user_login_usecase.dart';
import 'package:cura_pet/features/user/domain/usecase/user_register_usecase.dart';
import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:cura_pet/features/user/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:cura_pet/features/splash/view_model/splash_view_model.dart';
import 'package:cura_pet/main.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initCore();
  await _initHive();
  await _initSharedPrefs();
  _initUserModule();
  _initSplash();
}

void _initCore() {
  serviceLocator.registerLazySingleton<Dio>(() => Dio());

  serviceLocator.registerLazySingleton<ApiService>(
    () => ApiService(serviceLocator<Dio>()),
  );
}

Future<void> _initHive() async {
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
}

Future<void> _initSharedPrefs() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(sharedPrefs);

  serviceLocator.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(
      sharedPreferences: serviceLocator<SharedPreferences>(),
    ),
  );
}

void _initUserModule() {
  serviceLocator.registerFactory<UserLocalDataSource>(
    () => UserLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );

  serviceLocator.registerFactory<UserRemoteDataSource>(
    () => UserRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );

  serviceLocator.registerFactory<UserRemoteRepository>(
    () => UserRemoteRepository(
      remoteDataSource: serviceLocator<UserRemoteDataSource>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  serviceLocator.registerFactory<UserLocalRepository>(
    () => UserLocalRepository(
      userLocalDataSource: serviceLocator<UserLocalDataSource>(),
    ),
  );

  serviceLocator.registerFactory<UserLoginUseCase>(
    () => UserLoginUseCase(
      userRepository: serviceLocator<UserRemoteRepository>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  serviceLocator.registerFactory<UserRegisterUseCase>(
    () => UserRegisterUseCase(
      userRepository: serviceLocator<UserRemoteRepository>(),
    ),
  );

  // serviceLocator.registerFactory<LoginViewModel>(
  //   () => LoginViewModel(loginUserUseCase: serviceLocator<UserLoginUseCase>()),
  // );

  serviceLocator.registerFactory<RegisterViewModel>(
    () => RegisterViewModel(serviceLocator<UserRegisterUseCase>()),
  );
}

void _initSplash() {
  serviceLocator.registerFactory<SplashViewModel>(() => SplashViewModel());
}
