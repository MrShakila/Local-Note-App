import 'package:flutter/material.dart';
import 'package:local_databse/model/note_model.dart';
import 'package:local_databse/providers/note_provider.dart';
import 'package:local_databse/utills/dialog.dart';
import 'package:provider/provider.dart';

class NoteTile extends StatelessWidget {
  final NoteModel noteModel;
  const NoteTile({
    Key? key,
    required this.noteModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange[200],
      child: ListTile(
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Utils().showForm(context, noteModel);
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    Provider.of<NoteProvider>(context, listen: false)
                        .deleteNote(context, noteModel.id!);
                  },
                  icon: const Icon(Icons.delete)),
            ],
          ),
        ),
        title: Text(noteModel.title),
        subtitle: Text(noteModel.desc),
      ),
    );
  }
}
