import 'package:flutter/material.dart';

import 'choose_side_screen.dart';

class PlayModeScreen extends StatelessWidget {
  const PlayModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// 🔥 FIXED ROW (your bracket was misplaced)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/cross.png', width: 50),
                  Image.asset('assets/circel.png', width: 50),
                ],
              ),

              SizedBox(height: 50),

              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  'Choose Your Play Mode',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(300, 50),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  elevation: 10,
                  shadowColor: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.push(
                      context,MaterialPageRoute(
                      builder: (context)=>ChooseSideScreen(isAi: true)
                  )
                  );
                },
                child: Text(
                  'With AI',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(300, 50),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  elevation: 10,
                  shadowColor: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                      context,MaterialPageRoute(
                      builder: (context)=>ChooseSideScreen(isAi: false)
                  )
                  );
                },
                child: Text(
                  'With Friend',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
