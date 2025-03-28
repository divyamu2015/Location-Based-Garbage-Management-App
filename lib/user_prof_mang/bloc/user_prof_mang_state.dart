part of 'user_prof_mang_bloc.dart';

@freezed
class UserProfMangState with _$UserProfMangState {
  const factory UserProfMangState.initial() = _Initial;
  const factory UserProfMangState.loading() = _Loading;
  const factory UserProfMangState.success({required UserProfManageModel response}) = _Success;
  const factory UserProfMangState.error({required String message}) = _Error;
  
  
  
}
