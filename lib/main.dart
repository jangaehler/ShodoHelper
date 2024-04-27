import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/strings.dart';
import 'data/drift_db.dart';
import 'screens/home_page.dart';

void main() {
  runApp(ProviderScope(child: ShodoHelper()));
}

final lyricsDBProvider = Provider.autoDispose((ref) => LyricsDatabase());
final selectedLyricProvider = StateProvider<String>((ref) => "古池や\n蛙飛び込む\n水の音");
final positionProvider = StateProvider<int>((ref) => 0);

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
      home: HomePage(),
    );
  }
}
