import 'package:flutter/material.dart';
import 'package:kitchen_memory/Provider/recipe_form_provider.dart';
import 'package:kitchen_memory/Provider/recipe_provider.dart';
import 'package:kitchen_memory/models/recipe_model.dart';
import 'package:kitchen_memory/views/widgets/filled_elevated_button.dart';
import 'package:kitchen_memory/views/widgets/list_card.dart';
import 'package:kitchen_memory/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class IngredientUpdateScreen extends StatefulWidget {
  //why we declare this variables : we declare it so we can take recipe model as input
  //from constructor
  final RecipeModel recipeModel;
  const IngredientUpdateScreen({super.key, required this.recipeModel});

  @override
  State<IngredientUpdateScreen> createState() => _IngredientUpdateScreenState();
}

class _IngredientUpdateScreenState extends State<IngredientUpdateScreen> {
  final TextEditingController _ingredientController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //why this code is here : when screen first loads the code inside initState runs first.
  @override
  void initState() {
    context.read<RecipeFormProvider>().clearIngredients();

    final ingredients = widget.recipeModel.ingredients;

    for (var ingredient in ingredients!) {
      context.read<RecipeFormProvider>().ingredientInitialization(ingredient);
    }

    super.initState();
  }

  @override
  void dispose() {
    _ingredientController
        .dispose(); //it prevents our mobile app from being slow
    super.dispose();
  }

  void _addIngredientOperation() {
    if (_formKey.currentState!.validate()) {
      final y = context.read<RecipeFormProvider>().ingredientAddition(
        _ingredientController.text,
      );

      if (!y) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  'Ingredient already exist!',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      debugPrint("Ingredient Added");
    }
  }

  void _removeIngredientOperation(String ingredientName) {
    context.read<RecipeFormProvider>().removeIngredient(ingredientName);
    debugPrint("Ingredient deleted!");
  }

  void _updateIngredients() async {
    final updatedRecipeModel = RecipeModel(
      title: widget.recipeModel.title,
      description: widget.recipeModel.description,
      ingredients: [],
      steps: widget.recipeModel.steps,
      cookTime: widget.recipeModel.cookTime,
      prepTime: widget.recipeModel.prepTime,
      difficultyLevel: widget.recipeModel.difficultyLevel,
      isFavourite: widget.recipeModel.isFavourite,
      ratings: widget.recipeModel.ratings,
      imagePath: widget.recipeModel.imagePath,
      createdAt: widget.recipeModel.createdAt,
      updatedAt: DateTime.now(),
      note: widget.recipeModel.note,
      sourceUrl: widget.recipeModel.sourceUrl,
    );

    // updatedRecipeModel.id = widget.recipeModel.id;

    for (var ingredient in context.read<RecipeFormProvider>().ingredients!) {
      updatedRecipeModel.ingredients!.add(ingredient);
    }

    context.read<RecipeProvider>().updateRecipe(
      updatedRecipeModel,
      widget.recipeModel.key,
    );

    debugPrint("Ingredients updated!");

    var snackBarController = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.thumb_up_sharp, color: Colors.white),
            const SizedBox(width: 10),
            Text('Description updated!', style: TextStyle(fontSize: 20)),
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ingredientController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingredient is missing!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter ingredient name:',
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  FilledElevatedButton(onPressed: _addIngredientOperation),
                ],
              ),

              Divider(),

              Expanded(
                child: Consumer<RecipeFormProvider>(
                  builder: (context, provider, child) {
                    // This builder only runs when RecipeProvider calls notifyListeners()

                    if (provider.ingredients == null ||
                        provider.ingredients!.isEmpty) {
                      return const Center(
                        child: Text('Ingredients list is empty!'),
                      );
                    }

                    return ListView.builder(
                      addAutomaticKeepAlives: false,
                      itemCount: provider.ingredients!.length,
                      itemBuilder: (context, index) {
                        final ingredient = provider.ingredients![index];
                        return ListCard(
                          onRemove: () {
                            _removeIngredientOperation(ingredient);
                          },
                          subtitleText: ingredient,
                        );
                      },
                    );
                  },
                ),
              ),
              ReusableButton(label: 'Update', onPressed: _updateIngredients),
            ],
          ),
        ),
      ),
    );
  }
}
