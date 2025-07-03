import 'package:cura_pet/features/pets/domain/entity/pet_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pets_state.dart';

class PetsCubit extends Cubit<PetsState> {
  PetsCubit() : super(PetsInitialState());

  /// This should ideally call your repository to get data.
  /// For now, let's simulate with some dummy data and delay.
  Future<void> fetchPets() async {
    emit(PetsLoadingState());

    try {
      // Simulate network or DB delay
      await Future.delayed(const Duration(seconds: 2));

      // Dummy pet list
      final pets = [
        PetEntity(name: 'Charlie', breed: 'Golden Retriever', age: 3),
        PetEntity(name: 'Luna', breed: 'Siberian Husky', age: 2),
        PetEntity(name: 'Max', breed: 'Beagle', age: 4),
      ];

      emit(PetsLoadedState(pets));
    } catch (e) {
      emit(PetsErrorState('Failed to load pets'));
    }
  }
}
