part of 'user_payment_bloc.dart';

@freezed
class UserPaymentState with _$UserPaymentState {
  const factory UserPaymentState.initial() = _Initial;
  const factory UserPaymentState.loading() = _Loading;
  const factory UserPaymentState.success({required UserPymentHistoryModel response}) = _Success;
  const factory UserPaymentState.error({required String message}) = _Error;
  
  
  
}
