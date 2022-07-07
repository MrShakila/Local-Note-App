import 'package:flutter/material.dart';
import 'package:local_databse/providers/note_provider.dart';
import 'package:local_databse/screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => NoteProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.teal,
      home: HomeScreeen(),
    );
  }
}
