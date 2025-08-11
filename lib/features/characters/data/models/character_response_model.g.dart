// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterResponseModel _$CharacterResponseModelFromJson(
  Map<String, dynamic> json,
) => CharacterResponseModel(
  info: InfoModel.fromJson(json['info'] as Map<String, dynamic>),
  results: (json['results'] as List<dynamic>)
      .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CharacterResponseModelToJson(
  CharacterResponseModel instance,
) => <String, dynamic>{'info': instance.info, 'results': instance.results};

InfoModel _$InfoModelFromJson(Map<String, dynamic> json) => InfoModel(
  count: (json['count'] as num).toInt(),
  pages: (json['pages'] as num).toInt(),
  next: json['next'] as String?,
  prev: json['prev'] as String?,
);

Map<String, dynamic> _$InfoModelToJson(InfoModel instance) => <String, dynamic>{
  'count': instance.count,
  'pages': instance.pages,
  'next': instance.next,
  'prev': instance.prev,
};

CharacterModel _$CharacterModelFromJson(
  Map<String, dynamic> json,
) => CharacterModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  status: json['status'] as String,
  species: json['species'] as String,
  type: json['type'] as String,
  gender: json['gender'] as String,
  origin: OriginModel.fromJson(json['origin'] as Map<String, dynamic>),
  location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
  image: json['image'] as String,
  episode: (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
  url: json['url'] as String,
  created: json['created'] as String,
);

Map<String, dynamic> _$CharacterModelToJson(CharacterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
      'episode': instance.episode,
      'url': instance.url,
      'created': instance.created,
    };

OriginModel _$OriginModelFromJson(Map<String, dynamic> json) =>
    OriginModel(name: json['name'] as String, url: json['url'] as String);

Map<String, dynamic> _$OriginModelToJson(OriginModel instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(name: json['name'] as String, url: json['url'] as String);

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
