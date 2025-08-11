// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'characters_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CharactersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharactersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CharactersState()';
}


}

/// @nodoc
class $CharactersStateCopyWith<$Res>  {
$CharactersStateCopyWith(CharactersState _, $Res Function(CharactersState) __);
}


/// Adds pattern-matching-related methods to [CharactersState].
extension CharactersStatePatterns on CharactersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CharactersInitial value)?  initial,TResult Function( CharactersLoading value)?  loading,TResult Function( CharactersLoaded value)?  loaded,TResult Function( CharactersError value)?  error,TResult Function( CharacterDetailLoaded value)?  detailLoaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CharactersInitial() when initial != null:
return initial(_that);case CharactersLoading() when loading != null:
return loading(_that);case CharactersLoaded() when loaded != null:
return loaded(_that);case CharactersError() when error != null:
return error(_that);case CharacterDetailLoaded() when detailLoaded != null:
return detailLoaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CharactersInitial value)  initial,required TResult Function( CharactersLoading value)  loading,required TResult Function( CharactersLoaded value)  loaded,required TResult Function( CharactersError value)  error,required TResult Function( CharacterDetailLoaded value)  detailLoaded,}){
final _that = this;
switch (_that) {
case CharactersInitial():
return initial(_that);case CharactersLoading():
return loading(_that);case CharactersLoaded():
return loaded(_that);case CharactersError():
return error(_that);case CharacterDetailLoaded():
return detailLoaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CharactersInitial value)?  initial,TResult? Function( CharactersLoading value)?  loading,TResult? Function( CharactersLoaded value)?  loaded,TResult? Function( CharactersError value)?  error,TResult? Function( CharacterDetailLoaded value)?  detailLoaded,}){
final _that = this;
switch (_that) {
case CharactersInitial() when initial != null:
return initial(_that);case CharactersLoading() when loading != null:
return loading(_that);case CharactersLoaded() when loaded != null:
return loaded(_that);case CharactersError() when error != null:
return error(_that);case CharacterDetailLoaded() when detailLoaded != null:
return detailLoaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Character> characters,  Set<int> favoriteIds,  bool hasReachedMax,  bool isLoadingMore,  bool isOnline,  String currentFilter,  String currentSearchQuery,  Character? selectedCharacter)?  loaded,TResult Function( String message,  List<Character> cachedCharacters,  Set<int> favoriteIds,  bool isOnline)?  error,TResult Function( Character character,  bool isFavorite)?  detailLoaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CharactersInitial() when initial != null:
return initial();case CharactersLoading() when loading != null:
return loading();case CharactersLoaded() when loaded != null:
return loaded(_that.characters,_that.favoriteIds,_that.hasReachedMax,_that.isLoadingMore,_that.isOnline,_that.currentFilter,_that.currentSearchQuery,_that.selectedCharacter);case CharactersError() when error != null:
return error(_that.message,_that.cachedCharacters,_that.favoriteIds,_that.isOnline);case CharacterDetailLoaded() when detailLoaded != null:
return detailLoaded(_that.character,_that.isFavorite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Character> characters,  Set<int> favoriteIds,  bool hasReachedMax,  bool isLoadingMore,  bool isOnline,  String currentFilter,  String currentSearchQuery,  Character? selectedCharacter)  loaded,required TResult Function( String message,  List<Character> cachedCharacters,  Set<int> favoriteIds,  bool isOnline)  error,required TResult Function( Character character,  bool isFavorite)  detailLoaded,}) {final _that = this;
switch (_that) {
case CharactersInitial():
return initial();case CharactersLoading():
return loading();case CharactersLoaded():
return loaded(_that.characters,_that.favoriteIds,_that.hasReachedMax,_that.isLoadingMore,_that.isOnline,_that.currentFilter,_that.currentSearchQuery,_that.selectedCharacter);case CharactersError():
return error(_that.message,_that.cachedCharacters,_that.favoriteIds,_that.isOnline);case CharacterDetailLoaded():
return detailLoaded(_that.character,_that.isFavorite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Character> characters,  Set<int> favoriteIds,  bool hasReachedMax,  bool isLoadingMore,  bool isOnline,  String currentFilter,  String currentSearchQuery,  Character? selectedCharacter)?  loaded,TResult? Function( String message,  List<Character> cachedCharacters,  Set<int> favoriteIds,  bool isOnline)?  error,TResult? Function( Character character,  bool isFavorite)?  detailLoaded,}) {final _that = this;
switch (_that) {
case CharactersInitial() when initial != null:
return initial();case CharactersLoading() when loading != null:
return loading();case CharactersLoaded() when loaded != null:
return loaded(_that.characters,_that.favoriteIds,_that.hasReachedMax,_that.isLoadingMore,_that.isOnline,_that.currentFilter,_that.currentSearchQuery,_that.selectedCharacter);case CharactersError() when error != null:
return error(_that.message,_that.cachedCharacters,_that.favoriteIds,_that.isOnline);case CharacterDetailLoaded() when detailLoaded != null:
return detailLoaded(_that.character,_that.isFavorite);case _:
  return null;

}
}

}

