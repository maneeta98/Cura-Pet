import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cura_pet/features/user/domain/entity/user_entity.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;

  final String name;

  final String email;

  final String phone;

  final String? password;

  const UserApiModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  // factory UserApiModel.fromJson(Map<String, dynamic> json) =>
  //     _$UserApiModelFromJson(json);

  // Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  // Convert from API model to domain entity
  UserEntity toEntity() {
    return UserEntity(
      userId: id,
      name: name,
      email: email,
      phone: phone,
      password: password ?? '',
    );
  }

  // Convert from domain entity to API model
  factory UserApiModel.fromEntity(UserEntity entity) {
    return UserApiModel(
      id: entity.userId,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone, password];
}
