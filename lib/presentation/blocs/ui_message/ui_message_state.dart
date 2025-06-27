part of 'ui_message_bloc.dart';

sealed class UiMessageState extends Equatable {
  const UiMessageState();

  @override
  List<Object?> get props => [];
}

class UiMessageInitial extends UiMessageState {
  const UiMessageInitial();
}

class UiMessageShown extends UiMessageState {
  final String message;
  final String id;
  final UiMessageType type;
  final ToastPosition position;
  final Duration duration;
  final IconData? icon;
  final VoidCallback? onDismiss;

  const UiMessageShown({
    required this.message,
    required this.id,
    required this.type,
    required this.position,
    required this.duration,
    this.icon,
    this.onDismiss,
  });

  @override
  List<Object?> get props => [message, id, type, position, duration];
}
