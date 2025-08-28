import 'package:flutter/material.dart';

class Globals extends ChangeNotifier {
  List<String?> board = List.filled(9, null);
  String currentPlayer = "X";
  bool gameOver = false;
  String? winner;

  void setCell(int index) {
    if (gameOver) {
      return;
    }

    board[index] = board[index] ?? currentPlayer;
    currentPlayer = currentPlayer == "X" ? "O" : "X";
    checkVictory();
    notifyListeners();
  }

  void checkVictory() {
    List<List<int>> winningCombinations = [
      [0, 1, 2], // Самый вверх
      [3, 4, 5], // Средняя линия
      [6, 7, 8], // Нижняя линия
      [0, 3, 6], // Левый столбец
      [1, 4, 7], // Средний столбец
      [2, 5, 8], // Правый столбец
      [0, 4, 8], // Диагональ слева направо
      [2, 4, 6], // Диагональ справа налево
    ];

    for (var combination in winningCombinations) {
      String? first = board[combination[0]];
      String? second = board[combination[1]];
      String? third = board[combination[2]];

      if (first != null && first == second && second == third) {
        if (first == "X") {
          debugPrint("Player X wins!");
          winner = "X";
        } else if (first == "O") {
          debugPrint("Player O wins!");
          winner = "O";
        }
        gameOver = true;
        return;
      }
    }

    if (!board.contains(null)) {
      debugPrint("It's a draw!");
      gameOver = true;
      winner = "Draw!";
    }
  }

  void resetGame() {
    board = List.filled(9, null);
    currentPlayer = "X";
    gameOver = false;
    winner = null;
    notifyListeners();
  }
}