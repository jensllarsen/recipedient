// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return Recipe(
      json['label'] as String,
      json['image'] as String,
      json['source'] as String,
      json['url'] as String,
      (json['ingredientLines'] as List)?.map((e) => e as String)?.toList())
    ..id = json['id'] as int;
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'image': instance.image,
      'source': instance.source,
      'url': instance.url,
      'ingredientLines': instance.ingredientLines
    };
