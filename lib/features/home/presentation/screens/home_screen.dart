// lib/screens/home_screen.dart

import 'package:cura_pet/features/home/presentation/bloc/home_cubit.dart';
import 'package:cura_pet/features/home/presentation/bloc/home_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..loadHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is HomeLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("CuraPet Home"),
                backgroundColor: Colors.green,
              ),
              body: Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            );
          } else if (state is HomeError) {
            return Scaffold(
              body: Center(child: Text("Error: ${state.message}")),
            );
          }

          return const Scaffold(body: Center(child: Text("Initializing...")));
        },
      ),
    );
  }
}
