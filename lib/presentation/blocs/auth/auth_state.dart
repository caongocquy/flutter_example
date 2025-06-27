part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  final bool isLoading;
  final String? error;
  final String? accessToken;
  final Object? user;
  const AuthState({
    this.isLoading = false,
    this.error,
    this.accessToken,
    this.user,
  });

  @override
  List<Object?> get props => [isLoading, error, accessToken, user];

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? accessToken,
    Object? user,
  });
}

class AuthInitial extends AuthState {
  const AuthInitial({
    super.isLoading,
    super.error,
    super.accessToken,
    super.user,
  });

  @override
  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? accessToken,
    Object? user,
  }) {
    return AuthInitial(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({super.isLoading, super.error, super.accessToken});
  @override
  List<Object?> get props => [isLoading, error, accessToken];
  @override
  AuthAuthenticated copyWith({
    bool? isLoading,
    String? error,
    String? accessToken,
    Object? user,
    String? userName,
  }) {
    return AuthAuthenticated(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated({
    super.isLoading = false,
    super.error,
    super.accessToken,
    super.user,
  });
  @override
  List<Object?> get props => [isLoading, error, accessToken, user];

  @override
  AuthUnauthenticated copyWith({
    bool? isLoading,
    String? error,
    String? accessToken,
    Object? user,
  }) {
    return AuthUnauthenticated(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      accessToken: null,
      user: null,
    );
  }
}

class AuthProfile extends AuthState {
  const AuthProfile({
    super.isLoading = false,
    super.error,
    super.accessToken,
    super.user,
  });

  @override
  List<Object?> get props => [isLoading, error, accessToken, user];

  @override
  AuthProfile copyWith({
    bool? isLoading,
    String? error,
    String? accessToken,
    Object? user,
  }) {
    return AuthProfile(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      accessToken: accessToken ?? this.accessToken,
      user: user ?? this.user,
    );
  }
}
