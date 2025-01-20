// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'itinerary_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ItineraryEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name, List<Place> places) createTrip,
    required TResult Function(int id) deleteTrip,
    required TResult Function(Trip trip) updateTrip,
    required TResult Function(int tripId, int oldIndex, int newIndex)
        reorderPlaces,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String name, List<Place> places)? createTrip,
    TResult? Function(int id)? deleteTrip,
    TResult? Function(Trip trip)? updateTrip,
    TResult? Function(int tripId, int oldIndex, int newIndex)? reorderPlaces,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name, List<Place> places)? createTrip,
    TResult Function(int id)? deleteTrip,
    TResult Function(Trip trip)? updateTrip,
    TResult Function(int tripId, int oldIndex, int newIndex)? reorderPlaces,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CreateTrip value) createTrip,
    required TResult Function(_DeleteTrip value) deleteTrip,
    required TResult Function(_UpdateTrip value) updateTrip,
    required TResult Function(_ReorderPlaces value) reorderPlaces,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CreateTrip value)? createTrip,
    TResult? Function(_DeleteTrip value)? deleteTrip,
    TResult? Function(_UpdateTrip value)? updateTrip,
    TResult? Function(_ReorderPlaces value)? reorderPlaces,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CreateTrip value)? createTrip,
    TResult Function(_DeleteTrip value)? deleteTrip,
    TResult Function(_UpdateTrip value)? updateTrip,
    TResult Function(_ReorderPlaces value)? reorderPlaces,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItineraryEventCopyWith<$Res> {
  factory $ItineraryEventCopyWith(
          ItineraryEvent value, $Res Function(ItineraryEvent) then) =
      _$ItineraryEventCopyWithImpl<$Res, ItineraryEvent>;
}

/// @nodoc
class _$ItineraryEventCopyWithImpl<$Res, $Val extends ItineraryEvent>
    implements $ItineraryEventCopyWith<$Res> {
  _$ItineraryEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItineraryEvent
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
    extends _$ItineraryEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'ItineraryEvent.started()';
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
    required TResult Function(String name, List<Place> places) createTrip,
    required TResult Function(int id) deleteTrip,
    required TResult Function(Trip trip) updateTrip,
    required TResult Function(int tripId, int oldIndex, int newIndex)
        reorderPlaces,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String name, List<Place> places)? createTrip,
    TResult? Function(int id)? deleteTrip,
    TResult? Function(Trip trip)? updateTrip,
    TResult? Function(int tripId, int oldIndex, int newIndex)? reorderPlaces,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name, List<Place> places)? createTrip,
    TResult Function(int id)? deleteTrip,
    TResult Function(Trip trip)? updateTrip,
    TResult Function(int tripId, int oldIndex, int newIndex)? reorderPlaces,
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
    required TResult Function(_CreateTrip value) createTrip,
    required TResult Function(_DeleteTrip value) deleteTrip,
    required TResult Function(_UpdateTrip value) updateTrip,
    required TResult Function(_ReorderPlaces value) reorderPlaces,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CreateTrip value)? createTrip,
    TResult? Function(_DeleteTrip value)? deleteTrip,
    TResult? Function(_UpdateTrip value)? updateTrip,
    TResult? Function(_ReorderPlaces value)? reorderPlaces,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CreateTrip value)? createTrip,
    TResult Function(_DeleteTrip value)? deleteTrip,
    TResult Function(_UpdateTrip value)? updateTrip,
    TResult Function(_ReorderPlaces value)? reorderPlaces,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements ItineraryEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$CreateTripImplCopyWith<$Res> {
  factory _$$CreateTripImplCopyWith(
          _$CreateTripImpl value, $Res Function(_$CreateTripImpl) then) =
      __$$CreateTripImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, List<Place> places});
}

