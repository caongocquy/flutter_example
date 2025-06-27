import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/repositories/auth_repository.dart';

@injectable
class ClearTokens {
  final AuthRepository repository;

  ClearTokens(this.repository);

  Future<void> call() {
    return repository.clearTokens();
  }
}
