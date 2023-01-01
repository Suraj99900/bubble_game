import 'dart:async';

import 'package:bubble_game/ball.dart';
import 'package:bubble_game/button.dart';
import 'package:bubble_game/missile.dart';
import 'package:bubble_game/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  static double playerX = 0;

  //for midshot fire
  bool midShot = false;

  //missilevariable
  double missileX = playerX;
  double missileY = 1;
  double missileHeight = 10;

  //ball variables
  double ballX = 0.03;
  double ballY = 0;
  var ballDirection = direction.LEFT;
  //start game function
  void startGame() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (ballX - 0.03 < -1) {
        ballDirection = direction.RIGHT;
      } else if (ballX + 0.03 > 1) {
        ballDirection = direction.LEFT;
      }
      if (ballDirection == direction.LEFT) {
        setState(() {
          ballX -= 0.03;
        });
      } else if (ballDirection == direction.RIGHT) {
        setState(() {
          ballX += 0.03;
        });
      }
    });
  }

  //moving player function
  void moveLeft() {
    setState(() {
      if (playerX - 0.1 < -1) {
        //do nothing
      } else {
        playerX -= 0.1;
      }

      // only make the x coordinate the same when it isn't in the middle of a shot
      if (!midShot) {
        missileX = playerX;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + 0.1 > 1) {
        //do nothing
      } else {
        playerX += 0.1;
      }

      // only make the x coordinate the same when it isn't in the middle of a shot
      if (!midShot) {
        missileX = playerX;
      }
    });
  }

  void moveFire() {
    if (midShot == false) {
      Timer.periodic(Duration(milliseconds: 20), (timer) {
        //shots fired
        midShot = true;

        // missile grow til it hit's the top of the screen
        setState(() {
          missileHeight += 10;
        });

        if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
          //stop missile
          resetMissile();
          timer.cancel();
          midShot = false;
        }
      });
    }
  }

  void resetMissile() {
    missileX = playerX;
    missileHeight = 10;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          moveFire();
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.pink[100],
              child: Center(
                child: Stack(
                  children: [
                    MyBall(ballX: ballX, ballY: ballY), //MyBall
                    Missile(
                      missileX: missileX,
                      missileY: missileY,
                      missileHeight: missileHeight,
                    ),
                    MyPlayer(
                      playerX: playerX,
                    ),
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
                  icon: Icons.play_arrow,
                  function: startGame,
                ),
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
      ),
    );
  }
}
