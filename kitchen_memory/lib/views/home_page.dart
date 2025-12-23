import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchen_memory/Provider/recipe_provider.dart';
import 'package:kitchen_memory/views/addRecipe/main_form.dart';
import 'package:kitchen_memory/views/widgets/recipe_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kitchen Memory',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              // We wrap ONLY the dynamic content in a Consumer
              Expanded(
                child: Consumer<RecipeProvider>(
                  builder: (context, recipeProvider, child) {
                    // This builder only runs when RecipeProvider calls notifyListeners()

                    if (recipeProvider.recipes.isEmpty) {
                      return const Center(child: Text('No Recipes'));
                    }

                    // return ListView.builder(
                    //   itemCount: recipeProvider.recipes.length,
                    //   itemBuilder: (context, index) {
                    //     final recipe = recipeProvider.recipes[index];
                    //     return RecipeCard(recipe: recipe);
                    //   },
                    // );
                    return GridView.builder(
                      padding: EdgeInsets.all(12),
                      itemCount: recipeProvider.recipes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.75,
                          ),
                      itemBuilder: (context, index) {
                        final recipe = recipeProvider.recipes[index];
                        return RecipeCard(recipe: recipe);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const MainForm()));
        },
        label: const Text("Add Recipe"),
        icon: const Icon(CupertinoIcons.pencil_circle_fill),
      ),
    );
  }
}
