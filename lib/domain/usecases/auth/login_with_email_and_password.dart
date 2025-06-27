import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/repositories/auth_repository.dart';

@injectable
class LoginWithEmailAndPassword {
  final AuthRepository repository;

  LoginWithEmailAndPassword(this.repository);

  Future<Map<String, dynamic>> call({
    required String username,
    required String password,
  }) {
    return repository.login(username, password);
  }
}
