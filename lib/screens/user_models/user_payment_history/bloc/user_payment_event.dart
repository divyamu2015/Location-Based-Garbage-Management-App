part of 'user_payment_bloc.dart';

@freezed
class UserPaymentEvent with _$UserPaymentEvent {
  const factory UserPaymentEvent.started() = _Started;
  const factory UserPaymentEvent.userpayhistory(
    {
    required int id,
    required String paymentOption,
    required String status,
    required String totalPrice,
    required String cashStatus,
    required dynamic transactionId,
    required dynamic nameOfCard,
    required dynamic cardNumber,
    required dynamic expiryDate,
    required dynamic cvv,
    required int user,
    required int wasteSubmission,
    }
  ) = _Userpayhistory;
  
}