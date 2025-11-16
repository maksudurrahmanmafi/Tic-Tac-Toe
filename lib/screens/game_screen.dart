import 'dart:async';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String playerSide;
  final bool isAi;
  final String? aiDifficulty; // New: difficulty level for AI

  const GameScreen({
    super.key,
    required this.playerSide,
    required this.isAi,
    this.aiDifficulty,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String winner = '';
  int playerScore = 0;
  int aiScore = 0;
  String playerOneName = 'PLAYER';
  String playerTwoName = 'COMPUTER';

  Timer? moveTimer;
  int remainingTime = 10;
  bool timerActive = true;

  late AnimationController timerController;

  @override
  void initState() {
    super.initState();

    timerController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    timerController.addListener(() {
      setState(() {});
    });

    if (widget.playerSide == 'O' && widget.isAi) {
      currentPlayer = 'X';
      startMoveTimer();
      aiMove();
    } else {
      startMoveTimer();
    }

    if (!widget.isAi) {
      playerOneName = 'Player 1';
      playerTwoName = 'Player 2';
    }
  }

  @override
  void dispose() {
    moveTimer?.cancel();
    timerController.dispose();
    super.dispose();
  }

  void startMoveTimer() {
    moveTimer?.cancel();
    remainingTime = 10;
    timerActive = true;
    timerController.reset();
    timerController.forward();

    moveTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!timerActive) {
        timer.cancel();
        return;
      }

      setState(() {
        remainingTime--;
      });

      if (remainingTime <= 0) {
        timer.cancel();
        timerActive = false;
        skipTurn();
      }
    });
  }

  void skipTurn() {
    if (winner != '') return;
    setState(() {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      startMoveTimer();

      if (widget.isAi && currentPlayer != widget.playerSide) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await Future.delayed(Duration(seconds: 2));
          aiMove();
        });
      }
    });
  }

  void aiMove() async {
    if (winner != '') return;

    // 2-second delay for AI thinking
    await Future.delayed(Duration(seconds: 2));

    int moveIndex;

    switch (widget.aiDifficulty) {
      case "Easy":
      // Random move
        List<int> available = [];
        for (int i = 0; i < 9; i++) {
          if (board[i] == '') available.add(i);
        }
        available.shuffle();
        moveIndex = available.first;
        break;

      case "Medium":
      // Try winning or block opponent
        moveIndex = findBestMove(widget.playerSide == 'X' ? 'O' : 'X');
        break;

      case "Hard":
      // Perfect AI (Minimax placeholder)
        moveIndex = findBestMoveMinimax(currentPlayer);
        break;

      default:
      // Fallback random
        List<int> available = [];
        for (int i = 0; i < 9; i++) {
          if (board[i] == '') available.add(i);
        }
        available.shuffle();
        moveIndex = available.first;
    }

    setState(() {
      board[moveIndex] = currentPlayer;

      if (checkWinner(currentPlayer)) {
        winner = currentPlayer == widget.playerSide ? 'YOU WIN 🥳' : 'AI WINS 🤖💥';
        if (currentPlayer == widget.playerSide) playerScore++;
        else aiScore++;
        moveTimer?.cancel();
        showResultDialog(winner);
        return;
      }

      if (!board.contains('')) {
        winner = 'Draw';
        moveTimer?.cancel();
        showResultDialog('Draw 🧐🤝');
        return;
      }

      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      startMoveTimer();
    });
  }

  // Medium difficulty logic
  int findBestMove(String opponent) {
    // Try to win
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        board[i] = currentPlayer;
        if (checkWinner(currentPlayer)) {
          board[i] = '';
          return i;
        }
        board[i] = '';
      }
    }

    // Try to block opponent
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        board[i] = opponent;
        if (checkWinner(opponent)) {
          board[i] = '';
          return i;
        }
        board[i] = '';
      }
    }

    // Random fallback
    List<int> available = [];
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') available.add(i);
    }
    available.shuffle();
    return available.first;
  }

  // Hard difficulty placeholder (you can implement full Minimax)
  int findBestMoveMinimax(String player) {
    // For now, use medium logic as simple AI
    return findBestMove(widget.playerSide == 'X' ? 'O' : 'X');
  }

  bool checkWinner(String player) {
    List<List<int>> wins = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var line in wins) {
      if (board[line[0]] == player &&
          board[line[1]] == player &&
          board[line[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void makeMove(int index) {
    if (board[index] == '' && winner == '') {
      setState(() {
        board[index] = currentPlayer;
        timerActive = false;
        moveTimer?.cancel();
      });

      if (checkWinner(currentPlayer)) {
        winner = widget.isAi
            ? (currentPlayer == widget.playerSide ? 'YOU WIN 🥳' : 'AI WINS 🤖💥')
            : (currentPlayer == widget.playerSide ? 'YOU WIN 🥳' : 'OPPONENT WIN 💥');

        if (currentPlayer == widget.playerSide) playerScore++;
        else aiScore++;

        showResultDialog(winner);
      } else if (!board.contains('')) {
        winner = 'Draw';
        showResultDialog('Draw 🧐🤝');
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        startMoveTimer();

        if (widget.isAi && currentPlayer != widget.playerSide) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            aiMove();
          });
        }
      }
    }
  }

  void resetBoard() {
    setState(() {
      board = List.filled(9, '');
      winner = '';
      currentPlayer = 'X';
    });

    moveTimer?.cancel();
    startMoveTimer();

    if (widget.playerSide == 'O' && widget.isAi) {
      aiMove();
    }
  }

  void showResultDialog(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'portLligatSlab',
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  resetBoard();
                },
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 20, fontFamily: 'portLligatSlab'),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void showQuitDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Are you sure you want to quit the game?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'portLligatSlab',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No",
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'portLligatSlab'))),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("Yes",
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'portLligatSlab'))),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = timerController.value;

    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.purple.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Scoreboard
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text(playerOneName, style: TextStyle(fontSize: 20)),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [Colors.white, Colors.blue]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 30,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      '$playerScore - $aiScore',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'portLligatSlab',
                          color: Colors.black),
                    ),
                  ),
                  Text(playerTwoName, style: TextStyle(fontSize: 20)),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Turn indicator + Timer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.isAi
                        ? (currentPlayer == widget.playerSide
                        ? "Your Turn"
                        : "Computer's Turn")
                        : (currentPlayer == 'X'
                        ? "$playerOneName's Turn"
                        : "$playerTwoName's Turn"),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: currentPlayer == widget.playerSide
                          ? Colors.blue
                          : Colors.red,
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          value: timerActive ? 1 - progress : 0,
                          strokeWidth: 6,
                          valueColor: AlwaysStoppedAnimation(
                              remainingTime <= 3 ? Colors.red : Colors.green),
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                      Text(
                        '$remainingTime',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Game Grid
            Card(
              color: Colors.white,
              elevation: 5,
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => makeMove(index),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: index < 6
                                ? BorderSide(width: 2, color: Colors.green)
                                : BorderSide.none,
                            right: index < 9 && index % 3 != 2
                                ? BorderSide(width: 2, color: Colors.red)
                                : BorderSide.none,
                          ),
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(scale: animation, child: child),
                            child: board[index] == 'X'
                                ? Image.asset(
                              'assets/cross.png',
                              key: ValueKey('X$index'),
                              width: 80,
                            )
                                : board[index] == 'O'
                                ? Image.asset(
                              'assets/circle.png',
                              key: ValueKey('O$index'),
                              width: 80,
                            )
                                : SizedBox(key: ValueKey('empty$index')),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 20),

            // Winner text
            Text(
              winner,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'portLligatSlab',
                  color: Colors.red),
            ),

            SizedBox(height: 20),

            // Buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(120, 50),
                    backgroundColor: Colors.blue,
                    padding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    elevation: 8,
                    shadowColor: Colors.blueGrey,
                  ),
                  onPressed: resetBoard,
                  child: Text(
                    'Reset Game',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'portLligatSlab',
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(120, 50),
                    backgroundColor: Colors.red,
                    padding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    elevation: 8,
                    shadowColor: Colors.blueGrey,
                  ),
                  onPressed: showQuitDialog,
                  child: Text(
                    'Quit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'portLligatSlab',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