/// @nodoc


class CharactersInitial implements CharactersState {
  const CharactersInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharactersInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CharactersState.initial()';
}


}




/// @nodoc


class CharactersLoading implements CharactersState {
  const CharactersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharactersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CharactersState.loading()';
}


}




/// @nodoc


class CharactersLoaded implements CharactersState {
  const CharactersLoaded({required final  List<Character> characters, required final  Set<int> favoriteIds, this.hasReachedMax = false, this.isLoadingMore = false, this.isOnline = true, this.currentFilter = 'All', this.currentSearchQuery = '', this.selectedCharacter}): _characters = characters,_favoriteIds = favoriteIds;
  

 final  List<Character> _characters;
 List<Character> get characters {
  if (_characters is EqualUnmodifiableListView) return _characters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_characters);
}

 final  Set<int> _favoriteIds;
 Set<int> get favoriteIds {
  if (_favoriteIds is EqualUnmodifiableSetView) return _favoriteIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_favoriteIds);
}

@JsonKey() final  bool hasReachedMax;
@JsonKey() final  bool isLoadingMore;
@JsonKey() final  bool isOnline;
@JsonKey() final  String currentFilter;
@JsonKey() final  String currentSearchQuery;
 final  Character? selectedCharacter;

/// Create a copy of CharactersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharactersLoadedCopyWith<CharactersLoaded> get copyWith => _$CharactersLoadedCopyWithImpl<CharactersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharactersLoaded&&const DeepCollectionEquality().equals(other._characters, _characters)&&const DeepCollectionEquality().equals(other._favoriteIds, _favoriteIds)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.currentFilter, currentFilter) || other.currentFilter == currentFilter)&&(identical(other.currentSearchQuery, currentSearchQuery) || other.currentSearchQuery == currentSearchQuery)&&(identical(other.selectedCharacter, selectedCharacter) || other.selectedCharacter == selectedCharacter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_characters),const DeepCollectionEquality().hash(_favoriteIds),hasReachedMax,isLoadingMore,isOnline,currentFilter,currentSearchQuery,selectedCharacter);

@override
String toString() {
  return 'CharactersState.loaded(characters: $characters, favoriteIds: $favoriteIds, hasReachedMax: $hasReachedMax, isLoadingMore: $isLoadingMore, isOnline: $isOnline, currentFilter: $currentFilter, currentSearchQuery: $currentSearchQuery, selectedCharacter: $selectedCharacter)';
}


}

/// @nodoc
abstract mixin class $CharactersLoadedCopyWith<$Res> implements $CharactersStateCopyWith<$Res> {
  factory $CharactersLoadedCopyWith(CharactersLoaded value, $Res Function(CharactersLoaded) _then) = _$CharactersLoadedCopyWithImpl;
@useResult
$Res call({
 List<Character> characters, Set<int> favoriteIds, bool hasReachedMax, bool isLoadingMore, bool isOnline, String currentFilter, String currentSearchQuery, Character? selectedCharacter
});




}
/// @nodoc
class _$CharactersLoadedCopyWithImpl<$Res>
    implements $CharactersLoadedCopyWith<$Res> {
  _$CharactersLoadedCopyWithImpl(this._self, this._then);

  final CharactersLoaded _self;
  final $Res Function(CharactersLoaded) _then;

/// Create a copy of CharactersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? characters = null,Object? favoriteIds = null,Object? hasReachedMax = null,Object? isLoadingMore = null,Object? isOnline = null,Object? currentFilter = null,Object? currentSearchQuery = null,Object? selectedCharacter = freezed,}) {
  return _then(CharactersLoaded(
characters: null == characters ? _self._characters : characters // ignore: cast_nullable_to_non_nullable
as List<Character>,favoriteIds: null == favoriteIds ? _self._favoriteIds : favoriteIds // ignore: cast_nullable_to_non_nullable
as Set<int>,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,currentFilter: null == currentFilter ? _self.currentFilter : currentFilter // ignore: cast_nullable_to_non_nullable
as String,currentSearchQuery: null == currentSearchQuery ? _self.currentSearchQuery : currentSearchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedCharacter: freezed == selectedCharacter ? _self.selectedCharacter : selectedCharacter // ignore: cast_nullable_to_non_nullable
as Character?,
  ));
}


}

