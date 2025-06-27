import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/entities/auth/user_entity.dart';
import 'package:test_blocs/domain/repositories/auth_repository.dart';

@injectable
class FetchUser {
  final AuthRepository repository;

  FetchUser(this.repository);

  Future<UserEntity> call() {
    return repository.fetchUser();
  }
}
