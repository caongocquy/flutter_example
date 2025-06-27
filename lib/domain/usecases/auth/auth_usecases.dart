import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/usecases/auth/get_valid_access_token.dart';
import 'package:test_blocs/domain/usecases/auth/login_with_email_and_password.dart';
import 'package:test_blocs/domain/usecases/auth/clear_tokens.dart';
import 'package:test_blocs/domain/usecases/auth/fetch_user.dart';
import 'package:test_blocs/domain/usecases/auth/save_tokens.dart';

@injectable
class AuthUseCases {
  final GetValidAccessToken getValidAccessToken;
  final LoginWithEmailAndPassword loginWithEmailAndPassword;
  final ClearTokens clearTokens;
  final FetchUser fetchUser;
  final SaveTokens saveTokens;

  const AuthUseCases({
    required this.getValidAccessToken,
    required this.loginWithEmailAndPassword,
    required this.clearTokens,
    required this.fetchUser,
    required this.saveTokens,
  });
}
