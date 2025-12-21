import 'package:flutter/material.dart';
import 'package:k/Provider/recipe_provider.dart';
import 'package:k/models/recipe_model.dart';
import 'package:k/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class SourceUrlUpdateScreen extends StatefulWidget {
  //why we declare this variables : we declare it so we can take recipe model as input
  //from constructor
  final RecipeModel recipeModel;

  const SourceUrlUpdateScreen({super.key, required this.recipeModel});

  @override
  State<SourceUrlUpdateScreen> createState() => _SourceUrlUpdateScreenState();
}

class _SourceUrlUpdateScreenState extends State<SourceUrlUpdateScreen> {
  final TextEditingController _sourceUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  // why we do this?
  // => if we do not dispose this controllers in our app they consume lot of RAM in background
  //makes app slow & eventually crashs the app. So it is a good practice.
  @override
  void dispose() {
    _sourceUrlController.dispose();
    super.dispose();
  }

  void _updateSourceUrl() async {
    if (_formKey.currentState!.validate()) {
      final newRecipeModel = RecipeModel(
        widget.recipeModel.title,
        widget.recipeModel.description,
        widget.recipeModel.ingredients,
        widget.recipeModel.steps,
        widget.recipeModel.cookTime,
        widget.recipeModel.prepTime,
        widget.recipeModel.difficultyLevel,
        widget.recipeModel.isFavourite,
        widget.recipeModel.ratings,
        widget.recipeModel.imagePath,
        widget.recipeModel.createdAt,
        DateTime.now(),
        widget.recipeModel.note,
        _sourceUrlController.text,
      );

      newRecipeModel.id = widget.recipeModel.id;

      context.read<RecipeProvider>().updateRecipe(newRecipeModel);

      var snackBarController = ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.done, color: Colors.white),
              const SizedBox(width: 10),
              Text('Source URL updated!', style: TextStyle(fontSize: 20)),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );

      await snackBarController.closed;

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline_rounded, color: Colors.white),
              const SizedBox(width: 10),
              Text('URL field is pending!', style: TextStyle(fontSize: 20)),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
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
                controller: _sourceUrlController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Source URL is missing!";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Source URL',
                  border: OutlineInputBorder(),
                ),

                maxLines: 3,
              ),

              const SizedBox(height: 10),

              NextButton(label: 'Update', onPressed: _updateSourceUrl),
            ],
          ),
        ),
      ),
    );
  }
}
