import 'package:hive/hive.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 0) // Unique ID for this class
class RecipeModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  List<String>? ingredients;

  @HiveField(3)
  List<String>? steps;

  @HiveField(4)
  late int cookTime;

  @HiveField(5)
  late int prepTime;

  @HiveField(6)
  late DifficultyLevel difficultyLevel;

  @HiveField(7)
  late bool isFavourite;

  @HiveField(8)
  late int ratings;

  @HiveField(9)
  late String imagePath;

  @HiveField(10)
  late DateTime createdAt;

  @HiveField(11)
  late DateTime updatedAt;

  @HiveField(12)
  late String note;

  @HiveField(13)
  late String sourceUrl;

  RecipeModel({
    required this.title,
    required this.description,
    this.ingredients,
    this.steps,
    required this.cookTime,
    required this.prepTime,
    required this.difficultyLevel,
    required this.isFavourite,
    required this.ratings,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.note,
    required this.sourceUrl,
  });
}

@HiveType(typeId: 1)
enum DifficultyLevel {
  @HiveField(0)
  beginner,
  @HiveField(1)
  intermediate,
  @HiveField(2)
  expert,
}
