import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'globals.dart';
import 'widgets/Board.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => Globals(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.7),
        title: Center(
          child: Text(
            'Tic Tac Toe',
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          ),
        ),
      ),
      body: const Center(child: Board()),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}






