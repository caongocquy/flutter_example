import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:oktoast/oktoast.dart';
import 'package:test_blocs/core/constants/ui_message_type.dart';
import 'package:uuid/uuid.dart';

part 'ui_message_event.dart';
part 'ui_message_state.dart';

@injectable
class UiMessageBloc extends Bloc<UiMessageEvent, UiMessageState> {
  UiMessageBloc() : super(const UiMessageInitial()) {
    on<ShowUiMessage>(_showUiMessage);
  }

  void _showUiMessage(ShowUiMessage event, Emitter<UiMessageState> emit) {
    final id = const Uuid().v4();
    emit(
      UiMessageShown(
        message: event.message,
        id: id,
        type: event.type,
        position: event.position,
        duration: event.duration,
        icon: event.icon,
        onDismiss: event.onDismiss,
      ),
    );
  }
}
