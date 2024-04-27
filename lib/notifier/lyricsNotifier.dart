
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/drift_db.dart';

class LyricsNotifier extends StateNotifier<List<Lyrics>> {
  LyricsNotifier() : super([]);

  void goBack(String lyricId) {
    state = [

    ];
  }
}

final lyricsProvider = StateNotifierProvider<LyricsNotifier, List<Lyrics>>((ref) {
  return LyricsNotifier();
});