class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const LoginState({
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage,
  });

  // Initial/default state
  factory LoginState.initial() {
    return const LoginState(
      isLoading: false,
      isSuccess: false,
      errorMessage: null,
    );
  }

  // Copy state with optional updates
  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
