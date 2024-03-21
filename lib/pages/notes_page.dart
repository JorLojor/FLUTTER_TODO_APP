import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooaap/models/note_database.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  //text controller
  final textController = TextEditingController();
  //create
  void createNode(){
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(content: TextField(
          controller: textController,
        ),
          actions: [
            MaterialButton(onPressed: (){
              context.read<NoteDatabase>().addNote(textController.text);
            })
          ],
        ),
    );
  }

  //read

  //update

  //delete


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xFFE57373),
        title: const Text("apakek"),
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: createNode,

        child: const Icon(Icons.add),
      ),





    );
  }
}
