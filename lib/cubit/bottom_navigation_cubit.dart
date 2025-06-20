import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(const BottomNavigationState(currentIndex: 0));

  void updateIndex(int index) {
    emit(BottomNavigationState(currentIndex: index));
  }
}
