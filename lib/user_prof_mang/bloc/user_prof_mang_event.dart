part of 'user_prof_mang_bloc.dart';

@freezed
class UserProfMangEvent with _$UserProfMangEvent {
  const factory UserProfMangEvent.started() = _Started;
  
  const factory UserProfMangEvent.userProMan({
    required String id,
    required String profilePicture,
    required String name,
    required String email,
    required String place,
    required String address,
    required String phone,
    required String utype,
    required String longitude,
    required String latitude,
    required String ward,
  }) = _UserProMan;
  
  const factory UserProfMangEvent.editUserProMan({
    required String id,
    required String profilePicture,
    required String name,
    required String email,
    required String place,
    required String address,
    required String phone,
    required String utype,
    required String longitude,
    required String latitude,
    required String ward,
  }) = _EditUserProMan;
}
