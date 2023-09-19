import 'package:flutter/material.dart';

import '../constants/constants.dart';

class LyricItemCard extends StatelessWidget {
  final String content;

  const LyricItemCard({super.key, required this.content});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5.0,
          color: kdarkColor,
          child: Text(content,
            style: kTodoItemCardStyle,
          ),
        ),
      ),
    );
  }
}
