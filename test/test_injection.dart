import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'test_injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureTestInjection() async {
  getIt.init();
}