/// @nodoc
class __$$CreateTripImplCopyWithImpl<$Res>
    extends _$ItineraryEventCopyWithImpl<$Res, _$CreateTripImpl>
    implements _$$CreateTripImplCopyWith<$Res> {
  __$$CreateTripImplCopyWithImpl(
      _$CreateTripImpl _value, $Res Function(_$CreateTripImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? places = null,
  }) {
    return _then(_$CreateTripImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == places
          ? _value._places
          : places // ignore: cast_nullable_to_non_nullable
              as List<Place>,
    ));
  }
}

/// @nodoc

class _$CreateTripImpl implements _CreateTrip {
  const _$CreateTripImpl(this.name, final List<Place> places)
      : _places = places;

  @override
  final String name;
  final List<Place> _places;
  @override
  List<Place> get places {
    if (_places is EqualUnmodifiableListView) return _places;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_places);
  }

  @override
  String toString() {
    return 'ItineraryEvent.createTrip(name: $name, places: $places)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTripImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._places, _places));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_places));

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTripImplCopyWith<_$CreateTripImpl> get copyWith =>
      __$$CreateTripImplCopyWithImpl<_$CreateTripImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name, List<Place> places) createTrip,
    required TResult Function(int id) deleteTrip,
    required TResult Function(Trip trip) updateTrip,
    required TResult Function(int tripId, int oldIndex, int newIndex)
        reorderPlaces,
  }) {
    return createTrip(name, places);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String name, List<Place> places)? createTrip,
    TResult? Function(int id)? deleteTrip,
    TResult? Function(Trip trip)? updateTrip,
    TResult? Function(int tripId, int oldIndex, int newIndex)? reorderPlaces,
  }) {
    return createTrip?.call(name, places);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name, List<Place> places)? createTrip,
    TResult Function(int id)? deleteTrip,
    TResult Function(Trip trip)? updateTrip,
    TResult Function(int tripId, int oldIndex, int newIndex)? reorderPlaces,
    required TResult orElse(),
  }) {
    if (createTrip != null) {
      return createTrip(name, places);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CreateTrip value) createTrip,
    required TResult Function(_DeleteTrip value) deleteTrip,
    required TResult Function(_UpdateTrip value) updateTrip,
    required TResult Function(_ReorderPlaces value) reorderPlaces,
  }) {
    return createTrip(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CreateTrip value)? createTrip,
    TResult? Function(_DeleteTrip value)? deleteTrip,
    TResult? Function(_UpdateTrip value)? updateTrip,
    TResult? Function(_ReorderPlaces value)? reorderPlaces,
  }) {
    return createTrip?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CreateTrip value)? createTrip,
    TResult Function(_DeleteTrip value)? deleteTrip,
    TResult Function(_UpdateTrip value)? updateTrip,
    TResult Function(_ReorderPlaces value)? reorderPlaces,
    required TResult orElse(),
  }) {
    if (createTrip != null) {
      return createTrip(this);
    }
    return orElse();
  }
}

abstract class _CreateTrip implements ItineraryEvent {
  const factory _CreateTrip(final String name, final List<Place> places) =
      _$CreateTripImpl;

