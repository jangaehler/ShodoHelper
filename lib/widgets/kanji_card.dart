import 'package:flutter/material.dart';

import '../kanji_drawing_animation.dart';

class KanjiCard extends StatelessWidget {
  final String kanji;
  late AnimationController controller;

  KanjiCard({super.key, required this.kanji, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white.withOpacity(0.7),
        child: Container(
            height: 350,
            width: 350,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/quadrat.png"),
                  fit: BoxFit.cover,
                  opacity: 0.5),
            ),
            child: KanjiDrawingAnimation(kanji,
                penRadius: 6,
                penColor: const Color(0x33D84315),
                controller: controller)));
  }
}