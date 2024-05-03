import 'package:flutter/material.dart';
import 'package:svg_drawing_animation/svg_drawing_animation.dart';

class KanjiDrawingAnimation extends StatelessWidget {
  static const Color _color = Color(0x8A000000);
  const KanjiDrawingAnimation(this.kanji,
      { this.speed = 2,
        this.curve = Curves.decelerate,
        this.useLocalSvg = true,
        this.penRadius = 15,
        this.penColor = _color,
        this.controller,
        super.key,
      })
      : assert(kanji.length == 1);

  final String kanji;
  final double speed;
  final Curve curve;
  final bool useLocalSvg;
  final double penRadius;
  final Color penColor;
  final AnimationController? controller;

  @override
  Widget build(BuildContext context) {
    final filename = kanji.codeUnits.first.toRadixString(16).padLeft(5, '0');
    final key =
        'assets/kanjivg/kanji/$filename.svg';
    return SvgDrawingAnimation(
      SvgProvider.asset(key),
      repeats: true,
      curve: curve,
      animation: controller,
      refresh: true,
      errorWidgetBuilder: (context, error, stackTrace) =>
          Text('No kanji stroke information for $kanji'),
      penRenderer: CirclePenRenderer(
          radius: penRadius,
          paint: Paint()..color = penColor)
    );
  }
}
