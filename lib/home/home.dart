import 'package:flutter/material.dart';
import 'package:notepad/notes/addnotes.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad/notes/editnotes.dart';
import 'package:notepad/notes_model/notes_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final myBox = Hive.box('notes');

  void editNote(context, NotesModel note) {
    // edit functionality
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditNotes(note: note)));
  }

  void deleteNote(NotesModel note) async {
    //delete functionality
    await note.delete();
  }

  void gotoAddNotes() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNotes(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" N O T E P A D"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: gotoAddNotes,
            icon: const Icon(Icons.add),
            color: const Color.fromARGB(255, 216, 3, 3),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: myBox.listenable(),
        builder: (context, box, _) {
          final data = box.values.toList().cast<NotesModel>();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.separated(
              itemCount: data.length,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: const Color.fromARGB(255, 240, 162, 188),
                  title: Text(data[index].noteTitle),
                  subtitle: Text(data[index].noteBody),
                  leading: IconButton(
                    onPressed: () => deleteNote(data[index]),
                    icon: const Icon(Icons.delete),
                  ),
                  trailing: IconButton(
                      onPressed: () => editNote(context, data[index]),
                      icon: const Icon(Icons.edit)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
