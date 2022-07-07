import 'package:flutter/material.dart';
import 'package:local_databse/model/note_model.dart';
import 'package:local_databse/providers/note_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  void showForm(BuildContext context, NoteModel? model) {
    //set existing details

    if (model != null) {
      Provider.of<NoteProvider>(context, listen: false)
          .setTextEditingController(model);
    }
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SizedBox(
            height: 400,
            child: Consumer<NoteProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: model != null
                            ? const Text(
                                "Update Note",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              )
                            : const Text(
                                "Add New Note",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: value.titleController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: "Title"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: value.descController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Description"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          //save new note
                          if (model == null) {
                            value.addNewNote(context);
                          } else {
                            //update the note
                            value.updateNote(context, model.id!);
                          }
                          Navigator.pop(context);
                        },
                        child: model != null
                            ? const Text("Update Now")
                            : const Text("Save Your Note"))
                  ],
                );
              },
            ),
          );
        });
  }
}
