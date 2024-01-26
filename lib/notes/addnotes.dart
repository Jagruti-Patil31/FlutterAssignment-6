import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notepad/notes_model/notes_model.dart';

class AddNotes extends StatelessWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();

  final myBox = Hive.box('notes');

  AddNotes({super.key});

  void saveNote(context) {
    if (_title.text.isEmpty) {
      //display a snack bar
      showToast(context, 'Enter Note Title');
    } else if (_body.text.isEmpty) {
      showToast(context, 'Enter Note Body');
    } else {
      //store user entered data into hive storage
      final myobj = NotesModel(noteTitle: _title.text, noteBody: _body.text);

      myBox.add(myobj);

      myobj.save();

      Navigator.of(context).pop();
    }
  }

  showToast(context, message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => saveNote(context),
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: _title,
              // minLines: 6,
              maxLines: null,
              decoration: const InputDecoration(hintText: "Enter Note Title"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _body,
              minLines: 6,
              maxLines: null,
              decoration: const InputDecoration(hintText: "Enter Note Body"),
            ),
          ],
        ),
      ),
    );
  }
}
