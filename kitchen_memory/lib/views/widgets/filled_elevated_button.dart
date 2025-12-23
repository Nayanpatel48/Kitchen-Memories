import 'package:flutter/material.dart';

class FilledElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FilledElevatedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        backgroundColor: Colors.deepPurple.shade100,
        foregroundColor: Colors.deepPurple.shade900,
        elevation: 2,
      ),
      child: Icon(Icons.add, size: 32),
    );
  }
}
