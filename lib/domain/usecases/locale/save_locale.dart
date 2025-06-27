import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/repositories/locale_repository.dart';

@injectable
class SaveLocale {
  final LocaleRepository repo;

  SaveLocale(this.repo);

  Future<void> call(Locale locale) => repo.saveLocale(locale);
}
