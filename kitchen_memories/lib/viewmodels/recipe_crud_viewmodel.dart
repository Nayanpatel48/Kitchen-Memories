import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:k/models/recipe_model.dart';
import 'package:path_provider/path_provider.dart';

class RecipeCrudViewmodel {
  //singlton pattern (Industry standard)
  //this pattern will be used to open Isar db only once
  static Isar? _isarInstance;
  RecipeCrudViewmodel._internal();
  //this is private constructor
  static final RecipeCrudViewmodel instance = RecipeCrudViewmodel._internal();

  //---single open/access point
  Future<Isar> get isar async {
    if (_isarInstance == null) {
      //It securely gets the operating system path where the application is allowed to store permanent
      //user data (like your database file).
      final dir = await getApplicationDocumentsDirectory();

      _isarInstance = await Isar.open(
        [RecipeModelSchema],
        directory: dir.path,
        name: 'recipe_db',
      );
    }

    // It returns the established Isar connection object.
    return _isarInstance!;
  }

  Future<void> addRecipe(RecipeModel recipe) async {
    final isar = await this.isar;

    try {
      //insert recipe object inside database
      await isar.writeTxn(() async {
        await isar.recipeModels.put(recipe);
      });
    } catch (e) {
      debugPrint('Error while adding recipe: $e');
    }

    //isar automatically assign id to the object because id field is non final
  }

  Future<List<RecipeModel>> getAllRecipes() async {
    final isar = await this.isar;
    try {
      final recipes = await isar.recipeModels.where().findAll();

      debugPrint('Recipes fetch succeeded. Count: ${recipes.length}');

      return recipes;
    } catch (e) {
      debugPrint("Error while fetching all recipes: $e");
      return [];
    }
  }

  Future<void> deleteRecipe(int id) async {
    try {
      final isar = await this.isar;
      await isar.writeTxn(() async {
        final success = await isar.recipeModels.delete(id);
        debugPrint('Recipe deleted: $success');
      });
    } catch (e) {
      debugPrint("Error while deleting recipe: $e");
    }
  }

  Future<void> updateRecipe(RecipeModel updatedRecipe) async {
    try {
      final isar = await this.isar;
      await isar.writeTxn(() async {
        await isar.recipeModels.put(updatedRecipe);
      });
      debugPrint('Recipe updated successfully');
    } catch (e) {
      debugPrint("Error while updating recipe: $e");
    }
  }
}
