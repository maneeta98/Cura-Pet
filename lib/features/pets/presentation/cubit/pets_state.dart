import 'package:cura_pet/features/pets/domain/entity/pet_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PetsState extends Equatable {
  const PetsState();

  @override
  List<Object?> get props => [];
}

class PetsInitialState extends PetsState {}

class PetsLoadingState extends PetsState {}

class PetsLoadedState extends PetsState {
  final List<PetEntity> pets;

  const PetsLoadedState(this.pets);

  @override
  List<Object?> get props => [pets];
}

class PetsErrorState extends PetsState {
  final String message;

  const PetsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
