import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitchen_memory/Provider/recipe_form_provider.dart';
import 'package:kitchen_memory/views/widgets/next_button.dart';
import 'package:provider/provider.dart';

class Form5 extends StatefulWidget {
  const Form5({super.key});

  @override
  State<Form5> createState() => _Form5State();
}

class _Form5State extends State<Form5> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final imgPath = context.read<RecipeFormProvider>().imagePath;
    if (imgPath != null) {
      _selectedImage = File(imgPath);
    }
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

  void _saveImage() {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline_rounded, color: Colors.white),
              const SizedBox(width: 10),
              Text('Please select an image!', style: TextStyle(fontSize: 20)),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      context.read<RecipeFormProvider>().imagePath = _selectedImage!.path;
      final imgPath = context.read<RecipeFormProvider>().imagePath;
      debugPrint(imgPath);
      ScaffoldMessenger.of(context).showSnackBar(
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Rating?', style: TextStyle(fontSize: 20)),

                RatingBar.builder(
                  initialRating: context
                      .read<RecipeFormProvider>()
                      .ratings
                      .toDouble(),
                  minRating: 1,
                  maxRating: 5,
                  itemSize: 50,
                  direction: Axis.horizontal,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    context.read<RecipeFormProvider>().ratings = rating.toInt();
                    final newRating = context
                        .read<RecipeFormProvider>()
                        .ratings;
                    debugPrint('$newRating');
                  },
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Note : After selecting an image, must click \nsave image.',
                  style: TextStyle(
                    backgroundColor: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

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

            ReusableButton(label: 'Save Image', onPressed: _saveImage),
          ],
        ),
      ),
    );
  }
}
