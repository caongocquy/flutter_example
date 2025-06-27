import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_blocs/presentation/blocs/ui_message/ui_message_bloc.dart';
import 'package:test_blocs/core/constants/ui_message_type.dart';
import 'package:test_blocs/domain/entities/auth/user_entity.dart';
import 'package:test_blocs/domain/usecases/auth/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UiMessageBloc uiMessageBloc;
  final AuthUseCases authUseCases;

  AuthBloc({required this.uiMessageBloc, required this.authUseCases})
    : super(const AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthLoggedIn>(_onLoggedIn);
    on<AuthLoggedOut>(_onLoggedOut);
    on<AuthGetUser>(_onGetUser);
  }

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));

    final accessToken = await authUseCases.getValidAccessToken();

    if (accessToken != null) {
      emit(AuthAuthenticated(accessToken: accessToken));
      add(AuthGetUser());
    } else {
      await authUseCases.clearTokens();
      emit(const AuthUnauthenticated());
      uiMessageBloc.add(
        ShowUiMessage(
          'Vui lòng đăng nhập để tiếp tục',
          type: UiMessageType.warning,
        ),
      );
    }
  }

  Future<void> _onLoggedIn(AuthLoggedIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final response = await authUseCases.loginWithEmailAndPassword(
        username: event.userName,
        password: event.passWord,
      );

      final accessToken = response['accessToken'];
      final refreshToken = response['refreshToken'];

      if (accessToken != null && refreshToken != null) {
        await authUseCases.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
        emit(AuthAuthenticated(accessToken: accessToken));
        add(AuthGetUser());
      } else {
        emit(const AuthUnauthenticated());
        uiMessageBloc.add(
          ShowUiMessage(
            response['message'] ?? 'Sai tên đăng nhập hoặc mật khẩu',
          ),
        );
      }
    } catch (e) {
      emit(AuthUnauthenticated(error: e.toString()));
      uiMessageBloc.add(ShowUiMessage(e.toString()));
    }
  }

  Future<void> _onLoggedOut(
    AuthLoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    await authUseCases.clearTokens();
    emit(const AuthUnauthenticated());
    uiMessageBloc.add(
      ShowUiMessage('Đăng xuất thành công', type: UiMessageType.success),
    );
  }

  Future<void> _onGetUser(AuthGetUser event, Emitter<AuthState> emit) async {
    try {
      final UserEntity user = await authUseCases.fetchUser();
      emit(AuthProfile(user: user));
    } catch (e) {
      emit(AuthUnauthenticated());
      uiMessageBloc.add(ShowUiMessage(e.toString(), type: UiMessageType.error));
    }
  }
}
