import 'package:flutter/material.dart';
import "package:provider/provider.dart";

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

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => BoardState();
}

class BoardState extends State<Board> with SingleTickerProviderStateMixin {
  // late AnimationController _animationController;
  //  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 1),
    //   value: 1.0,
    // );
    // _animation = Tween<double>(begin: 1,)
    // _animationController.forward();
  }

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

class X extends StatelessWidget {
  const X({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("X", style: TextStyle(fontSize: 60, color: Colors.red));
  }
}

class O extends StatelessWidget {
  const O({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("O", style: TextStyle(fontSize: 60, color: Colors.yellow));
  }
}

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

