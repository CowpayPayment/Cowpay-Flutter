part of 'payment_webview_bloc.dart';

@immutable
class PaymentWebviewState extends Equatable {
  const PaymentWebviewState({
    this.isLoading = false,
    this.isCompleted = false,
  });

  final bool isLoading;
  final bool isCompleted;

  PaymentWebviewState copyWith({
    bool? isLoading,
    bool? isCompleted,
  }) {
    return PaymentWebviewState(
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [isLoading, isCompleted];
}
