// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kitchen_memory/Provider/recipe_provider.dart';
import 'package:kitchen_memory/models/recipe_model.dart';
import 'package:kitchen_memory/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class DescriptionUpdateScreen extends StatefulWidget {
  //why we declare this variables : we declare it so we can take recipe model as input
  //from constructor
  final RecipeModel recipeModel;

  const DescriptionUpdateScreen({super.key, required this.recipeModel});

  @override
  State<DescriptionUpdateScreen> createState() =>
      _DescriptionUpdateScreenState();
}

class _DescriptionUpdateScreenState extends State<DescriptionUpdateScreen> {
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateDescription() async {
    if (_formKey.currentState!.validate()) {
      widget.recipeModel.description = _descriptionController.text;
      widget.recipeModel.updatedAt = DateTime.now();

      context.read<RecipeProvider>().updateRecipe(
        widget.recipeModel,
        widget.recipeModel.key,
      );

      debugPrint("Description updated!");
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Title')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
          child: Column(
            children: [
              const SizedBox(height: 10),

              TextFormField(
                controller: _descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description is missing!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter new description:',
                ),
              ),

              const SizedBox(height: 10),

              ReusableButton(label: 'Update', onPressed: _updateDescription),
            ],
          ),
        ),
      ),
    );
  }
}
