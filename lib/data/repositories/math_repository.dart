import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/repositories/math_repository.dart';

@LazySingleton(as: MathRepository)
class MathRepositoryImpl implements MathRepository {
  @override
  int increment(int current) {
    return current + 1;
  }

  @override
  int decrement(int current) {
    return current - 1;
  }
}
