import 'package:flutter/material.dart';
import 'package:k/Provider/recipe_form_provider.dart';
import 'package:k/Provider/recipe_provider.dart';
import 'package:k/models/recipe_model.dart';
import 'package:provider/provider.dart';

class Form6 extends StatefulWidget {
  const Form6({super.key});

  @override
  State<Form6> createState() => _Form6State();
}

class _Form6State extends State<Form6> {
  final TextEditingController _sourceUrlController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
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
    _noteController.dispose();
    super.dispose();
  }

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      context.read<RecipeFormProvider>().sourceUrl = _sourceUrlController.text;
      context.read<RecipeFormProvider>().note = _noteController.text;
      RecipeModel? newRecipe = context.read<RecipeFormProvider>().submitForm();
      debugPrint(newRecipe.toString());
      if (newRecipe != null) {
        context.read<RecipeProvider>().addRecipe(newRecipe);
        context.read<RecipeFormProvider>().clearWizardData();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline_rounded, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  'Previous fields are pending!',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
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
                controller: _noteController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Note is missing!";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(),
                ),

                maxLines: 3,
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: _sourceUrlController,
                textInputAction: TextInputAction.done,
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
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white54,
                        foregroundColor: Colors.black, // Text color
                        elevation: 2,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent,
                        foregroundColor: Colors.black, // Text color
                        elevation: 2,
                      ),
                      onPressed: _saveRecipe,
                      child: const Text(
                        'SAVE RECIPE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
