import 'package:flutter/material.dart';
import 'package:letsgo_food/theme/style.dart';

class MenuItem extends StatelessWidget {
  final String name;

  const MenuItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          name,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
    );
  }

}
