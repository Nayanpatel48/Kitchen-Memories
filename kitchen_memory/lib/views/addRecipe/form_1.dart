import 'package:flutter/material.dart';
import 'package:kitchen_memory/Provider/recipe_form_provider.dart';
import 'package:kitchen_memory/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class Form1 extends StatefulWidget {
  const Form1({super.key});

  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveForm1Data() {
    if (_formKey.currentState!.validate()) {
      context.read<RecipeFormProvider>().updateForm1Data(
        _titleController.text,
        _descController.text,
      );
      debugPrint("Form 1 data saved!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.thumb_up_sharp, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                'title & discription saved!',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
    debugPrint("Form 1 button pressed!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
          child: Column(
            children: [
              const SizedBox(height: 10),

              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title is missing!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter recipe name',
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: _descController,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description is missing!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter description',
                ),
              ),

              const SizedBox(height: 10),

              NextButton(label: 'Save', onPressed: _saveForm1Data),

              Card(
                color: Colors.deepPurple.shade50,
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    if (context.watch<RecipeFormProvider>().title != null)
                      ListTile(
                        leading: const Icon(
                          Icons.title,
                          color: Colors.deepPurple,
                        ),
                        title: const Text("Latest Title"),
                        subtitle: Text(
                          context.watch<RecipeFormProvider>().title!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),

                    if (context.watch<RecipeFormProvider>().title != null &&
                        context.watch<RecipeFormProvider>().description != null)
                      const Divider(height: 1),

                    if (context.watch<RecipeFormProvider>().description != null)
                      ListTile(
                        leading: const Icon(
                          Icons.description,
                          color: Colors.deepPurple,
                        ),
                        title: const Text("Latest Description"),
                        subtitle: Text(
                          context.watch<RecipeFormProvider>().description!,
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
