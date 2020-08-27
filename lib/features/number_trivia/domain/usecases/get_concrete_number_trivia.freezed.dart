// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'get_concrete_number_trivia.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$ParamsTearOff {
  const _$ParamsTearOff();

// ignore: unused_element
  _Params call(int number) {
    return _Params(
      number,
    );
  }
}

// ignore: unused_element
const $Params = _$ParamsTearOff();

mixin _$Params {
  int get number;

  $ParamsCopyWith<Params> get copyWith;
}

abstract class $ParamsCopyWith<$Res> {
  factory $ParamsCopyWith(Params value, $Res Function(Params) then) =
      _$ParamsCopyWithImpl<$Res>;
  $Res call({int number});
}

class _$ParamsCopyWithImpl<$Res> implements $ParamsCopyWith<$Res> {
  _$ParamsCopyWithImpl(this._value, this._then);

  final Params _value;
  // ignore: unused_field
  final $Res Function(Params) _then;

  @override
  $Res call({
    Object number = freezed,
  }) {
    return _then(_value.copyWith(
      number: number == freezed ? _value.number : number as int,
    ));
  }
}

abstract class _$ParamsCopyWith<$Res> implements $ParamsCopyWith<$Res> {
  factory _$ParamsCopyWith(_Params value, $Res Function(_Params) then) =
      __$ParamsCopyWithImpl<$Res>;
  @override
  $Res call({int number});
}

class __$ParamsCopyWithImpl<$Res> extends _$ParamsCopyWithImpl<$Res>
    implements _$ParamsCopyWith<$Res> {
  __$ParamsCopyWithImpl(_Params _value, $Res Function(_Params) _then)
      : super(_value, (v) => _then(v as _Params));

  @override
  _Params get _value => super._value as _Params;

  @override
  $Res call({
    Object number = freezed,
  }) {
    return _then(_Params(
      number == freezed ? _value.number : number as int,
    ));
  }
}

class _$_Params implements _Params {
  const _$_Params(this.number) : assert(number != null);

  @override
  final int number;

  @override
  String toString() {
    return 'Params(number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Params &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(number);

  @override
  _$ParamsCopyWith<_Params> get copyWith =>
      __$ParamsCopyWithImpl<_Params>(this, _$identity);
}

abstract class _Params implements Params {
  const factory _Params(int number) = _$_Params;

  @override
  int get number;
  @override
  _$ParamsCopyWith<_Params> get copyWith;
}
