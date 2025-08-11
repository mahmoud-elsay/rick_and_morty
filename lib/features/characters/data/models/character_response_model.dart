import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/features/characters/domain/entities/origin.dart';
import 'package:rick_and_morty/features/characters/domain/entities/location.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

part 'character_response_model.g.dart';

@JsonSerializable()
class CharacterResponseModel {
  final InfoModel info;
  final List<CharacterModel> results;

  CharacterResponseModel({required this.info, required this.results});

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterResponseModelToJson(this);
}

@JsonSerializable()
class InfoModel {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  InfoModel({required this.count, required this.pages, this.next, this.prev});

  factory InfoModel.fromJson(Map<String, dynamic> json) =>
      _$InfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$InfoModelToJson(this);
}

@JsonSerializable()
class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final OriginModel origin;
  final LocationModel location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);

  // Convert to domain entity
  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      origin: Origin(name: origin.name, url: origin.url),
      location: Location(name: location.name, url: location.url),
      image: image,
      episode: episode,
      url: url,
      created: created,
    );
  }
}

@JsonSerializable()
class OriginModel {
  final String name;
  final String url;

  OriginModel({required this.name, required this.url});

  factory OriginModel.fromJson(Map<String, dynamic> json) =>
      _$OriginModelFromJson(json);

  Map<String, dynamic> toJson() => _$OriginModelToJson(this);
}

@JsonSerializable()
class LocationModel {
  final String name;
  final String url;

  LocationModel({required this.name, required this.url});

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
