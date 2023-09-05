import 'package:core/packages/equatable/equatable.dart';
import 'package:core/packages/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'payment_web_view_event.dart';
part 'payment_web_view_state.dart';

class PaymentWebViewBloc
    extends Bloc<PaymentWebViewEvent, PaymentWebviewState> {
  PaymentWebViewBloc() : super(const PaymentWebviewState()) {
    _registerEventsHandler();
  }

  void _registerEventsHandler() {
    on<PaymentWebViewEvent>(
      (event, emitter) async {
        if (event is StartLoadingChanged) {
          _startLoadingChanged(emitter);
        }
        if (event is StopLoadingChanged) {
          _stopLoadingChanged(emitter);
        }
        if (event is CompleteWebViewChanged) {
          _completeWebViewChanged(emitter);
        }
      },
    );
  }

  Future<void> _startLoadingChanged(Emitter emitter) async {
    emitter(state.copyWith(
      isLoading: true,
    ));
  }

  Future<void> _stopLoadingChanged(Emitter emitter) async {
    emitter(state.copyWith(
      isLoading: false,
    ));
  }

  Future<void> _completeWebViewChanged(Emitter emitter) async {
    emitter(state.copyWith(
      isCompleted: true,
    ));
  }
}
