// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_view_model.dart';
// import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_state.dart';
// import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_event.dart';

// void main() {
//   group('LoginViewModel Bloc Tests', () {
//     late LoginViewModel loginBloc;

//     setUp(() {
//       loginBloc = LoginViewModel();
//     });

//     blocTest<LoginViewModel, LoginState>(
//       '1. emits success on valid login',
//       build: () => loginBloc,
//       act: (bloc) => bloc.add(LoginWithEmailAndPassword(
//         context: null,
//         email: 'test@test.com',
//         password: 'password123',
//       )),
//       expect: () => [
//         isA<LoginState>().having((s) => s.isLoading, 'loading', true),
//         isA<LoginState>().having((s) => s.isSuccess, 'success', true),
//       ],
//     );

//     blocTest<LoginViewModel, LoginState>(
//       '2. emits error for invalid email',
//       build: () => loginBloc,
//       act: (bloc) => bloc.add(LoginWithEmailAndPassword(
//         context: null,
//         email: 'invalid',
//         password: 'password123',
//       )),
//       expect: () => [isA<LoginState>().having((s) => s.errorMessage, 'error', isNotNull)],
//     );

//     blocTest<LoginViewModel, LoginState>(
//       '3. emits error for empty password',
//       build: () => loginBloc,
//       act: (bloc) => bloc.add(LoginWithEmailAndPassword(
//         context: null,
//         email: 'test@test.com',
//         password: '',
//       )),
//       expect: () => [isA<LoginState>().having((s) => s.errorMessage, 'error', isNotNull)],
//     );

//     blocTest<LoginViewModel, LoginState>(
//       '4. emits error for empty email',
//       build: () => loginBloc,
//       act: (bloc) => bloc.add(LoginWithEmailAndPassword(
//         context: null,
//         email: '',
//         password: 'password123',
//       )),
//       expect: () => [isA<LoginState>().having((s) => s.errorMessage, 'error', isNotNull)],
//     );

//     blocTest<LoginViewModel, LoginState>(
//       '5. emits success after correct credentials',
//       build: () => loginBloc,
//       act: (bloc) => bloc.add(LoginWithEmailAndPassword(
//         context: null,
//         email: 'valid@email.com',
//         password: 'password123',
//       )),
//       expect: () => [
//         isA<LoginState>().having((s) => s.isLoading, 'loading', true),
//         isA<LoginState>().having((s) => s.isSuccess, 'success', true),
//       ],
//     );
//   });
// }
