import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:test_blocs/data/datasources/locale/locale_local_data_source.dart';
import 'package:test_blocs/domain/repositories/locale_repository.dart';

@LazySingleton(as: LocaleRepository)
class LocaleRepositoryImpl implements LocaleRepository {
  final LocaleLocalDataSource local;

  LocaleRepositoryImpl(this.local);

  @override
  Future<void> saveLocale(Locale locale) async {
    await local.saveLocale(locale.languageCode);
  }

  @override
  Future<Locale?> loadLocale() async {
    final code = await local.loadLocale();
    return code != null ? Locale(code) : null;
  }
}
