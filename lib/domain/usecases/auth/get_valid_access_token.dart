import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/repositories/auth_repository.dart';

@injectable
class GetValidAccessToken {
  final AuthRepository repository;

  GetValidAccessToken(this.repository);

  Future<String?> call() {
    return repository.getValidAccessToken();
  }
}
