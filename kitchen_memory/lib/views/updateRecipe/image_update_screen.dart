import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitchen_memory/Provider/recipe_provider.dart';
import 'package:kitchen_memory/models/recipe_model.dart';
import 'package:kitchen_memory/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class ImageUpdateScreen extends StatefulWidget {
  //why we declare this variables : we declare it so we can take recipe model as input
  //from constructor
  final RecipeModel recipeModel;
  const ImageUpdateScreen({super.key, required this.recipeModel});

  @override
  State<ImageUpdateScreen> createState() => _ImageUpdateScreenState();
}

class _ImageUpdateScreenState extends State<ImageUpdateScreen> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final imgPath = widget.recipeModel.imagePath;
    _selectedImage = File(imgPath);
  }

  Future<void> _pickImage(ImageSource image) async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: image);
    if (pickedImage == null) return;
    setState(() => _selectedImage = File(pickedImage.path));
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_rounded),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateImage() async {
    final newRecipeModel = RecipeModel(
      title: widget.recipeModel.title,
      description: widget.recipeModel.description,
      ingredients: widget.recipeModel.ingredients,
      steps: widget.recipeModel.steps,
      cookTime: widget.recipeModel.cookTime,
      prepTime: widget.recipeModel.prepTime,
      difficultyLevel: widget.recipeModel.difficultyLevel,
      isFavourite: widget.recipeModel.isFavourite,
      ratings: widget.recipeModel.ratings,
      imagePath: _selectedImage!.path,
      createdAt: widget.recipeModel.createdAt,
      updatedAt: DateTime.now(),
      note: widget.recipeModel.note,
      sourceUrl: widget.recipeModel.sourceUrl,
    );

    // newRecipeModel.id = widget.recipeModel.id;

    context.read<RecipeProvider>().updateRecipe(
      newRecipeModel,
      widget.recipeModel.key,
    );

    var snackBarController = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.done, color: Colors.white),
            const SizedBox(width: 10),
            Text('Image Saved!', style: TextStyle(fontSize: 20)),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );

    await snackBarController.closed;

    // ignore: use_build_context_synchronously
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Title')),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            GestureDetector(
              onTap: _showImagePickerOptions,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _selectedImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            'Tap to add recipe photo',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: Image.file(_selectedImage!, fit: BoxFit.cover),
                      ),
              ),
            ),

            const SizedBox(height: 10),

            ReusableButton(label: 'Update Image', onPressed: _updateImage),
          ],
        ),
      ),
    );
  }
}
