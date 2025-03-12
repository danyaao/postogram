// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_multiple_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostMultipleDto _$PostMultipleDtoFromJson(Map<String, dynamic> json) =>
    PostMultipleDto(
      (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostMultipleDtoToJson(PostMultipleDto instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      json['path'] as String,
      (json['sizes'] as List<dynamic>)
          .map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'path': instance.path,
      'sizes': instance.sizes,
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      json['url'] as String,
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'url': instance.url,
    };
