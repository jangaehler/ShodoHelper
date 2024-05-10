
import 'package:flutter_test/flutter_test.dart';
import 'package:shodo_helper/Models/lyric.dart';
import 'package:shodo_helper/screens/home_page.dart';

void main() {
  group('Tests for the getKanji function', () {
    late MyHomePageState pageState;

    setUp(() {
      pageState = MyHomePageState();
      pageState.lyric.fullLyric = 'fsdfsf';
    });

    test('Initial call with MoveKanji.init', () {
      final Lyric result = pageState.getKanji(MoveKanji.init);
      // here you validate the result for the initial state
    });

    test('Call with MoveKanji.go when _position < length - 1', () {
      pageState.position = 0;
      final Lyric result = pageState.getKanji(MoveKanji.go);

    });

    test('Call with MoveKanji.go when _position is at the end of the string', () {
      pageState.position = pageState.lyric.fullLyric!.length - 1;
      final Lyric result = pageState.getKanji(MoveKanji.go);
      // Validate the result for the state at the end of the string
    });

    test('Call with MoveKanji.back when _position > 0', () {
      pageState.position = 1;
      final Lyric result = pageState.getKanji(MoveKanji.back);
      // Validate the result for the state after moving back
    });

    test('Call with MoveKanji.back when _position is at the start of the string', () {
      pageState.position = 0;
      final Lyric result = pageState.getKanji(MoveKanji.back);
      // Validate the result for the state at the start of the string
    });
  });
}