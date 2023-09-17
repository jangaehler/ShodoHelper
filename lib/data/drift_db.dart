//STEP 1 - IMPORT drift package

import 'package:drift/drift.dart';
import 'dart:io'; // needed to generate/find a path to db
import 'package:drift/native.dart'; // needed to use NativeDatabase
import 'package:path_provider/path_provider.dart'; // needed to get path to document's directory where application can place user generated data
import 'package:path/path.dart'
as p; // needed to generate/find a path to db -> p is the name we will use in our code to join the path

// import generated file by drift
part 'drift_db.g.dart';

//STEP 2 - Create data model table

class Lyrics extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()
      .nullable()();
  TextColumn get artist => text()
      .nullable()();
  TextColumn get lang => text()
      .nullable()();
}

//STEP 3 - Create Drift database from table

@DriftDatabase(tables: [Lyrics])
class LyricsDatabase extends _$LyricsDatabase {
//STEP 4 - Open connection to database in system

  LyricsDatabase() : super(_openConnection());

  @override
  int get schemaVersion =>
      1; // strongly recomend this, to be able to update to new versions of your schema, for any future changes

//STEP 5 - Run command [ flutter pub run build_runner build ] to generate .g file and create queries
  //QUERIES
  //CREATE
  Future insertNewLyric(Lyric lyric) => into(lyrics).insert(lyric);
  //Create using post companion -  to create post since id is an autoincrement and cannot be entered manually
  Future<int> insertNewCompanionTodo(LyricsCompanion lyric) =>
      into(lyrics).insert(lyric);
  //READ
  Future<List<Lyric>> getAllLyrics() => select(lyrics).get();
  Stream<List<Lyric>> watchAllLyrics() => select(lyrics).watch(); //automatically emits new values when  we have underlying table changes
  Stream<Lyric>watchLyricWithId(int id) => (select(lyrics)..where((u) => u.id.equals(id))).watchSingle(); // to be used for testing purposes

  //UPDATE
  Future updateNewLyric(Lyric lyric) => update(lyrics).replace(lyric);
  //DELETE
  Future deleteLyric(Lyric lyric) => delete(lyrics).delete(lyric);

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      }
    );
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final file = File('lyricsdb.sqlite');
    return NativeDatabase(file,
        logStatements: true); // SET logs to true, for easier development
  });
}