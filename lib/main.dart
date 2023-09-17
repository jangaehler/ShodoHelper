import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/strings.dart';
import 'data/drift_db.dart';
import 'screens/home_page.dart';

void main() {
  runApp(ProviderScope(child: ShodoHelper()));
}

// create provider we will be able to use everywhere on app
final lyricsDBProvider = Provider.autoDispose((ref) => LyricsDatabase());

class ShodoHelper extends StatelessWidget {
  const ShodoHelper({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: kAppTitle,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

/*class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController controller;
  late LyricsDatabase database;

  String _lyric = " ";
  String _letter = "";
  int _pointer = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    _letter = _lyric[_pointer];
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
    controller.forward();
    super.initState();
    _pageController = PageController();
  }
}*/
