import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:test_blocs/presentation/blocs/ui_message/ui_message_bloc.dart';
import 'package:test_blocs/core/constants/ui_message_type.dart';

class UiMessageListener extends StatefulWidget {
  final Widget child;

  const UiMessageListener({super.key, required this.child});

  @override
  State<UiMessageListener> createState() => _UiMessageListenerState();
}

class _UiMessageListenerState extends State<UiMessageListener> {
  String? _lastMessageId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UiMessageBloc, UiMessageState>(
      listener: (context, state) {
        if (state is UiMessageShown && state.id != _lastMessageId) {
          _lastMessageId = state.id;
          _showTypedToast(
            msg: state.message.tr(),
            type: state.type,
            position: state.position,
            duration: state.duration,
            icon: state.icon,
            onDismiss: state.onDismiss,
          );
        }
      },
      child: widget.child,
    );
  }

  void _showTypedToast({
    required String msg,
    required UiMessageType type,
    required ToastPosition position,
    required Duration duration,
    IconData? icon,
    VoidCallback? onDismiss,
  }) {
    Color bgColor;
    IconData resolvedIcon;

    switch (type) {
      case UiMessageType.success:
        bgColor = Colors.green;
        resolvedIcon = Icons.check_circle;
        break;
      case UiMessageType.error:
        bgColor = Colors.red;
        resolvedIcon = Icons.error;
        break;
      case UiMessageType.info:
        bgColor = Colors.blueGrey;
        resolvedIcon = Icons.info;
        break;
      case UiMessageType.warning:
        bgColor = Colors.orange;
        resolvedIcon = Icons.warning_amber_rounded;
        break;
    }

    showToastWidget(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.95),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon ?? resolvedIcon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Flexible(
              child: Text(msg, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      position: position,
      duration: duration,
      onDismiss: onDismiss,
    );
  }
}
