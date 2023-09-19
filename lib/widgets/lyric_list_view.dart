import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';  // Use CRUD Queries  and database
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:writing_helper/data/drift_db.dart';
import 'package:writing_helper/main.dart';

import 'lyric_item_card.dart'; //  package used to slide todo items to delete them

class LyricListView extends ConsumerStatefulWidget {
  const LyricListView({super.key});

  @override
  LyricListViewState createState() => LyricListViewState();
}

class LyricListViewState extends ConsumerState<LyricListView> {
  @override
  Widget build(BuildContext context) {
    final database = ref.watch(lyricsDBProvider);

    // watch all posts in db
    Stream<List<Lyric>> lyrics =
    database.watchAllLyrics();

//STEP 3 - USE STREAM BUILDER, to be able to update list and get most up to date info
    return StreamBuilder(
//STEP 3.A . PASS THE STREAM LIST FROM DATABASE
        stream: lyrics,
//STEP 3.B . PASS A BUILD CONTEXT ,
        //SNAPSHOT IS THE DATA (OR LACK THEREOFF, if no data is present, handle this case below)
        builder: (BuildContext context, AsyncSnapshot<List<Lyric>> snapshot) {
//STEP 4 - CONSUME DATA AND HANDLE NULL VALUES / ERRORS ETC.
          return ListView.builder(
            itemBuilder: (context, index) {
//STEP4.A - IF WE GET DATA
              if (snapshot.hasData) {
                return Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: const ValueKey(0),
                  // The start action pane is the one at the left or the top side.
                  endActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const StretchMotion(),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (context) => deleteLyric(
                            context,
                            database,
                            snapshot
                                .data![index]), // note function call, GOTCHA!
                        autoClose: true,
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: LyricItemCard(
                    //MARK: 🚨 USING THE BANG OPERATOR HERE IS SAFE ENOUGH BECAUSE WE CHECK IF SNAPSHOT HAS DATA
                    // THE BANG OPERATOR IS FORCE UNWRAPPING, VERY DANGEROUS TO USE IN MOST CONDITIONS
                    content: snapshot.data![index].content ?? 'No data today',

                  ),
                );
//STEP4.B - IF WE GET ERROR
              } else if (snapshot.hasError) {
                return LyricItemCard(
                  content: '🚨 Error: ${snapshot.error}',
                );
//STEP4.C - IF WE ARE IDLE
              } else {
                return const LyricItemCard(
                  content: 'Loading...',
                );
              }
            },
            itemCount: snapshot
                .data?.length, //how to access the number of entries in database
          );
        });
  }

  void deleteLyric(BuildContext context, LyricsDatabase database, Lyric todo) {
    database.deleteLyric(todo);
  }
}
