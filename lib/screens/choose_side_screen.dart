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
            colors: [Colors.cyan.shade400, Colors.blue.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🔹 Title
                Text(
                  "Pick Your Side",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'portLligatSlab',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: Colors.black38,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),

                // 🔹 Side Selection Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sideCard('X', 'assets/cross.png', Colors.red),
                    SizedBox(width: 30),
                    sideCard('O', 'assets/circle.png', Colors.green),
                  ],
                ),

                SizedBox(height: 50),

                // 🔹 Continue Button
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
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 70),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 12,
                    backgroundColor: Colors.deepPurpleAccent,
                    shadowColor: Colors.deepPurple,
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
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(colors: [color.withOpacity(0.6), color])
              : LinearGradient(colors: [Colors.white, Colors.grey.shade200]),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: isSelected ? color.withOpacity(0.6) : Colors.grey.shade400,
              blurRadius: isSelected ? 20 : 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Image.asset(asset, width: 70),
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

