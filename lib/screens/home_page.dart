import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:writing_helper/screens/lyrics_page.dart';

import '../main.dart';
import '../widgets/kanji_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage>  with TickerProviderStateMixin {
  String newContent = ''; // textfield content
  var txtController = TextEditingController();
  late AnimationController controller;
  String _lyric = "古池や\n蛙飛び込む\n水の音";
  String _letter = "猫";
  int _pointer = 0;
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    final database = ref.watch(lyricsDBProvider);
    /*var lyrics = await database.getAllLyrics();
    _lyric = lyrics.first.content!;
    _letter = _lyric[_pointer];*/
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
    controller.forward();
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
        child: Container(
          width: 350,
          height: 350,
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(16.0)),
              KanjiCard(kanji: _letter, controller: controller),
              const Padding(padding: EdgeInsets.all(16.0)),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: RichText(
                    text: TextSpan(
                        text: _lyric?.substring(0, _pointer),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 26,
                            letterSpacing: 2,
                            fontFamily: 'Open Sans'),
                        children: <TextSpan>[
                          TextSpan(
                              text: _lyric?.substring(_pointer, _pointer + 1),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                          TextSpan(
                              text: _lyric?.substring(
                                  _pointer + 1, _lyric?.length)),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.navigate_before),
            label: 'Back',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.navigate_next), label: 'Next'),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        goBack();
      }
      if (_selectedIndex == 1) {
        goFoward();
      }
      if (_selectedIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LyricsPage()),
        );
      }
    });
  }

  void goBack() {
    if (_pointer > 0) {
      setState(() async {
        _letter = _lyric![--_pointer];
        controller.reset();
        controller.forward();
      });
    }
  }

  void goFoward() {
    if (_pointer < _lyric!.length - 1) {
      setState(() {
        _letter = _lyric![++_pointer];
        controller.reset();
        controller.forward();
      });
    }
  }
}