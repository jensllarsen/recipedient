import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

/// Plain class to store Ingredient data.
///
/// Utilizes json_serializable to create to and from JSON methods in
/// ingredient.g.dart.
///
@JsonSerializable()
class Ingredient {
  int id;
  String item;
  int recipeId;

  Ingredient(
    this.item,
    this.recipeId,
  );

  Ingredient.withId(
    this.id,
    this.item,
    this.recipeId,
  );

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
