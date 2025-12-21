import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final String subtitleText;
  final VoidCallback onRemove;

  const ListCard({
    super.key,
    required this.subtitleText,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.amberAccent,
        shadowColor: Colors.black87,
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            ListTile(
              subtitle: Text(
                subtitleText,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: TextButton.icon(
                onPressed: onRemove,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                ),
                icon: Icon(Icons.delete, color: Colors.white),
                label: Text('Remove', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
