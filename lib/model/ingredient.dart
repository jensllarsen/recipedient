
class Ingredient {
  String text;
  double weight;

  Ingredient({
    this.text,
    this.weight,
  });

  factory Ingredient.fromMap(Map<String, dynamic> json) => new Ingredient(
    text: json["text"],
    weight: json["weight"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "text": text,
    "weight": weight,
  };
}