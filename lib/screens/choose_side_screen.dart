import 'package:flutter/material.dart';

import 'game_screen.dart';

class ChooseSideScreen extends StatefulWidget {
  final bool isAi;
  const ChooseSideScreen({super.key,required this.isAi});

  @override
  State<ChooseSideScreen> createState() => _ChooseSideScreenState();
}

class _ChooseSideScreenState extends State<ChooseSideScreen> {
  String selectedSide='X';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pick your side",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/cross.png',
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Radio<String>(
                        value: 'X',
                        groupValue:selectedSide ,
                        activeColor: Colors.green,
                        onChanged: (value){
                          setState(() {
                            selectedSide = value!;
                          });
                        },
                       ),
                    )
                  ],
                ),
                SizedBox(width:20 ),
                Column(
                  children: [
                    Image.asset(
                      'assets/circel.png',
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Radio<String>(
                        value: 'O',
                        groupValue:selectedSide ,
                        activeColor: Colors.red,
                        onChanged: (value){
                          setState(() {
                            selectedSide = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                padding: EdgeInsets.symmetric(vertical: 10),
                elevation: 10,
                shadowColor: Colors.grey
              ),
                onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder:(context)=>GameScreen(
                        playerSide: selectedSide,
                        isAi:widget.isAi

                      )
                  )
                  
                );
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black54
                  ),

                ))

          ],
        ),
      ),
    );
  }
}
