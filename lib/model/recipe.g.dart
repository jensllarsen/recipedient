// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return Recipe(
      json['uri'] as String,
      json['label'] as String,
      json['image'] as String,
      json['source'] as String,
      json['url'] as String,
      json['shareAs'] as String,
      (json['recipeYield'] as num)?.toDouble(),
      (json['dietLabels'] as List)?.map((e) => e as String)?.toList(),
      (json['healthLabels'] as List)?.map((e) => e as String)?.toList(),
      (json['cautions'] as List)?.map((e) => e as String)?.toList(),
      (json['ingredientLines'] as List)?.map((e) => e as String)?.toList(),
      (json['ingredients'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'uri': instance.uri,
      'label': instance.label,
      'image': instance.image,
      'source': instance.source,
      'url': instance.url,
      'shareAs': instance.shareAs,
      'recipeYield': instance.recipeYield,
      'dietLabels': instance.dietLabels,
      'healthLabels': instance.healthLabels,
      'cautions': instance.cautions,
      'ingredientLines': instance.ingredientLines,
      'ingredients': instance.ingredients
    };
