import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitchen_memory/Provider/recipe_provider.dart';
import 'package:kitchen_memory/models/recipe_model.dart';
import 'package:kitchen_memory/views/widgets/next_button.dart';
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
        title: widget.recipeModel.title,
        description: widget.recipeModel.description,
        ingredients: widget.recipeModel.ingredients,
        steps: widget.recipeModel.steps,
        cookTime: widget.recipeModel.cookTime,
        prepTime: int.parse(_prepTimeController.text),
        difficultyLevel: widget.recipeModel.difficultyLevel,
        isFavourite: widget.recipeModel.isFavourite,
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
      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Title')),
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