/// @nodoc


class CharactersError implements CharactersState {
  const CharactersError({required this.message, final  List<Character> cachedCharacters = const [], final  Set<int> favoriteIds = const {}, this.isOnline = false}): _cachedCharacters = cachedCharacters,_favoriteIds = favoriteIds;
  

 final  String message;
 final  List<Character> _cachedCharacters;
@JsonKey() List<Character> get cachedCharacters {
  if (_cachedCharacters is EqualUnmodifiableListView) return _cachedCharacters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cachedCharacters);
}

 final  Set<int> _favoriteIds;
@JsonKey() Set<int> get favoriteIds {
  if (_favoriteIds is EqualUnmodifiableSetView) return _favoriteIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_favoriteIds);
}

@JsonKey() final  bool isOnline;

/// Create a copy of CharactersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharactersErrorCopyWith<CharactersError> get copyWith => _$CharactersErrorCopyWithImpl<CharactersError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharactersError&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._cachedCharacters, _cachedCharacters)&&const DeepCollectionEquality().equals(other._favoriteIds, _favoriteIds)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_cachedCharacters),const DeepCollectionEquality().hash(_favoriteIds),isOnline);

@override
String toString() {
  return 'CharactersState.error(message: $message, cachedCharacters: $cachedCharacters, favoriteIds: $favoriteIds, isOnline: $isOnline)';
}


}

/// @nodoc
abstract mixin class $CharactersErrorCopyWith<$Res> implements $CharactersStateCopyWith<$Res> {
  factory $CharactersErrorCopyWith(CharactersError value, $Res Function(CharactersError) _then) = _$CharactersErrorCopyWithImpl;
@useResult
$Res call({
 String message, List<Character> cachedCharacters, Set<int> favoriteIds, bool isOnline
});




}
/// @nodoc
class _$CharactersErrorCopyWithImpl<$Res>
    implements $CharactersErrorCopyWith<$Res> {
  _$CharactersErrorCopyWithImpl(this._self, this._then);

  final CharactersError _self;
  final $Res Function(CharactersError) _then;

/// Create a copy of CharactersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cachedCharacters = null,Object? favoriteIds = null,Object? isOnline = null,}) {
  return _then(CharactersError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cachedCharacters: null == cachedCharacters ? _self._cachedCharacters : cachedCharacters // ignore: cast_nullable_to_non_nullable
as List<Character>,favoriteIds: null == favoriteIds ? _self._favoriteIds : favoriteIds // ignore: cast_nullable_to_non_nullable
as Set<int>,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class CharacterDetailLoaded implements CharactersState {
  const CharacterDetailLoaded({required this.character, required this.isFavorite});
  

 final  Character character;
 final  bool isFavorite;

/// Create a copy of CharactersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharacterDetailLoadedCopyWith<CharacterDetailLoaded> get copyWith => _$CharacterDetailLoadedCopyWithImpl<CharacterDetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterDetailLoaded&&(identical(other.character, character) || other.character == character)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}


@override
int get hashCode => Object.hash(runtimeType,character,isFavorite);

@override
String toString() {
  return 'CharactersState.detailLoaded(character: $character, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $CharacterDetailLoadedCopyWith<$Res> implements $CharactersStateCopyWith<$Res> {
  factory $CharacterDetailLoadedCopyWith(CharacterDetailLoaded value, $Res Function(CharacterDetailLoaded) _then) = _$CharacterDetailLoadedCopyWithImpl;
@useResult
$Res call({
 Character character, bool isFavorite
});




}
/// @nodoc
class _$CharacterDetailLoadedCopyWithImpl<$Res>
    implements $CharacterDetailLoadedCopyWith<$Res> {
  _$CharacterDetailLoadedCopyWithImpl(this._self, this._then);

  final CharacterDetailLoaded _self;
  final $Res Function(CharacterDetailLoaded) _then;

/// Create a copy of CharactersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? character = null,Object? isFavorite = null,}) {
  return _then(CharacterDetailLoaded(
character: null == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as Character,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
