import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:writing_helper/app_states/nav_states/nav_notifier.dart';
import 'package:writing_helper/screens/lyrics_page.dart';

import '../main.dart';
import '../widgets/kanji_card.dart';

class HomePage extends HookConsumerWidget {
  String newContent = '';
  var txtController = TextEditingController();
  late AnimationController controller;

  static final List<Widget> _widgetOptions = <Widget>[
    const LyricsPage(),
    const Padding(padding: EdgeInsets.all(16.0)),
    const LyricsPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(selectedLyricProvider);
    final pointer = ref.watch(positionProvider);
    var navIndex = ref.watch(navProvider);
    controller = useAnimationController(duration: const Duration(seconds: 4));
    controller.forward();
    return Scaffold(
      body: GestureDetector (
          onTap: () {
            nextLetter(ref);
          },
          onDoubleTap: () {
            prefLetter(ref);
          },
          child: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover),
        ),
        child: Container(
            width: 350,
            height: 350,
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(16.0)),
                const Padding(padding: EdgeInsets.all(16.0)),
                KanjiCard(kanji: text[pointer], controller: controller),
                const Padding(padding: EdgeInsets.all(16.0)),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: RichText(
                      text: TextSpan(
                          text: text?.substring(0, pointer),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 26,
                              letterSpacing: 2,
                              fontFamily: 'Open Sans'),
                          children: <TextSpan>[
                            TextSpan(
                                text: text?.substring(pointer, pointer + 1),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            TextSpan(
                                text: text?.substring(pointer + 1, text?.length)),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.gamepad), label: 'Play'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: navIndex.index,
        selectedItemColor: Colors.red[800],
        onTap: (value) {
          ref.read(navProvider.notifier).onIndexChanged(value);
        },
      ),
    );
  }

  void prefLetter(WidgetRef ref) {

    ref.read(positionProvider.notifier).state--;
    controller.reset();
    controller.forward();
  }

  void nextLetter(WidgetRef ref) {
    ref.read(positionProvider.notifier).state++;
    controller.reset();
    controller.forward();
  }
}
