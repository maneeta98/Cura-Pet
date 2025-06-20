import 'package:equatable/equatable.dart';

class BottomNavigationState extends Equatable {
  final int currentIndex;

  const BottomNavigationState({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}
