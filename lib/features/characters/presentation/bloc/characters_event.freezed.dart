// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'characters_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CharactersEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharactersEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CharactersEvent()';
}


}

/// @nodoc
class $CharactersEventCopyWith<$Res>  {
$CharactersEventCopyWith(CharactersEvent _, $Res Function(CharactersEvent) __);
}


/// Adds pattern-matching-related methods to [CharactersEvent].
extension CharactersEventPatterns on CharactersEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadCharacters value)?  loadCharacters,TResult Function( LoadMoreCharacters value)?  loadMoreCharacters,TResult Function( SearchCharacters value)?  searchCharacters,TResult Function( FilterCharacters value)?  filterCharacters,TResult Function( ToggleFavorite value)?  toggleFavorite,TResult Function( ConnectivityChanged value)?  connectivityChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadCharacters() when loadCharacters != null:
return loadCharacters(_that);case LoadMoreCharacters() when loadMoreCharacters != null:
return loadMoreCharacters(_that);case SearchCharacters() when searchCharacters != null:
return searchCharacters(_that);case FilterCharacters() when filterCharacters != null:
return filterCharacters(_that);case ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that);case ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadCharacters value)  loadCharacters,required TResult Function( LoadMoreCharacters value)  loadMoreCharacters,required TResult Function( SearchCharacters value)  searchCharacters,required TResult Function( FilterCharacters value)  filterCharacters,required TResult Function( ToggleFavorite value)  toggleFavorite,required TResult Function( ConnectivityChanged value)  connectivityChanged,}){
final _that = this;
switch (_that) {
case LoadCharacters():
return loadCharacters(_that);case LoadMoreCharacters():
return loadMoreCharacters(_that);case SearchCharacters():
return searchCharacters(_that);case FilterCharacters():
return filterCharacters(_that);case ToggleFavorite():
return toggleFavorite(_that);case ConnectivityChanged():
return connectivityChanged(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadCharacters value)?  loadCharacters,TResult? Function( LoadMoreCharacters value)?  loadMoreCharacters,TResult? Function( SearchCharacters value)?  searchCharacters,TResult? Function( FilterCharacters value)?  filterCharacters,TResult? Function( ToggleFavorite value)?  toggleFavorite,TResult? Function( ConnectivityChanged value)?  connectivityChanged,}){
final _that = this;
switch (_that) {
case LoadCharacters() when loadCharacters != null:
return loadCharacters(_that);case LoadMoreCharacters() when loadMoreCharacters != null:
return loadMoreCharacters(_that);case SearchCharacters() when searchCharacters != null:
return searchCharacters(_that);case FilterCharacters() when filterCharacters != null:
return filterCharacters(_that);case ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that);case ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool isRefresh)?  loadCharacters,TResult Function()?  loadMoreCharacters,TResult Function( String query)?  searchCharacters,TResult Function( String status)?  filterCharacters,TResult Function( int characterId)?  toggleFavorite,TResult Function( bool isOnline)?  connectivityChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadCharacters() when loadCharacters != null:
return loadCharacters(_that.isRefresh);case LoadMoreCharacters() when loadMoreCharacters != null:
return loadMoreCharacters();case SearchCharacters() when searchCharacters != null:
return searchCharacters(_that.query);case FilterCharacters() when filterCharacters != null:
return filterCharacters(_that.status);case ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that.characterId);case ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that.isOnline);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool isRefresh)  loadCharacters,required TResult Function()  loadMoreCharacters,required TResult Function( String query)  searchCharacters,required TResult Function( String status)  filterCharacters,required TResult Function( int characterId)  toggleFavorite,required TResult Function( bool isOnline)  connectivityChanged,}) {final _that = this;
switch (_that) {
case LoadCharacters():
return loadCharacters(_that.isRefresh);case LoadMoreCharacters():
return loadMoreCharacters();case SearchCharacters():
return searchCharacters(_that.query);case FilterCharacters():
return filterCharacters(_that.status);case ToggleFavorite():
return toggleFavorite(_that.characterId);case ConnectivityChanged():
return connectivityChanged(_that.isOnline);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool isRefresh)?  loadCharacters,TResult? Function()?  loadMoreCharacters,TResult? Function( String query)?  searchCharacters,TResult? Function( String status)?  filterCharacters,TResult? Function( int characterId)?  toggleFavorite,TResult? Function( bool isOnline)?  connectivityChanged,}) {final _that = this;
switch (_that) {
case LoadCharacters() when loadCharacters != null:
return loadCharacters(_that.isRefresh);case LoadMoreCharacters() when loadMoreCharacters != null:
return loadMoreCharacters();case SearchCharacters() when searchCharacters != null:
return searchCharacters(_that.query);case FilterCharacters() when filterCharacters != null:
return filterCharacters(_that.status);case ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that.characterId);case ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that.isOnline);case _:
  return null;

}
}

}

/// @nodoc


class LoadCharacters implements CharactersEvent {
  const LoadCharacters({this.isRefresh = false});
  

@JsonKey() final  bool isRefresh;

/// Create a copy of CharactersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadCharactersCopyWith<LoadCharacters> get copyWith => _$LoadCharactersCopyWithImpl<LoadCharacters>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadCharacters&&(identical(other.isRefresh, isRefresh) || other.isRefresh == isRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,isRefresh);

@override
String toString() {
  return 'CharactersEvent.loadCharacters(isRefresh: $isRefresh)';
}


}

