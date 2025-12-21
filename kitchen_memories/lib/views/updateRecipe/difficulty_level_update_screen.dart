import 'package:flutter/material.dart';
import 'package:k/Provider/recipe_provider.dart';
import 'package:k/models/recipe_model.dart';
import 'package:k/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class DifficultyLevelUpdateScreen extends StatefulWidget {
  //why we declare this variables : we declare it so we can take recipe model as input
  //from constructor
  final RecipeModel recipeModel;
  const DifficultyLevelUpdateScreen({super.key, required this.recipeModel});

  @override
  State<DifficultyLevelUpdateScreen> createState() =>
      _DifficultyLevelUpdateScreenState();
}

class _DifficultyLevelUpdateScreenState
    extends State<DifficultyLevelUpdateScreen> {
  DifficultyLevel currentDiffucultyLevel = DifficultyLevel.beginner;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateDifficultyLevel() async {
    final newRecipeModel = RecipeModel(
      widget.recipeModel.title,
      widget.recipeModel.description,
      widget.recipeModel.ingredients,
      widget.recipeModel.steps,
      widget.recipeModel.cookTime,
      widget.recipeModel.prepTime,
      currentDiffucultyLevel,
      widget.recipeModel.isFavourite,
      widget.recipeModel.ratings,
      widget.recipeModel.imagePath,
      widget.recipeModel.createdAt,
      DateTime.now(),
      widget.recipeModel.note,
      widget.recipeModel.sourceUrl,
    );

    newRecipeModel.id = widget.recipeModel.id;

    context.read<RecipeProvider>().updateRecipe(newRecipeModel);

    var snackBarController = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.done, color: Colors.white),
            const SizedBox(width: 10),
            Text('Difficulty level updated!', style: TextStyle(fontSize: 20)),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );

    await snackBarController.closed;

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            SegmentedButton<DifficultyLevel>(
              segments: const [
                ButtonSegment(
                  value: DifficultyLevel.beginner,
                  label: Text('Beginner'),
                  icon: Icon(Icons.soup_kitchen),
                ),
                ButtonSegment(
                  value: DifficultyLevel.intermediate,
                  label: Text('Intermediate'),
                  icon: Icon(Icons.restaurant),
                ),
                ButtonSegment(
                  value: DifficultyLevel.expert,
                  label: Text('Expert'),
                  icon: Icon(Icons.emoji_events),
                ),
              ],
              selected: {currentDiffucultyLevel},
              onSelectionChanged: (Set<DifficultyLevel> newSelection) {
                setState(() {
                  currentDiffucultyLevel = newSelection.first;
                });
              },
            ),

            const SizedBox(height: 10),

            NextButton(label: 'Update', onPressed: _updateDifficultyLevel),
          ],
        ),
      ),
    );
  }
}
