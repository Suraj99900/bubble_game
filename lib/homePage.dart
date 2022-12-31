import 'package:bubble_game/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double playerX = 0;

  void moveLeft() {
    setState(() {
      playerX -= 0.2;
    });
  }

  void moveRight() {
    setState(() {
      playerX += 0.2;
    });
  }

  void moveFire() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.pink[100],
            child: Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      alignment: Alignment(playerX, 1),
                      child: Container(
                        color: Colors.purple,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
            child: Container(
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyButton(
                icon: Icons.arrow_back,
                function: moveLeft,
              ),
              MyButton(
                icon: Icons.arrow_upward,
                function: moveFire,
              ),
              MyButton(
                icon: Icons.arrow_forward,
                function: moveRight,
              ),
            ],
          ),
        ))
      ],
    );
  }
}
