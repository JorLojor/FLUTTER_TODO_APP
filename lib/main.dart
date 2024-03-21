import 'package:flutter/material.dart';
import 'package:todooaap/models/note_database.dart';
import 'package:provider/provider.dart';
import 'pages/notes_page.dart';

void main() async {
  //meng inisialisasi note dari isar
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDatabase(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
