part of 'signin_bloc.dart';

@freezed
class SigninEvent with _$SigninEvent {
  const factory SigninEvent.started() = _Started;
  const factory SigninEvent.userRegister({
 required String name,
    required String email,
    required String pswd,
    required String place,
    required String address,
    required String phone,
    required String ward,
    required double longitude,
    required double latitude,

  }) = _UserRegister;
  
}