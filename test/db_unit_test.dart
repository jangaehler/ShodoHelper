import 'package:flutter_test/flutter_test.dart';
import 'package:writing_helper/data/drift_db.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LyricsDatabase database; // late is used for null safety,
  //because of the setup/teardown lifecycle,
  //late should be safe here since tests
  //should always run setup before teardown,
  //thus ensuring that database is assigned
  //before tearDown is run

  setUp(() {
    database =
        LyricsDatabase(); //NativeDatabase.memory() -> create database in memory and does not save to disk
  });

  tearDown(() async {
    await database.close();
  });

  //CREATE
  test('lyrics can be created', () async {
    final id = await database
        .insertNewLyric(const Lyric(id: 1, content: 'lyric number 1'));
    final lyric = await database.watchLyricWithId(id).first;
    expect(lyric.content, 'lyric number 1');
  });

//READ
  test('lyrics can be read', () async {
    final lyricsList = await database.getAllLyrics();
    expect(lyricsList, [const Lyric(id: 1, content: 'lyric number 1')]);
  });

  //UPDATE
  // did not use an update feature on app, but can test it can be done with written queries
  // might be a good idea to update based on ids
  test('lyrics can be updated', () async {
    await database
        .updateNewLyric(const Lyric(id: 1, content: 'lyric number 1 updated'));
    final lyricsList = await database.getAllLyrics();
    final match = [const Lyric(id: 1, content: 'lyric number 1 updated')];

    expect(lyricsList, match);
  });

  //DELETE

  test('lyrics can be deleted', () async {
    await database
        .deleteLyric(const Lyric(id: 1, content: 'lyric number 1 updated'));

    final lyricsList = await database.getAllLyrics();
    final match = [];
    expect(lyricsList, match);
  });

  test('A Haiku should be added to the db', () async {
     // Create a Lyric and add it to the Lyrics table
     var haiku = const Lyric(
         id: 4,
         content: '古池や\n蛙飛び込む\n水の音',
         artist:'Matsuo Bashō - 松尾芭蕉',
          lang: 'jp',);

     database.insertNewLyric(haiku);

     final lyricsList = await database.getAllLyrics();
     final match = [haiku];
     expect(lyricsList, match);
  });
}