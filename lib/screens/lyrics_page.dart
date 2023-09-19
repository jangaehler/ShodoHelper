import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:writing_helper/data/drift_db.dart';
import 'package:writing_helper/main.dart';

import '../constants/constants.dart';
import '../constants/strings.dart';
import '../widgets/lyric_list_view.dart'; // necessary to use Value, to store new todos

class LyricsPage extends ConsumerStatefulWidget {
  const LyricsPage({super.key});

  @override
  LyricsPageState createState() => LyricsPageState();
}

class LyricsPageState extends ConsumerState<LyricsPage> {
  String newContent = ''; // textfield content
  var txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(lyricsDBProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
// MARK: UI -> TEXTFIELD to enter todo item
              Expanded(
                child: TextField(
//wrap textfield in Expanded widget + maxlines null == scrollable
                  controller:
                  txtController, // need a controller to clear textfield once we use the save button
                  maxLines: null, //wrap text
                  autofocus: true,
                  autocorrect: true,
                  cursorColor: kCursorColor,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: kAppTitle,
                  ),
//MARK: There might be something better to use rather than onchanged,
//like onSubmitted and get this async, but for simplicity we are going with onChanged
                  onChanged: (newValue) {
                    newContent = newValue;
                  },
                ),
              ),
// CHECK DATABASE BUTTON
// DELETE this button for deployment
              ElevatedButton(
                child: const Text('Check database'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DriftDbViewer(database)));
                },
              ),

//MARK: UI -> LISTVIEW - vertical scroll, contains todo items
              const Expanded(
                child: LyricListView(),
              ),
            ],
          ),
        ),
      ),
//MARK: UI ->  FLOATING ACTION BUTTON IN SCAFFOLD
//- save text input and update listView
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () {
            _saveButtonAction(context, database);
            // Clear textfield
            txtController.clear();
          }),
    );
  }

  void _saveButtonAction(BuildContext context, LyricsDatabase database) { //private method, can only be used inside the class
    database.insertNewCompanionTodo(LyricsCompanion(content: Value(newContent)));
  }
}
