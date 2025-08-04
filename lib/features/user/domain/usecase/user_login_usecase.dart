// // import 'package:cura_pet/app/shared_pref/token_shared_prefs.dart';
// // import 'package:cura_pet/app/usecase/use_case.dart';
// // import 'package:cura_pet/core/error/failure.dart';
// // import 'package:cura_pet/features/user/domain/repository/user_repository.dart';
// // import 'package:dartz/dartz.dart';
// // import 'package:equatable/equatable.dart';

// // class LoginParams extends Equatable {
// //   final String email;
// //   final String password;

// //   const LoginParams({required this.email, required this.password});

// //   @override
// //   List<Object?> get props => [email, password];
// // }

// // class UserLoginUseCase implements UseCaseWithParams<String, LoginParams> {
// //   final IUserRepository _userRepository;

// //   UserLoginUseCase(
// //     MockUserRepository mockUserRepository, {
// //     required IUserRepository userRepository,
// //     required TokenSharedPrefs tokenSharedPrefs,
// //   }) : _userRepository = userRepository;

// //   @override
// //   Future<Either<Failure, String>> call(LoginParams params) {
// //     return _userRepository.loginUser(params.email, params.password);
// //   }
// // }

// // class MockUserRepository {
// //   loginUser(String email, String password) {}
// // }

// import 'package:cura_pet/app/shared_pref/token_shared_prefs.dart';
// import 'package:cura_pet/app/usecase/use_case.dart';
// import 'package:cura_pet/core/error/failure.dart';
// import 'package:cura_pet/features/user/domain/repository/user_repository.dart';
// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';

// class LoginParams extends Equatable {
//   final String email;
//   final String password;

//   const LoginParams({required this.email, required this.password});

//   @override
//   List<Object?> get props => [email, password];
// }

// class UserLoginUseCase implements UseCaseWithParams<String, LoginParams> {
//   final IUserRepository _userRepository;
//   final TokenSharedPrefs _tokenSharedPrefs;

//   UserLoginUseCase({
//     required IUserRepository userRepository,
//     required TokenSharedPrefs tokenSharedPrefs,
//   }) : _userRepository = userRepository,
//        _tokenSharedPrefs = tokenSharedPrefs;

//   @override
//   Future<Either<Failure, String>> call(LoginParams params) async {
//     final result = await _userRepository.loginUser(
//       params.email,
//       params.password,
//     );
//     // Save token if login succeeds
//     result.fold(
//       (_) => null,
//       (token) async => await _tokenSharedPrefs.saveToken(token),
//     );
//     return result;
//   }
// }

import 'package:cura_pet/app/usecase/use_case.dart';
import 'package:cura_pet/app/shared_pref/token_shared_prefs.dart';
import 'package:cura_pet/core/error/failure.dart';
import 'package:cura_pet/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class UserLoginUseCase implements UseCaseWithParams<String, LoginParams> {
  final IUserRepository _userRepository;
  final TokenSharedPrefs _tokenSharedPrefs;

  UserLoginUseCase({
    required IUserRepository userRepository,
    required TokenSharedPrefs tokenSharedPrefs,
  }) : _userRepository = userRepository,
       _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    final result = await _userRepository.loginUser(
      params.email,
      params.password,
    );
    return result.fold((failure) => Left(failure), (token) async {
      await _tokenSharedPrefs.saveToken(token);
      return Right(token);
    });
  }
}