  String get name;
  List<Place> get places;

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateTripImplCopyWith<_$CreateTripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteTripImplCopyWith<$Res> {
  factory _$$DeleteTripImplCopyWith(
          _$DeleteTripImpl value, $Res Function(_$DeleteTripImpl) then) =
      __$$DeleteTripImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$DeleteTripImplCopyWithImpl<$Res>
    extends _$ItineraryEventCopyWithImpl<$Res, _$DeleteTripImpl>
    implements _$$DeleteTripImplCopyWith<$Res> {
  __$$DeleteTripImplCopyWithImpl(
      _$DeleteTripImpl _value, $Res Function(_$DeleteTripImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$DeleteTripImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DeleteTripImpl implements _DeleteTrip {
  const _$DeleteTripImpl(this.id);

  @override
  final int id;

  @override
  String toString() {
    return 'ItineraryEvent.deleteTrip(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteTripImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteTripImplCopyWith<_$DeleteTripImpl> get copyWith =>
      __$$DeleteTripImplCopyWithImpl<_$DeleteTripImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name, List<Place> places) createTrip,
    required TResult Function(int id) deleteTrip,
    required TResult Function(Trip trip) updateTrip,
    required TResult Function(int tripId, int oldIndex, int newIndex)
        reorderPlaces,
  }) {
    return deleteTrip(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String name, List<Place> places)? createTrip,
    TResult? Function(int id)? deleteTrip,
    TResult? Function(Trip trip)? updateTrip,
    TResult? Function(int tripId, int oldIndex, int newIndex)? reorderPlaces,
  }) {
    return deleteTrip?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name, List<Place> places)? createTrip,
    TResult Function(int id)? deleteTrip,
    TResult Function(Trip trip)? updateTrip,
    TResult Function(int tripId, int oldIndex, int newIndex)? reorderPlaces,
    required TResult orElse(),
  }) {
    if (deleteTrip != null) {
      return deleteTrip(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CreateTrip value) createTrip,
    required TResult Function(_DeleteTrip value) deleteTrip,
    required TResult Function(_UpdateTrip value) updateTrip,
    required TResult Function(_ReorderPlaces value) reorderPlaces,
  }) {
    return deleteTrip(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CreateTrip value)? createTrip,
    TResult? Function(_DeleteTrip value)? deleteTrip,
    TResult? Function(_UpdateTrip value)? updateTrip,
    TResult? Function(_ReorderPlaces value)? reorderPlaces,
  }) {
    return deleteTrip?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CreateTrip value)? createTrip,
    TResult Function(_DeleteTrip value)? deleteTrip,
    TResult Function(_UpdateTrip value)? updateTrip,
    TResult Function(_ReorderPlaces value)? reorderPlaces,
    required TResult orElse(),
  }) {
    if (deleteTrip != null) {
      return deleteTrip(this);
    }
    return orElse();
  }
}

abstract class _DeleteTrip implements ItineraryEvent {
  const factory _DeleteTrip(final int id) = _$DeleteTripImpl;

  int get id;

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteTripImplCopyWith<_$DeleteTripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTripImplCopyWith<$Res> {
  factory _$$UpdateTripImplCopyWith(
          _$UpdateTripImpl value, $Res Function(_$UpdateTripImpl) then) =
      __$$UpdateTripImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Trip trip});

  $TripCopyWith<$Res> get trip;
}

/// @nodoc
class __$$UpdateTripImplCopyWithImpl<$Res>
    extends _$ItineraryEventCopyWithImpl<$Res, _$UpdateTripImpl>
    implements _$$UpdateTripImplCopyWith<$Res> {
  __$$UpdateTripImplCopyWithImpl(
      _$UpdateTripImpl _value, $Res Function(_$UpdateTripImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trip = null,
  }) {
    return _then(_$UpdateTripImpl(
      null == trip
          ? _value.trip
          : trip // ignore: cast_nullable_to_non_nullable
              as Trip,
    ));
  }

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TripCopyWith<$Res> get trip {
    return $TripCopyWith<$Res>(_value.trip, (value) {
      return _then(_value.copyWith(trip: value));
    });
  }
}

/// @nodoc

class _$UpdateTripImpl implements _UpdateTrip {
  const _$UpdateTripImpl(this.trip);

  @override
  final Trip trip;

