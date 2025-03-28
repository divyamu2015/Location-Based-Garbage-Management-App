// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_payment_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserPaymentEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(
            int id,
            String paymentOption,
            String status,
            String totalPrice,
            String cashStatus,
            dynamic transactionId,
            dynamic nameOfCard,
            dynamic cardNumber,
            dynamic expiryDate,
            dynamic cvv,
            int user,
            int wasteSubmission)
        userpayhistory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(
            int id,
            String paymentOption,
            String status,
            String totalPrice,
            String cashStatus,
            dynamic transactionId,
            dynamic nameOfCard,
            dynamic cardNumber,
            dynamic expiryDate,
            dynamic cvv,
            int user,
            int wasteSubmission)?
        userpayhistory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(
            int id,
            String paymentOption,
            String status,
            String totalPrice,
            String cashStatus,
            dynamic transactionId,
            dynamic nameOfCard,
            dynamic cardNumber,
            dynamic expiryDate,
            dynamic cvv,
            int user,
            int wasteSubmission)?
        userpayhistory,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Userpayhistory value) userpayhistory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Userpayhistory value)? userpayhistory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Userpayhistory value)? userpayhistory,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPaymentEventCopyWith<$Res> {
  factory $UserPaymentEventCopyWith(
          UserPaymentEvent value, $Res Function(UserPaymentEvent) then) =
      _$UserPaymentEventCopyWithImpl<$Res, UserPaymentEvent>;
}

/// @nodoc
class _$UserPaymentEventCopyWithImpl<$Res, $Val extends UserPaymentEvent>
    implements $UserPaymentEventCopyWith<$Res> {
  _$UserPaymentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPaymentEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$UserPaymentEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPaymentEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'UserPaymentEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(
            int id,
            String paymentOption,
            String status,
            String totalPrice,
            String cashStatus,
            dynamic transactionId,
            dynamic nameOfCard,
            dynamic cardNumber,
            dynamic expiryDate,
            dynamic cvv,
            int user,
            int wasteSubmission)
        userpayhistory,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(
            int id,
            String paymentOption,
            String status,
            String totalPrice,
            String cashStatus,
            dynamic transactionId,
            dynamic nameOfCard,
            dynamic cardNumber,
            dynamic expiryDate,
            dynamic cvv,
            int user,
            int wasteSubmission)?
        userpayhistory,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(
            int id,
            String paymentOption,
            String status,
            String totalPrice,
            String cashStatus,
            dynamic transactionId,
            dynamic nameOfCard,
            dynamic cardNumber,
            dynamic expiryDate,
            dynamic cvv,
            int user,
            int wasteSubmission)?
        userpayhistory,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Userpayhistory value) userpayhistory,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Userpayhistory value)? userpayhistory,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Userpayhistory value)? userpayhistory,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements UserPaymentEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$UserpayhistoryImplCopyWith<$Res> {
  factory _$$UserpayhistoryImplCopyWith(_$UserpayhistoryImpl value,
          $Res Function(_$UserpayhistoryImpl) then) =
      __$$UserpayhistoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int id,
      String paymentOption,
      String status,
      String totalPrice,
      String cashStatus,
      dynamic transactionId,
      dynamic nameOfCard,
      dynamic cardNumber,
      dynamic expiryDate,
      dynamic cvv,
      int user,
      int wasteSubmission});
}

