// import 'package:flutter/material.dart';
// import 'choose_side_screen.dart';
//
// class ChooseDifficultyScreen extends StatefulWidget {
//   const ChooseDifficultyScreen({super.key});
//
//   @override
//   State<ChooseDifficultyScreen> createState() =>
//       _ChooseDifficultyScreenState();
// }
//
// class _ChooseDifficultyScreenState extends State<ChooseDifficultyScreen> {
//   String selectedDifficulty = 'Easy';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Select AI Difficulty")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             difficultyButton('Easy', Colors.green),
//             const SizedBox(height: 20),
//             difficultyButton('Medium', Colors.orange),
//             const SizedBox(height: 20),
//             difficultyButton('Hard', Colors.red),
//             const SizedBox(height: 50),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ChooseSideScreen(
//                       isAi: true,
//                       aiDifficulty: selectedDifficulty,
//                     ),
//                   ),
//                 );
//               },
//               child: const Text("Continue"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget difficultyButton(String difficulty, Color color) {
//     bool isSelected = selectedDifficulty == difficulty;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedDifficulty = difficulty;
//         });
//       },
//       child: Container(
//         width: 200,
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         decoration: BoxDecoration(
//           color: isSelected ? color : Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Center(
//           child: Text(
//             difficulty,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.black,
//               fontSize: 20,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// import 'choose_side_screen.dart';
//
// class ChooseDifficultyScreen extends StatefulWidget {
//   const ChooseDifficultyScreen({super.key});
//
//   @override
//   State<ChooseDifficultyScreen> createState() => _ChooseDifficultyScreenState();
// }
//
// class _ChooseDifficultyScreenState extends State<ChooseDifficultyScreen> {
//   String selectedDifficulty = 'Medium';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.cyan.shade400, Colors.blue.shade900],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Choose AI Difficulty",
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontFamily: 'portLligatSlab',
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 difficultyCard("Easy"),
//                 difficultyCard("Medium"),
//                 difficultyCard("Hard"),
//                 const SizedBox(height: 50),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ChooseSideScreen(
//                           isAi: true,
//                           aiDifficulty: selectedDifficulty,
//                         ),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 18, horizontal: 70),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                   ),
//                   child: const Text(
//                     'Continue',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontFamily: 'portLligatSlab',
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget difficultyCard(String difficulty) {
//     bool isSelected = selectedDifficulty == difficulty;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedDifficulty = difficulty;
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         decoration: BoxDecoration(
//           gradient: isSelected
//               ? LinearGradient(colors: [Colors.purple, Colors.deepPurple])
//               : LinearGradient(colors: [Colors.white, Colors.grey.shade300]),
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Center(
//           child: Text(
//             difficulty,
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: isSelected ? Colors.white : Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'choose_side_screen.dart';

class ChooseDifficultyScreen extends StatefulWidget {
  const ChooseDifficultyScreen({super.key});

  @override
  State<ChooseDifficultyScreen> createState() => _ChooseDifficultyScreenState();
}

class _ChooseDifficultyScreenState extends State<ChooseDifficultyScreen> {
  String selectedDifficulty = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade400, Colors.blue.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Choose AI Difficulty",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'portLligatSlab',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                difficultyCard("Easy"),
                difficultyCard("Medium"),
                difficultyCard("Hard"),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChooseSideScreen(
                          isAi: true,
                          aiDifficulty: selectedDifficulty,
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 18, horizontal: 70)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.deepPurple; // pressed color
                        }
                        return Colors.white; // default color
                      },
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'portLligatSlab',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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

  Widget difficultyCard(String difficulty) {
    bool isSelected = selectedDifficulty == difficulty;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDifficulty = difficulty;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(colors: [Colors.purple, Colors.deepPurple])
              : LinearGradient(colors: [Colors.white, Colors.grey.shade300]),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            difficulty,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
