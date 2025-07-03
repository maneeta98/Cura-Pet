class HomeState {
  final int selectedIndex;

  const HomeState({required this.selectedIndex});

  // Initial state with the first tab selected by default
  factory HomeState.initial() => const HomeState(selectedIndex: 0);

  HomeState copyWith({int? selectedIndex}) {
    return HomeState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}
