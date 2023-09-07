import 'dart:io';

import 'package:flutter/material.dart';

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
  int _selectedIndex = 0;

  @override
  void initState() {
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
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.white.withOpacity(0.5),
            child: SizedBox(
              width: 250,
              height: 250,
              child: Column(
                children: [
                  ListTile(
                    title: Text('猫かぶり',
                      style: TextStyle(color: Colors.white.withOpacity(0.6)),
                    ),
                    subtitle: Text(
                      'Mutant Monster',
                      style: TextStyle(color: Colors.white.withOpacity(0.6)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                  ),
                  Image.asset('assets/images/bg.jpg',
                    height: 250,
                    width: 250,
                    fit: BoxFit.fitWidth,
                  ),
                  Text("愛想振りまく\n\n本能うずまく\n\n涙見せて、弱音はいて、\n\nジェノベーゼが大好きな\n\n",
                  style:
                    TextStyle(color: Colors.white.withOpacity(0.6))
                  )

                ],
              ),
            ),
          ),
        ));
  }
}