/// @nodoc
class __$$UserpayhistoryImplCopyWithImpl<$Res>
    extends _$UserPaymentEventCopyWithImpl<$Res, _$UserpayhistoryImpl>
    implements _$$UserpayhistoryImplCopyWith<$Res> {
  __$$UserpayhistoryImplCopyWithImpl(
      _$UserpayhistoryImpl _value, $Res Function(_$UserpayhistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? paymentOption = null,
    Object? status = null,
    Object? totalPrice = null,
    Object? cashStatus = null,
    Object? transactionId = freezed,
    Object? nameOfCard = freezed,
    Object? cardNumber = freezed,
    Object? expiryDate = freezed,
    Object? cvv = freezed,
    Object? user = null,
    Object? wasteSubmission = null,
  }) {
    return _then(_$UserpayhistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      paymentOption: null == paymentOption
          ? _value.paymentOption
          : paymentOption // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as String,
      cashStatus: null == cashStatus
          ? _value.cashStatus
          : cashStatus // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      nameOfCard: freezed == nameOfCard
          ? _value.nameOfCard
          : nameOfCard // ignore: cast_nullable_to_non_nullable
              as dynamic,
      cardNumber: freezed == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as dynamic,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      cvv: freezed == cvv
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as int,
      wasteSubmission: null == wasteSubmission
          ? _value.wasteSubmission
          : wasteSubmission // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UserpayhistoryImpl implements _Userpayhistory {
  const _$UserpayhistoryImpl(
      {required this.id,
      required this.paymentOption,
      required this.status,
      required this.totalPrice,
      required this.cashStatus,
      required this.transactionId,
      required this.nameOfCard,
      required this.cardNumber,
      required this.expiryDate,
      required this.cvv,
      required this.user,
      required this.wasteSubmission});

  @override
  final int id;
  @override
  final String paymentOption;
  @override
  final String status;
  @override
  final String totalPrice;
  @override
  final String cashStatus;
  @override
  final dynamic transactionId;
  @override
  final dynamic nameOfCard;
  @override
  final dynamic cardNumber;
  @override
  final dynamic expiryDate;
  @override
  final dynamic cvv;
  @override
  final int user;
  @override
  final int wasteSubmission;

  @override
  String toString() {
    return 'UserPaymentEvent.userpayhistory(id: $id, paymentOption: $paymentOption, status: $status, totalPrice: $totalPrice, cashStatus: $cashStatus, transactionId: $transactionId, nameOfCard: $nameOfCard, cardNumber: $cardNumber, expiryDate: $expiryDate, cvv: $cvv, user: $user, wasteSubmission: $wasteSubmission)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserpayhistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.paymentOption, paymentOption) ||
                other.paymentOption == paymentOption) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.cashStatus, cashStatus) ||
                other.cashStatus == cashStatus) &&
            const DeepCollectionEquality()
                .equals(other.transactionId, transactionId) &&
            const DeepCollectionEquality()
                .equals(other.nameOfCard, nameOfCard) &&
            const DeepCollectionEquality()
                .equals(other.cardNumber, cardNumber) &&
            const DeepCollectionEquality()
                .equals(other.expiryDate, expiryDate) &&
            const DeepCollectionEquality().equals(other.cvv, cvv) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.wasteSubmission, wasteSubmission) ||
                other.wasteSubmission == wasteSubmission));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      paymentOption,
      status,
      totalPrice,
      cashStatus,
      const DeepCollectionEquality().hash(transactionId),
      const DeepCollectionEquality().hash(nameOfCard),
      const DeepCollectionEquality().hash(cardNumber),
      const DeepCollectionEquality().hash(expiryDate),
      const DeepCollectionEquality().hash(cvv),
      user,
      wasteSubmission);

  /// Create a copy of UserPaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserpayhistoryImplCopyWith<_$UserpayhistoryImpl> get copyWith =>
      __$$UserpayhistoryImplCopyWithImpl<_$UserpayhistoryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(
            int id,
            String paymentOption,
            String status,
            String totalPrice,
            String cashStatus,
            dynamic transactionId,
            dynamic nameOfCard,
            dynamic cardNumber,
            dynamic expiryDate,
            dynamic cvv,
            int user,
            int wasteSubmission)
        userpayhistory,
  }) {
    return userpayhistory(
        id,
        paymentOption,
        status,
        totalPrice,
        cashStatus,
        transactionId,
        nameOfCard,
        cardNumber,
        expiryDate,
        cvv,
        user,
        wasteSubmission);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(
            int id,
            String paymentOption,
            String status,
            String totalPrice,
            String cashStatus,
            dynamic transactionId,
            dynamic nameOfCard,
            dynamic cardNumber,
            dynamic expiryDate,
            dynamic cvv,
            int user,
            int wasteSubmission)?
        userpayhistory,
  }) {
    return userpayhistory?.call(
        id,
        paymentOption,
        status,
        totalPrice,
        cashStatus,
        transactionId,
        nameOfCard,
        cardNumber,
        expiryDate,
        cvv,
        user,
        wasteSubmission);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(
            int id,
            String paymentOption,
            String status,
            String totalPrice,
            String cashStatus,
            dynamic transactionId,
            dynamic nameOfCard,
            dynamic cardNumber,
            dynamic expiryDate,
            dynamic cvv,
            int user,
            int wasteSubmission)?
        userpayhistory,
    required TResult orElse(),
  }) {
    if (userpayhistory != null) {
      return userpayhistory(
          id,
          paymentOption,
          status,
          totalPrice,
          cashStatus,
          transactionId,
          nameOfCard,
          cardNumber,
          expiryDate,
          cvv,
          user,
          wasteSubmission);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Userpayhistory value) userpayhistory,
  }) {
    return userpayhistory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Userpayhistory value)? userpayhistory,
  }) {
    return userpayhistory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Userpayhistory value)? userpayhistory,
    required TResult orElse(),
  }) {
    if (userpayhistory != null) {
      return userpayhistory(this);
    }
    return orElse();
  }
}

