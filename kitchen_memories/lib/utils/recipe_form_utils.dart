import 'package:flutter/material.dart';
import 'package:k/models/recipe_model.dart';

class RecipeFormUtils {
  // Static because it doesn't need to hold data
  static List<DropdownMenuItem<DifficultyLevel>> buildDifficultyItems() {
    return DifficultyLevel.values
        .map((v) => DropdownMenuItem(value: v, child: Text(v.name)))
        .toList();
  }

  // Pure converter: Takes controllers, returns Strings
  static List<String> convertControllersToStrings(
    List<TextEditingController> controllers,
  ) {
    return controllers
        .where(
          (c) => c.text.isNotEmpty,
        ) // Bonus: Filter out empty lines automatically
        .map((c) => c.text)
        .toList();
  }
}
