import 'package:flutter/cupertino.dart';
import 'package:kitchen_memory/models/recipe_model.dart';
import 'package:kitchen_memory/viewmodels/recipe_crud_viewmodel.dart';

class RecipeProvider extends ChangeNotifier {
  final recipeViewModel = RecipeCrudViewmodel.instance;

  //---STATE VARIABLES---
  List<RecipeModel> _recipes = [];

  //---PUBLIC GETTERS---
  List<RecipeModel> get recipes {
    return _recipes;
  }

  //---CONSTRUCTOR---
  RecipeProvider() {
    getAllRecipes();
  }

  Future<void> getAllRecipes() async {
    try {
      //1. use view model to fetch all recipes
      final data = await recipeViewModel.getAllRecipes();

      //2. assign data to state variable
      _recipes = data;

      //3. notify listining widgets
      notifyListeners();
    } catch (e) {
      debugPrint('Error while fetching all recipes: $e');
    }
  }

  Future<void> addRecipe(RecipeModel recipe) async {
    //1. perform save operation
    await recipeViewModel.addRecipe(recipe);

    //2.refresh local list after saving
    await getAllRecipes();
  }

  Future<void> deleteRecipe(int id) async {
    //1. delete recipe with given id
    await recipeViewModel.deleteRecipe(id);

    //2. refresh local list after deleting
    await getAllRecipes();
  }

  Future<void> updateRecipe(RecipeModel updatedRecipe, int oldKey) async {
    //1. update recipe with given id
    await recipeViewModel.updateRecipe(updatedRecipe, oldKey);

    //2. refresh local list after updating
    await getAllRecipes();
  }
}
