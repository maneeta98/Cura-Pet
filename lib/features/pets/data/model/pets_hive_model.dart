import 'package:hive/hive.dart';

part 'pets_hive_model.g.dart';

@HiveType(typeId: 0)
class PetsHiveModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String breed;

  @HiveField(2)
  final String age;

  PetsHiveModel({required this.name, required this.breed, required this.age});
}
