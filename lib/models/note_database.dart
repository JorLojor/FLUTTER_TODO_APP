import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todooaap/models/note.dart';

class NoteDatabase extends ChangeNotifier{
  static late Isar isar;

  // meng inisialisasi database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  //list of notes
  final List<Note> currentNotes = [];

  // create (ngebuat note baru dan di simpan ke database)
  Future<void> addote(String textFormUser) async{

    //membuat object baru
    final newNote = Note()..text = textFormUser;
    //menyimpan di database
    await isar.writeTxn(() => isar.notes.put(newNote));
    //membaca note yang baru
    fetchNotes();
  }

// read (menampilkan note yang ada )
  Future<void> fetchNotes() async{
    List<Note> fetchedNote = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNote);
    notifyListeners();
  }

// update (mengubah isi dari dari note yang ada)
  Future<void> updateNotes(int id, String newText) async{
    final noteSebelumnya = await isar.notes.get(id);
    if (noteSebelumnya != null){
      noteSebelumnya.text = newText;
      await isar.writeTxn(() => isar.notes.put(noteSebelumnya));
      await fetchNotes();
    }
  }

// delete (menghapus note dari databse)
  Future<void> deleteNote(int id) async{
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
