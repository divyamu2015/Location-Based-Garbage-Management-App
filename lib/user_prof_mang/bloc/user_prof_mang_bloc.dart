import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../user_prof_mang_model/emplo_prof_model.dart';
import '../user_prof_mang_service/emplo_prof_cont.dart';

part 'user_prof_mang_event.dart';
part 'user_prof_mang_state.dart';
part 'user_prof_mang_bloc.freezed.dart';

class UserProfMangBloc extends Bloc<UserProfMangEvent, UserProfMangState> {
  UserProfMangBloc() : super(const UserProfMangState.initial()) {
    on<UserProfMangEvent>((event, emit) async {
      if (event is _UserProMan) {
        emit(const UserProfMangState.loading());

        try {
          final response = await userProMan(
              id: event.id,
              profilePicture: event.profilePicture,
              name: event.name,
              email: event.email,
              place: event.place,
              address: event.address,
              phone: event.phone,
              utype: event.utype,
              longitude: event.longitude,
              latitude: event.latitude,
              ward: event.ward);

          emit(UserProfMangState.success(response: response));
        } catch (e) {
          emit(UserProfMangState.error(message: e.toString()));
        }
      }
    });
  }
}
