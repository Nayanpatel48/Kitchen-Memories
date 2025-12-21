import 'package:flutter/material.dart';
import 'package:k/models/recipe_model.dart';
import 'package:k/views/updateRecipe/cooktime_update_screen.dart';
import 'package:k/views/updateRecipe/description_update_screen.dart';
import 'package:k/views/updateRecipe/difficulty_level_update_screen.dart';
import 'package:k/views/updateRecipe/image_update_screen.dart';
import 'package:k/views/updateRecipe/ingredient_update_screen.dart';
import 'package:k/views/updateRecipe/isfavorite_update_screen.dart';
import 'package:k/views/updateRecipe/note_update_screen.dart';
import 'package:k/views/updateRecipe/preptime_update_screen.dart';
import 'package:k/views/updateRecipe/ratings_update_screen.dart';
import 'package:k/views/updateRecipe/sourceurl_update_screen.dart';
import 'package:k/views/updateRecipe/steps_update_screen.dart';
import 'package:k/views/updateRecipe/title_update_screen.dart';

class MainUpdateForm extends StatefulWidget {
  final RecipeModel recipeModel;

  const MainUpdateForm({super.key, required this.recipeModel});
  @override
  State<MainUpdateForm> createState() => _MainUpdateFormState();
}

class _MainUpdateFormState extends State<MainUpdateForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update recipe details')),
      body: ListView(
        children: [
          Card(
            color: Colors.amberAccent,
            shadowColor: Colors.black87,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(
                    'Title',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TitleUpdateScreen(
                            recipeModel: widget.recipeModel,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    label: Text(
                      'edit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.amberAccent,
            shadowColor: Colors.black87,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DescriptionUpdateScreen(
                            recipeModel: widget.recipeModel,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    label: Text(
                      'edit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.amberAccent,
            shadowColor: Colors.black87,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IngredientUpdateScreen(
                            recipeModel: widget.recipeModel,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    label: Text(
                      'edit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.amberAccent,
            shadowColor: Colors.black87,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(
                    'Steps',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StepsUpdateScreen(
                            recipeModel: widget.recipeModel,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    label: Text(
                      'edit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.amberAccent,
            shadowColor: Colors.black87,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(
                    'CookTime',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CookTimeUpdateScreen(
                            recipeModel: widget.recipeModel,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    label: Text(
                      'edit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.amberAccent,
            shadowColor: Colors.black87,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(
                    'PrepTime',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrepTimeUpdateScreen(
                            recipeModel: widget.recipeModel,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    label: Text(
                      'edit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.amberAccent,
            shadowColor: Colors.black87,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(
                    'DifficultyLevel',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DifficultyLevelUpdateScreen(
                            recipeModel: widget.recipeModel,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    label: Text(
                      'edit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.amberAccent,
            shadowColor: Colors.black87,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(
                    'IsFavourite',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IsFavoriteUpdateScreen(
                            recipeModel: widget.recipeModel,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    label: Text(
                      'edit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.amberAccent,
            shadowColor: Colors.black87,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(
                    'Ratings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RatingsUpdateScreen(
                            recipeModel: widget.recipeModel,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    label: Text(
                      'edit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.amberAccent,
            shadowColor: Colors.black87,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(
                    'Image',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageUpdateScreen(
                            recipeModel: widget.recipeModel,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    label: Text(
                      'edit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.amberAccent,
            shadowColor: Colors.black87,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(
                    'Note',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteUpdateScreen(recipeModel: widget.recipeModel),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    label: Text(
                      'edit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.amberAccent,
            shadowColor: Colors.black87,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(
                    'Source URL',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SourceUrlUpdateScreen(
                            recipeModel: widget.recipeModel,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    label: Text(
                      'edit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
