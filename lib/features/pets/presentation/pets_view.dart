import 'package:cura_pet/features/pets/domain/entity/pet_entity.dart';
import 'package:cura_pet/features/pets/presentation/cubit/pets_cubit.dart';
import 'package:cura_pet/features/pets/presentation/cubit/pets_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetsView extends StatefulWidget {
  const PetsView({Key? key}) : super(key: key);

  @override
  State<PetsView> createState() => _PetsViewState();
}

class _PetsViewState extends State<PetsView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PetsCubit>().fetchPets();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Pets"),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Field (non-functional placeholder)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search pets...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF66BB6A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    onPressed: () {
                      // TODO: Implement filter logic or modal
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pet List
            Expanded(
              child: BlocBuilder<PetsCubit, PetsState>(
                builder: (context, state) {
                  if (state is PetsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PetsLoadedState) {
                    if (state.pets.isEmpty) {
                      return const Center(child: Text("No pets added yet."));
                    }
                    return ListView.separated(
                      itemCount: state.pets.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final pet = state.pets[index];
                        return _buildPetCard(pet);
                      },
                    );
                  } else if (state is PetsErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text("Something went wrong"));
                  }
                },
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // TODO: Navigate to Add Pet Screen or Show Add Pet Modal
                // Navigator.pushNamed(context, '/addPet');
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Add New Pet",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetCard(PetEntity pet) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pet.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem(Icons.pets, pet.breed),
                _buildDetailItem(Icons.cake, '${pet.age} yrs'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.green.shade700),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(color: Colors.grey.shade700)),
      ],
    );
  }
}
