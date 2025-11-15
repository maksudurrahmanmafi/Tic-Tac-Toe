// import 'package:flutter/material.dart';
//
// import 'choose_side_screen.dart';
//
// class PlayModeScreen extends StatelessWidget {
//   const PlayModeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfff6f6f6),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//
//               /// 🔥 FIXED ROW (your bracket was misplaced)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset('assets/cross.png', width: 50),
//                   Image.asset('assets/circle.png', width: 50),
//                 ],
//               ),
//
//               SizedBox(height: 50),
//
//               Padding(
//                 padding: EdgeInsets.only(bottom: 15),
//                 child: Text(
//                   'Choose Your Play Mode',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontFamily: 'portLligatSlab',
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   minimumSize: Size(300, 50),
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   elevation: 10,
//                   shadowColor: Colors.blueGrey,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                       context,MaterialPageRoute(
//                       builder: (context)=>ChooseSideScreen(isAi: true)
//                   )
//                   );
//                 },
//                 child: Text(
//                   'With AI',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontFamily: 'portLligatSlab',
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   minimumSize: Size(300, 50),
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   elevation: 10,
//                   shadowColor: Colors.grey,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                       context,MaterialPageRoute(
//                       builder: (context)=>ChooseSideScreen(isAi: false)
//                   )
//                   );
//                 },
//                 child: Text(
//                   'With Friend',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontFamily: 'portLligatSlab',
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'choose_side_screen.dart';

class PlayModeScreen extends StatelessWidget {
  const PlayModeScreen({super.key});

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
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // 🔹 Top Cross & Circle Images in Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset('assets/cross.png', width: 50),
                      ),
                    ),
                    SizedBox(width: 20),
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset('assets/circle.png', width: 50),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 50),

                // 🔹 Title
                Text(
                  'Choose Your Play Mode',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'portLligatSlab',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),

                SizedBox(height: 50),

                // 🔹 Buttons
                // AI Mode Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 10,
                    backgroundColor: Colors.deepPurpleAccent,
                    shadowColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChooseSideScreen(isAi: true),
                      ),
                    );
                  },
                  child: Text(
                    'With AI',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'portLligatSlab',
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Friend Mode Button with gradient
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      colors: [Colors.orangeAccent, Colors.deepOrange],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.4),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChooseSideScreen(isAi: false),
                        ),
                      );
                    },
                    child: Text(
                      'With Friend',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'portLligatSlab',
                        color: Colors.white,
                      ),
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
}