  @override
  String toString() {
    return 'ItineraryEvent.updateTrip(trip: $trip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTripImpl &&
            (identical(other.trip, trip) || other.trip == trip));
  }

  @override
  int get hashCode => Object.hash(runtimeType, trip);

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTripImplCopyWith<_$UpdateTripImpl> get copyWith =>
      __$$UpdateTripImplCopyWithImpl<_$UpdateTripImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name, List<Place> places) createTrip,
    required TResult Function(int id) deleteTrip,
    required TResult Function(Trip trip) updateTrip,
    required TResult Function(int tripId, int oldIndex, int newIndex)
        reorderPlaces,
  }) {
    return updateTrip(trip);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String name, List<Place> places)? createTrip,
    TResult? Function(int id)? deleteTrip,
    TResult? Function(Trip trip)? updateTrip,
    TResult? Function(int tripId, int oldIndex, int newIndex)? reorderPlaces,
  }) {
    return updateTrip?.call(trip);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name, List<Place> places)? createTrip,
    TResult Function(int id)? deleteTrip,
    TResult Function(Trip trip)? updateTrip,
    TResult Function(int tripId, int oldIndex, int newIndex)? reorderPlaces,
    required TResult orElse(),
  }) {
    if (updateTrip != null) {
      return updateTrip(trip);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CreateTrip value) createTrip,
    required TResult Function(_DeleteTrip value) deleteTrip,
    required TResult Function(_UpdateTrip value) updateTrip,
    required TResult Function(_ReorderPlaces value) reorderPlaces,
  }) {
    return updateTrip(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CreateTrip value)? createTrip,
    TResult? Function(_DeleteTrip value)? deleteTrip,
    TResult? Function(_UpdateTrip value)? updateTrip,
    TResult? Function(_ReorderPlaces value)? reorderPlaces,
  }) {
    return updateTrip?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CreateTrip value)? createTrip,
    TResult Function(_DeleteTrip value)? deleteTrip,
    TResult Function(_UpdateTrip value)? updateTrip,
    TResult Function(_ReorderPlaces value)? reorderPlaces,
    required TResult orElse(),
  }) {
    if (updateTrip != null) {
      return updateTrip(this);
    }
    return orElse();
  }
}

abstract class _UpdateTrip implements ItineraryEvent {
  const factory _UpdateTrip(final Trip trip) = _$UpdateTripImpl;

  Trip get trip;

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTripImplCopyWith<_$UpdateTripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReorderPlacesImplCopyWith<$Res> {
  factory _$$ReorderPlacesImplCopyWith(
          _$ReorderPlacesImpl value, $Res Function(_$ReorderPlacesImpl) then) =
      __$$ReorderPlacesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int tripId, int oldIndex, int newIndex});
}

/// @nodoc
class __$$ReorderPlacesImplCopyWithImpl<$Res>
    extends _$ItineraryEventCopyWithImpl<$Res, _$ReorderPlacesImpl>
    implements _$$ReorderPlacesImplCopyWith<$Res> {
  __$$ReorderPlacesImplCopyWithImpl(
      _$ReorderPlacesImpl _value, $Res Function(_$ReorderPlacesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? oldIndex = null,
    Object? newIndex = null,
  }) {
    return _then(_$ReorderPlacesImpl(
      null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int,
      null == oldIndex
          ? _value.oldIndex
          : oldIndex // ignore: cast_nullable_to_non_nullable
              as int,
      null == newIndex
          ? _value.newIndex
          : newIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ReorderPlacesImpl implements _ReorderPlaces {
  const _$ReorderPlacesImpl(this.tripId, this.oldIndex, this.newIndex);

  @override
  final int tripId;
  @override
  final int oldIndex;
  @override
  final int newIndex;

  @override
  String toString() {
    return 'ItineraryEvent.reorderPlaces(tripId: $tripId, oldIndex: $oldIndex, newIndex: $newIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReorderPlacesImpl &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.oldIndex, oldIndex) ||
                other.oldIndex == oldIndex) &&
            (identical(other.newIndex, newIndex) ||
                other.newIndex == newIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tripId, oldIndex, newIndex);

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReorderPlacesImplCopyWith<_$ReorderPlacesImpl> get copyWith =>
      __$$ReorderPlacesImplCopyWithImpl<_$ReorderPlacesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name, List<Place> places) createTrip,
    required TResult Function(int id) deleteTrip,
    required TResult Function(Trip trip) updateTrip,
    required TResult Function(int tripId, int oldIndex, int newIndex)
        reorderPlaces,
  }) {
    return reorderPlaces(tripId, oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String name, List<Place> places)? createTrip,
    TResult? Function(int id)? deleteTrip,
    TResult? Function(Trip trip)? updateTrip,
    TResult? Function(int tripId, int oldIndex, int newIndex)? reorderPlaces,
  }) {
    return reorderPlaces?.call(tripId, oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name, List<Place> places)? createTrip,
    TResult Function(int id)? deleteTrip,
    TResult Function(Trip trip)? updateTrip,
    TResult Function(int tripId, int oldIndex, int newIndex)? reorderPlaces,
    required TResult orElse(),
  }) {
    if (reorderPlaces != null) {
      return reorderPlaces(tripId, oldIndex, newIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_CreateTrip value) createTrip,
    required TResult Function(_DeleteTrip value) deleteTrip,
    required TResult Function(_UpdateTrip value) updateTrip,
    required TResult Function(_ReorderPlaces value) reorderPlaces,
  }) {
    return reorderPlaces(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_CreateTrip value)? createTrip,
    TResult? Function(_DeleteTrip value)? deleteTrip,
    TResult? Function(_UpdateTrip value)? updateTrip,
    TResult? Function(_ReorderPlaces value)? reorderPlaces,
  }) {
    return reorderPlaces?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_CreateTrip value)? createTrip,
    TResult Function(_DeleteTrip value)? deleteTrip,
    TResult Function(_UpdateTrip value)? updateTrip,
    TResult Function(_ReorderPlaces value)? reorderPlaces,
    required TResult orElse(),
  }) {
    if (reorderPlaces != null) {
      return reorderPlaces(this);
    }
    return orElse();
  }
}

