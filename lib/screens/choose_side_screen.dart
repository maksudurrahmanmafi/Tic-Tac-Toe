// import 'package:flutter/material.dart';
//
// import 'game_screen.dart';
//
// class ChooseSideScreen extends StatefulWidget {
//   final bool isAi;
//   const ChooseSideScreen({super.key,required this.isAi});
//
//   @override
//   State<ChooseSideScreen> createState() => _ChooseSideScreenState();
// }
//
// class _ChooseSideScreenState extends State<ChooseSideScreen> {
//   String selectedSide='X';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.cyanAccent,
//       // backgroundColor: Color(0xfff6f6f6),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.cyanAccent, Colors.blueAccent],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Pick your side",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontFamily: 'portLligatSlab',
//                 color: Colors.black,
//               ),
//               ),
//               SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Column(
//                     children: [
//
//                       Image.asset(
//                         'assets/cross.png',
//                         width: 50,
//                         fit: BoxFit.cover,
//                       ),
//                       Transform.scale(
//                         scale: 1.5,
//                         child: Radio<String>(
//                           value: 'X',
//                           groupValue:selectedSide ,
//                           activeColor: Colors.red,
//                           onChanged: (value){
//                             setState(() {
//                               selectedSide = value!;
//                             });
//                           },
//                          ),
//                       )
//                     ],
//                   ),
//                   SizedBox(width:20 ),
//                   Column(
//                     children: [
//                       Image.asset(
//                         'assets/circle.png',
//                         width: 50,
//                         fit: BoxFit.cover,
//                       ),
//                       Transform.scale(
//                         scale: 1.5,
//                         child: Radio<String>(
//                           value: 'O',
//                           groupValue:selectedSide ,
//                           activeColor: Colors.green,
//                           onChanged: (value){
//                             setState(() {
//                               selectedSide = value!;
//                             });
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 50),
//               ElevatedButton(
//
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   minimumSize: Size(200, 50),
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   elevation: 10,
//
//                   shadowColor: Colors.grey
//                 ),
//                   onPressed: (){
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder:(context)=>GameScreen(
//                           playerSide: selectedSide,
//                           isAi:widget.isAi
//
//                         )
//                     )
//
//                   );
//                   },
//                   child: Text(
//                     'Continue',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontFamily: 'portLligatSlab',
//                       color: Colors.white
//                     ),
//
//                   ))
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'game_screen.dart';

class ChooseSideScreen extends StatefulWidget {
  final bool isAi;
  const ChooseSideScreen({super.key, required this.isAi});

  @override
  State<ChooseSideScreen> createState() => _ChooseSideScreenState();
}

class _ChooseSideScreenState extends State<ChooseSideScreen> {
  String selectedSide = 'X';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyanAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pick Your Side",
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'portLligatSlab',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sideCard('X', 'assets/cross.png', Colors.red),
                  SizedBox(width: 30),
                  sideCard('O', 'assets/circle.png', Colors.green),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(
                        playerSide: selectedSide,
                        isAi: widget.isAi,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 10,
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'portLligatSlab',
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sideCard(String side, String asset, Color color) {
    bool isSelected = selectedSide == side;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSide = side;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.3) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isSelected ? color.withOpacity(0.5) : Colors.grey.shade300,
              blurRadius: isSelected ? 15 : 5,
              offset: Offset(3, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Image.asset(asset, width: 60),
            SizedBox(height: 10),
            Radio<String>(
              value: side,
              groupValue: selectedSide,
              activeColor: color,
              onChanged: (value) {
                setState(() {
                  selectedSide = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

