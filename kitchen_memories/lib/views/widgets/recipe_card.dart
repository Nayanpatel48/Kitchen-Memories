import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:k/models/recipe_model.dart';
import 'package:k/views/details_page.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 420,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- UPDATED IMAGE SECTION ---
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity, // 1. Force full width
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                clipBehavior:
                    Clip.hardEdge, // 2. Clip the image to rounded corners
                child: Image.file(
                  File(recipe.imagePath),
                  fit: BoxFit.cover, // 3. Cover fills space without distortion
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
            ),

            // -----------------------------
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          recipe.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.time,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${recipe.cookTime + recipe.prepTime} mins",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          CupertinoIcons.speedometer,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          recipe.difficultyLevel.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    // Action Buttons Row
                    Row(
                      children: [
                        // Main Black Button (Navigate)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsPage(recipeModel: recipe),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A1A1A),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 22),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'View Recipe',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Heart / Favorite Button
                        InkWell(
                          onTap: () {
                            // Toggle Favorite Logic
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Icon(
                              recipe.isFavourite
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: recipe.isFavourite
                                  ? Colors.red
                                  : Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
