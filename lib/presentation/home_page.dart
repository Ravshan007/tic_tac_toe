import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> board = List.filled(9, '');

  bool playerOneTurn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Tic Tac Toe",
            style: TextStyle(
              color: Color(0xff0d33c5),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (board[index] == '') {
                      setState(() {
                        board[index] = playerOneTurn ? 'X' : 'O';
                        playerOneTurn = !playerOneTurn;
                        checkWinner();
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: const TextStyle(
                            fontSize: 40.0,
                          color: Color(0xff0d33c5)
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: 350,
            height: 50,
            child: MaterialButton(
              color: const Color(0xff0d33c5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                setState(() {
                  board = List.filled(9, '');
                  playerOneTurn = true;
                });
              },
              child: const Text("Yangi o'yin",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkWinner() {
    // Rows
    for (int i = 0; i < 9; i += 3) {
      if (board[i] != '' && board[i] == board[i + 1] &&
          board[i] == board[i + 2]) {
        showWinnerDialog(board[i]);
        return;
      }
    }

    // Columns
    for (int i = 0; i < 3; i++) {
      if (board[i] != '' && board[i] == board[i + 3] &&
          board[i] == board[i + 6]) {
        showWinnerDialog(board[i]);
        return;
      }
    }

    // Diagonals
    if (board[0] != '' && board[0] == board[4] && board[0] == board[8]) {
      showWinnerDialog(board[0]);
      return;
    }
    if (board[2] != '' && board[2] == board[4] && board[2] == board[6]) {
      showWinnerDialog(board[2]);
      return;
    }

    // Check for draw
    if (!board.contains('')) {
      showDrawDialog();
    }
  }

  void showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("G'olib", style: TextStyle( fontSize: 25)),
          content: Text("$winner ishtirokchi g'olib bo'ldi", style: const TextStyle( fontSize: 22)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(
                color: Color(0xff0d33c5),
                fontSize: 20,
              ),),
            ),
          ],
        );
      },
    );
  }

  void showDrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Durang', style: TextStyle( fontSize: 25),),
          content: const Text('Durang!', style: TextStyle( fontSize: 22)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(
                color: Color(0xff0d33c5),
                fontSize: 20,
              ),
              ),
            ),
          ],
        );
      },
    );
  }
}