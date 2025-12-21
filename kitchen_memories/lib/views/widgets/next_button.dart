import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const NextButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        side: const BorderSide(color: Colors.deepPurple, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        foregroundColor: Colors.deepPurple,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      child: Text(label),
    );
  }
}
