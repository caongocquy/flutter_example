import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/repositories/locale_repository.dart';

@injectable
class LoadLocale {
  final LocaleRepository repo;

  LoadLocale(this.repo);

  Future<Locale?> call() => repo.loadLocale();
}
