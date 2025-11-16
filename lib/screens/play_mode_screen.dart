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
                // 🔹 Top Cross & Circle Images
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cardImage('assets/cross.png', Colors.red),
                    SizedBox(width: 20),
                    cardImage('assets/circle.png', Colors.green),
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
                        blurRadius: 5,
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 50),

                // 🔹 AI Button
                elevatedGradientButton(
                  context: context,
                  text: "With AI",
                  gradient: LinearGradient(colors: [Colors.purpleAccent, Colors.deepPurple]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChooseSideScreen(isAi: true),
                      ),
                    );
                  },
                ),

                SizedBox(height: 25),

                // 🔹 Friend Button
                elevatedGradientButton(
                  context: context,
                  text: "With Friend",
                  gradient: LinearGradient(colors: [Colors.orangeAccent, Colors.deepOrange]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChooseSideScreen(isAi: false),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Card image widget
  Widget cardImage(String asset, Color shadowColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.4),
            blurRadius: 10,
            offset: Offset(3, 3),
          )
        ],
      ),
      padding: EdgeInsets.all(15),
      child: Image.asset(asset, width: 60),
    );
  }

  // 🔹 Gradient elevated button
  Widget elevatedGradientButton({
    required BuildContext context,
    required String text,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 3),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'portLligatSlab',
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
