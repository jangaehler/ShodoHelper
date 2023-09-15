import 'package:flutter/material.dart';

import 'kanji_drawing_animation.dart';

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
  late AnimationController controller;

  final _lyrics = "愛想振りまく\n本能うずまく\n涙見せて、弱音はいて、\nジェノベーゼが大好きな\n本能うずまく\n涙見せて、弱音はいて、\nジェノベーゼが大好きな";
  String _letter = "";
  int _pointer = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    _letter = _lyrics[_pointer];
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
    controller.forward();
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
        child: Container(
          width: 350,
          height: 350,
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(16.0)),
              kanjiCard(_letter),
              const Padding(padding: EdgeInsets.all(16.0)),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: RichText(
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
                                  color: Colors.red)),
                          TextSpan(
                              text: _lyrics.substring(
                                  _pointer + 1, _lyrics.length)),
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
            icon: Icon(Icons.navigate_next),
            label: 'Next'
          ),
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
    });
  }

  void goBack() {
    if (_pointer > 0) {
      setState(() {
        _letter = _lyrics[--_pointer];
        controller.reset();
        controller.forward();
      });
    }
  }

  void goFoward() {
    if (_pointer < _lyrics.length - 1) {
      setState(() {
        _letter = _lyrics[++_pointer];
        controller.reset();
        controller.forward();
      });
    }
  }

  Widget kanjiCard(String kanji) => Card(
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
