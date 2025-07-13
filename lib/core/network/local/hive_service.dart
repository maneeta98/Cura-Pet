// import 'package:cura_pet/app/constant/hive/hive_table_constant.dart';
// import 'package:cura_pet/features/user/data/model/user_hive_model.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';

// class HiveService {
//   late Box<UserHiveModel> _userBox;

//   Future<void> init() async {
//     final directory = await getApplicationDocumentsDirectory();
//     Hive.init(directory.path);
//     Hive.registerAdapter(UserHiveModelAdapter());
//     _userBox = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
//   }

//   // ================ User Queries ================

//   Future<void> addUser(UserHiveModel user) async {
//     await _userBox.put(user.userId, user);
//   }

//   Future<List<UserHiveModel>> getAllUsers() async {
//     return _userBox.values.toList()..sort((a, b) => a.name.compareTo(b.name));
//   }

//   Future<void> updateUser(UserHiveModel user) async {
//     await _userBox.put(user.userId, user);
//   }

//   Future<void> deleteUser(String id) async {
//     await _userBox.delete(id);
//   }

//   // ================ Auth Queries ================

//   Future<void> register(UserHiveModel auth) async {
//     await _userBox.put(auth.userId, auth);
//   }

//   // Login using email and password
//   Future<UserHiveModel?> login(String email, String password) async {
//     try {
//       return _userBox.values.firstWhere(
//         (element) => element.email == email && element.password == password,
//       );
//     } catch (e) {
//       // Return null if user not found or password incorrect
//       return null;
//     }
//   }

//   // ================ Clear Data ================

//   Future<void> clearAll() async {
//     await Hive.deleteFromDisk();
//   }

//   // Call this to properly close the box when app is closing (optional)
//   Future<void> close() async {
//     await _userBox.close();
//   }
// }
