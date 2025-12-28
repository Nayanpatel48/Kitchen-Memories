import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kitchen_memory/Provider/recipe_form_provider.dart';
import 'package:kitchen_memory/Provider/recipe_provider.dart';
import 'package:kitchen_memory/models/recipe_model.dart';
import 'package:kitchen_memory/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class RatingsUpdateScreen extends StatefulWidget {
  //why we declare this variables : we declare it so we can take recipe model as input
  //from constructor
  final RecipeModel recipeModel;

  const RatingsUpdateScreen({super.key, required this.recipeModel});

  @override
  State<RatingsUpdateScreen> createState() => _RatingsUpdateScreenState();
}

class _RatingsUpdateScreenState extends State<RatingsUpdateScreen> {
  int currentRating = 1;

  @override
  void initState() {
    super.initState();
  }

  void _updateRating() async {
    final newRecipeModel = RecipeModel(
      title: widget.recipeModel.title,
      description: widget.recipeModel.description,
      ingredients: widget.recipeModel.ingredients,
      steps: widget.recipeModel.steps,
      cookTime: widget.recipeModel.cookTime,
      prepTime: widget.recipeModel.prepTime,
      difficultyLevel: widget.recipeModel.difficultyLevel,
      isFavourite: widget.recipeModel.isFavourite,
      ratings: currentRating,
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
            Icon(Icons.thumb_up_sharp, color: Colors.white),
            const SizedBox(width: 10),
            Text('Ratings updated!', style: TextStyle(fontSize: 20)),
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
              children: [
                const Text('Rating?', style: TextStyle(fontSize: 20)),

                RatingBar.builder(
                  initialRating: context
                      .read<RecipeFormProvider>()
                      .ratings
                      .toDouble(),
                  minRating: 1,
                  maxRating: 5,
                  itemSize: 50,
                  direction: Axis.horizontal,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    setState(() {
                      currentRating = rating.toInt();
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            ReusableButton(label: 'Update Rating', onPressed: _updateRating),
          ],
        ),
      ),
    );
  }
}
