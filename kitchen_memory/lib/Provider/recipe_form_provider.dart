import 'package:flutter/material.dart';
import 'package:kitchen_memory/models/recipe_model.dart';

class RecipeFormProvider extends ChangeNotifier {
  //form fields
  String? title;
  String? description;
  List<String>? ingredients;
  List<String>? steps;
  int cookTime = 10;
  int prepTime = 10;
  DifficultyLevel difficultyLevel = DifficultyLevel.beginner;
  bool isFavourite = false;
  int ratings = 1;
  String? imagePath;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? note;
  String? sourceUrl;

  void updateTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
    debugPrint("Title updated!");
  }

  void updateForm1Data(String newTitle, String newDescription) {
    title = newTitle;
    description = newDescription;
    notifyListeners();
    debugPrint("Form 1 data updated!");
  }

  bool ingredientAddition(String newIngredient) {
    //if ingredient already exist the return false -> can not add duplicate
    if (ingredients != null) {
      for (var ingredient in ingredients!) {
        if (newIngredient.toLowerCase() == ingredient.toLowerCase()) {
          return false;
        }
      }
    }
    // cases :
    //1. if not exist the add
    //2. if list is null then initialize
    ingredients ??= [];
    ingredients!.add(newIngredient);
    notifyListeners();
    return true;
  }

  void ingredientInitialization(String newIngredient) {
    ingredients ??= [];
    ingredients!.add(newIngredient);
  }

  void stepInitialization(String step) {
    steps ??= [];
    steps!.add(step);
  }

  void clearIngredients() {
    if (ingredients != null) {
      ingredients!.clear();
    }
  }

  void clearStepss() {
    if (steps != null) {
      steps!.clear();
    }
  }

  void removeIngredient(String ingredientName) {
    ingredients!.remove(ingredientName);
    notifyListeners();
  }

  List<String> getAllIngredients() {
    return ingredients!;
  }

  bool stepAddition(String newStep) {
    //if step already exist the return false -> can not add duplicate
    if (steps != null) {
      for (var step in steps!) {
        if (step.toLowerCase() == newStep.toLowerCase()) {
          return false;
        }
      }
    }
    // cases :
    //1. if not exist the add
    //2. if list is null then initialize
    steps ??= [];
    steps!.add(newStep);
    notifyListeners();
    return true;
  }

  void removeStep(String stepName) {
    steps!.remove(stepName);
    notifyListeners();
  }

  List<String> getAllSteps() {
    return steps!;
  }

  void setTime(int newCookTime, int newPrepTime) {
    cookTime = newCookTime;
    prepTime = newPrepTime;
    notifyListeners();
    debugPrint("Cook & prep time updated!");
  }

  void setDifficultyLevel(DifficultyLevel newDifficultyLevel) {
    difficultyLevel = newDifficultyLevel;
    notifyListeners();
    debugPrint("difficulty level updated!");
  }

  void setIsFavorite(bool newIsFavorite) {
    isFavourite = newIsFavorite;
    notifyListeners();
    debugPrint("is favorite updated! $isFavourite");
  }

  //reset button
  void clearWizardData() {
    title = null;
    description = null;
    ingredients = null;
    steps = null;
    cookTime = 10;
    prepTime = 10;
    difficultyLevel = DifficultyLevel.beginner;
    isFavourite = false;
    ratings = 1;
    imagePath = null;
    createdAt = null;
    updatedAt = null;
    note = null;
    sourceUrl = null;
    debugPrint("Wizard data is cleared!");
  }

  //final submit called in very last page
  RecipeModel? submitForm() {
    debugPrint(
      "title : $title, description : $description, ingredients : $ingredients, steps : $steps, preptime : $prepTime, cooktime : $cookTime, difficultyLevel : $difficultyLevel, isFavourite : $isFavourite, ratings : $ratings, imagePath : $imagePath, note : $note, sourceUrl : $sourceUrl",
    );
    try {
      return RecipeModel(
        title: title!,
        description: description!,
        ingredients: ingredients,
        steps: steps,
        cookTime: cookTime,
        prepTime: prepTime,
        difficultyLevel: difficultyLevel,
        isFavourite: isFavourite,
        ratings: ratings,
        imagePath: imagePath!,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        note: note!,
        sourceUrl: sourceUrl!,
      );
    } catch (e) {
      debugPrint("Error during submission of form : $e");
      return null;
    }
  }
}
