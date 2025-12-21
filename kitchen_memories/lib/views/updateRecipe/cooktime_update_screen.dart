import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:k/Provider/recipe_provider.dart';
import 'package:k/models/recipe_model.dart';
import 'package:k/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class CookTimeUpdateScreen extends StatefulWidget {
  //why we declare this variables : we declare it so we can take recipe model as input
  //from constructor
  final RecipeModel recipeModel;
  const CookTimeUpdateScreen({super.key, required this.recipeModel});

  @override
  State<CookTimeUpdateScreen> createState() => _CookTimeUpdateScreenState();
}

class _CookTimeUpdateScreenState extends State<CookTimeUpdateScreen> {
  final TextEditingController _cookTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cookTimeController.dispose();
    super.dispose();
  }

  void _updateCookTime() async {
    if (_formKey.currentState!.validate()) {
      debugPrint(
        "${int.parse(_cookTimeController.text)} & ${_cookTimeController.text}",
      );
      final newRecipeModel = RecipeModel(
        widget.recipeModel.title,
        widget.recipeModel.description,
        widget.recipeModel.ingredients,
        widget.recipeModel.steps,
        int.parse(_cookTimeController.text),
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

      newRecipeModel.id = widget.recipeModel.id;

      context.read<RecipeProvider>().updateRecipe(newRecipeModel);

      debugPrint("${newRecipeModel.cookTime}");

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
                controller: _cookTimeController,
                keyboardType:
                    TextInputType.number, //to open numbers only keyboard
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ], //allows only numbers
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Cook Time is missing!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('New Cook time:'),
                ),
              ),

              const SizedBox(height: 10),

              NextButton(label: 'Update', onPressed: _updateCookTime),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
