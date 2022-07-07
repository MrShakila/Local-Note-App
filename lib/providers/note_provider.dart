import 'package:flutter/material.dart';
import 'package:local_databse/controller/sql_helper.dart';
import 'package:logger/logger.dart';

import '../model/note_model.dart';

class NoteProvider extends ChangeNotifier {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  TextEditingController get titleController => _title;
  TextEditingController get descController => _desc;

//create new note

  Future<void> addNewNote(BuildContext context) async {
    if (_title.text.isEmpty || _desc.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Fill All the Fields")));

      Logger().e("empty Fields");
    } else {
      await SqlHelper.createNote(_title.text, _desc.text);
      _title.clear();
      refreshNotes();
      _desc.clear();
      Logger().i("new note add to Database(Provider)");
      notifyListeners();
    }
  }

  //update existing note

  Future<void> updateNote(BuildContext context, int id) async {
    if (_title.text.isEmpty || _desc.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Fill All the Fields")));

      Logger().e("empty Fields");
    } else {
      await SqlHelper.updateNote(id, _title.text, _desc.text);

      await refreshNotes();
      _desc.clear();
      _title.clear();
      Logger().i("updated note add to the Database(Provider)");
      notifyListeners();
    }
  }

  //delete Note

  Future<void> deleteNote(BuildContext context, int id) async {
    await SqlHelper.deletsNote(id);
ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("One Note Delete")));

    await refreshNotes();
    
    Logger().i("note deleted succes(Provider)");
    notifyListeners();
  }
  //read all Notes

  //fetch all the notes

  List<NoteModel> _allNotes = [];
  List<NoteModel> get allNotes => _allNotes;

  Future<void> refreshNotes() async {
    _allNotes = await SqlHelper.getNotes();
    notifyListeners();
  }

  void setTextEditingController(NoteModel model) {
    _title.text = model.title;
    _desc.text = model.desc;
    notifyListeners();
  }
}
