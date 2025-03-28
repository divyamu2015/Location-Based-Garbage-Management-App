import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suchithvam_app/screens/user_models/user_payment_history/user_payment_control/user_paymenr_control.dart';

import '../user_payment_model/user_payment_model.dart';

part 'user_payment_event.dart';
part 'user_payment_state.dart';
part 'user_payment_bloc.freezed.dart';

class UserPaymentBloc extends Bloc<UserPaymentEvent, UserPaymentState> {
  UserPaymentBloc() : super(const _Initial()) {
    on<UserPaymentEvent>((event, emit) async {
      if (event is _Userpayhistory) {
        emit(const UserPaymentState.loading());

        try {
          final response = await userpayhistory(
              id: event.id,
              paymentOption: event.paymentOption,
              status: event.status,
              totalPrice: event.totalPrice,
              cashStatus: event.cashStatus,
              transactionId: event.transactionId,
              nameOfCard: event.nameOfCard,
              cardNumber: event.cardNumber,
              expiryDate: event.expiryDate,
              cvv: event.cvv,
              user: event.user,
              wasteSubmission: event.wasteSubmission);
          emit(UserPaymentState.success(response: response));
        } catch (e) {
          emit(UserPaymentState.error(message: e.toString()));
        }
      }
    });
  }
}
