import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notepad/notes_model/notes_model.dart';

class EditNotes extends StatefulWidget {
  NotesModel note;

  EditNotes({super.key, required this.note});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  final TextEditingController _title = TextEditingController();

  final TextEditingController _body = TextEditingController();

  final myBox = Hive.box('notes');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("note received = ${widget.note.noteBody}");

    _title.text = widget.note.noteTitle;
    _body.text = widget.note.noteBody;
  }

  void UpdateNote(context) {
    widget.note.noteTitle = _title.text;
    widget.note.noteBody = _body.text;

    widget.note.save();

    Navigator.of(context).pop();
    //}
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
        title: const Text("Edit Notes"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => UpdateNote(context),
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
              //minLines: 6,
              maxLines: null,
              decoration:
                  const InputDecoration(hintText: "Enter Edited Note Title"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _body,
              minLines: 6,
              maxLines: null,
              decoration:
                  const InputDecoration(hintText: "Enter Edited Note Body"),
            ),
          ],
        ),
      ),
    );
  }
}
