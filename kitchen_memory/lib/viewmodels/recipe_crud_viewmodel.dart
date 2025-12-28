import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kitchen_memory/models/recipe_model.dart';

class RecipeCrudViewmodel {
  // Singleton pattern
  static Box<RecipeModel>? _recipeBox;
  RecipeCrudViewmodel._internal();
  static final RecipeCrudViewmodel instance = RecipeCrudViewmodel._internal();

  static const String _boxName = 'recipe_db';

  Future<Box<RecipeModel>> get recipeBox async {
    if (_recipeBox == null || !_recipeBox!.isOpen) {
      if (!kIsWeb && !Hive.isAdapterRegistered(0)) {}

      _recipeBox = await Hive.openBox<RecipeModel>(_boxName);
    }
    return _recipeBox!;
  }

  Future<void> addRecipe(RecipeModel recipe) async {
    try {
      final box = await recipeBox;
      await box.add(recipe);
      debugPrint('Recipe added successfully');
    } catch (e) {
      debugPrint('Error while adding recipe: $e');
    }
  }

  Future<List<RecipeModel>> getAllRecipes() async {
    try {
      final box = await recipeBox;
      // Convert Hive values to a List
      final recipes = box.values.toList();
      debugPrint('Recipes fetch succeeded. Count: ${recipes.length}');
      return recipes;
    } catch (e) {
      debugPrint("Error while fetching all recipes: $e");
      return [];
    }
  }

  Future<void> deleteRecipe(int key) async {
    try {
      final box = await recipeBox;

      // Hive uses "keys" to delete. If you used .add(), the key is the index.
      await box.delete(key);
      debugPrint('Recipe deleted at key: $key');
    } catch (e) {
      debugPrint("Error while deleting recipe: $e");
    }
  }

  Future<void> updateRecipe(RecipeModel updatedRecipe, int key) async {
    try {
      // If RecipeModel extends HiveObject, you can simply call .save()
      // Otherwise, you put it back into the box using its key
      if (updatedRecipe.isInBox) {
        await updatedRecipe.save();
      } else {
        final box = await recipeBox;
        await box.put(key, updatedRecipe);
      }
      debugPrint('Recipe updated successfully');
    } catch (e) {
      debugPrint("Error while updating recipe: $e");
    }
  }
}
