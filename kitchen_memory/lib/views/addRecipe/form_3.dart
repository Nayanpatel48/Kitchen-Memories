import 'package:flutter/material.dart';
import 'package:kitchen_memory/Provider/recipe_form_provider.dart';
import 'package:kitchen_memory/views/widgets/filled_elevated_button.dart';
import 'package:kitchen_memory/views/widgets/list_card.dart';
import 'package:provider/provider.dart';

class Form3 extends StatefulWidget {
  const Form3({super.key});

  @override
  State<Form3> createState() => _Form3State();
}

class _Form3State extends State<Form3> {
  final TextEditingController _stepsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _stepsController.dispose();
    super.dispose();
  }

  void _addStepOperation() {
    if (_formKey.currentState!.validate()) {
      final y = context.read<RecipeFormProvider>().stepAddition(
        _stepsController.text,
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
      debugPrint("Step Added ${context.read<RecipeFormProvider>().steps}");
    }
  }

  void _removeStepOperation(String stepName) {
    context.read<RecipeFormProvider>().removeStep(stepName);
    debugPrint("Step deleted!");
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
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _stepsController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Step is missing!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a step:',
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
                    if (provider.steps == null || provider.steps!.isEmpty) {
                      return const Center(child: Text('No steps found!'));
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
            ],
          ),
        ),
      ),
    );
  }
}
