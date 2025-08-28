import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/globals.dart';
import 'Cell.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => BoardState();
}

class BoardState extends State<Board> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.count(
        crossAxisCount: 3,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(
          9,
          (index) => Cell(
            index: index,
            onTap: () {
              context.read<Globals>().setCell(index);
              if (context.read<Globals>().gameOver) {
                final winner = context.read<Globals>().winner;
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(
                      winner == "Draw!" ? "Ничья!" : "Победил $winner!",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.read<Globals>().resetGame();
                        },
                        child: const Text("Сыграть снова"),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
