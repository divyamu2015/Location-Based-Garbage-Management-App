part of 'signin_bloc.dart';

@freezed
class SigninState with _$SigninState {
  const factory SigninState.initial() = _Initial;
  const factory SigninState.loading() = _loading;
  const factory SigninState.error({required String error}) = _Error;
  const factory SigninState.success({required UserRegisterModel response}) =
      _Success;

}
