import 'package:flutter/material.dart';
import 'package:k/Provider/recipe_form_provider.dart';
import 'package:k/views/widgets/filled_elevated_button.dart';
import 'package:k/views/widgets/list_card.dart';
import 'package:provider/provider.dart';

class Form2 extends StatefulWidget {
  const Form2({super.key});

  @override
  State<Form2> createState() => _Form2State();
}

class _Form2State extends State<Form2> {
  final TextEditingController _ingredientController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _ingredientController.dispose();
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
            ],
          ),
        ),
      ),
    );
  }
}