abstract class _Userpayhistory implements UserPaymentEvent {
  const factory _Userpayhistory(
      {required final int id,
      required final String paymentOption,
      required final String status,
      required final String totalPrice,
      required final String cashStatus,
      required final dynamic transactionId,
      required final dynamic nameOfCard,
      required final dynamic cardNumber,
      required final dynamic expiryDate,
      required final dynamic cvv,
      required final int user,
      required final int wasteSubmission}) = _$UserpayhistoryImpl;

  int get id;
  String get paymentOption;
  String get status;
  String get totalPrice;
  String get cashStatus;
  dynamic get transactionId;
  dynamic get nameOfCard;
  dynamic get cardNumber;
  dynamic get expiryDate;
  dynamic get cvv;
  int get user;
  int get wasteSubmission;

  /// Create a copy of UserPaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserpayhistoryImplCopyWith<_$UserpayhistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserPaymentState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserPymentHistoryModel response) success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserPymentHistoryModel response)? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserPymentHistoryModel response)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPaymentStateCopyWith<$Res> {
  factory $UserPaymentStateCopyWith(
          UserPaymentState value, $Res Function(UserPaymentState) then) =
      _$UserPaymentStateCopyWithImpl<$Res, UserPaymentState>;
}

/// @nodoc
class _$UserPaymentStateCopyWithImpl<$Res, $Val extends UserPaymentState>
    implements $UserPaymentStateCopyWith<$Res> {
  _$UserPaymentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPaymentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$UserPaymentStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPaymentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'UserPaymentState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserPymentHistoryModel response) success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserPymentHistoryModel response)? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserPymentHistoryModel response)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements UserPaymentState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$UserPaymentStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPaymentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'UserPaymentState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserPymentHistoryModel response) success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserPymentHistoryModel response)? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserPymentHistoryModel response)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements UserPaymentState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserPymentHistoryModel response});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$UserPaymentStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$SuccessImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as UserPymentHistoryModel,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl({required this.response});

  @override
  final UserPymentHistoryModel response;

  @override
  String toString() {
    return 'UserPaymentState.success(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  /// Create a copy of UserPaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserPymentHistoryModel response) success,
    required TResult Function(String message) error,
  }) {
    return success(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserPymentHistoryModel response)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserPymentHistoryModel response)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements UserPaymentState {
  const factory _Success({required final UserPymentHistoryModel response}) =
      _$SuccessImpl;

  UserPymentHistoryModel get response;

  /// Create a copy of UserPaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$UserPaymentStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'UserPaymentState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of UserPaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserPymentHistoryModel response) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserPymentHistoryModel response)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserPymentHistoryModel response)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements UserPaymentState {
  const factory _Error({required final String message}) = _$ErrorImpl;

  String get message;

  /// Create a copy of UserPaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
