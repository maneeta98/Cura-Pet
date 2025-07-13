// main.dart
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';

// =================== Core Error ===================
abstract class Failure {
  final String message;
  Failure({required this.message});
}

// =================== Entities ===================
class UserEntity {
  final String name;
  final String email;
  final String phone;
  final String password;

  UserEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}

// =================== Params ===================
class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class RegisterUserParams {
  final String name;
  final String email;
  final String phone;
  final String password;

  RegisterUserParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}

// =================== Core Services ===================
class HiveService {
  // Dummy Hive service
  void openBox() {
    print('Hive box opened');
  }
}

// =================== Shared Prefs Wrapper ===================
class TokenSharedPrefs {
  final SharedPreferences sharedPreferences;

  TokenSharedPrefs({required this.sharedPreferences});

  Future<void> saveToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  String? getToken() {
    return sharedPreferences.getString('token');
  }
}

// =================== Repository Interface ===================
abstract class IUserRepository {
  Future<Either<Failure, String>> loginUser(String email, String password);
  Future<Either<Failure, void>> registerUser(UserEntity user);
}

// =================== Data Source ===================
class UserLocalDataSource {
  final HiveService hiveService;

  UserLocalDataSource({required this.hiveService});

  Future<void> saveUser(UserEntity user) async {
    // Dummy save
    print('User saved locally: ${user.email}');
  }
}

// =================== Repository Implementation ===================
class UserLocalRepository implements IUserRepository {
  final UserLocalDataSource userLocalDataSource;

  UserLocalRepository({required this.userLocalDataSource});

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {
    try {
      await userLocalDataSource.saveUser(user);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure('Registration failed'));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    // Dummy login: if password is 'test123', success else failure
    if (password == 'test123') {
      return Right('dummy_token_123');
    } else {
      return Left(ServerFailure('Invalid credentials'));
    }
  }
}

// =================== Use Cases ===================
class UserLoginUseCase {
  final IUserRepository userRepository;

  UserLoginUseCase({required this.userRepository});

  Future<Either<Failure, String>> call(LoginParams params) {
    return userRepository.loginUser(params.email, params.password);
  }
}

class UserRegisterUseCase {
  final IUserRepository userRepository;

  UserRegisterUseCase({required this.userRepository});

  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final user = UserEntity(
      name: params.name,
      email: params.email,
      phone: params.phone,
      password: params.password,
    );
    return userRepository.registerUser(user);
  }
}

// =================== View Models ===================
class LoginViewModel {
  final UserLoginUseCase loginUserUseCase;
  LoginViewModel({required this.loginUserUseCase});

  Future<void> login(String email, String password) async {
    final result = await loginUserUseCase(
      LoginParams(email: email, password: password),
    );
    result.fold(
      (failure) => print('Login failed: ${failure.message}'),
      (token) => print('Login succeeded, token: $token'),
    );
  }
}

class RegisterViewModel {
  final UserRegisterUseCase registerUserUseCase;
  RegisterViewModel(this.registerUserUseCase);

  Future<void> register(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    final result = await registerUserUseCase(
      RegisterUserParams(
        name: name,
        email: email,
        phone: phone,
        password: password,
      ),
    );
    result.fold(
      (failure) => print('Register failed: ${failure.message}'),
      (_) => print('Register succeeded'),
    );
  }
}

// =================== Failure Implementation ===================
class ServerFailure extends Failure {
  ServerFailure(String message) : super(message: message);
}

// =================== Service Locator ===================
final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(sharedPrefs);

  serviceLocator.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(sharedPreferences: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());

  serviceLocator.registerFactory<UserLocalDataSource>(
    () => UserLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );

  serviceLocator.registerFactory<IUserRepository>(
    () => UserLocalRepository(
      userLocalDataSource: serviceLocator<UserLocalDataSource>(),
    ),
  );

  serviceLocator.registerFactory<UserRegisterUseCase>(
    () =>
        UserRegisterUseCase(userRepository: serviceLocator<IUserRepository>()),
  );

  serviceLocator.registerFactory<UserLoginUseCase>(
    () => UserLoginUseCase(userRepository: serviceLocator<IUserRepository>()),
  );

  serviceLocator.registerFactory<RegisterViewModel>(
    () => RegisterViewModel(serviceLocator<UserRegisterUseCase>()),
  );

  serviceLocator.registerFactory<LoginViewModel>(
    () => LoginViewModel(loginUserUseCase: serviceLocator<UserLoginUseCase>()),
  );
}

// =================== Main Entry Point ===================
Future<void> main() async {
  await initDependencies();

  // Example usage:
  final loginVM = serviceLocator<LoginViewModel>();
  await loginVM.login('manita@example.com', 'test123'); // should succeed
  await loginVM.login('manita@example.com', 'wrongpass'); // should fail

  final registerVM = serviceLocator<RegisterViewModel>();
  await registerVM.register(
    'Manita',
    'manita@example.com',
    '9812345678',
    'test123',
  );
}
