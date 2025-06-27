part of 'ui_message_bloc.dart';

sealed class UiMessageEvent extends Equatable {
  const UiMessageEvent();

  @override
  List<Object> get props => [];
}

class ShowUiMessage extends UiMessageEvent {
  final String message;
  final UiMessageType type;
  final ToastPosition position;
  final Duration duration;
  final IconData? icon;
  final VoidCallback? onDismiss;

  const ShowUiMessage(
    this.message, {
    this.type = UiMessageType.error,
    this.position = ToastPosition.bottom,
    this.duration = const Duration(seconds: 3),
    this.icon,
    this.onDismiss,
  });
}
