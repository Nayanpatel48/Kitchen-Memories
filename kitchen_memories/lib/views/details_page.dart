import 'dart:io';
import 'package:flutter/material.dart';
import 'package:k/models/recipe_model.dart';
import 'package:k/views/updateRecipe/main_update_form.dart';
import 'package:k/views/widgets/next_button.dart';

class DetailsPage extends StatefulWidget {
  final RecipeModel recipeModel;
  const DetailsPage({super.key, required this.recipeModel});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  void _navigateToUpdateRecipeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainUpdateForm(recipeModel: widget.recipeModel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                // ignore: deprecated_member_use
                backgroundColor: Colors.white.withOpacity(0.9),
                child: BackButton(
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            expandedHeight: 300.0,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              expandedTitleScale: 1.1,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: Hero(
                tag: 'title-${widget.recipeModel.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.recipeModel.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      shadows: [Shadow(blurRadius: 8, color: Colors.black54)],
                    ),
                  ),
                ),
              ),
              background: _buildImageWithPlaceholder(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsRow(),
                  const SizedBox(height: 20),
                  Text(
                    widget.recipeModel.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const Divider(height: 40),
                  _buildSectionTitle("Ingredients"),
                  ..._buildIngredientsList(),
                  const Divider(height: 40),
                  _buildSectionTitle("Instructions"),
                  ..._buildStepsList(),
                  const SizedBox(height: 30),
                  NextButton(
                    label: 'Update Recipe!',
                    onPressed: _navigateToUpdateRecipeScreen,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWithPlaceholder() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Colors.amber[100]),

        Hero(
          tag:
              'image-${widget.recipeModel.id}', // Match this tag in your List View
          child: widget.recipeModel.imagePath.isEmpty
              ? const Icon(Icons.fastfood, size: 50, color: Colors.grey)
              : Image.file(
                  File(widget.recipeModel.imagePath),
                  fit: BoxFit.cover,
                  frameBuilder: (context, child, frame, wasSync) {
                    if (wasSync) return child;
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: frame == null
                          ? Container(color: Colors.grey[200])
                          : child,
                    );
                  },
                ),
        ),
        // 3. A subtle gradient so white text is always readable over any image
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black45],
            ),
          ),
        ),
      ],
    );
  }

  // Separated logic for cleaner build method
  List<Widget> _buildIngredientsList() {
    return widget.recipeModel.ingredients!
        .map(
          (ingredient) => ListTile(
            leading: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 20,
            ),
            title: Text(ingredient),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        )
        .toList();
  }

  List<Widget> _buildStepsList() {
    return widget.recipeModel.steps!.asMap().entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 10,
              child: Text(
                "${entry.key + 1}",
                style: const TextStyle(fontSize: 10),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(entry.value)),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildIconInfo(
          Icons.timer,
          "${widget.recipeModel.prepTime + widget.recipeModel.cookTime} min",
        ),
        _buildIconInfo(
          Icons.bar_chart,
          widget.recipeModel.difficultyLevel.name,
        ),
        _buildIconInfo(Icons.star, "${widget.recipeModel.ratings}/5"),
      ],
    );
  }

  Widget _buildIconInfo(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.amber[800]),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
