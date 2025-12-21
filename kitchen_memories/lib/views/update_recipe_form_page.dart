import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:k/Provider/recipe_provider.dart';
import 'package:k/models/recipe_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k/views/home_page.dart';
import 'package:provider/provider.dart';

class UpdateRecipeFormPage extends StatefulWidget {
  //why we declare this variables : we declare it so we can take those as an input from constructor
  final int id;
  final String title;
  final String description;
  final List<String> ingredients;
  final List<String> steps;
  final int cookTime;
  final int prepTime;
  final DifficultyLevel difficultyLevel;
  final bool isFavourite;
  final int ratings;
  final String imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String note;
  final String sourceUrl;

  const UpdateRecipeFormPage({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.cookTime,
    required this.prepTime,
    required this.difficultyLevel,
    required this.isFavourite,
    required this.ratings,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.note,
    required this.sourceUrl,
  });

  @override
  State<UpdateRecipeFormPage> createState() => _UpdateRecipePageState();
}

class _UpdateRecipePageState extends State<UpdateRecipeFormPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.

  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<TextEditingController> steps = [];
  List<TextEditingController> ingredients = [];
  TextEditingController cookTimeController = TextEditingController();
  TextEditingController prepTimeController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController sourceUrlController = TextEditingController();
  DifficultyLevel? _selectedRecipeDifficultyLevel;
  bool isFavorite = false;
  int? _currentRating;
  File? _selectedImage;

  //initState is useful for setting up initial values of variables
  @override
  void initState() {
    super.initState();

    //initializing steps & ingredients fiel with 1 field
    _addStepsInputField();
    _addIngredientsInputField();

    //initialize controller values
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
    cookTimeController = TextEditingController(
      text: widget.cookTime.toString(),
    );
    prepTimeController = TextEditingController(
      text: widget.prepTime.toString(),
    );
    noteController = TextEditingController(text: widget.note);
    sourceUrlController = TextEditingController(text: widget.sourceUrl);
    _selectedRecipeDifficultyLevel = widget.difficultyLevel;
    isFavorite = widget.isFavourite;
    _currentRating = widget.ratings;
    _selectedImage = File(widget.imagePath);
    steps = widget.steps.map((e) => TextEditingController(text: e)).toList();
    ingredients = widget.ingredients
        .map((e) => TextEditingController(text: e))
        .toList();
  }

  //--helper methods
  void _addStepsInputField() {
    setState(() {
      steps.add(TextEditingController());
    });
  }

  void _addIngredientsInputField() {
    setState(() {
      ingredients.add(TextEditingController());
    });
  }

  void _removeStepsInputField(int index) {
    //1. we free memory taken by controller -> application runs smoothly
    steps[index].dispose();

    //2. trigger rebuilding of UI because of internal state changed
    setState(() {
      //3. we remove controller at perticular index because it is a controller associated
      //with deleted step
      steps.removeAt(index);

      // if all steps fields are deleted
      // atleast 1 empty step field should be there
      if (steps.isEmpty) {
        _addStepsInputField();
      }
    });
  }

  void _removeIngredientsInputField(int index) {
    ingredients[index].dispose();

    setState(() {
      ingredients.removeAt(index);
      if (ingredients.isEmpty) {
        _addIngredientsInputField();
      }
    });
  }

  //--- helper function that converts an enum into List<> of DropdownMenuItem<DifficultyLevel>
  List<DropdownMenuItem<DifficultyLevel>> _buildDropDownItems() {
    return DifficultyLevel.values
        .map(
          (value) => DropdownMenuItem<DifficultyLevel>(
            value: value,
            child: Text(value.name),
          ),
        )
        .toList();
  }

  //function that actually picks the image
  Future<void> _pickImage(ImageSource image) async {
    final picker =
        ImagePicker(); //created instance so that we can use methods of ImagePicker.

    //pick the image
    final XFile? pickedImage = await picker.pickImage(source: image);

    //if user cancels do nothing
    if (pickedImage == null) return;

    //if user does not cancel then update the UI
    setState(() {
      //we've created File object in which we've path of selected image
      _selectedImage = File(pickedImage.path);
    });
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
                  //we call abpve created function that will actually pick an image
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

  List<String>? _ingredientsListConverter() {
    //step 1 : define list
    List<String> ingredientList = [];

    //step 2 : add values in the ingredientList
    for (var controller in ingredients) {
      ingredientList.add(controller.text);
    }

    //step 3 : return list
    return ingredientList;
  }

  List<String>? _stepsListConverter() {
    //step 1 : define list
    List<String>? stepsList = [];

    //step 2 : add values in the ingredientList
    for (var controller in steps) {
      stepsList.add(controller.text);
    }

    //step 3 : return list
    return stepsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.square_pencil_fill, size: 30),
        title: Text('Enter Recipe Details 😋'),
        elevation: 2,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        shadowColor: Colors.black87,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        clipBehavior: Clip.antiAlias,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 5),

                //---title input field
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                //---description input field
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 5),
                Divider(),

                //--- ingredients input fields
                //build the list of TextFormFields dynamically
                ...ingredients.asMap().entries.map((entry) {
                  final index = entry.key;
                  final currentController = entry.value;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        //---dynamic input fields
                        Expanded(
                          child: TextFormField(
                            controller: currentController,
                            decoration: InputDecoration(
                              label: Text("Ingredient ${index + 1}"),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the ingredient!";
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(width: 5),

                        GestureDetector(
                          onTap: () => _removeIngredientsInputField(index),
                          child: ingredients.length > 1
                              ? Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.remove_circle_rounded,
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox(width: 40, height: 40),
                        ),
                      ],
                    ),
                  );
                }),

                //---global add new ingredient button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _addIngredientsInputField(),
                      label: Text('Add a new Ingredient'),
                      icon: Icon(CupertinoIcons.add_circled_solid),
                    ),
                  ],
                ),

                const SizedBox(height: 5),
                Divider(),

                //--- steps input fields
                //build the list of TextFormFields dynamically
                ...steps.asMap().entries.map((entry) {
                  final index = entry.key;
                  final currentController = entry.value;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        //---dynamic input field
                        Expanded(
                          child: TextFormField(
                            controller: currentController,
                            decoration: InputDecoration(
                              labelText: "Step ${index + 1}",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the step!";
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(width: 5),

                        //---minus btn
                        GestureDetector(
                          onTap: () => _removeStepsInputField(index),
                          //show Minus button only if there is more than 1 field
                          child: steps.length > 1
                              ? Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.remove_circle_rounded,
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox(height: 40, width: 40),
                        ),
                      ],
                    ),
                  );
                }),

                //---globle add new step button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _addStepsInputField,
                      icon: Icon(CupertinoIcons.plus_circle_fill),
                      label: const Text('Add a new step'),
                    ),
                  ],
                ),

                const SizedBox(height: 5),
                Divider(),

                //integer only form field for preparation time
                TextFormField(
                  controller: cookTimeController,
                  decoration: InputDecoration(
                    label: Text('Cook Time (minutes)'),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number, //opens numeric keyboard
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter average cook time required!";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                //integer only form field for preparation time
                TextFormField(
                  controller: prepTimeController,
                  decoration: InputDecoration(
                    label: Text('Preparation Time (minutes)'),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number, //opens numeric keyboard
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter average cook time required!";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 5),

                Divider(),

                //---Drop down button for letting user choose from various options
                Text('Experience required for cooking this recipe:'),
                DropdownButtonFormField<DifficultyLevel>(
                  items: _buildDropDownItems(),
                  icon: Icon(Icons.arrow_downward_rounded),
                  value: _selectedRecipeDifficultyLevel,
                  onChanged: (value) {
                    setState(() {
                      if (value is DifficultyLevel) {
                        _selectedRecipeDifficultyLevel = value;
                      }
                    });
                  },
                ),

                const SizedBox(height: 10),

                //---check box for isFavorite field
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Is Favorite?'),
                    Checkbox(
                      value: isFavorite,
                      onChanged: (bool? value) {
                        setState(() {
                          isFavorite = value!;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                //---rating widget using 'flutter_rating_bar' package from pub.dev
                Text('Rating for this recipe:'),
                RatingBar.builder(
                  initialRating: 2,
                  minRating: 1,
                  maxRating: 5,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) =>
                      Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _currentRating = rating.toInt();
                    });
                  },
                ),

                const SizedBox(height: 10),

                //---image picker
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _selectedImage == null
                      ? const Center(child: Text('No Image Selected'))
                      : ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          child: Image.file(_selectedImage!, fit: BoxFit.cover),
                        ),
                ),

                const SizedBox(height: 10),

                OutlinedButton.icon(
                  onPressed: _showImagePickerOptions,
                  label: const Text('Pick an image'),
                  icon: Icon(Icons.image_rounded),
                ),

                const SizedBox(height: 10),

                //---
                TextFormField(
                  controller: noteController,
                  decoration: InputDecoration(
                    label: const Text('Note'),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter text!';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                //---
                TextFormField(
                  controller: sourceUrlController,
                  decoration: InputDecoration(
                    label: const Text('Source URL'),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter URL!';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                Row(
                  spacing: 23,
                  children: [
                    SizedBox(
                      width: 162,
                      child: FloatingActionButton(
                        heroTag: 'hero_1',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        backgroundColor: Colors.greenAccent,
                        child: const Text(
                          textAlign: TextAlign.center,
                          'Cancel Update',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 162,
                      child: FloatingActionButton(
                        heroTag: 'hero_2',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final int cookTime = int.parse(
                              cookTimeController.text,
                            );
                            final int prepTime = int.parse(
                              prepTimeController.text,
                            );

                            final newRecipeObject = RecipeModel(
                              titleController.text,
                              descriptionController.text,
                              _ingredientsListConverter(),
                              _stepsListConverter(),
                              cookTime,
                              prepTime,
                              _selectedRecipeDifficultyLevel!,
                              isFavorite,
                              _currentRating ?? 1,
                              _selectedImage!.path,
                              DateTime.now(),
                              DateTime.now(),
                              noteController.text,
                              sourceUrlController.text,
                            );
                            debugPrint('Update btn');

                            newRecipeObject.id = widget.id;
                            debugPrint('New Recipe Id is ${widget.id}.');

                            context.read<RecipeProvider>().updateRecipe(
                              newRecipeObject,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        },
                        backgroundColor: Colors.amberAccent,
                        child: const Text(
                          textAlign: TextAlign.center,
                          'Update Recipe!',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
