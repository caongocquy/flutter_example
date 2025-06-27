import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:test_blocs/core/constants/ui_message_type.dart';
import 'package:test_blocs/presentation/blocs/ui_message/ui_message_bloc.dart';

extension UiMessageContextExt on BuildContext {
  void showUiMessage(
    String message, {
    UiMessageType type = UiMessageType.error,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
    VoidCallback? onDismiss,
  }) {
    read<UiMessageBloc>().add(
      ShowUiMessage(
        message,
        type: type,
        position: position,
        duration: duration,
        icon: icon,
        onDismiss: onDismiss,
      ),
    );
  }
}
