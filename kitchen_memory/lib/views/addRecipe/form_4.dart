import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitchen_memory/Provider/recipe_form_provider.dart';
import 'package:kitchen_memory/models/recipe_model.dart';
import 'package:kitchen_memory/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class Form4 extends StatefulWidget {
  const Form4({super.key});

  @override
  State<Form4> createState() => _Form4State();
}

class _Form4State extends State<Form4> {
  final TextEditingController _prepTimeController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isFavourite = false;

  @override
  void initState() {
    if (context.read<RecipeFormProvider>().isFavourite != false) {
      isFavourite = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    super.dispose();
  }

  void _saveTimes() {
    if (_formKey.currentState!.validate()) {
      context.read<RecipeFormProvider>().setTime(
        int.parse(_cookTimeController.text),
        int.parse(_prepTimeController.text),
      );
      ScaffoldMessenger.of(context).showSnackBar(
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
                  label: Text('Prep time:'),
                ),
              ),

              const SizedBox(height: 10),

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
                  label: Text('Cook time:'),
                ),
              ),

              const SizedBox(height: 10),

              SegmentedButton<DifficultyLevel>(
                segments: const [
                  ButtonSegment(
                    value: DifficultyLevel.beginner,
                    label: Text('Beginner'),
                    icon: Icon(Icons.soup_kitchen),
                  ),
                  ButtonSegment(
                    value: DifficultyLevel.intermediate,
                    label: Text('Intermediate'),
                    icon: Icon(Icons.restaurant),
                  ),
                  ButtonSegment(
                    value: DifficultyLevel.expert,
                    label: Text('Expert'),
                    icon: Icon(Icons.emoji_events),
                  ),
                ],
                selected: {context.watch<RecipeFormProvider>().difficultyLevel},
                onSelectionChanged: (Set<DifficultyLevel> newSelection) {
                  context.read<RecipeFormProvider>().setDifficultyLevel(
                    newSelection.first,
                  );
                },
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Is Favorite?'),
                  Checkbox(
                    value: isFavourite,
                    onChanged: (value) {
                      setState(() {
                        isFavourite = value!;
                      });
                      context.read<RecipeFormProvider>().setIsFavorite(
                        isFavourite,
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              NextButton(label: 'Save', onPressed: _saveTimes),
              const SizedBox(height: 10),

              Card(
                color: Colors.deepPurple.shade50,
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    if (context.watch<RecipeFormProvider>().prepTime != 10)
                      ListTile(
                        leading: const Icon(
                          Icons.title,
                          color: Colors.deepPurple,
                        ),
                        title: const Text("Preperation time required:"),
                        subtitle: Text(
                          context
                              .watch<RecipeFormProvider>()
                              .prepTime
                              .toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),

                    if (context.watch<RecipeFormProvider>().prepTime != 10 &&
                        context.watch<RecipeFormProvider>().cookTime != 10)
                      const Divider(height: 1),

                    if (context.watch<RecipeFormProvider>().cookTime != 10)
                      ListTile(
                        leading: const Icon(
                          Icons.description,
                          color: Colors.deepPurple,
                        ),
                        title: const Text("Cooking Time required:"),
                        subtitle: Text(
                          context
                              .watch<RecipeFormProvider>()
                              .cookTime
                              .toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
