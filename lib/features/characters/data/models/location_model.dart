import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/features/characters/domain/entities/location.dart';
// features/characters/data/models/location_model.dart

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel extends Location {
  LocationModel({required String name, required String url})
    : super(name: name, url: url);

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
