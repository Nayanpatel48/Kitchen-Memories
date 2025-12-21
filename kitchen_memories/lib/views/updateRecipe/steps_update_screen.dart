import 'package:flutter/material.dart';
import 'package:k/Provider/recipe_form_provider.dart';
import 'package:k/Provider/recipe_provider.dart';
import 'package:k/models/recipe_model.dart';
import 'package:k/views/widgets/filled_elevated_button.dart';
import 'package:k/views/widgets/list_card.dart';
import 'package:k/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class StepsUpdateScreen extends StatefulWidget {
  //why we declare this variables : we declare it so we can take recipe model as input
  //from constructor
  final RecipeModel recipeModel;
  const StepsUpdateScreen({super.key, required this.recipeModel});

  @override
  State<StepsUpdateScreen> createState() => _StepsUpdateScreenState();
}

class _StepsUpdateScreenState extends State<StepsUpdateScreen> {
  final TextEditingController _stepController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //why this code is here : when screen first loads the code inside initState runs first.
  @override
  void initState() {
    context.read<RecipeFormProvider>().clearStepss();

    final steps = widget.recipeModel.steps;

    for (var step in steps!) {
      context.read<RecipeFormProvider>().stepInitialization(step);
    }

    debugPrint('${context.read<RecipeFormProvider>().steps}');

    super.initState();
  }

  @override
  void dispose() {
    _stepController.dispose(); //it prevents our mobile app from being slow
    super.dispose();
  }

  void _addStepOperation() {
    if (_formKey.currentState!.validate()) {
      final y = context.read<RecipeFormProvider>().stepAddition(
        _stepController.text,
      );

      if (!y) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 10),
                Text('Step already exist!', style: TextStyle(fontSize: 20)),
              ],
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      debugPrint("Step Added");
    }
  }

  void _removeStepOperation(String stepName) {
    context.read<RecipeFormProvider>().removeStep(stepName);
    debugPrint("Step deleted!");
  }

  void _updateStep() async {
    final updatedRecipeModel = RecipeModel(
      widget.recipeModel.title,
      widget.recipeModel.description,
      widget.recipeModel.ingredients,
      [],
      widget.recipeModel.cookTime,
      widget.recipeModel.prepTime,
      widget.recipeModel.difficultyLevel,
      widget.recipeModel.isFavourite,
      widget.recipeModel.ratings,
      widget.recipeModel.imagePath,
      widget.recipeModel.createdAt,
      DateTime.now(),
      widget.recipeModel.note,
      widget.recipeModel.sourceUrl,
    );

    updatedRecipeModel.id = widget.recipeModel.id;

    for (var step in context.read<RecipeFormProvider>().steps!) {
      updatedRecipeModel.steps!.add(step);
    }

    context.read<RecipeProvider>().updateRecipe(updatedRecipeModel);

    debugPrint("Steps updated!");

    var snackBarController = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.thumb_up_sharp, color: Colors.white),
            const SizedBox(width: 10),
            Text('Steps updated!', style: TextStyle(fontSize: 20)),
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _stepController,
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

                  FilledElevatedButton(onPressed: _addStepOperation),
                ],
              ),

              Divider(),

              Expanded(
                child: Consumer<RecipeFormProvider>(
                  builder: (context, provider, child) {
                    // This builder only runs when RecipeProvider calls notifyListeners()

                    if (provider.steps == null || provider.steps!.isEmpty) {
                      return const Center(
                        child: Text('Ingredients list is empty!'),
                      );
                    }

                    return ListView.builder(
                      addAutomaticKeepAlives: false,
                      itemCount: provider.steps!.length,
                      itemBuilder: (context, index) {
                        final step = provider.steps![index];
                        return ListCard(
                          onRemove: () {
                            _removeStepOperation(step);
                          },
                          subtitleText: step,
                        );
                      },
                    );
                  },
                ),
              ),
              NextButton(label: 'Update', onPressed: _updateStep),
            ],
          ),
        ),
      ),
    );
  }
}