abstract class _ReorderPlaces implements ItineraryEvent {
  const factory _ReorderPlaces(
          final int tripId, final int oldIndex, final int newIndex) =
      _$ReorderPlacesImpl;

  int get tripId;
  int get oldIndex;
  int get newIndex;

  /// Create a copy of ItineraryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReorderPlacesImplCopyWith<_$ReorderPlacesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ItineraryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Trip> trips) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Trip> trips)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Trip> trips)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItineraryStateCopyWith<$Res> {
  factory $ItineraryStateCopyWith(
          ItineraryState value, $Res Function(ItineraryState) then) =
      _$ItineraryStateCopyWithImpl<$Res, ItineraryState>;
}

/// @nodoc
class _$ItineraryStateCopyWithImpl<$Res, $Val extends ItineraryState>
    implements $ItineraryStateCopyWith<$Res> {
  _$ItineraryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItineraryState
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
    extends _$ItineraryStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItineraryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ItineraryState.initial()';
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
    required TResult Function(List<Trip> trips) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Trip> trips)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Trip> trips)? loaded,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ItineraryState {
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
    extends _$ItineraryStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItineraryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ItineraryState.loading()';
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
    required TResult Function(List<Trip> trips) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Trip> trips)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Trip> trips)? loaded,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ItineraryState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Trip> trips});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ItineraryStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItineraryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trips = null,
  }) {
    return _then(_$LoadedImpl(
      null == trips
          ? _value._trips
          : trips // ignore: cast_nullable_to_non_nullable
              as List<Trip>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(final List<Trip> trips) : _trips = trips;

  final List<Trip> _trips;
  @override
  List<Trip> get trips {
    if (_trips is EqualUnmodifiableListView) return _trips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trips);
  }

  @override
  String toString() {
    return 'ItineraryState.loaded(trips: $trips)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._trips, _trips));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_trips));

  /// Create a copy of ItineraryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Trip> trips) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(trips);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Trip> trips)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(trips);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Trip> trips)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(trips);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ItineraryState {
  const factory _Loaded(final List<Trip> trips) = _$LoadedImpl;

  List<Trip> get trips;

  /// Create a copy of ItineraryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
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
    extends _$ItineraryStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItineraryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ItineraryState.error(message: $message)';
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

  /// Create a copy of ItineraryState
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
    required TResult Function(List<Trip> trips) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Trip> trips)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Trip> trips)? loaded,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ItineraryState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of ItineraryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
