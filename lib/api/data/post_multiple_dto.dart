import 'package:json_annotation/json_annotation.dart';

part 'post_multiple_dto.g.dart';

@JsonSerializable()
class PostMultipleDto {
  PostMultipleDto(this.items);

  List<Item> items;

  factory PostMultipleDto.fromJson(Map<String, dynamic> json) => _$PostMultipleDtoFromJson(json);
}

@JsonSerializable()
class Item {
  Item(
    this.path,
    this.sizes,
  );

  final String path;

  final List<Photo> sizes;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@JsonSerializable()
class Photo {
  Photo(
    this.url,
  );

  final String url;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
