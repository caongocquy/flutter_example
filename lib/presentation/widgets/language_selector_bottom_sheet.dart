import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      final currentLocale = context.locale;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Text(
            'locale.select_title'.tr(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          _buildLangTile(
            context,
            'locale.nameEn',
            const Locale('en'),
            currentLocale,
          ),
          _buildLangTile(
            context,
            'locale.nameVi',
            const Locale('vi'),
            currentLocale,
          ),
          const SizedBox(height: 12),
        ],
      );
    },
  );
}

Widget _buildLangTile(
  BuildContext context,
  String label,
  Locale locale,
  Locale currentLocale,
) {
  final isSelected = locale == currentLocale;
  final flagUrl = locale.languageCode == 'vi'
      ? 'https://flagcdn.com/24x18/vn.png'
      : 'https://flagcdn.com/24x18/us.png';
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    leading: CachedNetworkImage(
      width: 24,
      height: 18,
      imageUrl: flagUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      fit: BoxFit.cover,
      cacheKey: flagUrl,
    ),
    title: Text(label.tr()),
    trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
    onTap: () {
      context.setLocale(locale);
      context.pop(); // Close the bottom sheet after selection
    },
  );
}
