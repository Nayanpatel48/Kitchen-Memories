import 'package:flutter/material.dart';
import 'package:kitchen_memory/Provider/recipe_provider.dart';
import 'package:kitchen_memory/models/recipe_model.dart';
import 'package:kitchen_memory/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class IsFavoriteUpdateScreen extends StatefulWidget {
  //why we declare this variables : we declare it so we can take recipe model as input
  //from constructor
  final RecipeModel recipeModel;
  const IsFavoriteUpdateScreen({super.key, required this.recipeModel});

  @override
  State<IsFavoriteUpdateScreen> createState() => _IsFavoriteUpdateScreenState();
}

class _IsFavoriteUpdateScreenState extends State<IsFavoriteUpdateScreen> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateIsFavorite() async {
    final newRecipeModel = RecipeModel(
      title: widget.recipeModel.title,
      description: widget.recipeModel.description,
      ingredients: widget.recipeModel.ingredients,
      steps: widget.recipeModel.steps,
      cookTime: widget.recipeModel.cookTime,
      prepTime: widget.recipeModel.prepTime,
      difficultyLevel: widget.recipeModel.difficultyLevel,
      isFavourite: isFavourite,
      ratings: widget.recipeModel.ratings,
      imagePath: widget.recipeModel.imagePath,
      createdAt: widget.recipeModel.createdAt,
      updatedAt: DateTime.now(),
      note: widget.recipeModel.note,
      sourceUrl: widget.recipeModel.sourceUrl,
    );

    context.read<RecipeProvider>().updateRecipe(
      newRecipeModel,
      widget.recipeModel.key,
    );

    var snackBarController = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.done, color: Colors.white),
            const SizedBox(width: 10),
            Text('Is favorite updated!', style: TextStyle(fontSize: 20)),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );

    await snackBarController.closed;

    // ignore: use_build_context_synchronously
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Title')),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Is Favorite?'),
                Checkbox(
                  value: isFavourite,
                  onChanged: (value) {
                    setState(() {
                      isFavourite = value!;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            ReusableButton(label: 'Update', onPressed: _updateIsFavorite),
          ],
        ),
      ),
    );
  }
}
