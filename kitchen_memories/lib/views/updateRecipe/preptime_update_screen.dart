import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:k/Provider/recipe_provider.dart';
import 'package:k/models/recipe_model.dart';
import 'package:k/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class PrepTimeUpdateScreen extends StatefulWidget {
  //why we declare this variables : we declare it so we can take recipe model as input
  //from constructor
  final RecipeModel recipeModel;
  const PrepTimeUpdateScreen({super.key, required this.recipeModel});

  @override
  State<PrepTimeUpdateScreen> createState() => _PrepTimeUpdateScreenState();
}

class _PrepTimeUpdateScreenState extends State<PrepTimeUpdateScreen> {
  final TextEditingController _prepTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _prepTimeController.dispose();
    super.dispose();
  }

  void _updatePrepTime() async {
    if (_formKey.currentState!.validate()) {
      debugPrint(
        "${int.parse(_prepTimeController.text)} & ${_prepTimeController.text}",
      );
      final newRecipeModel = RecipeModel(
        widget.recipeModel.title,
        widget.recipeModel.description,
        widget.recipeModel.ingredients,
        widget.recipeModel.steps,
        widget.recipeModel.cookTime,
        int.parse(_prepTimeController.text),
        widget.recipeModel.difficultyLevel,
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

      debugPrint("${newRecipeModel.prepTime}");

      var snackBarController = ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.done, color: Colors.white),
              const SizedBox(width: 10),
              Text('Time updated!', style: TextStyle(fontSize: 20)),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );

      await snackBarController.closed;

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              TextFormField(
                controller: _prepTimeController,
                keyboardType:
                    TextInputType.number, //to open numbers only keyboard
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ], //allows only numbers
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Prep time is missing!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('New prep time:'),
                ),
              ),

              const SizedBox(height: 10),

              NextButton(label: 'Update', onPressed: _updatePrepTime),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
