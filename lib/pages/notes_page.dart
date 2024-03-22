import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooaap/models/note_database.dart';
import 'package:todooaap/models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // text controller
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // on app startup, fetch existing note
    readNotes();
  }

  // create
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          // create button
          MaterialButton(
            onPressed: () {
              // add to db
              context.read<NoteDatabase>().addNote(textController.text);

              // clear controller
              textController.clear();

              // close dialog
              Navigator.pop(context);
            },
            child: const Text("create"),
          )
        ],
      ),
    );
  }

  // read
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update
  void updateNote(Note note) {
    // isi ulang nilai
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("update Note !!"),
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<NoteDatabase>().updateNotes(note.id, textController.text);
              textController.clear();
              Navigator.pop(context);
            },
            child: Text("update"),
          )
        ],
      ),
    );
  }

  // delete
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // note database
    final noteDataBase = context.watch<NoteDatabase>();

    // current notes
    List<Note> currentNote = noteDataBase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE57373),
        title: const Text("apakek"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNote.length,
        itemBuilder: (context, index) {
          // get individual note
          final note = currentNote[index];

          // list tile UI
          return ListTile(
            title: Text(note.text),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // edit button
                IconButton(
                  onPressed: () => updateNote(note),
                  icon: Icon(Icons.edit),
                ),
                // delete button
                IconButton(
                  onPressed: () => deleteNote(note.id),
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
