import 'package:cura_pet/app/shared_pref/token_shared_prefs.dart';
import 'package:cura_pet/main.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core Services
import 'package:cura_pet/core/network/local/hive_service.dart';

// User Feature
import 'package:cura_pet/features/user/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:cura_pet/features/user/data/repository/local_repository/user_local_repository.dart';
import 'package:cura_pet/features/user/domain/repository/user_repository.dart';
import 'package:cura_pet/features/user/domain/usecase/user_login_usecase.dart';
import 'package:cura_pet/features/user/domain/usecase/user_register_usecase.dart';
import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:cura_pet/features/user/presentation/view_model/register_view_model/register_view_model.dart';

// Splash Feature
import 'package:cura_pet/features/splash/view_model/splash_view_model.dart';

/// Service locator instance
final serviceLocator = GetIt.instance;

/// Call this at app startup to register all dependencies
Future<void> initDependencies() async {
  // Initialize SharedPreferences first and register it
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(sharedPrefs);
  serviceLocator.registerLazySingleton(
    () => TokenSharedPrefs(sharedPreferences: serviceLocator()),
  );

  await _initCoreServices();
  await _initUserModule();
  await _initSplashModule();
  // Future: await _initDashboardModule();
}

/// Register core app-level services (e.g. Hive, DB, SharedPrefs)
Future<void> _initCoreServices() async {
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
}

/// Register dependencies related to user feature (Login, Register)
Future<void> _initUserModule() async {
  // Data Source
  serviceLocator.registerFactory<UserLocalDataSource>(
    () => UserLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );

  // Repository (bind interface to implementation)
  serviceLocator.registerFactory<IUserRepository>(
    () => UserLocalRepository(
      userLocalDataSource: serviceLocator<UserLocalDataSource>(),
    ),
  );

  // Use Cases
  serviceLocator.registerFactory<UserRegisterUseCase>(
    () =>
        UserRegisterUseCase(userRepository: serviceLocator<IUserRepository>()),
  );

  serviceLocator.registerFactory<UserLoginUseCase>(
    () => UserLoginUseCase(userRepository: serviceLocator<IUserRepository>()),
  );

  // View Models (Bloc/Cubit/Notifier)
  serviceLocator.registerFactory<RegisterViewModel>(
    () => RegisterViewModel(serviceLocator<UserRegisterUseCase>()),
  );

  serviceLocator.registerFactory<LoginViewModel>(
    () => LoginViewModel(loginUserUseCase: serviceLocator<UserLoginUseCase>()),
  );
}

/// Register splash screen ViewModel
Future<void> _initSplashModule() async {
  serviceLocator.registerFactory<SplashViewModel>(() => SplashViewModel());
}

Future<void> _initDashboardModule() async {
  // serviceLocator.registerFactory(() => DashboardViewModel());
}
