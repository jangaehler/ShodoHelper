import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Models/lyric.dart';
import '../widgets/kanji_card.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late Lyric lyric = Lyric();
  late AnimationController controller;
  int _position = 0;

 @override
  void initState() {
    lyric.fullLyric = '古池や\n蛙飛';
    lyric = getKanji(true);
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    controller.forward();
    _getClipboardText();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _nextLetter() {
    setState(() {
      lyric = getKanji(true);
      controller.reset();
      controller.forward();
    });
  }

  void _prefLetter() {
    setState(() {
      lyric = getKanji(false);
      controller.reset();
      controller.forward();
    });
  }

  Lyric getKanji(bool forward) {
    do {
      if (forward) {
        if (_position < lyric.fullLyric!.length - 1) {
          _position++;
        }
      } else {
        if (_position != 0){
          _position--;
        }
      }

      lyric.actLetter = lyric.fullLyric!.substring(_position, _position + 1);
    }
    while (lyric.actLetter == '\n' || lyric.actLetter == ' ');

    lyric.beforeLetter = lyric.fullLyric!.substring(0, _position);
    lyric.afterLetter = lyric.fullLyric!.substring(_position + 1, lyric.fullLyric!.length);

    return lyric;
  }

  Future<void> _getClipboardText() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    setState(() {
      lyric.fullLyric = data?.text ?? "";
      _position = -1;
      lyric = getKanji(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector (
          onTap: _nextLetter,
          onDoubleTap: _prefLetter,
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover),
            ),
            child: Container(
              width: 350,
              height: 350,
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(40.0)),
                  KanjiCard(kanji: lyric.actLetter ?? '', controller: controller),
                  const Padding(padding: EdgeInsets.all(10.0)),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(30.0),
                      child: RichText(
                        text: TextSpan(
                            text: lyric.beforeLetter,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 20,
                                letterSpacing: 2,
                                fontFamily: 'Open Sans'),
                            children: <TextSpan>[
                              TextSpan(
                                  text: lyric.actLetter,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                              TextSpan(
                                  text: lyric.afterLetter),
                            ]),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(16.0)),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _getClipboardText();
                        },
                        child: Text('Aus der Zwischenablage einfügen'),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(10.0)),
                ],
              ),
            ),
          )
      ),
    );
  }
}
