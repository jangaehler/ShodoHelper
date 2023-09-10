import 'package:flutter/material.dart';
import 'package:kanji_drawing_animation/kanji_drawing_animation.dart';


void main() {
  runApp(ShodoHelper());
}

class ShodoHelper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;

  final lyrics = "愛想振りまく\n本能うずまく\n涙見せて、弱音はいて、\nジェノベーゼが大好きな";
  String letter = "";
  int pointer = 0;

  @override
  void initState() {
    letter = lyrics[pointer];
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Shodo Helper"),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover),
          ),
          child: SizedBox(
            width: 350,
            height: 350,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                wrap(letter),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                Text(lyrics,
                    style:
                    TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 26,
                        letterSpacing: 2,
                        fontFamily: 'Open Sans'
                    )
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                Row(
                  children: <Widget>[
                    const Spacer(),
                    ElevatedButton(
                        onPressed: goBack,
                        child: const Text('Back')
                    ),
                    ElevatedButton(
                        onPressed: goFoward,
                        child: const Text('Next')
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void goBack() {
    if (pointer > 0) {
      pointer--;
      setState(() {letter = lyrics[pointer];});
    }
  }

  void goFoward() {
    if (pointer <= lyrics.length) {
      pointer++;
      setState(() {letter = lyrics[pointer];});
    }
  }

  // Wraps an animated kanji into a card with fixed height.
  Widget wrap(String kanji) =>
      Card(child: SizedBox(height: 300, child: KanjiDrawingAnimation(kanji)));
}
