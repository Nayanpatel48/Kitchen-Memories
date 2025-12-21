import 'package:isar/isar.dart';

part 'recipe_model.g.dart';

@collection
class RecipeModel {
  RecipeModel(
    this.title,
    this.description,
    this.ingredients,
    this.steps,
    this.cookTime,
    this.prepTime,
    this.difficultyLevel,
    this.isFavourite,
    this.ratings,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
    this.note,
    this.sourceUrl,
  );

  //primary key of Recipe Model
  //id will be auto incremented
  @Index(unique: true, type: IndexType.value)
  Id id = Isar.autoIncrement;

  //value of title will be initialized when needed
  //& can be only assigned once
  //it ensures the unique title of each recipe
  //we ensure that no names are overlapping & indexing makes searching faster
  @Index(unique: true, type: IndexType.value)
  late String title;

  //same as above title
  late String description;

  //we've linked RecipeModel with IngredientsModel
  List<String>? ingredients;

  //we've linked RecipeModel with StepsModel
  List<String>? steps;

  late int cookTime;

  late int prepTime;

  @enumerated
  late DifficultyLevel difficultyLevel;

  late bool isFavourite;

  late int ratings;

  late String imagePath;

  late DateTime createdAt;

  late DateTime updatedAt;

  late String note;

  late String sourceUrl;
}

enum DifficultyLevel { beginner, intermediate, expert }
