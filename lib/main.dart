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

  final _lyrics = "愛想振りまく\n本能うずまく\n涙見せて、弱音はいて、\nジェノベーゼが大好きな";
  String _letter = "";
  int _pointer = 0;

  @override
  void initState() {
    _letter = _lyrics[_pointer];
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
            backgroundColor: Colors.black,
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
                const Padding(padding: EdgeInsets.all(16.0)),
                kanjiCard(_letter),
                const Padding(padding: EdgeInsets.all(16.0)),
                RichText(
                    text: TextSpan(
                      text: _lyrics.substring(0, _pointer),
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 26,
                          letterSpacing: 2,
                          fontFamily: 'Open Sans'),
                      children: <TextSpan>[
                        TextSpan(
                            text: _lyrics.substring(_pointer, _pointer + 1),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red
                            )),
                        TextSpan(text: _lyrics.substring(_pointer + 1, _lyrics.length)),
                      ]),
                ),
                const Padding(padding: EdgeInsets.all(16.0)),
                Row(
                  children: <Widget>[
                    const Spacer(),
                    ElevatedButton(
                        onPressed: goBack, child: const Text('Back')),
                    ElevatedButton(
                        onPressed: goFoward, child: const Text('Next')),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void goBack() {
    if (_pointer > 0) {
      setState(() {
        _letter = _lyrics[--_pointer];
      });
    }
  }

  void goFoward() {
    if (_pointer < _lyrics.length - 1) {
      setState(() {
        _letter = _lyrics[++_pointer];
      });
    }
  }

  // Wraps an animated kanji into a card with fixed height.
  Widget kanjiCard(String kanji) =>
      Card(child: SizedBox(height: 300, child: KanjiDrawingAnimation(kanji)));
}
