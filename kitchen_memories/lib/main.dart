import 'package:flutter/material.dart';
import 'package:k/Provider/recipe_form_provider.dart';
import 'package:k/Provider/recipe_provider.dart';
import 'package:k/views/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
        ChangeNotifierProvider(create: (_) => RecipeFormProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