/// @nodoc
abstract mixin class $LoadCharactersCopyWith<$Res> implements $CharactersEventCopyWith<$Res> {
  factory $LoadCharactersCopyWith(LoadCharacters value, $Res Function(LoadCharacters) _then) = _$LoadCharactersCopyWithImpl;
@useResult
$Res call({
 bool isRefresh
});




}
/// @nodoc
class _$LoadCharactersCopyWithImpl<$Res>
    implements $LoadCharactersCopyWith<$Res> {
  _$LoadCharactersCopyWithImpl(this._self, this._then);

  final LoadCharacters _self;
  final $Res Function(LoadCharacters) _then;

/// Create a copy of CharactersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isRefresh = null,}) {
  return _then(LoadCharacters(
isRefresh: null == isRefresh ? _self.isRefresh : isRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class LoadMoreCharacters implements CharactersEvent {
  const LoadMoreCharacters();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadMoreCharacters);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CharactersEvent.loadMoreCharacters()';
}


}




/// @nodoc


class SearchCharacters implements CharactersEvent {
  const SearchCharacters(this.query);
  

 final  String query;

/// Create a copy of CharactersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchCharactersCopyWith<SearchCharacters> get copyWith => _$SearchCharactersCopyWithImpl<SearchCharacters>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchCharacters&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'CharactersEvent.searchCharacters(query: $query)';
}


}

/// @nodoc
abstract mixin class $SearchCharactersCopyWith<$Res> implements $CharactersEventCopyWith<$Res> {
  factory $SearchCharactersCopyWith(SearchCharacters value, $Res Function(SearchCharacters) _then) = _$SearchCharactersCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$SearchCharactersCopyWithImpl<$Res>
    implements $SearchCharactersCopyWith<$Res> {
  _$SearchCharactersCopyWithImpl(this._self, this._then);

  final SearchCharacters _self;
  final $Res Function(SearchCharacters) _then;

/// Create a copy of CharactersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(SearchCharacters(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FilterCharacters implements CharactersEvent {
  const FilterCharacters(this.status);
  

 final  String status;

/// Create a copy of CharactersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterCharactersCopyWith<FilterCharacters> get copyWith => _$FilterCharactersCopyWithImpl<FilterCharacters>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterCharacters&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'CharactersEvent.filterCharacters(status: $status)';
}


}

/// @nodoc
abstract mixin class $FilterCharactersCopyWith<$Res> implements $CharactersEventCopyWith<$Res> {
  factory $FilterCharactersCopyWith(FilterCharacters value, $Res Function(FilterCharacters) _then) = _$FilterCharactersCopyWithImpl;
@useResult
$Res call({
 String status
});




}
/// @nodoc
class _$FilterCharactersCopyWithImpl<$Res>
    implements $FilterCharactersCopyWith<$Res> {
  _$FilterCharactersCopyWithImpl(this._self, this._then);

  final FilterCharacters _self;
  final $Res Function(FilterCharacters) _then;

/// Create a copy of CharactersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(FilterCharacters(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ToggleFavorite implements CharactersEvent {
  const ToggleFavorite(this.characterId);
  

 final  int characterId;

/// Create a copy of CharactersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleFavoriteCopyWith<ToggleFavorite> get copyWith => _$ToggleFavoriteCopyWithImpl<ToggleFavorite>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleFavorite&&(identical(other.characterId, characterId) || other.characterId == characterId));
}


@override
int get hashCode => Object.hash(runtimeType,characterId);

@override
String toString() {
  return 'CharactersEvent.toggleFavorite(characterId: $characterId)';
}


}

/// @nodoc
abstract mixin class $ToggleFavoriteCopyWith<$Res> implements $CharactersEventCopyWith<$Res> {
  factory $ToggleFavoriteCopyWith(ToggleFavorite value, $Res Function(ToggleFavorite) _then) = _$ToggleFavoriteCopyWithImpl;
@useResult
$Res call({
 int characterId
});




}
/// @nodoc
class _$ToggleFavoriteCopyWithImpl<$Res>
    implements $ToggleFavoriteCopyWith<$Res> {
  _$ToggleFavoriteCopyWithImpl(this._self, this._then);

  final ToggleFavorite _self;
  final $Res Function(ToggleFavorite) _then;

/// Create a copy of CharactersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? characterId = null,}) {
  return _then(ToggleFavorite(
null == characterId ? _self.characterId : characterId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ConnectivityChanged implements CharactersEvent {
  const ConnectivityChanged(this.isOnline);
  

 final  bool isOnline;

/// Create a copy of CharactersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectivityChangedCopyWith<ConnectivityChanged> get copyWith => _$ConnectivityChangedCopyWithImpl<ConnectivityChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectivityChanged&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline));
}


@override
int get hashCode => Object.hash(runtimeType,isOnline);

@override
String toString() {
  return 'CharactersEvent.connectivityChanged(isOnline: $isOnline)';
}


}

/// @nodoc
abstract mixin class $ConnectivityChangedCopyWith<$Res> implements $CharactersEventCopyWith<$Res> {
  factory $ConnectivityChangedCopyWith(ConnectivityChanged value, $Res Function(ConnectivityChanged) _then) = _$ConnectivityChangedCopyWithImpl;
@useResult
$Res call({
 bool isOnline
});




}
/// @nodoc
class _$ConnectivityChangedCopyWithImpl<$Res>
    implements $ConnectivityChangedCopyWith<$Res> {
  _$ConnectivityChangedCopyWithImpl(this._self, this._then);

  final ConnectivityChanged _self;
  final $Res Function(ConnectivityChanged) _then;

/// Create a copy of CharactersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isOnline = null,}) {
  return _then(ConnectivityChanged(
null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
