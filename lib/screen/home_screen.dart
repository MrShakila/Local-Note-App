import 'package:flutter/material.dart';
import 'package:local_databse/model/note_model.dart';
import 'package:local_databse/providers/note_provider.dart';
import 'package:local_databse/utills/dialog.dart';
import 'package:provider/provider.dart';

import '../widgets/note_tile.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({Key? key}) : super(key: key);

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  @override
  void initState() {
    Provider.of<NoteProvider>(context, listen: false).refreshNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: ElevatedButton.icon(
              onPressed: () {
                Utils().showForm(context, null);
              },
              icon: const Icon(Icons.add),
              label: const Text("Add new Note")),
          appBar: AppBar(centerTitle: true, title: const Text("Notes App")),
          body: Consumer<NoteProvider>(
            builder: (context, value, child) {
              return value.allNotes.isEmpty
                  ? const Center(child: Text("No Notes"))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: value.allNotes.length,
                      itemBuilder: (context, index) {
                        return  NoteTile(
                          noteModel: value.allNotes[index],
                        );
                      },
                    );
            },
          )),
    );
  }
}
