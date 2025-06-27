import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'locale_local_data_source.dart';

@LazySingleton(as: LocaleLocalDataSource)
class SharedPrefsLocaleDataSource implements LocaleLocalDataSource {
  static const _localeKey = 'locale_code';

  @override
  Future<void> saveLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, code);
  }

  @override
  Future<String?> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeKey);
  }
}
