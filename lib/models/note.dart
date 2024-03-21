import 'package:isar/isar.dart';

//untuk mengenerate file
part 'note.g.dart';


@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}