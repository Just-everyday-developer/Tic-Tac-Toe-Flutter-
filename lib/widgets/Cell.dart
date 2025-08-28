import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/globals.dart';

class Cell extends StatelessWidget {
  final int index;
  final GestureTapCallback onTap;
  Cell({super.key, required this.index, required this.onTap});
  late List<String?> board;

  @override
  Widget build(BuildContext context) {
    board = context.watch<Globals>().board;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: AnimatedOpacity(
          curve: Curves.easeIn,
          duration: const Duration(seconds: 1),
          opacity: board[index] != null ? 1 : 0,
          child: Center(
            child: Text(board[index] ?? "", style: TextStyle(fontSize: 90)),
          ),
        ),
      ),
    );
  }
}