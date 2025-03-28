import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/signin_model.dart';
import '../services/signin_services.dart';

part 'signin_event.dart';
part 'signin_state.dart';
part 'signin_bloc.freezed.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(const _Initial()) {
    on<SigninEvent>((event, emit) async {
      if (event is _UserRegister) {
        emit(const SigninState.loading());
        try {
          final response = await userRegister(
            name: event.name,
            email: event.email,
            pswd: event.pswd, // Ensure it matches API
            place: event.place,
            address: event.address,
            phone: event.phone,
            ward: event.ward,
            longitude: event.longitude,
            latitude: event.latitude,
          );
          emit(SigninState.success(response: response));
        } catch (e) {
          emit(SigninState.error(error: e.toString()));
        }
      }
    });
  }
}
