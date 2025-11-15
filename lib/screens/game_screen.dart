import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String playerSide;
  final bool isAi;
  const GameScreen({super.key,required this.playerSide,required this.isAi});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board =List.filled(9, '');
  String currentPlayer ='X';
  String winner = '';
  int playerScore =0;
  int aiScore =0;
  String playerOneName ='PLAYER';
  String playerTwoName ='COMPUTER';

  @override

  void initState(){
    super.initState();
    if(widget.playerSide == 'O' && widget.isAi){
      currentPlayer ='X';
      aiMove();
    }
    if(widget.isAi == false){
      playerOneName = 'Player 1';
      playerTwoName = 'Player 2';
    }
  }
  // --------------------- POPUP FUNCTION ------------------------
  void showResultDialog(String msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          title: Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24,
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
                child: Text("OK", style: TextStyle(fontSize: 20,fontFamily: 'portLligatSlab')),
              ),
            )
          ],
        );
      },
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      // backgroundColor: Color(0xfff6f6f6),
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
            Padding(padding: EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                children: [
                  Text(
                    playerOneName,
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [Colors.white, Colors.blue]),
                      // color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 30,
                          offset:Offset (0,3),
                        ),
                      ],
                    ),
                    child: Text(
                      '$playerScore - $aiScore',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'portLligatSlab',
                        color: Colors.black
                      ),
                    ),
                  ),
                  Text(
                    playerTwoName,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.white,
              elevation: 5,
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
        
              ),
              child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: 20) ,
                child: GridView.builder(
                  shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: 9,
                    itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: ()=> makeMove(index),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: index<6?
                                BorderSide(width: 2,color: Colors.green):BorderSide.none,
                            right:  index<9 && index%3!=2?
                                BorderSide(width: 2,color: Colors.red):BorderSide.none,
        
                          )
                        ),
                      //   child: Center(
                      // child: AnimatedSwitcher(
                      // duration: Duration(milliseconds: 300),
                      // transitionBuilder: (child, animation) {
                      // return ScaleTransition(scale: animation, child: child);
                      // },
                      //     child: board[index]=='X'
                      //     ?Image.asset('assets/cross.png',width:80 ,) :board[index]=='O'?
                      //     Image.asset('assets/circle.png',width: 80,):const SizedBox(),
                      //   ),
                      // ),
                      child: Center(
                      child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                      return ScaleTransition(scale: animation, child: child);
                      },
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
                          : SizedBox(
                      key: ValueKey('empty$index'),
                      ),
                      ),
                      ),
                      ),

                      );
        
                    }
                )
              ),
            ),
            SizedBox(height: 20),
            Text(winner,
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'portLligatSlab',
              color: Colors.red
            ),),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: Colors.blue,

                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 40),
                elevation: 8,
                shadowColor: Colors.blueGrey
        
            ),
                onPressed: resetBoard,
                child: Text(
              'Reset Game',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'portLligatSlab',
                color: Colors.white,
        
              ),
        
            ))
            
          ],
        ),
      ),
    );

  }
  void aiMove(){
    for(int i =0 ;i<9;i++){
      if(board[i]==''){
        board[i]= currentPlayer;
        if(checkWinner(currentPlayer)){
          setState(() {
            winner = '$currentPlayer Wins!';
            aiScore++;
          });
          showResultDialog(winner);
          return;
        }
        board[i]='';

      }
    }
    String opponent = widget.playerSide;
    for(int i =0 ;i<9;i++){
      if(board[i]==''){
        board[i]= opponent;
        if(checkWinner(opponent)){
          setState(() {
           board[i] = currentPlayer;

          });
         currentPlayer = currentPlayer == 'X'?'O':'X';
         return;
        }
        board[i]='';


  }
}
    if (board[4] == '') {
      setState(() {
        board[4] = currentPlayer;
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      });
      return;
    }
    List<int>corners = [0,2,6,8];
    for (int c in corners) {
      if (board[c] == '') {
        setState(() {
          board[c] = currentPlayer;
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        });
        return;
      }
    }
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
  void makeMove(int index){
    if(board[index] == '' && winner==''){
      setState(() {
        board[index]=currentPlayer;
        if(checkWinner(currentPlayer)){
          // winner='$currentPlayer Wins!';
          // Context-sensitive popup
          if (widget.isAi) {
            winner = currentPlayer == widget.playerSide
                ? 'YOU WIN 🥳'
                : 'AI WINS 🤖💥';
          } else {
            winner = currentPlayer == widget.playerSide
                ? 'YOU WIN 🥳'
                : 'OPPONENT WIN 💥';
          }
          if(currentPlayer==widget.playerSide){
            playerScore++;
          }else {
            aiScore++;
          }
          showResultDialog(winner);
        }
        else if(!board.contains('')){
          winner = 'Draw';
          showResultDialog('Draw 🧐🤝');
        }else{
          currentPlayer= currentPlayer=='X'?'O':'X';
          if(widget.isAi && currentPlayer !=widget.playerSide){
            aiMove();
          }
        }
      });
    }
  }

  void resetBoard() {
    setState(() {
      board = List.filled(9, '');
      winner='';
      currentPlayer=widget.playerSide=='O'?'X':'O';
      if(widget.playerSide =='O' && widget.isAi){
        aiMove();
      }
      
    });
  }
}
