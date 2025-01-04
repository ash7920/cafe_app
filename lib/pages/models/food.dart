class Food {
  String? id;
  String? context;
  String? type;
  String? category;
  String? datePublished;
  String? description;
  String? image;
  String? name;
  String? prepTime;
  List<String>? recipeIngredient;
  List<RecipeInstruction>? recipeInstructions;
  String? recipeYield;
  String? totalTime;

  Food({
    this.id,
    this.context,
    this.type,
    this.category,
    this.datePublished,
    this.description,
    this.image,
    this.name,
    this.prepTime,
    this.recipeIngredient,
    this.recipeInstructions,
    this.recipeYield,
    this.totalTime,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['_id'],
      context: json['@context'],
      type: json['@type'],
      category: json['category'],
      datePublished: json['datePublished'],
      description: json['description'],
      image: json['image'],
      name: json['name'],
      prepTime: json['prepTime'],
      recipeIngredient: json['recipeIngredient'] != null
          ? List<String>.from(json['recipeIngredient'])
          : null,
      recipeInstructions: json['recipeInstructions'] != null
          ? (json['recipeInstructions'] as List)
              .map((i) => RecipeInstruction.fromJson(i))
              .toList()
          : null,
      recipeYield: json['recipeYield'],
      totalTime: json['totalTime'],
    );
  }
}

class RecipeInstruction {
  String? type;
  String? image;
  String? name;
  String? text;

  RecipeInstruction({this.type, this.image, this.name, this.text});

  factory RecipeInstruction.fromJson(Map<String, dynamic> json) {
    return RecipeInstruction(
      type: json['@type'],
      image: json['image'],
      name: json['name'],
      text: json['text'],
    );
  }
}