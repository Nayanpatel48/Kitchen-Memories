import 'package:flutter/material.dart';
import 'package:k/views/details_page.dart';
import 'package:provider/provider.dart';
import '../Provider/recipe_provider.dart' show RecipeProvider;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Controller to handle the text input
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.watch<RecipeProvider>();
    final allRecipes = recipeProvider.recipes;

    // Filter logic: If query is empty, show all; otherwise filter by title
    final filteredRecipes = _searchQuery.isEmpty
        ? allRecipes
        : allRecipes.where((recipe) {
            return recipe.title.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true, // Keyboard pops up immediately
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10,
              ),
              hintText: 'Type a recipe name...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
      ),
      body: filteredRecipes.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 50, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No recipes found!"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: filteredRecipes.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                final recipe = filteredRecipes[index];

                return Card(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(recipe.title[0].toUpperCase()),
                    ),
                    title: Text(recipe.title),
                    subtitle: Text(
                      "Time required for cooking is ${recipe.cookTime} mins.",
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      debugPrint("Clicked on ${recipe.title}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(recipeModel: recipe),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
