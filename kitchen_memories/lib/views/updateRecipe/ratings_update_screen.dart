import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:k/Provider/recipe_form_provider.dart';
import 'package:k/Provider/recipe_provider.dart';
import 'package:k/models/recipe_model.dart';
import 'package:k/views/widgets/next_button.dart';
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
      widget.recipeModel.title,
      widget.recipeModel.description,
      widget.recipeModel.ingredients,
      widget.recipeModel.steps,
      widget.recipeModel.cookTime,
      widget.recipeModel.prepTime,
      widget.recipeModel.difficultyLevel,
      widget.recipeModel.isFavourite,
      currentRating,
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
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            NextButton(label: 'Update Rating', onPressed: _updateRating),
          ],
        ),
      ),
    );
  }
}
